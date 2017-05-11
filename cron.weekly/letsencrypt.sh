#!/bin/bash
set -eux
sudo -u acme_tiny python /usr/local/bin/acme_tiny.py \
    --account-key /etc/pki/letsencrypt.key \
    --csr /etc/pki/nginx/diarizer.blabbertabber.com.csr \
    --acme-dir /var/blabbertabber/acme-challenge > /tmp/signed.crt || exit
wget -O- https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem > /tmp/intermediate.pem
cat /tmp/signed.crt /tmp/intermediate.pem |
    sudo -u acme_tiny tee /etc/pki/nginx/diarizer.blabbertabber.com.crt
sudo systemctl restart nginx.service
