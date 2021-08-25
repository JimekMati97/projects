-- phpMyAdmin SQL Dump
-- version 4.9.7deb1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 24, 2021 at 05:10 PM
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
-- Database: `terminarz`
--

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
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2021_05_26_164434_create_panstwos_table', 1),
(5, '2021_06_02_095943_create_months_table', 1),
(6, '2021_06_02_110130_create_tasks_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `months`
--

CREATE TABLE `months` (
  `id` bigint UNSIGNED NOT NULL,
  `miesiac` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `months`
--

INSERT INTO `months` (`id`, `miesiac`) VALUES
(1, 'styczeń'),
(2, 'luty'),
(3, 'marzec'),
(4, 'kwiecień'),
(5, 'maj'),
(6, 'czerwiec'),
(7, 'lipiec'),
(8, 'sierpień'),
(9, 'wrzesień'),
(10, 'październik'),
(11, 'listopad'),
(12, 'grudzień');

-- --------------------------------------------------------

--
-- Table structure for table `panstwos`
--

CREATE TABLE `panstwos` (
  `id` bigint UNSIGNED NOT NULL,
  `nazwa` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `panstwos`
--

INSERT INTO `panstwos` (`id`, `nazwa`) VALUES
(1, 'Cuba'),
(2, 'Puerto Rico'),
(3, 'Mongolia'),
(4, 'French Polynesia'),
(5, 'Argentina'),
(6, 'Jordan'),
(7, 'United States Minor Outlying Islands'),
(8, 'Portugal'),
(9, 'Sweden'),
(10, 'Burundi'),
(11, 'Kenya'),
(12, 'Tanzania'),
(13, 'Martinique'),
(14, 'Turkmenistan'),
(15, 'Guatemala'),
(16, 'Sudan'),
(17, 'Syrian Arab Republic'),
(18, 'Guam'),
(19, 'Aruba'),
(20, 'Norfolk Island'),
(21, 'Cayman Islands'),
(22, 'Heard Island and McDonald Islands'),
(23, 'Luxembourg'),
(24, 'Chile'),
(25, 'Belgium'),
(26, 'Panama'),
(27, 'Belgium'),
(28, 'Togo'),
(29, 'Peru'),
(30, 'Gibraltar'),
(31, 'United States Minor Outlying Islands'),
(32, 'Anguilla'),
(33, 'Puerto Rico'),
(34, 'Pitcairn Islands'),
(35, 'Luxembourg'),
(36, 'Norfolk Island'),
(37, 'Gambia'),
(38, 'Gabon'),
(39, 'Austria'),
(40, 'Iceland'),
(41, 'American Samoa'),
(42, 'Nicaragua'),
(43, 'Italy'),
(44, 'Grenada'),
(45, 'Cyprus'),
(46, 'Sierra Leone'),
(47, 'Italy'),
(48, 'Chile'),
(49, 'India'),
(50, 'Jordan'),
(51, 'Guernsey'),
(52, 'Bermuda'),
(53, 'Egypt'),
(54, 'Aruba'),
(55, 'Equatorial Guinea'),
(56, 'Samoa'),
(57, 'Tokelau'),
(58, 'Saint Vincent and the Grenadines'),
(59, 'Andorra'),
(60, 'Niue'),
(61, 'Belgium'),
(62, 'Monaco'),
(63, 'Western Sahara'),
(64, 'Saint Pierre and Miquelon'),
(65, 'Trinidad and Tobago'),
(66, 'Afghanistan'),
(67, 'Antigua and Barbuda'),
(68, 'Morocco'),
(69, 'Turkmenistan'),
(70, 'Iraq'),
(71, 'Andorra'),
(72, 'Croatia'),
(73, 'Pitcairn Islands'),
(74, 'Egypt'),
(75, 'Albania'),
(76, 'Myanmar'),
(77, 'Sierra Leone'),
(78, 'China'),
(79, 'Suriname'),
(80, 'Bahamas'),
(81, 'Gibraltar'),
(82, 'Anguilla'),
(83, 'Czech Republic'),
(84, 'Sudan'),
(85, 'Guinea'),
(86, 'Benin'),
(87, 'Saudi Arabia'),
(88, 'Iraq'),
(89, 'Saint Helena'),
(90, 'Niue'),
(91, 'Iceland'),
(92, 'Israel'),
(93, 'Tokelau'),
(94, 'Mayotte'),
(95, 'Guinea-Bissau'),
(96, 'Uganda'),
(97, 'Netherlands Antilles'),
(98, 'Dominican Republic'),
(99, 'Guam'),
(100, 'New Caledonia');

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
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `year` int NOT NULL,
  `month` int NOT NULL,
  `day` int NOT NULL,
  `task` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tasks`
--

INSERT INTO `tasks` (`id`, `user_id`, `year`, `month`, `day`, `task`, `created_at`, `updated_at`) VALUES
(1, 1, 2021, 8, 24, 'Zadanie 1', '2021-08-24 13:05:21', '2021-08-24 13:05:21');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `nazwa` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `imie` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nazwisko` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `panstwo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefon` int NOT NULL,
  `plec` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `nazwa`, `imie`, `nazwisko`, `panstwo`, `telefon`, `plec`, `profile_image`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'jankow01', 'Jan', 'Kowalski', 'Belgium', 67474745, '1', 'profile_man.jpg', 'jan@wp.pl', NULL, '$2y$10$jzjGUNCBFQ13Xz0xURRiUOHl9J2UYDtLJRY6TWnEXomNUi9JpwOcC', NULL, '2021-08-24 12:55:54', '2021-08-24 12:55:54'),
(2, 'darkow01', 'Dariusz', 'Kowalski', 'Bermuda', 67474745, '1', 'profile_man.jpg', 'dar@wp.pl', NULL, '$2y$10$ZxwLOGoLFTximhSF3kidHOcyFayU5eb0OPDRbeqIYhK7BwZpdFCsC', NULL, '2021-08-24 13:06:06', '2021-08-24 13:06:06');

--
-- Indexes for dumped tables
--

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
-- Indexes for table `months`
--
ALTER TABLE `months`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `panstwos`
--
ALTER TABLE `panstwos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tasks_user_id_foreign` (`user_id`);

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
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `months`
--
ALTER TABLE `months`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `panstwos`
--
ALTER TABLE `panstwos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tasks`
--
ALTER TABLE `tasks`
  ADD CONSTRAINT `tasks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
