{ config, pkgs, ... }:

let
  localSourcePath = config.services.suwayomi-server.settings.server.localSourcePath;
in
{
  # Enable Suwayomi manga reader
  services.suwayomi-server = {
    enable = true;
    openFirewall = true;
    settings.server = {
      port = 4567;
      localSourcePath = "/var/data/suwayomi-server/local_mangas";
      autoDownloadNewChapters = true;
      extensionRepos = [
        "https://raw.githubusercontent.com/keiyoushi/extensions/repo/index.min.json"
      ];
    };
  };

  # Allow a user to copy new manga into Local source
  users.users.kreid.extraGroups = [ "suwayomi" ];

  # Enforce permissions to new manga in Local source
  systemd.services.suwayomi-permissions = {
    description = "Auto-fix imported Local source manga permissions.";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = ''
        /bin/sh -c '${pkgs.inotify-tools}/bin/inotifywait -mrq -e create -e moved_to ${localSourcePath} \
        | while read dir event file; do \
            chown -R suwayomi:suwayomi "$dir$file"; \
            chmod -R 775 "$dir$file"; \
        done'
      '';
      Restart = "always";
    };
    path = [ pkgs.coreutils ];
  };
}
