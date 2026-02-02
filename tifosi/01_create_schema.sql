-- =====================================================
-- PROJET TIFOSI - CRÉATION DU SCHÉMA DE BASE DE DONNÉES
-- Fichier : 01_create_schema.sql
-- Description : Création de la base de données, de l'utilisateur
--               et de toutes les tables avec leurs contraintes
-- Date : 02/02/2026
-- =====================================================

-- =====================================================
-- SUPPRESSION ET CRÉATION DE LA BASE DE DONNÉES
-- =====================================================

-- Suppression de la base si elle existe (pour rejouabilité)
DROP DATABASE IF EXISTS tifosi;

-- Création de la base avec encodage UTF-8
CREATE DATABASE tifosi 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_general_ci;

-- Sélection de la base
USE tifosi;


-- =====================================================
-- CRÉATION DE L'UTILISATEUR ET ATTRIBUTION DES DROITS
-- =====================================================

-- Suppression de l'utilisateur s'il existe
DROP USER IF EXISTS 'tifosi'@'localhost';

-- Création de l'utilisateur avec mot de passe
CREATE USER 'tifosi'@'localhost' IDENTIFIED BY 'tifosi123';

-- Attribution de tous les privilèges sur la base tifosi
GRANT ALL PRIVILEGES ON tifosi.* TO 'tifosi'@'localhost';

-- Application des changements
FLUSH PRIVILEGES;

-- Note : Le mot de passe simple est utilisé uniquement dans un cadre de développement/test


-- =====================================================
-- CRÉATION DES TABLES PRINCIPALES
-- =====================================================

-- -----------------------------------------------------
-- Table : marque
-- Description : Stocke les marques de boissons
-- -----------------------------------------------------
CREATE TABLE marque (
    id_marque INT AUTO_INCREMENT PRIMARY KEY,
    nom_marque VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table : ingredient
-- Description : Stocke tous les ingrédients disponibles
-- -----------------------------------------------------
CREATE TABLE ingredient (
    id_ingredient INT AUTO_INCREMENT PRIMARY KEY,
    nom_ingredient VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table : focaccia
-- Description : Stocke les différentes focaccias du menu
-- -----------------------------------------------------
CREATE TABLE focaccia (
    id_focaccia INT AUTO_INCREMENT PRIMARY KEY,
    nom_focaccia VARCHAR(100) NOT NULL UNIQUE,
    prix DECIMAL(5,2) NOT NULL CHECK (prix > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table : boisson
-- Description : Stocke les boissons disponibles
-- -----------------------------------------------------
CREATE TABLE boisson (
    id_boisson INT AUTO_INCREMENT PRIMARY KEY,
    nom_boisson VARCHAR(100) NOT NULL,
    marque VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table : client
-- Description : Stocke les informations des clients
-- -----------------------------------------------------
CREATE TABLE client (
    id_client INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    age INT CHECK (age > 0 AND age < 150),
    cp VARCHAR(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table : menu
-- Description : Stocke les menus proposés
-- -----------------------------------------------------
CREATE TABLE menu (
    id_menu INT AUTO_INCREMENT PRIMARY KEY,
    nom_menu VARCHAR(100) NOT NULL UNIQUE,
    prix DECIMAL(5,2) NOT NULL CHECK (prix > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- =====================================================
-- CRÉATION DES TABLES DE LIAISON (RELATIONS N-N)
-- =====================================================

-- -----------------------------------------------------
-- Table : focaccia_ingredient
-- Description : Relation N-N entre focaccia et ingredient
--               Indique quels ingrédients composent chaque focaccia
-- -----------------------------------------------------
CREATE TABLE focaccia_ingredient (
    id_focaccia INT NOT NULL,
    id_ingredient INT NOT NULL,
    quantite INT DEFAULT NULL COMMENT 'Quantité en grammes',
    PRIMARY KEY (id_focaccia, id_ingredient),
    FOREIGN KEY (id_focaccia) REFERENCES focaccia(id_focaccia) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_ingredient) REFERENCES ingredient(id_ingredient) 
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table : achete
-- Description : Relation N-N entre client et menu
--               Enregistre les achats des clients
-- -----------------------------------------------------
CREATE TABLE achete (
    id_client INT NOT NULL,
    id_menu INT NOT NULL,
    jour DATE NOT NULL,
    PRIMARY KEY (id_client, id_menu, jour),
    FOREIGN KEY (id_client) REFERENCES client(id_client) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_menu) REFERENCES menu(id_menu) 
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table : est_constitue
-- Description : Relation N-N entre menu et focaccia
--               Indique quelles focaccias composent chaque menu
-- -----------------------------------------------------
CREATE TABLE est_constitue (
    id_menu INT NOT NULL,
    id_focaccia INT NOT NULL,
    PRIMARY KEY (id_menu, id_focaccia),
    FOREIGN KEY (id_menu) REFERENCES menu(id_menu) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_focaccia) REFERENCES focaccia(id_focaccia) 
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table : contient
-- Description : Relation N-N entre menu et boisson
--               Indique quelles boissons sont incluses dans chaque menu
-- -----------------------------------------------------
CREATE TABLE contient (
    id_menu INT NOT NULL,
    id_boisson INT NOT NULL,
    PRIMARY KEY (id_menu, id_boisson),
    FOREIGN KEY (id_menu) REFERENCES menu(id_menu) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_boisson) REFERENCES boisson(id_boisson) 
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- =====================================================
-- FIN DE LA CRÉATION DU SCHÉMA
-- =====================================================
-- Le schéma de la base de données tifosi est maintenant créé.
-- Toutes les tables et contraintes d'intégrité sont en place.
-- =====================================================
