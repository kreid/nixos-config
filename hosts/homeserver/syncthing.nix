{ ... }:

{
  # Enable Syncthing continuous file synchronization
  # TODO: SOPS device id's
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    guiAddress = "0.0.0.0:8384";
    user = "kreid";
    group = "users";
    dataDir = "/home/kreid/";    # Default folder for new synced folders
    configDir = "/home/kreid/.config/syncthing";
    settings = {
      devices = {
        "Home server"     = { id = "YSSVO6U-OSLARLV-OQCRIW6-GALXLM6-D5YTS4A-YUBF6HI-ZOFQMFC-O2C6NQL"; };
        "Windows desktop" = { id = "ULLQSIT-2R3FZVL-P4F2IQX-PW5E5AQ-J6DGPG6-4LN6VFG-2CIXINP-DG3VXQD"; };
        "MacBook Air"     = { id = "FBWYNLJ-VALD4DG-KTPZ4HG-AUCST5P-NOPJETV-F4I4WLM-MGRMXRS-XAHGLA2"; };
        "MacBook Pro"     = { id = "2NM42ZS-OPYWZNW-VA42QTK-2RKIB5Y-3QNBNPT-KNH6LJL-L7Q2BPI-PK6YKAZ"; };
      };
      folders = {
        "Downloads" = {
          id = "drfnf-ayqbj";
          path = "/home/kreid/Downloads";
          devices = [ "Windows desktop" "MacBook Air" "MacBook Pro" ];
          versioning = {
            type = "trashcan";
            params.cleanoutDays = "30";
          };
          ignorePatterns = [
            "(?d).DS_Store"
            "*.part"
            "*.crdownload"
          ];
        };
      };
    };
  };

  # TODO: SOPS web GUI user/password.
  # services.syncthing.settings.gui = {
  #   user = "username";
  #  password = "password";
  # };

  # Open ports in the firewall.
  # Syncthing ports: 8384 for remote access to GUI
  # source: https://docs.syncthing.net/users/firewall.html
  networking.firewall.allowedTCPPorts = [ 8384 ];

}