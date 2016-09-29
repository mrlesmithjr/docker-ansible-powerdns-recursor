#!/bin/bash

# Configure PowerDNS
ansible-playbook -i "localhost," -c local \
  --extra-vars "pdns_recursor_listen_port=$PDNS_RECURSOR_LISTEN_PORT \
  pdns_recursor_local_address=$PDNS_RECURSOR_LOCAL_ADDRESS" /pdns_config.yml

if [ "$#" -gt 0 ]; then
  exec /usr/sbin/pdns_recursor "$@"
else
  exec /usr/sbin/pdns_recursor --daemon=no --loglevel=9
fi
