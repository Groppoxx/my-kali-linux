#!/bin/bash

# Script para reparar historial corrupto de Zsh

HIST_FILE="$HOME/.zsh_history"
BACKUP_FILE="$HOME/.zsh_history_bad_$(date +%F_%H-%M-%S)"

echo "[*] Reparando historial de Zsh..."

if ! command -v zsh &>/dev/null; then
    echo "[!] Zsh no está instalado. Abortando."
    exit 1
fi

if [[ ! -f "$HIST_FILE" ]]; then
    echo "[!] No se encontró $HIST_FILE. Nada que reparar."
    exit 0
fi

echo "[*] Creando backup del historial corrupto..."
mv "$HIST_FILE" "$BACKUP_FILE"

echo "[*] Reconstruyendo historial limpio..."
strings "$BACKUP_FILE" > "$HIST_FILE"

chmod 600 "$HIST_FILE"

echo "[*] Recargando historial en la sesión actual..."
fc -R "$HIST_FILE" 2>/dev/null || true

echo "[*] Eliminando backup temporal..."
rm -f "$BACKUP_FILE"

echo "[+] Historial de Zsh reparado correctamente."
echo "[+] Ya puedes usar ↑ ↓ y CTRL+R sin errores."