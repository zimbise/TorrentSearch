#!/bin/bash
cd "$(dirname "$0")"
while true; do
  ./Prowlarr >> ../logs/prowlarr.log 2>&1
  echo "[Prowlarr] Restarting in 5 seconds..." >> ../logs/prowlarr.log
  sleep 5
done
