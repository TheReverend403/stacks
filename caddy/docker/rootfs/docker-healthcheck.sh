#!/bin/sh
set -eu

curl -sSL "http://127.0.0.1:2019/metrics" >/dev/null && echo "OK"
