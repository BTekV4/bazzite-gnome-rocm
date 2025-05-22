#!/bin/bash
set -euo pipefail

# Aggiungi il repository Brave
echo "Aggiunta del repository Brave..."
curl -fsSLo /etc/yum.repos.d/brave-browser.repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo

# Installa Brave Browser
echo "Installazione di Brave Browser..."
rpm-ostree install -y brave-browser

echo "Brave Browser installato con successo!" 