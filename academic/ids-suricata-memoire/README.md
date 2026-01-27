# 🎯 IDS Suricata – Mémoire de Soutenance

![Type](https://img.shields.io/badge/type-académique-purple?style=for-the-badge)
![Status](https://img.shields.io/badge/statut-validé-success?style=for-the-badge)
![Year](https://img.shields.io/badge/année-2024-blue?style=for-the-badge)

> **Projet académique terminé** : Mémoire de soutenance sur l'implémentation de Suricata pour la détection des intrusions dans un réseau informatique d'entreprise.

---

## 📚 Contexte Académique

### Établissement
- **Institution** : [Votre université/école]
- **Diplôme** : Licence / Master en Cybersécurité
- **Année** : 2024
- **Cas d'étude** : Entreprise NGCom Services (Cotonou, Bénin)

### Objectifs du Mémoire

1. **Comprendre les systèmes de détection d'intrusion (IDS)**
2. **Déployer Suricata dans un environnement virtualisé**
3. **Configurer des règles de détection personnalisées**
4. **Tester la détection face à différents types d'attaques**
5. **Automatiser les alertes de sécurité**
6. **Rédiger une documentation technique rigoureuse**

---

## 🏗️ Architecture Mise en Place

### Environnement Virtualisé

- **Plateforme** : VMware Workstation Pro 17
- **Simulateur réseau** : GNS3
- **Segmentation** : 3 zones (WAN, DMZ, LAN)

### Machines Virtuelles

| Machine | Système | Rôle | Zone |
|---------|----------|------|------|
| **Serveur IDS** | Ubuntu Server 22.04 | Hôte Suricata + scripts alertes | DMZ |
| **Pare-feu** | pfSense | Routage + Filtrage | DMZ |
| **Serveur Web** | Windows Server 2022 | Service exposé (cible) | DMZ |
| **Poste Utilisateur** | Windows 11 | Utilisateur interne | LAN |
| **Machine Attaquante** | Kali Linux | Simulation d'attaques | WAN |

---

## 🔍 Travaux Réalisés

### 1. Installation et Configuration Suricata

✅ **Installation** via apt sur Ubuntu Server
✅ **Configuration** des interfaces réseau (WAN, LAN, DMZ)
✅ **Activation** des règles de détection (Emerging Threats)
✅ **Personnalisation** de règles spécifiques au contexte

### 2. Scénarios de Tests

| Attaque Testée | Outil | Détection | Résultat |
|-----------------|-------|-----------|----------|
| Scan réseau UDP | Nmap | ✅ Détecté | Alerte générée |
| Scan réseau TCP SYN | Nmap | ✅ Détecté | Alerte générée |
| Scan de services | Nmap | ✅ Détecté | Alerte générée |
| Reconnaissance interne | Nmap (LAN→DMZ) | ✅ Détecté | Alerte temps réel |

### 3. Système d'Alertes Automatisé

✅ **Script Python** pour surveillance du fichier `fast.log`
✅ **Intégration Gotify** pour notifications instantanées
✅ **Service systemd** pour exécution automatique au démarrage
✅ **Alertes mobiles** via application Gotify

---

## 📊 Résultats Obtenus

### Performance de Détection

- **100% des scans réseau détectés**
- **Temps de réponse moyen** : < 2 secondes
- **Taux de faux positifs** : Faible (après calibrage des règles)
- **Notifications** : Envoyées instantanément aux administrateurs

### Apports du Projet

**Techniques** :
- Maîtrise de Suricata (IDS open-source)
- Compréhension des architectures réseau segmentées
- Pratique de la virtualisation (VMware + GNS3)
- Scripting Python pour automatisation

**Méthodologiques** :
- Rigueur dans la documentation technique
- Approche expérimentale (tests, mesures, analyse)
- Rédaction académique structurée

---

## 📂 Contenu du Mémoire

### Structure du Document

1. **Introduction** : Contexte et problématique
2. **État de l'art** : Réseaux, sécurité, IDS/IPS
3. **Matériel et méthodes** : Environnement technique, méthodologie
4. **Résultats et discussion** : Tests, détections, analyses
5. **Conclusion** : Synthèse, limites, perspectives
6. **Annexes** : Scripts, configurations, captures

### Fichiers Disponibles

```
academic/ids-suricata-memoire/
├── README.md                  # Ce fichier
├── rapport/
│   └── memoire-suricata.pdf  # Mémoire complet (disponible sur demande)
├── configs/
│   ├── suricata.yaml        # Configuration Suricata
│   └── custom-rules.rules   # Règles personnalisées
├── scripts/
│   └── suricata-alert-notifier.py  # Script Python d'alertes
└── captures/
    ├── fast.log.sample      # Exemple d'alertes générées
    └── screenshots/         # Captures d'écran (Gotify, Suricata)
```

---

## 🧠 Compétences Démontrées

`IDS/IPS` `Suricata` `Détection d'intrusion` `Analyse de trafic` `Virtualisation` `VMware` `GNS3` `Scripting Python` `Automatisation` `Réseaux` `Segmentation VLAN` `pfSense` `Documentation technique` `Méthodologie académique`

---

## 🔗 Lien avec le Portfolio

Ce projet académique **terminé et validé** démontre une **rigueur méthodologique** et une **maîtrise des fondamentaux IDS**. Il constitue la base théorique et pratique qui a permis d'évoluer vers des projets professionnels plus complexes, notamment l'architecture bancaire sécurisée (voir [nexwarden-labs](https://github.com/Alex987411/nexwarden-labs)).

**Progression** :
- **Académique** : Maîtrise de Suricata en environnement contrôlé
- **Professionnel** : Application à une architecture bancaire complète

---

## 💬 Lien vers le Portfolio NEXWARDEN

- **Dépôt principal** : [Alex987411/NEXWARDEN](https://github.com/Alex987411/NEXWARDEN)
- **Projet professionnel** : [nexwarden-labs (Architecture Bancaire)](https://github.com/Alex987411/nexwarden-labs)
- **Portfolio web** : Disponible sur le dépôt principal

---

## 📬 Contact

- **LinkedIn** : [Alexandre DOSSOUKPEVI](https://www.linkedin.com/in/nexwarden)
- **Email** : Disponible sur demande via LinkedIn
- **GitHub** : [Alex987411](https://github.com/Alex987411)

---

## 📝 Note Importante

> Ce projet est un **travail académique** réalisé dans un cadre pédagogique. Le mémoire complet est disponible sur demande. Les configurations et scripts présentés sont à usage éducatif et de démonstration.
