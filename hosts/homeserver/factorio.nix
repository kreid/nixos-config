{ config, ... }:

{
  # Enable Factorio game server
  # TODO: SOPS extraSettingsFile
  services.factorio = {
    enable = true;
    openFirewall = true;
    public = true;
    extraSettingsFile = "/var/lib/${config.services.factorio.stateDirName}/extraSettingsFile.json";
    username = "kreid";
    token = "433017c3ec2109b9fb9f968dcbd6a0";
    admins = [
      "kreid"
      "GlowGreen"
    ];
  };
}
