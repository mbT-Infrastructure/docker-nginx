# Nginx image

This Docker image contains a nginx and certbot install.

## Environment variables

- `ENV CERTBOT_AGREE_TOS`
    - Set to `true` to agree to the Terms of Service from certbot ACME
- `CERTBOT_DOMAINS`
    - List of domains for certificates from certbot. For example `CERTBOT_DOMAINS=madebytimo.de web.madebytimo.de`
- `CERTBOT_EMAIL`
    - Email to use for certbot. For example `CERTBOT_EMAIL=example@madebytimo.de`
- `CERTBOT_RSA_KEY_SIZE`
    - Size of RSA-key for certbot. For example `CERTBOT_RSA_KEY_SIZE=4096`
- `CERTBOT_STAGING`
    - Set to `true` to agree to use staging certbot ACME

## Volumes

To persist container data you can define some volumes. Directories that contain data are

- `/media/nginx`
    - Contains all data for nginx and certbot
- `/media/nginx/configuration`
    - Contains the nginx configuration files, which are copied to `/etc/nginx/conf.d`
- `/media/nginx/certs`
    - Recommended path to stoore certificates
- `/media/nginx/letsencrypt`
    - Contains the certbot data


## Development

To build the image locally run:
```bash
./docker-build.sh
```