#!/bin/bash
bash ~/TorrentSearch/stack/jackett/start.sh &
bash ~/TorrentSearch/stack/prowlarr/start.sh &
bash ~/TorrentSearch/stack/qbittorrent/start.sh &
echo "[STACK] All services started."
