-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Hôte : maria_db:3306
-- Généré le : mar. 08 fév. 2022 à 14:47
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
-- Base de données : `projet3`
--

-- --------------------------------------------------------

--
-- Structure de la table `equipe`
--

CREATE TABLE `equipe` (
  `id` int(10) NOT NULL,
  `nom` varchar(64) NOT NULL,
  `entraineur` varchar(64) NOT NULL,
  `logo` varchar(320) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `equipe`
--

INSERT INTO `equipe` (`id`, `nom`, `entraineur`, `logo`) VALUES
(1, 'FC Sion', 'Paolo Tramezzani', 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/Logo_FC_Sion.svg/langfr-1920px-Logo_FC_Sion.svg.png'),
(2, 'FC Servette', 'Alain Geiger', 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Servette_FC.svg/langfr-260px-Servette_FC.svg.png'),
(3, 'AC Milan', 'Stefano Pioli', 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/Logo_of_AC_Milan.svg/langfr-260px-Logo_of_AC_Milan.svg.png'),
(4, 'Olympique de Marseille', 'Jorge Sampaoli', 'https://upload.wikimedia.org/wikipedia/fr/thumb/4/43/Logo_Olympique_de_Marseille.svg/langfr-260px-Logo_Olympique_de_Marseille.svg.png');

-- --------------------------------------------------------

--
-- Structure de la table `equipe_tournoi`
--

CREATE TABLE `equipe_tournoi` (
  `equipe_id` int(10) NOT NULL,
  `tournoi_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `equipe_tournoi`
--

INSERT INTO `equipe_tournoi` (`equipe_id`, `tournoi_id`) VALUES
(3, 3),
(4, 3),
(4, 2),
(2, 2),
(2, 1),
(1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `joueur`
--

CREATE TABLE `joueur` (
  `id` int(10) NOT NULL,
  `nom` varchar(64) NOT NULL,
  `age` int(3) NOT NULL,
  `nationalité` varchar(64) NOT NULL,
  `equipe_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `joueur`
--

INSERT INTO `joueur` (`id`, `nom`, `age`, `nationalité`, `equipe_id`) VALUES
(1, 'Steve Mandanda', 36, 'France', 4),
(2, 'Jean-Pierre Papin', 58, 'France', 4),
(3, 'Alex Schalk', 29, 'Pays-bas', 2),
(4, 'Ricardo Alves', 20, 'Suisse', 2),
(5, 'Kevin Fickentscher', 31, 'Suisse', 1),
(6, 'Mattias Andersson', 23, 'Suède', 1),
(7, 'Marco van Basten', 57, 'Pays-bas', 3),
(8, 'Giovanni Rivera', 78, 'Italie', 3);

-- --------------------------------------------------------

--
-- Structure de la table `tournoi`
--

CREATE TABLE `tournoi` (
  `id` int(10) NOT NULL,
  `nom` varchar(64) NOT NULL,
  `date` date NOT NULL,
  `heure_debut` time NOT NULL,
  `heure_fin` time NOT NULL,
  `lieu` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `tournoi`
--

INSERT INTO `tournoi` (`id`, `nom`, `date`, `heure_debut`, `heure_fin`, `lieu`) VALUES
(1, 'Tournoi amical suisse', '2022-05-20', '16:00:00', '18:00:00', 'Lausanne'),
(2, 'Tournoi de France', '2022-07-13', '17:00:00', '19:00:00', 'Paris'),
(3, 'Tournoi de Naples', '2022-06-10', '20:00:00', '22:00:00', '');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `equipe`
--
ALTER TABLE `equipe`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `equipe_tournoi`
--
ALTER TABLE `equipe_tournoi`
  ADD KEY `lien_equipe` (`equipe_id`),
  ADD KEY `lien_tournoi` (`tournoi_id`);

--
-- Index pour la table `joueur`
--
ALTER TABLE `joueur`
  ADD PRIMARY KEY (`id`),
  ADD KEY `joueur_equipe` (`equipe_id`);

--
-- Index pour la table `tournoi`
--
ALTER TABLE `tournoi`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `equipe`
--
ALTER TABLE `equipe`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `joueur`
--
ALTER TABLE `joueur`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `tournoi`
--
ALTER TABLE `tournoi`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `equipe_tournoi`
--
ALTER TABLE `equipe_tournoi`
  ADD CONSTRAINT `lien_equipe` FOREIGN KEY (`equipe_id`) REFERENCES `equipe` (`id`),
  ADD CONSTRAINT `lien_tournoi` FOREIGN KEY (`tournoi_id`) REFERENCES `tournoi` (`id`);

--
-- Contraintes pour la table `joueur`
--
ALTER TABLE `joueur`
  ADD CONSTRAINT `joueur_equipe` FOREIGN KEY (`equipe_id`) REFERENCES `equipe` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
