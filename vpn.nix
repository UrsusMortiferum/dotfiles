{ ... }:

{
  home.file."Proton/VPN/settings.json" = {
    text = ''
      {
          "protocol": "wireguard",
          "killswitch": 1,
          "custom_dns": {
              "enabled": false,
              "ip_list": []
          },
          "ipv6": true,
          "anonymous_crash_reports": true,
          "features": {
              "netshield": 2,
              "moderate_nat": false,
              "vpn_accelerator": true,
              "port_forwarding": true
          }
      }
    '';
  };
  home.file."Proton/VPN/app-config.json" = {
    text = ''
      {
          "tray_pinned_servers": [
              "PL",
              "NL",
              "DE",
              "CA",
              "UK",
              "US",
              "IT"
          ],
          "connect_at_app_startup": "FASTEST",
          "start_app_minimized": true
      }
    '';
  };
}
