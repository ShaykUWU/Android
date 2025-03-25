-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 25 mars 2025 à 20:43
-- Version du serveur : 8.2.0
-- Version de PHP : 8.3.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `arras_gaming`
--

-- --------------------------------------------------------

--
-- Structure de la table `games`
--

CREATE TABLE `games` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `type` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `games`
--

INSERT INTO `games` (`id`, `name`, `type`) VALUES
(1, 'League of Legends', 'MOBA');

-- --------------------------------------------------------

--
-- Structure de la table `machines`
--

CREATE TABLE `machines` (
  `id` int NOT NULL,
  `processeur` varchar(100) NOT NULL,
  `memoire` int NOT NULL,
  `systeme_exploitation` varchar(50) NOT NULL,
  `purchase_date` date NOT NULL,
  `install_games` text,
  `status` enum('disponible','en maintenance') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `last_maintenance` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `machines`
--

INSERT INTO `machines` (`id`, `processeur`, `memoire`, `systeme_exploitation`, `purchase_date`, `install_games`, `status`, `last_maintenance`) VALUES
(1, 'I7', 32, 'Windows', '2024-02-15', 'League of Legends, Dota 2, Counter Strike 2.', 'en maintenance', '2024-11-10 20:00:00'),
(3, 'i5', 32, 'Windows', '2552-02-12', 'lol', 'disponible', '2025-02-18 12:02:22'),
(4, 'I5', 32, 'Windows', '2025-02-15', 'Lol', 'disponible', '2024-05-10 00:00:00');

-- --------------------------------------------------------

--
-- Structure de la table `machines_games`
--

CREATE TABLE `machines_games` (
  `id` int NOT NULL,
  `machine_id` int NOT NULL,
  `game_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `machines_games`
--

INSERT INTO `machines_games` (`id`, `machine_id`, `game_id`) VALUES
(1, 1, 1),
(2, 3, 1);

-- --------------------------------------------------------

--
-- Structure de la table `maintenances`
--

CREATE TABLE `maintenances` (
  `id` int NOT NULL,
  `machine_id` int NOT NULL,
  `date_maintenance` datetime NOT NULL,
  `description` text,
  `prochaine_maintenance` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `maintenances`
--

INSERT INTO `maintenances` (`id`, `machine_id`, `date_maintenance`, `description`, `prochaine_maintenance`) VALUES
(1, 1, '2024-11-23 20:00:00', 'Nouvelle mise a jour Nvidia', '2024-12-12 20:00:00');

-- --------------------------------------------------------

--
-- Structure de la table `packages`
--

CREATE TABLE `packages` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `duration` int NOT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `packages`
--

INSERT INTO `packages` (`id`, `name`, `price`, `duration`, `description`) VALUES
(1, 'Petit Temps', 5.00, 120, 'Un petit forfait pas chère pour des petites games'),
(2, 'prix moyen', 10.00, 240, 'Un prix moyen pour du plaisir');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `pwd` varchar(255) NOT NULL,
  `login` varchar(255) NOT NULL,
  `pseudo` varchar(255) NOT NULL,
  `role` enum('user','admin') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `pwd`, `login`, `pseudo`, `role`) VALUES
(1, 'B', 'Jean', 'Jeanjean', 'admin'),
(2, 'A', 'Toto', 'Hololoo', 'user'),
(3, 'A', 'BBnomoney', 'Math', 'user'),
(4, 'Lakaka', 'L\'électricieeen', 'Elec', 'user'),
(5, '123A', 'Pierre', 'Test', 'user'),
(7, 'fgrhu', 'fgrhu', 'yguif', 'user');

-- --------------------------------------------------------

--
-- Structure de la table `users_packages`
--

CREATE TABLE `users_packages` (
  `user_id` int NOT NULL,
  `package_id` int NOT NULL,
  `reservation_date` datetime NOT NULL,
  `duration` int NOT NULL,
  `status` enum('confirmée','annulée') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'confirmée',
  `id` int NOT NULL,
  `Code` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `users_packages`
--

INSERT INTO `users_packages` (`user_id`, `package_id`, `reservation_date`, `duration`, `status`, `id`, `Code`) VALUES
(2, 2, '2025-02-25 21:04:07', 240, 'confirmée', 26, 548326),
(2, 1, '2025-03-24 20:36:08', 120, 'confirmée', 33, 85489);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `games`
--
ALTER TABLE `games`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `machines`
--
ALTER TABLE `machines`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `machines_games`
--
ALTER TABLE `machines_games`
  ADD PRIMARY KEY (`id`),
  ADD KEY `machine_id` (`machine_id`),
  ADD KEY `game_id` (`game_id`);

--
-- Index pour la table `maintenances`
--
ALTER TABLE `maintenances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `machine_id` (`machine_id`);

--
-- Index pour la table `packages`
--
ALTER TABLE `packages`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login` (`login`);

--
-- Index pour la table `users_packages`
--
ALTER TABLE `users_packages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `package_id` (`package_id`),
  ADD KEY `idusersfk` (`user_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `games`
--
ALTER TABLE `games`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `machines`
--
ALTER TABLE `machines`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `machines_games`
--
ALTER TABLE `machines_games`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `maintenances`
--
ALTER TABLE `maintenances`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `packages`
--
ALTER TABLE `packages`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `users_packages`
--
ALTER TABLE `users_packages`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `machines_games`
--
ALTER TABLE `machines_games`
  ADD CONSTRAINT `machines_games_ibfk_1` FOREIGN KEY (`machine_id`) REFERENCES `machines` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `machines_games_ibfk_2` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `maintenances`
--
ALTER TABLE `maintenances`
  ADD CONSTRAINT `maintenances_ibfk_1` FOREIGN KEY (`machine_id`) REFERENCES `machines` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `users_packages`
--
ALTER TABLE `users_packages`
  ADD CONSTRAINT `idpackagefk` FOREIGN KEY (`package_id`) REFERENCES `packages` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `idusersfk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
