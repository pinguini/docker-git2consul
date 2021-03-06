#!/bin/bash


if [ -n "$CFG" ]
then
  echo "$CFG" > /etc/git2consul.d/config.json
else
  sed -i -e "s@GITREPO@$GIT_REPO@" -e "s@NAMESPACE@$NAMESPACE@" /etc/git2consul.d/config.json
fi

if [ -n "$ID" ]
then
  mkdir ~/.ssh
  echo $ID   |base64 -d > ~/.ssh/id_rsa
  echo $IDPUB|base64 -d > ~/.ssh/id_rsa.pub
  echo "StrictHostKeyChecking no" > ~/.ssh/config
  echo "UserKnownHostsFile=/dev/null" >> ~/.ssh/config
  chmod 700 -R ~/.ssh
fi

echo -e "$(date) starting git2consul. found these env vars: \nCFG:$CFG\nIDPUB:$IDPUB\nGIT_REPO:$GIT_REPO\nNAMESPACE:$NAMESPACE\nCONSUL_ENDPOINT:$CONSUL_ENDPOINT\nCONSUL_PORT:$CONSUL_PORT"

while true
do
  /usr/local/bin/node /usr/local/lib/node_modules/git2consul $@ --config-file /etc/git2consul.d/config.json
done

