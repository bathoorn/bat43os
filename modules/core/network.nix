{
  pkgs,
  host,
  options,
  ...
}: {
  networking = {
    hostName = "${host}";
    networkmanager.enable = true;
    timeServers = options.networking.timeServers.default ++ ["pool.ntp.org"];
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
        59010
        59011
      ];
      allowedUDPPorts = [
        59010
        59011
      ];
      # if packets are still dropped, they will show up in dmesg
      logReversePathDrops = true;
      # wireguard trips rpfilter up
      extraCommands = ''
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN
      '';
      extraStopCommands = ''
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN || true
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN || true
      '';
    };
    #wg-quick.interfaces = {
    #  wg0 = {
    #    address = [ "10.209.31.10/24" "2a02:fe9:12f6:531::a/64" ];
    #    dns = [ "10.209.60.254" "ti"];
    #    privateKeyFile = "/root/wireguard-keys/techinc-privatekey";
    #
    #    peers = [
    #      {
    #        publicKey = "";
    #        presharedKeyFile = "/root/wireguard-keys/techinc-presharedkey";
    #        allowedIPs = [ "10.209.0.0/16" "2a02:fe9:12f6:500::/56"];
    #        endpoint = "vpn.techinc.nl:51820";
    #        persistentKeepalive = 25;
    #      }
    #    ];
    #  };
    #};
  };

  environment.systemPackages = with pkgs; [networkmanagerapplet];
}
