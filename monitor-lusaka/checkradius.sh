#!/bin/bash

docker run  --name test_radius --rm rad_eap_test -t 10 -m WPA-EAP -e PEAP -H 196.32.213.90 -P 1812 -S 728144f69c298e23eb9a -u eduroam.mw@ubuntunet.net -p y69PWzCW3cRHlHyS | tee -a wparadius.log
