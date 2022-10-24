resource "fortios_firewall_vip" "extlb1" {
    arp_reply                        = "enable"
    comment                          = "nginx"
    extintf                          = "any"
    extip                            = split(" ", data.fortios_system_interface.wan_ip.ip)[0]
    extport                          = "0-65535"
    ldb_method                       = "static"
    mappedport                       = "0-65535"
    max_embryonic_connections        = 1000
    name                             = "lanilsen.xyz ext lb nginx"
    persistence                      = "none"
    portforward                      = "disable"
    portmapping_type                 = "1-to-1"
    protocol                         = "tcp"
    ssl_server_session_state_type    = "both"
    type                             = "static-nat"


    mappedip {
        range = local.vmware_vm_Ips.extlb1
    }

    service {
        name = "HTTP"
    }

        service {
        name = "HTTPS"
    }

}


resource "fortios_firewall_vip" "plex_docker1" {
    arp_reply                        = "enable"
    comment                          = "nginx"
    extintf                          = "any"
    extip                            = split(" ", data.fortios_system_interface.wan_ip.ip)[0]
    extport                          = "0-65535"
    ldb_method                       = "static"
    mappedport                       = "0-65535"
    max_embryonic_connections        = 1000
    name                             = "lanilsen.xyz plex on docker1"
    persistence                      = "none"
    portforward                      = "disable"
    portmapping_type                 = "1-to-1"
    protocol                         = "tcp"
    ssl_server_session_state_type    = "both"
    type                             = "static-nat"


    mappedip {
        range = local.vmware_vm_Ips.docker1
    }

    service {
        name = "plex"
    }
}