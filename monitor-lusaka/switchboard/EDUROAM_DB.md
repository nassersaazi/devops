Switchboard publishes information about the NROs, institutions (SP & IdP) and Hot Spots (Service Locations) to feed the eduroam database. The central database is crucial for the operation of the eduroam and supporting services (CAT, Monitoring, Service location maps, Statistics).

Switchboard provides this information in JSON format following the eduroam database specifiation Version 2.0 from 17.10.2017. The schema and additional information can be found under https://monitor.eduroam.org/fact_eduroam_db.php

There are two datasets, one about the (N)RO, the other contains information about the organisations participating in the NRO federation.

## RO Dataset

https://switchboard.eduroam.africa/federations/<federation_id>/ro.json



## Institution Dataset

https://switchboard.eduroam.africa/federations/<federation_id>/institution.json


## Validating datasets

Both datasets can be manually checked for correctness using the validator provided by eduroam Operations Team (OT).

The validator can be found under this URL:
https://monitor.eduroam.org/eduroam-database/v2/scripts/json_validation_test.php

Validate the RO dataset
https://monitor.eduroam.org/eduroam-database/v2/scripts/json_validation_test.php?url=http://switchboard.eduroam.africa/federations/<federation_id>/ro.json

Validate the institution dataset
https://monitor.eduroam.org/eduroam-database/v2/scripts/json_validation_test.php?url=http://switchboard.eduroam.africa/federations/<federation_id>/institution.json

## Submit links to eduroam Operations Team (OT)

