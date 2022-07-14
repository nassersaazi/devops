# INSTALLATION

## Deployment
* Install Docker and Docker Compose
* Build the docker containers. If you need to (re)start the containers without having changed anything, you can drop the --build
```docker-compose up --build```

## Database Creation & Initialisation
* Open a separate terminal and setup the database
```docker-compose exec website rails db:setup```

## Create the super user
There is a rake task to promote the first user that registered to become admin user.
```docker-compose exec website rails promote_admin```

Additional users can be promoted by enabling the admin flag in the User model, either on the Rails console or directly in the database.

## Ruby Version
This application requires at least Ruby 2.3.

## System Dependencies
Needs Docker and Docker-Compose installed. The application is based on the orats template: https://github.com/nickjj/orats

## Testing with rad_eap_test
The container 'rad_eap_test' contains the rad_eap_test tool (https://github.com/CESNET/rad_eap_test) which is a nice wrapper arount wpa_supplicant (https://w1.fi/wpa_supplicant/).

rad_eap_test can be used for testing your RADIUS configuration

```
rad_eap_test -H <radius.server.name> \
	-P 1812 -S <secret> -u <user@realm> \
	-p <password> -m WPA-EAP -e PEAP
``` 

For more info run rad_eap_test withou any argument.