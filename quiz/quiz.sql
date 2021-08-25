-- phpMyAdmin SQL Dump
-- version 4.9.7deb1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 25, 2021 at 09:44 AM
-- Server version: 8.0.26-0ubuntu0.21.04.3
-- PHP Version: 7.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `quiz`
--

-- --------------------------------------------------------

--
-- Table structure for table `czasownik_models`
--

CREATE TABLE `czasownik_models` (
  `id` int UNSIGNED NOT NULL,
  `czasownik` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tlumaczenie` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nieregularnosc` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `czasownik_models`
--

INSERT INTO `czasownik_models` (`id`, `czasownik`, `tlumaczenie`, `nieregularnosc`, `created_at`, `updated_at`) VALUES
(1, 'correr', 'biegać', 'Brak', '2021-08-25 05:21:00', '2021-08-25 05:21:00'),
(2, 'morder', 'gryźć', 'Brak', '2021-08-25 05:21:14', '2021-08-25 05:21:14'),
(3, 'hacer', 'robić', 'Brak', '2021-08-25 05:21:19', '2021-08-25 05:21:19'),
(4, 'tener', 'mieć', 'Brak', '2021-08-25 05:21:27', '2021-08-25 05:21:27'),
(5, 'hablar', 'mówić', 'Brak', '2021-08-25 05:21:38', '2021-08-25 05:21:38');

-- --------------------------------------------------------

--
-- Table structure for table `czasownik_odmianas`
--

CREATE TABLE `czasownik_odmianas` (
  `id` int UNSIGNED NOT NULL,
  `czasownik_model_id` int UNSIGNED NOT NULL,
  `Pierwszalp` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Drugalp` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Trzecialp` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Pierwszalm` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Drugalm` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Trzecialm` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `czasownik_odmianas`
--

INSERT INTO `czasownik_odmianas` (`id`, `czasownik_model_id`, `Pierwszalp`, `Drugalp`, `Trzecialp`, `Pierwszalm`, `Drugalm`, `Trzecialm`) VALUES
(1, 1, 'corro', 'corres', 'corre', 'corremos', 'corréis', 'corren'),
(2, 2, 'mordo', 'mordes', 'morde', 'mordemos', 'mordéis', 'morden'),
(3, 3, 'hago', 'haces', 'hace', 'hacemos', 'hacéis', 'hacen'),
(4, 4, 'tengo', 'tienes', 'tiene', 'tenemos', 'tenéis', 'tienen'),
(5, 5, 'hablo', 'hablas', 'habla', 'hablamos', 'habláis', 'hablan');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(37, '2014_10_12_000000_create_users_table', 1),
(38, '2014_10_12_100000_create_password_resets_table', 1),
(39, '2019_08_19_000000_create_failed_jobs_table', 1),
(40, '2021_04_11_101622_create_czasownik_models_table', 1),
(41, '2021_04_14_142624_create_czasownik_odmianas_table', 1),
(42, '2021_04_15_183304_create_rzeczowniki_models_table', 1),
(43, '2021_04_16_181642_create_quiz_models_table', 1),
(44, '2021_04_17_093035_create_quiz__rundas_table', 1),
(45, '2021_04_20_140529_create_quiz_gras_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quiz_gras`
--

CREATE TABLE `quiz_gras` (
  `id` bigint UNSIGNED NOT NULL,
  `slowoDoTlumaczenia` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quiz_gras`
--

INSERT INTO `quiz_gras` (`id`, `slowoDoTlumaczenia`) VALUES
(1, 'biegać'),
(2, 'gryźć'),
(3, 'robić'),
(4, 'mieć'),
(5, 'mówić');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_models`
--

CREATE TABLE `quiz_models` (
  `id` int UNSIGNED NOT NULL,
  `slowo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tlumaczenie` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quiz_models`
--

INSERT INTO `quiz_models` (`id`, `slowo`, `tlumaczenie`, `created_at`, `updated_at`) VALUES
(1, 'correr', 'biegać', NULL, NULL),
(2, 'morder', 'gryźć', NULL, NULL),
(3, 'hacer', 'robić', NULL, NULL),
(4, 'tener', 'mieć', NULL, NULL),
(5, 'hablar', 'mówić', NULL, NULL),
(6, 'el queso', 'ser', NULL, NULL),
(7, 'la tele', 'telwizor', NULL, NULL),
(8, 'el pueblo', 'wieś', NULL, NULL),
(9, 'la niña', 'dziewczynka', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `quiz__rundas`
--

CREATE TABLE `quiz__rundas` (
  `id` int UNSIGNED NOT NULL,
  `slowoDoTlumaczenia` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quiz__rundas`
--

INSERT INTO `quiz__rundas` (`id`, `slowoDoTlumaczenia`) VALUES
(1, 'mówić');

-- --------------------------------------------------------

--
-- Table structure for table `rzeczowniki_models`
--

CREATE TABLE `rzeczowniki_models` (
  `id` int UNSIGNED NOT NULL,
  `rzeczownik` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tlumaczenie` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rzeczowniki_models`
--

INSERT INTO `rzeczowniki_models` (`id`, `rzeczownik`, `tlumaczenie`, `created_at`, `updated_at`) VALUES
(1, 'el queso', 'ser', '2021-08-25 05:42:58', '2021-08-25 05:42:58'),
(2, 'la tele', 'telwizor', '2021-08-25 05:43:07', '2021-08-25 05:43:07'),
(3, 'el pueblo', 'wieś', '2021-08-25 05:43:13', '2021-08-25 05:43:13'),
(4, 'la niña', 'dziewczynka', '2021-08-25 05:43:19', '2021-08-25 05:43:19');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `czasownik_models`
--
ALTER TABLE `czasownik_models`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `czasownik_odmianas`
--
ALTER TABLE `czasownik_odmianas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `czasownik_odmianas_czasownik_model_id_foreign` (`czasownik_model_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `quiz_gras`
--
ALTER TABLE `quiz_gras`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quiz_models`
--
ALTER TABLE `quiz_models`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quiz__rundas`
--
ALTER TABLE `quiz__rundas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rzeczowniki_models`
--
ALTER TABLE `rzeczowniki_models`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `czasownik_models`
--
ALTER TABLE `czasownik_models`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `czasownik_odmianas`
--
ALTER TABLE `czasownik_odmianas`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `quiz_gras`
--
ALTER TABLE `quiz_gras`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `quiz_models`
--
ALTER TABLE `quiz_models`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `quiz__rundas`
--
ALTER TABLE `quiz__rundas`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `rzeczowniki_models`
--
ALTER TABLE `rzeczowniki_models`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `czasownik_odmianas`
--
ALTER TABLE `czasownik_odmianas`
  ADD CONSTRAINT `czasownik_odmianas_czasownik_model_id_foreign` FOREIGN KEY (`czasownik_model_id`) REFERENCES `czasownik_models` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
