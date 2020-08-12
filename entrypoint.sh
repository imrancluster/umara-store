#!/bin/sh

curl --request PUT --data-binary @config.yaml http://umara_consul:8500/v1/kv/umara

exec ./umarastore serve
