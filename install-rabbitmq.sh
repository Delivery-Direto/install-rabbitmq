#!/bin/bash
# Author: Gabriel Lasso <https://github.com/GabrielLasso>
# Install Erlang and RabbitMQ in a debian machine
# Inspired by https://www.rabbitmq.com/install-debian.html

## Install prerequisites
sudo apt-get update -y
sudo apt-get install curl gnupg -y

## Install RabbitMQ signing key
curl -fsSL https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc | sudo apt-key add -
apt-key adv --keyserver "hkps://keys.openpgp.org" --recv-keys "0x0A9AF2115F4687BD29803A206B73A36E6026DFCA"
apt-get install apt-transport-https

## Add Bintray repositories that provision latest RabbitMQ and Erlang 22.x releases
distribution=$(lsb_release -a | grep Codename  | cut -d : -f 2 | xargs)
sudo tee /etc/apt/sources.list.d/bintray.rabbitmq.list <<EOF
deb https://dl.bintray.com/rabbitmq-erlang/debian ${distribution} erlang-22.x
deb https://dl.bintray.com/rabbitmq/debian ${distribution} main
EOF
sudo apt-get update -y

## Install Erlang
sudo apt-get install -y erlang-base \
                        erlang-asn1 erlang-crypto erlang-eldap erlang-ftp erlang-inets \
                        erlang-mnesia erlang-os-mon erlang-parsetools erlang-public-key \
                        erlang-runtime-tools erlang-snmp erlang-ssl \
                        erlang-syntax-tools erlang-tftp erlang-tools erlang-xmerl

## Install rabbitmq-server and its dependencies
sudo apt-get install rabbitmq-server -y --fix-missing
