#!/bin/bash
set -euo pipefail

# Aggiungi il repository Brave
echo "Aggiunta del repository Brave..."
curl -fsSLo /etc/yum.repos.d/brave-browser.repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo

# Verifica che il repository sia stato aggiunto correttamente
echo "Contenuto del repository Brave:"
cat /etc/yum.repos.d/brave-browser.repo

# Aggiorna i metadati dei repository
echo "Aggiornamento dei metadati dei repository..."
rpm-ostree refresh-md

# Elenca i pacchetti disponibili nel repository Brave
echo "Pacchetti disponibili nel repository Brave:"
rpm-ostree search brave-browser

# Installa Brave Browser
echo "Installazione di Brave Browser..."
rpm-ostree install -y brave-browser

# Verifica che il pacchetto sia stato installato
echo "Verifica dell'installazione:"
rpm -qa | grep brave

echo "Brave Browser installato con successo!" 