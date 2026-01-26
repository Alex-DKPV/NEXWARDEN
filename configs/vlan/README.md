# Configuration VLAN 🌐

## ❓ Problème
Comment isoler les flux applicatifs, gestion, et invités au sein du même réseau physique ?

## 🛠️ Solution
Segmentation logique en sous-réseaux isolés avec routage inter-VLAN contrôlé par ACL.

## 🧪 Environnement
- **Switches** : Cisco Catalyst (vIOS) / HP ProCurve / Aruba
- **VLANs créés** : VLAN 10 (Admin), VLAN 20 (Users), VLAN 30 (Guest), VLAN 40 (IoT)

## 🎯 Résultats / apprentissages
- Mise en place du principe de segmentation des réseaux.
- Réduction de la surface d'attaque.
- Routage inter-VLAN via routeur L3 avec politiques de sécurité.
