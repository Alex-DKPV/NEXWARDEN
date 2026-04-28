#!/bin/bash
# iptables-rules.sh - Regles Firewall NEXWARDEN Lab
# Auteur : Alexandre Dossoukpevi | 2024
# Architecture : DMZ / Core Banking / SOC / Admin

IPT="iptables"

# Interfaces
WAN="eth0"
DMZ="eth1"
CORE="eth2"
SOC="eth3"
ADMIN="eth4"

echo "[*] Application des regles iptables NEXWARDEN..."

# --- Remise a zero ---
$IPT -F
$IPT -X
$IPT -t nat -F
$IPT -t nat -X

# --- Politiques par defaut ---
$IPT -P INPUT   DROP
$IPT -P FORWARD DROP
$IPT -P OUTPUT  ACCEPT

# --- Loopback autorise ---
$IPT -A INPUT -i lo -j ACCEPT
$IPT -A OUTPUT -o lo -j ACCEPT

# --- Connexions etablies ---
$IPT -A INPUT   -m state --state ESTABLISHED,RELATED -j ACCEPT
$IPT -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

# =============================================
# FLUX WAN -> DMZ (HTTP/HTTPS public)
# =============================================
$IPT -A FORWARD -i $WAN -o $DMZ -p tcp --dport 80  -m state --state NEW -j ACCEPT
$IPT -A FORWARD -i $WAN -o $DMZ -p tcp --dport 443 -m state --state NEW -j ACCEPT

# =============================================
# FLUX DMZ -> CORE (Applications internes)
# =============================================
$IPT -A FORWARD -i $DMZ -o $CORE -p tcp --dport 443  -j ACCEPT
$IPT -A FORWARD -i $DMZ -o $CORE -p tcp --dport 8443 -j ACCEPT
# Bloquer tout le reste DMZ -> CORE
$IPT -A FORWARD -i $DMZ -o $CORE -j LOG --log-prefix "[DMZ->CORE BLOCK] "
$IPT -A FORWARD -i $DMZ -o $CORE -j DROP

# =============================================
# FLUX CORE -> SOC (Logs et monitoring)
# =============================================
$IPT -A FORWARD -i $CORE -o $SOC -p tcp --dport 514  -j ACCEPT  # Syslog
$IPT -A FORWARD -i $CORE -o $SOC -p udp --dport 514  -j ACCEPT
$IPT -A FORWARD -i $CORE -o $SOC -p tcp --dport 5044 -j ACCEPT  # Logstash
$IPT -A FORWARD -i $CORE -o $SOC -p tcp --dport 9200 -j ACCEPT  # Elasticsearch

# =============================================
# FLUX SOC -> ALL (Monitoring entrant)
# =============================================
$IPT -A FORWARD -i $SOC -p tcp --dport 22   -j ACCEPT  # SSH monitoring
$IPT -A FORWARD -i $SOC -p tcp --dport 443  -j ACCEPT  # HTTPS admin
$IPT -A FORWARD -i $SOC -p icmp            -j ACCEPT  # Ping

# =============================================
# FLUX ADMIN -> ALL (Administration)
# =============================================
$IPT -A FORWARD -i $ADMIN -j ACCEPT

# =============================================
# BLOQUER tout le reste + LOG
# =============================================
$IPT -A FORWARD -j LOG --log-prefix "[FW DROP] " --log-level 4
$IPT -A FORWARD -j DROP

# =============================================
# NAT - Masquerade sortie WAN
# =============================================
$IPT -t nat -A POSTROUTING -o $WAN -j MASQUERADE

# Activer forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward

echo "[OK] Regles iptables appliquees."
$IPT -L -n -v --line-numbers | head -40
