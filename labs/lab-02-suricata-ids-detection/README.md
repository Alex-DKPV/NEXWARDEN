
# 🔍 Lab 02 - Détection d'intrusion avec Suricata IDS

## ⭐ Lab Signature

![Difficulté](https://img.shields.io/badge/Difficulté-Intermédiaire-orange) ![Type](https://img.shields.io/badge/Type-Blue%20Team%20Défense-blue)

---

## ❓ Problème

Comment détecter efficacement les tentatives d'intrusion et les activités malveillantes sur un réseau d'entreprise ? Comment mettre en place un système de détection d'intrusion (IDS) robuste avec Suricata ?

---

## 🛠️ Solution

Mise en place d'un IDS **Suricata** pour surveiller le trafic réseau, détecter les attaques courantes et générer des alertes en temps réel.

**Fonctionnalités déployées :**
- ✅ Installation et configuration de Suricata
- ✅ Règles de détection personnalisées
- ✅ Analyse de trafic en temps réel
- ✅ Génération d'alertes pour tentatives d'intrusion
- ✅ Intégration avec Eve JSON pour analyse avancée

---

## 🧪 Environnement

### Architecture réseau

```
[Attaquant (Kali)]  →  [IDS Suricata]  →  [Réseau Interne]
    192.168.1.50         10.0.0.5              10.0.1.0/24
```

### Machines virtuelles

| Machine | OS | Rôle | IP |
|---------|----|-  ----|
| Kali Linux | Kali 2025.1 | Machine d'attaque | 192.168.1.50 |
| IDS Server | Ubuntu 22.04 + Suricata | Détection d'intrusion | 10.0.0.5 |
| Web Server | Ubuntu 22.04 | Serveur web cible | 10.0.1.10 |
| Client | Windows 10 | Poste utilisateur | 10.0.1.100 |

---

## 🎯 Objectifs

✅ Installer et configurer Suricata sur Ubuntu  
✅ Déployer des règles de détection (Emerging Threats, règles custom)  
✅ Tester la détection avec des attaques simulées (scan Nmap, exploitation Metasploit)  
✅ Analyser les logs et les alertes générées  
✅ Optimiser les règles pour réduire les faux positifs

---

## 📋 Étapes de réalisation

### 1️⃣ Installation de Suricata

```bash
sudo apt update
sudo apt install suricata -y
sudo systemctl enable suricata
sudo systemctl start suricata
```

### 2️⃣ Configuration de Suricata

**Édition du fichier de configuration** (`/etc/suricata/suricata.yaml`) :

```yaml
vars:
  address-groups:
    HOME_NET: "[10.0.1.0/24]"
    EXTERNAL_NET: "!$HOME_NET"

af-packet:
  - interface: eth0
    threads: auto
```

### 3️⃣ Mise à jour des règles

```bash
sudo suricata-update
sudo suricata-update list-sources
sudo suricata-update enable-source et/open
sudo systemctl restart suricata
```

### 4️⃣ Règles personnalisées

**Ajout de règles custom** (`/etc/suricata/rules/local.rules`) :

```suricata
# Détection de scan Nmap SYN
alert tcp any any -> $HOME_NET any (msg:"Possible Nmap SYN scan"; flags:S; threshold: type both, track by_src, count 30, seconds 10; sid:1000001; rev:1;)

# Détection de scan Nmap NULL
alert tcp any any -> $HOME_NET any (msg:"Possible Nmap NULL scan"; flags:0; threshold: type both, track by_src, count 20, seconds 5; sid:1000002; rev:1;)

# Détection de reverse shell
alert tcp $HOME_NET any -> $EXTERNAL_NET any (msg:"Possible reverse shell connection"; flow:to_server,established; content:"/bin/sh"; sid:1000003; rev:1;)
```

### 5️⃣ Tests d'intrusion simulés

**Depuis Kali Linux** :

```bash
# Scan Nmap
nmap -sS -p- 10.0.1.10

# Exploitation avec Metasploit
msfconsole
use exploit/multi/handler
set payload linux/x64/shell_reverse_tcp
set LHOST 192.168.1.50
set LPORT 4444
exploit
```

### 6️⃣ Analyse des alertes

**Consultation des logs** :

```bash
# Alertes en temps réel
sudo tail -f /var/log/suricata/fast.log

# Logs JSON pour analyse détaillée
sudo tail -f /var/log/suricata/eve.json | jq '.alert'
```

---

## 📊 Résultats / Apprentissages

🔹 **Détection** : Capacité à identifier les scans réseau, exploitations et comportements anormaux  
🔹 **Configuration** : Maîtrise de la configuration avancée de Suricata (interfaces, règles, seuils)  
🔹 **Analyse de logs** : Utilisation d'Eve JSON pour corrélation et analyse forensique  
🔹 **Optimisation** : Réduction des faux positifs par ajustement des règles  
🔹 **Intégration** : Compréhension du rôle d'un IDS dans une architecture de défense en profondeur

---

## 🔐 Bonnes pratiques

✅ Mettre à jour régulièrement les règles de détection  
✅ Surveiller les performances système (CPU, mémoire)  
✅ Configurer des alertes par email ou SIEM  
✅ Tester régulièrement la détection avec des simulations d'attaque  
✅ Documenter les incidents détectés et les faux positifs

---

**💡 Ce lab démontre une approche pratique de la détection d'intrusion et de l'analyse défensive.**
