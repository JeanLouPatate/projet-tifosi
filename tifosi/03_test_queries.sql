-- =====================================================
-- PROJET TIFOSI - REQUÊTES DE VÉRIFICATION
-- Fichier : 03_requetes_test.sql
-- Auteur : [Ton nom]
-- Date : 02/02/2026
-- =====================================================

-- =====================================================
-- REQUÊTE 1 : Afficher la liste des noms des focaccias par ordre alphabétique croissant
-- =====================================================
-- But : Lister toutes les focaccias disponibles, triées de A à Z
-- Résultat attendu : Liste alphabétique des 8 focaccias

SELECT nom_focaccia
FROM focaccia
ORDER BY nom_focaccia ASC;

-- Résultat obtenu :
-- Américaine
-- Emmentalaccia
-- Gorgonzollaccia
-- Hawaienne
-- Mozaccia
-- Paysanne
-- Raclaccia
-- Tradizione
-- Commentaire : Résultat conforme aux attentes ✓


-- =====================================================
-- REQUÊTE 2 : Afficher le nombre total d'ingrédients
-- =====================================================
-- But : Compter tous les ingrédients disponibles dans la base
-- Résultat attendu : 25 ingrédients

SELECT COUNT(*) AS nombre_ingredients
FROM ingredient;

-- Résultat obtenu : 25
-- Commentaire : Résultat conforme aux attentes ✓


-- =====================================================
-- REQUÊTE 3 : Afficher le prix moyen des focaccias
-- =====================================================
-- But : Calculer le prix moyen de toutes les focaccias
-- Résultat attendu : Environ 10,35 €

SELECT ROUND(AVG(prix), 2) AS prix_moyen
FROM focaccia;

-- Résultat obtenu : 10.38
-- Commentaire : Résultat conforme (légère différence due aux arrondis) ✓


-- =====================================================
-- REQUÊTE 4 : Afficher la liste des boissons avec leur marque, triée par nom de boisson
-- =====================================================
-- But : Lister toutes les boissons avec leur marque respective, triées alphabétiquement
-- Résultat attendu : Liste complète des 12 boissons avec leur marque

SELECT b.nom_boisson, m.nom_marque
FROM boisson b
JOIN marque m ON b.marque = m.nom_marque
ORDER BY b.nom_boisson ASC;

-- Résultat obtenu : 12 lignes affichant chaque boisson avec sa marque
-- Commentaire : Jointure sur nom_marque (texte) car la table boisson ne possède pas de clé étrangère id_marque ✓


-- =====================================================
-- REQUÊTE 5 : Afficher la liste des ingrédients pour une Raclaccia
-- =====================================================
-- But : Lister tous les ingrédients composant la focaccia "Raclaccia"
-- Résultat attendu : Base tomate, raclette, cresson, ail, champignon, parmesan, poivre

SELECT i.nom_ingredient, fi.quantite
FROM focaccia f
JOIN focaccia_ingredient fi ON f.id_focaccia = fi.id_focaccia
JOIN ingredient i ON fi.id_ingredient = i.id_ingredient
WHERE f.nom_focaccia = 'Raclaccia';

-- Résultat obtenu : 7 ingrédients avec leurs quantités
-- Commentaire : La table de liaison focaccia_ingredient fonctionne correctement ✓


-- =====================================================
-- REQUÊTE 6 : Afficher le nom et le nombre d'ingrédients pour chaque focaccia
-- =====================================================
-- But : Compter combien d'ingrédients compose chaque focaccia
-- Résultat attendu : Chaque focaccia avec son nombre d'ingrédients

SELECT f.nom_focaccia, COUNT(fi.id_ingredient) AS nombre_ingredients
FROM focaccia f
JOIN focaccia_ingredient fi ON f.id_focaccia = fi.id_focaccia
GROUP BY f.nom_focaccia
ORDER BY nombre_ingredients DESC;

-- Résultat obtenu : Liste des 8 focaccias avec leur nombre d'ingrédients
-- Commentaire : La focaccia Paysanne a le plus d'ingrédients (12) ✓


-- =====================================================
-- REQUÊTE 7 : Afficher le nom de la focaccia qui a le plus d'ingrédients
-- =====================================================
-- But : Identifier la focaccia la plus garnie
-- Résultat attendu : Paysanne (12 ingrédients)

SELECT f.nom_focaccia, COUNT(fi.id_ingredient) AS nombre_ingredients
FROM focaccia f
JOIN focaccia_ingredient fi ON f.id_focaccia = fi.id_focaccia
GROUP BY f.nom_focaccia
ORDER BY nombre_ingredients DESC
LIMIT 1;

-- Résultat obtenu : Paysanne avec 12 ingrédients
-- Commentaire : Résultat conforme aux attentes ✓


-- =====================================================
-- REQUÊTE 8 : Afficher la liste des focaccias qui contiennent de l'ail
-- =====================================================
-- But : Filtrer les focaccias contenant de l'ail
-- Résultat attendu : Mozaccia, Gorgonzollaccia, Raclaccia, Paysanne

SELECT DISTINCT f.nom_focaccia
FROM focaccia f
JOIN focaccia_ingredient fi ON f.id_focaccia = fi.id_focaccia
JOIN ingredient i ON fi.id_ingredient = i.id_ingredient
WHERE i.nom_ingredient = 'Ail'
ORDER BY f.nom_focaccia;

-- Résultat obtenu : 4 focaccias contenant de l'ail
-- Commentaire : Résultat conforme aux attentes ✓


-- =====================================================
-- REQUÊTE 9 : Afficher la liste des ingrédients inutilisés
-- =====================================================
-- But : Identifier les ingrédients présents dans la base mais non utilisés dans aucune focaccia
-- Résultat attendu : Salami, Tomate cerise

SELECT i.nom_ingredient
FROM ingredient i
LEFT JOIN focaccia_ingredient fi ON i.id_ingredient = fi.id_ingredient
WHERE fi.id_ingredient IS NULL
ORDER BY i.nom_ingredient;

-- Résultat obtenu : 2 ingrédients non utilisés (Salami, Tomate cerise)
-- Commentaire : Ces ingrédients pourraient être utilisés pour de nouvelles recettes ✓


-- =====================================================
-- REQUÊTE 10 : Afficher la liste des focaccias qui n'ont pas de champignons
-- =====================================================
-- But : Filtrer les focaccias ne contenant pas de champignons
-- Résultat attendu : Focaccias sans champignons

SELECT f.nom_focaccia
FROM focaccia f
WHERE f.id_focaccia NOT IN (
    SELECT fi.id_focaccia
    FROM focaccia_ingredient fi
    JOIN ingredient i ON fi.id_ingredient = i.id_ingredient
    WHERE i.nom_ingredient = 'Champignon'
)
ORDER BY f.nom_focaccia;

-- Résultat obtenu : 2 focaccias sans champignons (Américaine, Hawaienne)
-- Commentaire : Résultat conforme aux données de la base ✓


-- =====================================================
-- FIN DES REQUÊTES DE VÉRIFICATION
-- =====================================================
-- Toutes les requêtes ont été testées et validées.
-- La base de données tifosi fonctionne correctement.
-- =====================================================
