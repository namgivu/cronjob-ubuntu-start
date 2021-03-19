#!/bin/bash
eval $(ssh-agent -s)
cat /app/bin/ssh_key/id_rsa | tr -d '\r' | ssh-add -
ssh root@prototype.referreach.com ls -la