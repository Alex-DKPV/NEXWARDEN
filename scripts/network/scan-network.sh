#!/bin/bash
# =============================================================
# scan-network.sh - Scanner reseau et inventaire d'hotes
# Auteur  : Alexandre Dossoukpevi
# Projet  : NEXWARDEN - Infrastructure Security Labs
# Version : 1.0 | 2024
# =============================================================

set -euo pipefail

GREEN='\033[0;32m' YELLOW='\033[1;33m' NC='\033[0m'
log() { echo -e "${GREEN}[*]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }

check_deps() {
  for tool in nmap arp-scan; do
    if ! command -v "$tool" &>/dev/null; then
      warn "$tool non installe. Installation..."
      apt-get install -y "$tool" -qq
    fi
  done
}

get_local_network() {
  ip route | grep -E 'src' | head -1 | awk '{print $1}'
}

discover_hosts() {
  local SUBNET="$1"
  log "Decouverte des hotes sur $SUBNET..."
  nmap -sn "$SUBNET" -oG - 2>/dev/null | grep 'Up' | awk '{print $2, $3}'
}

port_scan() {
  local HOST="$1"
  log "Scan des ports ouverts sur $HOST..."
  nmap -sS -sV -T4 --open -p 22,80,443,3389,8080,8443,21,23,25,53 \
    "$HOST" 2>/dev/null | grep -E 'open|filtered'
}

check_default_creds() {
  local HOST="$1"
  warn "Verification des services sur $HOST..."
  nmap --script=ssh-auth-methods -p 22 "$HOST" 2>/dev/null | \
    grep -E 'publickey|password|keyboard'
}

generate_report() {
  local SUBNET="$1"
  local REPORT="/tmp/nexwarden-scan-$(date +%Y%m%d-%H%M%S).txt"
  {
    echo "# NEXWARDEN - Rapport de Scan Reseau"
    echo "# Date : $(date)"
    echo "# Reseau : $SUBNET"
    echo "# Auteur : Alexandre Dossoukpevi"
    echo "#-----------------------------------"
    echo ""
    discover_hosts "$SUBNET"
  } > "$REPORT"
  log "Rapport genere : $REPORT"
}

main() {
  echo "====================================="
  echo " NEXWARDEN - Network Scanner v1.0"
  echo " Auteur : Alexandre Dossoukpevi"
  echo "====================================="

  if [[ $EUID -ne 0 ]]; then
    warn "Certaines fonctions necessitent les droits root."
  fi

  check_deps

  local SUBNET
  SUBNET="${1:-$(get_local_network)}"

  if [[ -z "$SUBNET" ]]; then
    echo "Usage: $0 [subnet ex: 192.168.1.0/24]"
    exit 1
  fi

  log "Reseau cible : $SUBNET"
  generate_report "$SUBNET"

  log "Scan termine."
}

main "$@"
