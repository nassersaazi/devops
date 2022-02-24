Building
========

```
docker build -t rad_eap_test .
```

Running
=======

Example invocation:
```
docker run -it --rm rad_eap_test -m WPA-EAP -e PEAP -H 192.168.1.10 -P 1812 -S secret123 -u test@example.com -A anonymous@example.com -p testpassword -s eduroam
```

All options
-----------

```
# wrapper script around eapol_test from wpa_supplicant project
# script generates configuration for eapol_test and runs it
# eapol_test is program for testing RADIUS and their EAP methods authentication

Parameters :
-H <address> - Address of radius server
-P <port> - Port of radius server
-S <secret> - Secret for radius server communication
-u <username> - Username (user@realm)
-A <anonymous_id> - Anonymous identity (anonymous_user@realm)
-p <password> - Password
-t <timeout> - Timeout (default is 5 seconds)
-m <method> - Method (WPA-EAP | IEEE8021X )
-v - Verbose (prints decoded last Access-accept packet)
-c - Prints all packets decoded
-s <ssid> - SSID
-e <method> - EAP method (PEAP | TLS | TTLS | LEAP)
-M <mac_addr> - MAC address in xx:xx:xx:xx:xx:xx format
-i <connect_info> - Connection info (in radius log: connect from <connect_info>)
-d <directory> - status directory (unified identifier of packets)
-k <user_key_file> - user certificate key file
-l <user_key_file_password> - password for user certificate key file
-j <user_cert_file> - user certificate file
-a <ca_cert_file> - certificate of CA
-2 <phase2 method> - Phase2 type (PAP,CHAP,MSCHAPV2)
-x <subject_match> - Substring to be matched against the subject of the authentication server certificate.
-N - Identify and do not delete temporary files
-O <domain.edu.cctld> - Operator-Name value in domain name format
-I <ip address> - explicitly specify NAS-IP-Address
-C - request Chargeable-User-Identity
-h - show this message
```


Breaking into the container
---------------------------

```
docker run -it --rm --entrypoint /bin/ash rad_eap_test
```