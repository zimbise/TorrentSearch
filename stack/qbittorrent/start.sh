#!/bin/bash
mkdir -p ~/.config/qBittorrent
cd ~/TorrentSearch/stack/qbittorrent
while true; do
  qbittorrent-nox --webui-port=8080 >> ../logs/qbittorrent.log 2>&1
  echo "[qBittorrent] Restarting in 5 seconds..." >> ../logs/qbittorrent.log
  sleep 5
done
