-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Hôte : maria_db:3306
-- Généré le : mar. 08 fév. 2022 à 14:48
-- Version du serveur :  10.6.5-MariaDB-1:10.6.5+maria~focal
-- Version de PHP : 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `projet1`
--

-- --------------------------------------------------------

--
-- Structure de la table `entreprise`
--

CREATE TABLE `entreprise` (
  `id` int(10) NOT NULL,
  `nom` varchar(64) NOT NULL,
  `telephone` varchar(32) DEFAULT NULL,
  `website` varchar(320) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `entreprise`
--

INSERT INTO `entreprise` (`id`, `nom`, `telephone`, `website`) VALUES
(1, 'Réalise', '023424242', 'www.realise.ch'),
(2, 'Google', '023232323', 'www.google.ch'),
(3, 'Infomaniak', '0232323223', 'www.infomaniak.ch'),
(4, 'Mediamarkt', '02323552323', 'www.mediamarkt.ch');

-- --------------------------------------------------------

--
-- Structure de la table `entreprise_personne`
--

CREATE TABLE `entreprise_personne` (
  `entreprise_id` int(10) NOT NULL,
  `personne_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `entreprise_personne`
--

INSERT INTO `entreprise_personne` (`entreprise_id`, `personne_id`) VALUES
(2, 4),
(3, 7),
(4, 6),
(1, 3),
(2, 8),
(4, 5);

-- --------------------------------------------------------

--
-- Structure de la table `personne`
--

CREATE TABLE `personne` (
  `id` int(10) NOT NULL,
  `nom` varchar(64) NOT NULL,
  `telephone` varchar(32) DEFAULT NULL,
  `email` varchar(128) NOT NULL,
  `profile` varchar(320) DEFAULT NULL,
  `ville_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `personne`
--

INSERT INTO `personne` (`id`, `nom`, `telephone`, `email`, `profile`, `ville_id`) VALUES
(3, 'Jean Muerner', '0342498824', 'jean@test.ch', 'https://cdn.pixabay.com/photo/2015/12/23/14/56/man-profile-1105761_960_720.jpg', 3),
(4, 'Alfred Suter', '04413204892', 'alfred@test.ch', 'http://image.over-blog.com/luiHPrsnNvdMwCNaEI2BWao18fM=/filters:no_upscale()/image%2F1091191%2F20210216%2Fob_6ea61c_zheka-boychenko-vpktwytgk8e-unsplash.jpg', 1),
(5, 'Laura Belfada', '032424222', 'laura@test.ch', 'https://st.depositphotos.com/1001992/2222/i/950/depositphotos_22224021-stock-photo-beautiful-woman-cares-for-the.jpg', 4),
(6, 'Isabelle Schmidt', '02392322', 'isabelle@test.ch', 'https://www.portaildelamode.com/wp-content/uploads/2018/04/relooking-couleurs-ete-min.jpg', 2),
(7, 'Corinne Hausch', '0327382', 'corine@test.ch', NULL, 1),
(8, 'Yvan Toldisch', '03723827287', 'yvan@test.ch', NULL, 4);

-- --------------------------------------------------------

--
-- Structure de la table `ville`
--

CREATE TABLE `ville` (
  `id` int(10) NOT NULL,
  `nom` varchar(64) NOT NULL,
  `lattitude` decimal(10,8) NOT NULL,
  `longitude` decimal(10,8) NOT NULL,
  `pays` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `ville`
--

INSERT INTO `ville` (`id`, `nom`, `lattitude`, `longitude`, `pays`) VALUES
(1, 'Genève', '46.20700000', '6.14234000', 'Suisse'),
(2, 'Lausanne', '46.51965350', '6.63227340', 'Suisse'),
(3, 'Buenos Aires', '-34.61315000', '-58.37723000', 'Argentine'),
(4, 'Santiago de Chile', '-33.30851000', '-70.11405900', 'Chili');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `entreprise`
--
ALTER TABLE `entreprise`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `entreprise_personne`
--
ALTER TABLE `entreprise_personne`
  ADD KEY `lien_entreprise` (`entreprise_id`),
  ADD KEY `lien_personne` (`personne_id`);

--
-- Index pour la table `personne`
--
ALTER TABLE `personne`
  ADD PRIMARY KEY (`id`),
  ADD KEY `personne_ville` (`ville_id`) USING BTREE;

--
-- Index pour la table `ville`
--
ALTER TABLE `ville`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `entreprise`
--
ALTER TABLE `entreprise`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `personne`
--
ALTER TABLE `personne`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `ville`
--
ALTER TABLE `ville`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `entreprise_personne`
--
ALTER TABLE `entreprise_personne`
  ADD CONSTRAINT `lien_entreprise` FOREIGN KEY (`entreprise_id`) REFERENCES `entreprise` (`id`),
  ADD CONSTRAINT `lien_personne` FOREIGN KEY (`personne_id`) REFERENCES `personne` (`id`);

--
-- Contraintes pour la table `personne`
--
ALTER TABLE `personne`
  ADD CONSTRAINT `personne_ville` FOREIGN KEY (`ville_id`) REFERENCES `ville` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
