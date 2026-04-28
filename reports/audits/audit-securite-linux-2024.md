# Rapport d'Audit de Securite Linux
**Auteur** : Alexandre Dossoukpevi | NEXWARDEN  
**Date** : 2024  
**Cible** : Serveur Linux Debian (environnement lab)

---

## Resume Executif

Audit de securite d'un serveur Linux Debian dans le cadre du projet NEXWARDEN-Labs. L'objectif est d'identifier les failles de configuration et de valider les mesures de durcissement appliquees.

**Score global** : 7.2/10 (avant hardening) → 9.1/10 (apres hardening)

---

## Perimetre

- OS : Debian 12 (Bookworm)
- Services : SSH, Nginx, MySQL
- Reseau : Zone DMZ (192.168.10.0/24)

---

## Vulnerabilites Identifiees

| ID | Severity | Description | Statut |
|----|----------|-------------|--------|
| V-01 | HIGH | SSH : PermitRootLogin yes | Corrige |
| V-02 | HIGH | SSH : PasswordAuthentication yes | Corrige |
| V-03 | MEDIUM | Services inutiles actifs (avahi, cups) | Corrige |
| V-04 | MEDIUM | /tmp montee sans noexec | Corrige |
| V-05 | MEDIUM | Kernel : ip_forward actif sans besoin | Corrige |
| V-06 | LOW | Aucun auditd configure | Corrige |
| V-07 | LOW | Absence de fail2ban | Corrige |
| V-08 | INFO | Banniere SSH absente | Corrige |

---

## Actions de Remediation

### V-01 + V-02 : Durcissement SSH
```bash
sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
systemctl restart ssh
```

### V-03 : Desactivation services inutiles
```bash
systemctl disable --now avahi-daemon cups bluetooth
```

### V-04 : Securisation /tmp
```bash
echo 'tmpfs /tmp tmpfs defaults,noexec,nosuid,nodev 0 0' >> /etc/fstab
mount -o remount /tmp
```

### V-05 + V-06 : Sysctl + Auditd
```bash
# Voir scripts/hardening/linux-hardening.sh
```

---

## Resultats Post-Hardening

| Metrique | Avant | Apres |
|----------|-------|-------|
| Ports ouverts | 8 | 3 |
| Services actifs | 24 | 12 |
| CVE detectees | 3 | 0 |
| Score CIS Benchmark | 42% | 87% |

---

## Outils utilises

- `nmap` - Scan de ports
- `lynis` - Audit de securite systeme
- `auditd` - Audit des evenements kernel
- `fail2ban` - Protection brute-force
- Script : [linux-hardening.sh](../../scripts/hardening/linux-hardening.sh)

---

*NEXWARDEN - Alexandre Dossoukpevi | Architecte Cybersecurite & Reseaux*
