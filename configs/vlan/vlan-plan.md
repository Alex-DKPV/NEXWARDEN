# Plan de Segmentation VLAN - NEXWARDEN Lab
# Auteur : Alexandre Dossoukpevi | 2024

## Tableau d'Adressage

| VLAN ID | Nom          | Reseau           | Passerelle     | Description                    |
|---------|--------------|------------------|----------------|--------------------------------|
| 10      | DMZ          | 192.168.10.0/24  | 192.168.10.1   | Services exposes (Web, DNS)    |
| 20      | CORE-BANKING | 192.168.20.0/24  | 192.168.20.1   | Transactions et donnees sensib |
| 30      | SOC          | 192.168.30.0/24  | 192.168.30.1   | Monitoring Wazuh, Suricata     |
| 40      | ADMIN        | 192.168.40.0/24  | 192.168.40.1   | Administration systeme         |
| 99      | MGMT         | 192.168.99.0/24  | 192.168.99.1   | Management Out-of-Band         |

## Regles de Flux Inter-VLAN

| Source       | Destination  | Ports autorises       | Action |
|--------------|--------------|-----------------------|--------|
| DMZ          | CORE-BANKING | 443, 8443             | ACCEPT |
| CORE-BANKING | SOC          | 514, 5044, 9200       | ACCEPT |
| SOC          | ALL          | ANY (monitoring)      | ACCEPT |
| ADMIN        | ALL          | SSH(22), HTTPS(443)   | ACCEPT |
| ANY          | DMZ          | 80, 443               | ACCEPT |
| ANY          | ANY          | -                     | DROP   |

## Hosts par Zone

### VLAN 10 - DMZ
- 192.168.10.10 - Web Server (Nginx)
- 192.168.10.11 - DNS Server
- 192.168.10.12 - Mail Relay

### VLAN 20 - Core Banking
- 192.168.20.10 - Application Server
- 192.168.20.11 - Database Server
- 192.168.20.12 - Backup Server

### VLAN 30 - SOC
- 192.168.30.10 - Wazuh Manager
- 192.168.30.11 - Suricata IDS
- 192.168.30.12 - ELK Stack

### VLAN 40 - Admin
- 192.168.40.10 - Jump Server
- 192.168.40.11 - NMS (Network Mgmt)
