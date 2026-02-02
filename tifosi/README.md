# 🍕 Projet Tifosi - Base de données restaurant

## 📋 Description

Base de données relationnelle pour **Le Tifosi**, restaurant de street-food italien. Ce projet permet la gestion complète des focaccias, ingrédients, boissons, marques et menus du restaurant.

## 🎯 Objectifs du projet

- Créer une base de données dynamique et normalisée
- Gérer les relations entre focaccias et leurs ingrédients
- Permettre des requêtes complexes sur les produits
- Assurer l'intégrité des données via des contraintes

## 📁 Structure du dépôt

```
tifosi/
│
├── README.md                    # Documentation du projet
├── 01_create_schema.sql         # Création de la base et des tables
├── 02_insert_data.sql           # Insertion des données de test
└── 03_requetes_test.sql         # 10 requêtes de vérification
```

## 🗄️ Schéma de la base de données

### Tables principales
- **marque** : Marques de boissons (Coca-cola, Pepsico, Monster, Cristalline)
- **ingredient** : 25 ingrédients disponibles
- **focaccia** : 8 focaccias du menu
- **boisson** : 12 boissons proposées
- **client** : Informations des clients
- **menu** : Menus composés

### Tables de liaison
- **focaccia_ingredient** : Composition des focaccias (avec quantités en grammes)
- **achete** : Historique des achats clients
- **est_constitue** : Composition des menus (focaccias)
- **contient** : Composition des menus (boissons)

## 🚀 Installation

### Prérequis
- MySQL 5.7+ ou MariaDB 10.3+
- Accès root à MySQL

### Étapes d'installation

1. **Créer la base de données et l'utilisateur**
```bash
mysql -u root -p < 01_create_schema.sql
```

2. **Peupler la base avec les données de test**
```bash
mysql -u tifosi -p tifosi < 02_insert_data.sql
```
*Mot de passe : `tifosi123`*

3. **Tester les requêtes de vérification**
```bash
mysql -u tifosi -p tifosi < 03_requetes_test.sql
```

## 🔍 Requêtes de test

Le fichier `03_requetes_test.sql` contient 10 requêtes qui permettent de vérifier le bon fonctionnement de la base :

1. ✅ Liste des focaccias par ordre alphabétique
2. ✅ Nombre total d'ingrédients
3. ✅ Prix moyen des focaccias
4. ✅ Liste des boissons avec leur marque
5. ✅ Ingrédients d'une focaccia spécifique (Raclaccia)
6. ✅ Nombre d'ingrédients par focaccia
7. ✅ Focaccia avec le plus d'ingrédients
8. ✅ Focaccias contenant de l'ail
9. ✅ Ingrédients non utilisés
10. ✅ Focaccias sans champignons

## 📊 Données de test

### Focaccias (8)
- Mozaccia (9,80 €)
- Gorgonzollaccia (10,80 €)
- Raclaccia (8,90 €)
- Emmentalaccia (9,80 €)
- Tradizione (8,90 €)
- Hawaienne (11,20 €)
- Américaine (10,80 €)
- Paysanne (12,80 €)

### Ingrédients (25)
Base tomate, Base crème, Mozarella, Gorgonzola, Raclette, Emmental, Chèvre, Parmesan, Jambon cuit, Jambon fumé, Bacon, Cresson, Champignon, Artichaut, Pomme de terre, Oignon, Ail, Piment, Poivre, Olive noire, Olive verte, Ananas, Œuf, Salami, Tomate cerise

### Boissons (12)
Coca-cola (zéro, original), Fanta (citron, orange), Capri-sun, Pepsi (classique, Max Zéro), Lipton (zéro citron, Peach), Monster (ultra gold, ultra blue), Eau de source

## ⚙️ Caractéristiques techniques

- **Encodage** : UTF-8 (utf8mb4)
- **Moteur** : InnoDB (sauf focaccia_ingredient en MyISAM)
- **Contraintes** : 
  - Clés primaires sur toutes les tables
  - Clés étrangères avec `ON DELETE CASCADE`
  - Contraintes `CHECK` sur les prix (> 0)
  - Contraintes `UNIQUE` sur les noms
  - Contraintes `NOT NULL` sur les champs obligatoires

## 👤 Utilisateur de la base

- **Nom d'utilisateur** : `tifosi`
- **Mot de passe** : `tifosi123`
- **Privilèges** : Tous les droits sur la base `tifosi`

⚠️ *Note : Ce mot de passe simple est utilisé uniquement dans un cadre de développement/test*

## 📝 Notes importantes

- La table `boisson` utilise une jointure textuelle avec `marque` (colonne `marque` en VARCHAR au lieu de clé étrangère `id_marque`)
- Les quantités dans `focaccia_ingredient` sont exprimées en grammes
- 2 ingrédients ne sont pas utilisés : Salami et Tomate cerise (disponibles pour de futures recettes)

## 🧪 Tests validés

✅ Toutes les requêtes de test ont été exécutées avec succès  
✅ Les résultats obtenus correspondent aux attentes  
✅ L'intégrité référentielle est respectée  
✅ Les contraintes fonctionnent correctement

## 📅 Informations du projet

- **Date de création** : Février 2026
- **Contexte** : Projet académique - Gestion de base de données
- **SGBD** : MySQL / MariaDB

## 📧 Contact

Pour toute question concernant ce projet, veuillez consulter la documentation ou les commentaires dans les fichiers SQL.

---

*Projet réalisé dans le cadre d'un exercice de conception de base de données relationnelle* 🎓
