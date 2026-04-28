#!/bin/bash
# =============================================================
# linux-hardening.sh - Script de durcissement Linux
# Auteur  : Alexandre Dossoukpevi
# Projet  : NEXWARDEN - Infrastructure Security Labs
# Version : 1.0 | 2024
# =============================================================

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log_ok()   { echo -e "${GREEN}[OK]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_err()  { echo -e "${RED}[ERR]${NC} $1"; }

check_root() {
  if [[ $EUID -ne 0 ]]; then
    log_err "Ce script doit etre execute en root."
    exit 1
  fi
}

# --- 1. Mise a jour du systeme ---
update_system() {
  log_ok "Mise a jour du systeme..."
  apt-get update -qq && apt-get upgrade -y -qq
  apt-get autoremove -y -qq
}

# --- 2. Durcissement SSH ---
harden_ssh() {
  local SSH_CFG="/etc/ssh/sshd_config"
  log_ok "Durcissement SSH..."
  sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin no/' "$SSH_CFG"
  sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication no/' "$SSH_CFG"
  sed -i 's/^#\?X11Forwarding.*/X11Forwarding no/' "$SSH_CFG"
  sed -i 's/^#\?MaxAuthTries.*/MaxAuthTries 3/' "$SSH_CFG"
  echo "Protocol 2" >> "$SSH_CFG"
  systemctl restart ssh
  log_ok "SSH durci : root desactive, auth par cle uniquement."
}

# --- 3. Configuration du pare-feu (UFW) ---
setup_firewall() {
  log_ok "Configuration UFW..."
  apt-get install -y ufw -qq
  ufw default deny incoming
  ufw default allow outgoing
  ufw allow 22/tcp comment 'SSH'
  ufw --force enable
  log_ok "Pare-feu active : seul SSH autorise en entree."
}

# --- 4. Desactiver services inutiles ---
disable_services() {
  log_ok "Desactivation services inutiles..."
  local SERVICES=("avahi-daemon" "cups" "bluetooth" "telnet")
  for svc in "${SERVICES[@]}"; do
    if systemctl is-active --quiet "$svc" 2>/dev/null; then
      systemctl disable --now "$svc"
      log_warn "$svc desactive."
    fi
  done
}

# --- 5. Securisation /tmp ---
secure_tmp() {
  log_ok "Securisation /tmp..."
  if ! grep -q '/tmp' /etc/fstab; then
    echo "tmpfs /tmp tmpfs defaults,noexec,nosuid,nodev 0 0" >> /etc/fstab
    log_ok "/tmp monte avec noexec, nosuid, nodev."
  else
    log_warn "/tmp deja configure dans /etc/fstab."
  fi
}

# --- 6. Parametres kernel (sysctl) ---
harden_kernel() {
  log_ok "Application parametres sysctl..."
  cat > /etc/sysctl.d/99-nexwarden-hardening.conf << 'EOF'
# NEXWARDEN - Parametres de securite kernel
net.ipv4.ip_forward = 0
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.tcp_syncookies = 1
kernel.dmesg_restrict = 1
kernel.kptr_restrict = 2
fs.suid_dumpable = 0
EOF
  sysctl --system -q
  log_ok "Parametres sysctl appliques."
}

# --- 7. Audit avec auditd ---
install_auditd() {
  log_ok "Installation auditd..."
  apt-get install -y auditd audispd-plugins -qq
  systemctl enable --now auditd
  auditctl -e 1
  log_ok "auditd actif et configure."
}

# --- Main ---
main() {
  echo "============================================"
  echo " NEXWARDEN - Linux Hardening Script v1.0"
  echo " Auteur : Alexandre Dossoukpevi"
  echo "============================================"
  check_root
  update_system
  harden_ssh
  setup_firewall
  disable_services
  secure_tmp
  harden_kernel
  install_auditd
  echo ""
  log_ok "Durcissement termine avec succes !"
  echo "Redemarrez le systeme pour appliquer tous les changements."
}

main "$@"
