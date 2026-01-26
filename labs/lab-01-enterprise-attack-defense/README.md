# 🧪 Lab 01 - Enterprise Network Under Attack

## ⭐ Lab Signature

![Difficultés](https://img.shields.io/badge/Difficult%C3%A9-Interm%C3%A9diaire-orange)
![Type](https://img.shields.io/badge/Type-Red%20%26%20Blue%20Team-blueviolet)

---

## ❓ Problème

Comment une petite/moyenne entreprise peut-elle être compromise depuis Internet ? Quelles sont les défenses réseau efficaces pour limiter l'impact d'une intrusion ?

## 🛠️ Solution

Simulation d'une infrastructure d'entreprise réaliste avec :
- **LAN interne** (postes utilisateurs, serveurs)
- **DMZ** (serveur web exposé)
- **Active Directory** (gestion centralisée)
- **Firewall** (segmentation réseau)
- **IDS** (détection d'intrusion)

**Phase Red Team** : Attaque depuis Kali Linux (scan, exploitation, pivot vers LAN interne)  
**Phase Blue Team** : Détection via IDS, mise en place de règles firewall, segmentation VLAN, durcissement

---

## 🧪 Environnement

### Architecture réseau

_Diagramme réseau à venir_

### Machines virtuelles

| Machine | OS | Rôle | IP |
|---------|----|----- |----|
| Kali Linux | Kali 2025.1 | Attaquant | 192.168.1.50 |
| Firewall | pfSense 2.7 | Routeur/Firewall | 192.168.1.1 / 10.0.0.1 |
| Web Server | Ubuntu 22.04 | Serveur web (DMZ) | 10.0.0.10 |
| DC | Windows Server 2022 | Active Directory | 10.0.1.5 |
| Client | Windows 10 | Poste utilisateur | 10.0.1.100 |
| IDS | Ubuntu + Suricata | Détection | 10.0.0.5 |

---

## 🎯 Objectifs

✅ Comprendre le chemin d'attaque depuis Internet vers le LAN  
✅ Identifier les points faibles d'une architecture réseau  
✅ Mettre en place une détection efficace via IDS  
✅ Appliquer des contre-mesures (firewall, segmentation)  
✅ Documenter l'attaque et la défense de manière professionnelle  

---

## 📊 Résultats / Apprentissages

🔹 **Technique** : Maîtrise du pivoting réseau, segmentation VLAN, règles firewall avancées  
🔹 **Détection** : Configuration d'IDS, analyse de logs, corrélation d'événements  
🔹 **Défense** : Application de contre-mesures pragmatiques, durcissement système  
🔹 **Documentation** : Capacité à expliquer l'attaque et la défense de manière claire  

---

**💡 Ce lab démontre une approche complète Red Team / Blue Team sur une infrastructure réaliste.**
