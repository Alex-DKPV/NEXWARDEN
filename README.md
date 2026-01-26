# 🛡️ NEXWARDEN

**Portfolio pratique en sécurité des infrastructures réseau**

![Network Security](https://img.shields.io/badge/Focus-Network%20%26%20Infrastructure%20Security-blue?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Active-success?style=for-the-badge)
![Lab Based](https://img.shields.io/badge/Approach-Hands--on%20Labs-orange?style=for-the-badge)

---

## 📖 À propos

NEXWARDEN est mon portfolio technique dédié à la **sécurité des réseaux et des infrastructures**. Ce dépôt documente mes travaux pratiques en segmentation réseau, détection d'intrusion, tests d'intrusion internes et configuration sécurisée d'équipements réseau.

**Chaque projet est documenté avec :**
- ❓ Le **contexte** et le problème technique
- 🛠️ La **solution** mise en place (en lab)
- 🧪 **L'environnement** utilisé (VMs, outils, topologies)
- 🎯 Les **compétences** techniques démontrées

---

## 🏗️ Structure du dépôt

### ⭐ **Labs - Projets pratiques**

Environnements de lab simulant des scénarios réels de sécurité réseau.

| Lab | Description | Compétences |
|-----|-------------|-------------|
| **[Lab 01 - Enterprise Attack & Defense](./labs/lab-01-enterprise-attack-defense/)** | Simulation d'attaque depuis Internet vers LAN interne via DMZ | Pivoting, segmentation VLAN, firewall, IDS |
| **[Lab 02 - Suricata IDS Detection](./labs/lab-02-suricata-ids-detection/)** | Déploiement et configuration d'un IDS Suricata | Détection d'intrusion, analyse de trafic, règles personnalisées |

---
| **[Lab 03 - Secure Banking Network Architecture](https://github.com/Alex987411/nexwarden-labs)** ⭐ | Architecture bancaire sécurisée complète avec segmentation réseau | Architecture réseau critique, zones de confiance, défense en profondeur |### 📦 **Scripts - Automatisation**

Scripts utilitaires pour tâches réseau et sécurité.

- **[Network](./scripts/network/)** : Scan, monitoring, analyse de trafic
- **[Pentest](./scripts/pentest/)** : Outils pour tests d'intrusion internes
- **[Hardening](./scripts/hardening/)** : Automatisation de sécurisation système

---

### 🔗 **Du Lab à l'Architecture Réelle**

Les Labs 01 et 02 constituent des **environnements d'apprentissage contrôlés** permettant de maîtriser les fondamentaux de la sécurité réseau (attaque/défense, IDS, détection).

Le **Lab 03** représente une **application concrète** de ces compétences : il s'agit du projet [**nexwarden-labs**](https://github.com/Alex987411/nexwarden-labs), une architecture bancaire sécurisée complète démontrant une approche architecte cybersecurité.

👉 **[Voir le projet nexwarden-labs](https://github.com/Alex987411/nexwarden-labs)**

### ⚙️ **Configurations - Équipements réseau**

Exemples de configurations sécurisées d'équipements réseau.

- **[VyOS](./configs/vyos/)** : Configuration routeur (DHCP, DNS, VPN, NAT)
- **[Firewall](./configs/firewall/)** : Règles de filtrage et politiques d'accès
- **[VLAN](./configs/vlan/)** : Segmentation et isolation réseau

---

### 📝 **Rapports - Documentation professionnelle**

Documentation structurée de tests et audits.

- **[Pentest Reports](./reports/pentest/)** : Rapports de tests d'intrusion avec recommandations
- **[Security Audits](./reports/audits/)** : Audits techniques et méthodologiques

---

## 🎯 Objectif

Démontrer mes compétences pratiques en **sécurité des infrastructures réseau** à travers des labs réalistes, une documentation rigoureuse et une approche méthodique de l'apprentissage.

**Ce que ce portfolio démontre :**
- Capacité à concevoir et sécuriser des architectures réseau
- Maîtrise des outils de détection et de prévention d'intrusion
- Compétences en tests d'intrusion internes (Red Team / Blue Team)
- Rigueur dans la documentation et la communication technique

---

## 🛠️ Technologies utilisées

**Systèmes & Virtualisation :**  
VMware Workstation, GNS3, VirtualBox, Windows Server, Linux (Debian/Ubuntu)

**Offensive Security :**  
Kali Linux, Metasploit, Nmap, Burp Suite, Hydra, SQLMap

**Defensive Security :**  
Suricata, Snort, pfSense, OPNsense, Wazuh, OSSEC

**Réseau & Infrastructure :**  
VyOS, VLANs, Firewall (pfSense/iptables), VPN (WireGuard/OpenVPN), Active Directory

**Scripts & Automatisation :**  
Bash, Python

---

## 📬 Contact

Intéressé par mes projets ou souhaitez discuter de sécurité réseau ?

📧 **Email :** [votre-email@exemple.com]  
🔗 **LinkedIn :** [Votre profil LinkedIn]

---

⭐ **Si ce portfolio vous intéresse, n'hésitez pas à le star !**
