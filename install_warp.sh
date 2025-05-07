#!/bin/bash

# URL diretto del pacchetto RPM di Warp
RPM_URL="https://app.warp.dev/download?package=rpm"

# Scarica il pacchetto RPM
echo "Scaricando l'ultima versione di Warp da $RPM_URL"
curl -L -o /tmp/warp-latest.rpm "$RPM_URL"

# Verifica se il file è stato scaricato correttamente
if [ -f /tmp/warp-latest.rpm ]; then
    # Installa il pacchetto usando rpm-ostree
    rpm-ostree install /tmp/warp-latest.rpm
    # Rimuovi il pacchetto temporaneo
    rm /tmp/warp-latest.rpm
    echo "Warp è stato installato con successo."
else
    echo "Errore: il pacchetto non è stato scaricato correttamente."
fi

