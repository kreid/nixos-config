{ ... }:

let
  host = "192.168.1.88";
in
{
  # Enable customizable homepage dashboard
  services.homepage-dashboard = {
    enable = true;
    allowedHosts = "${host}:8082";
    openFirewall = true;
    settings = {
      target = "_self";
      statusStyle = "dot";
      layout = [
        {
          "Media" = {
            style = "row";
            columns = "4";
          };
        }
        {
          "Files" = {
            style = "row";
            columns = "4";
          };
        }
        {
          "Utilities" = {
            style = "row";
            columns = "4";
          };
        }
        {
          "Tracking" = {
            style = "row";
            columns = "4";
          };
        }
      ];
    };
    widgets = [
      {
        resources = {
          cpu = true;
          disk = "/";
          memory = true;
        };
      }
    ];
    services = [
      {
        "Media" = [
          {
            "Plex" = {
              icon = "plex.png";
              href = "http://${host}:32400/web/";
              description = "Media library streaming server";
              siteMonitor = "http://${host}:32400";
              widget = {
                type = "plex";
                url = "http://${host}:32400";
                key = "todo";
              };
            };
          }
          {
            "Suwayomi" = {
              icon = "suwayomi.png";
              href = "http://${host}:4567/";
              description = "Manga reader";
              siteMonitor = "http://${host}:4567";
              widget = {
                type = "suwayomi";
                url = "http://${host}:4567";
                fields = [
                  "read"
                  "unread"
                  "download"
                  "nondownload"
                ];
              };
            };
          }
        ];
      }
      {
        "Files" = [
          {
            "Syncthing" = {
              icon = "syncthing.png";
              href = "http://${host}:8384/";
              description = "Continuous file synchronization";
              siteMonitor = "http://${host}:8384";
            };
          }
        ];
      }
      {
        "Utilities" = [
          {
            "JetKVM" = {
              icon = "jetkvm.png";
              href = "http://homeserver-con.localdomain/";
              description = "Next-gen open-source KVM over IP";
              siteMonitor = "http://homeserver-con.localdomain";
              statusStyle = "basic";
            };
          }
        ];
      }
    ];
    bookmarks = [
      {
        "Tracking" = [
          {
            "AniList" = [
              {
                icon = "https://anilist.co/img/icons/icon.svg";
                href = "https://anilist.co/";
              }
            ];
          }
        ];
      }
    ];
  };
}
