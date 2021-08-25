-- phpMyAdmin SQL Dump
-- version 4.9.7deb1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 28, 2021 at 12:59 PM
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
-- Database: `order_app`
--

-- --------------------------------------------------------

--
-- Table structure for table `dish`
--

CREATE TABLE `dish` (
  `id` bigint UNSIGNED NOT NULL,
  `dish_group_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double(8,2) NOT NULL,
  `describtion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `ingredients` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `dish`
--

INSERT INTO `dish` (`id`, `dish_group_id`, `name`, `price`, `describtion`, `ingredients`, `created_at`, `updated_at`) VALUES
(1, 1, 'Cheeseburger', 21.50, 'oprócz kotleta wołowego ważny jest tu lekko roztopiony żółty ser. Plaster kładzie się bezpośrednio na burgerze. Pozostałe dodatki to sałata, cebula, pomidory i sosy. Kuchnia amerykańska zna również inne rodzaje cheeseburgerów, np. w kanapce Jucy Lucy (Juicy Lucy) kawałek sera umieszcza się wewnątrz kotleta, a w Juicy Blucy wykorzystuje się ser pleśniowy. Dla wielbicieli ostrych smaków został stworzony burger Cajun Lucy z dodatkiem papryczek jalapeño', 'kotlet wołowy, ser żółty', '2021-07-11 10:32:37', '2021-07-11 10:32:37'),
(2, 1, 'Chickenburger', 31.00, 'przygotowywany jest z mięsa drobiowego. Kotlet należy piec nieco dłużej niż w przypadku mięsa wołowego – ok. 3–4 min z każdej strony. Do burgera z drobiu, tak jak w przypadku pozostałych wersji hamburgera, dodaje się świeżą sałatę, cebulę i pomidory, a także sos', 'mięso drobiowe, salata, cebula', '2021-07-11 10:32:37', '2021-07-11 10:32:37'),
(3, 1, 'Burger wegański i wegetariański', 29.50, 'Burgery wegańskie i wegetariańskie wyglądają podobnie do hamburgerów mięsnych, ale kotlet przygotowuje się z ciecierzycy, buraków, kasz różnego rodzaju, cukinii, soczewicy, bobu, dyni, kalafiora lub innych warzyw. Usmażony serwuje się w bułce ze świeżymi warzywami i sosam', 'ciecierzyca, burak, cukinia, bób, dynia, kalafior', '2021-07-16 08:20:27', '2021-07-16 08:20:27'),
(4, 2, 'Krewetki z makaronem', 41.00, 'Pyszny makaron z krewetkami i pomidorkami w sosie śmietanowym z natką pietruszki.', 'krewetki, makaron spaghetti, masło, czosnek, olej roślinny', '2021-07-28 09:47:33', '2021-07-28 09:47:33'),
(5, 2, 'Makaron z ośmiornicą', 45.50, 'Jedno z głównych dań reprezentujących kuchnię włoską.', 'ośmiornica, oliwa, czosnek, sos pomidorowy', '2021-07-28 09:47:33', '2021-07-28 09:47:33'),
(6, 3, 'Pizza neapolitana', 26.00, 'Nie ma nic bardziej włoskiego niż pizza w barwach narodowych. Włosi są wielkimi patriotami i z ogromną dumą wplatają zieleń, biel i czerwień również do swoich dań. Jako duma narodowa pizza Neapoli jest znakiem firmowym, a składniki i sposób wykonania regulują patenty i oznaczenia jak np. Chronione Oznaczenie Geograficzne. Pizzę przyrządza się z pomidorów San Marzano, rosnących na polach wulkanicznych oraz mozzarelli di bufala sampana z mleka krów wypasanych na bagnach Campanii i Lazio z dodatkiem liści bazylii. Całość skrapiana jest oliwą z oliwek.', 'ser, salami, pomidor', '2021-07-28 09:52:31', '2021-07-28 09:52:31'),
(7, 3, 'Pizza nowojorska', 28.50, 'Charakteryzuje ją chrupiący brzeg oraz miękkie i elastyczne ciasto na środku placka. Dzięki temu kawałek z łatwością można złożyć na pół. Zapobiega to spadaniu dodatków i spływaniu oliwy. Oprócz cienkiej warstwy sosu pomidorowego i mozzarelli na smak pizzy wpływa wysokoglutenowa mąka oraz nowojorska woda. Wielu uważa, że jej skład mineralny determinuje ostateczny smak. Z tego powodu wiele pizzerii poza stanem sprowadza wodę z Nowego Jorku, aby jak najwierniej odtworzyć jej smak.', 'mozarella, sos pomidorowy, oliwa', '2021-07-28 09:52:31', '2021-07-28 09:52:31'),
(8, 3, 'French bread', 24.00, 'Popularna we Francji wersja pizzy przygotowywana na chlebie. Bochenek kroi się wzdłuż, smaruje sosem pomidorowym, a następnie układa ser i inne dodatki. Najczęściej jest to pepperoni lub inna szynka. Bardzo podobna wersja jest dostępna również w Niemczech. Flammkuchen przygotowuje się na bazie ciasta chlebowego z dodatkiem boczku i cebuli, a w niektórych przypadkach także sera. Flammkuchen obowiązkowo podaje się na drewnianej desce.', 'bochenek, ser', '2021-07-28 09:52:31', '2021-07-28 09:52:31');

-- --------------------------------------------------------

--
-- Table structure for table `dish_extra_food`
--

CREATE TABLE `dish_extra_food` (
  `dish_id` bigint UNSIGNED NOT NULL,
  `extra_food_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `dish_extra_food`
--

INSERT INTO `dish_extra_food` (`dish_id`, `extra_food_id`) VALUES
(3, 2),
(3, 17),
(3, 13),
(3, 5),
(1, 5),
(1, 2),
(1, 9),
(1, 7),
(1, 14),
(1, 1),
(1, 12),
(2, 5),
(2, 7),
(2, 8),
(2, 2),
(2, 3),
(8, 15),
(8, 16),
(8, 17),
(4, 11),
(4, 10),
(4, 4),
(5, 11),
(5, 10),
(6, 15),
(6, 16),
(6, 12),
(6, 13),
(7, 15),
(7, 16),
(7, 17),
(7, 1);

-- --------------------------------------------------------

--
-- Table structure for table `dish_group`
--

CREATE TABLE `dish_group` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `img` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `dish_group`
--

INSERT INTO `dish_group` (`id`, `name`, `created_at`, `updated_at`, `img`) VALUES
(1, 'Burgery', '2021-06-17 14:20:30', '2021-06-16 14:20:30', 'hamburger-1238246_640.jpg'),
(2, 'Owoce morza', '2021-07-09 10:12:58', '2021-07-09 10:12:58', 'fish-725949_640.jpg'),
(3, 'Pizza', '2021-07-01 07:40:13', '2021-07-01 07:40:13', 'pizza-3010062_640.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `extra_food`
--

CREATE TABLE `extra_food` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `extra_food`
--

INSERT INTO `extra_food` (`id`, `name`, `price`, `created_at`, `updated_at`) VALUES
(1, 'pikle', 2.50, '2021-07-28 09:58:24', '2021-07-28 09:58:24'),
(2, 'czerwona cebula', 1.20, '2021-07-28 09:59:01', '2021-07-28 09:59:01'),
(3, 'ser cheddar', 1.60, '2021-07-28 09:59:01', '2021-07-28 09:59:01'),
(4, 'sałata lodowa', 4.00, '2021-07-28 09:59:01', '2021-07-28 09:59:01'),
(5, 'podwójna warstwa mięsa', 12.00, '2021-07-28 09:59:01', '2021-07-28 09:59:01'),
(6, 'ser pleśniowy', 4.00, '2021-07-28 09:59:01', '2021-07-28 09:59:01'),
(7, 'jalapeno', 4.50, '2021-07-28 09:59:01', '2021-07-28 09:59:01'),
(8, 'awokado', 3.50, '2021-07-28 09:59:01', '2021-07-28 09:59:01'),
(9, 'guacamole', 3.00, '2021-07-28 09:59:01', '2021-07-28 09:59:01'),
(10, 'ostryga morska', 7.00, '2021-07-28 09:59:01', '2021-07-28 09:59:01'),
(11, 'kawior', 13.00, '2021-07-28 10:03:24', '2021-07-28 10:03:24'),
(12, 'sos pomidorowy ostry', 4.00, '2021-07-28 10:03:48', '2021-07-28 10:03:48'),
(13, 'podwójny ser', 6.00, '2021-07-28 10:03:48', '2021-07-28 10:03:48'),
(14, 'ogórek konserwowy', 3.50, '2021-07-28 10:04:44', '2021-07-28 10:04:44'),
(15, 'oliwki czarne', 6.50, '2021-07-28 10:05:12', '2021-07-28 10:05:12'),
(16, 'oliwki zielone', 6.50, '2021-07-28 10:05:12', '2021-07-28 10:05:12'),
(17, 'pieczarki', 7.50, '2021-07-28 10:06:06', '2021-07-28 10:06:06');

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
(4, '2021_07_13_102624_create_dish_group_table', 1),
(5, '2021_07_13_102839_create_dish_table', 1),
(10, '2021_07_13_102921_create_extra_food_table', 2),
(11, '2021_07_13_102954_create_dish_extra_food_table', 2),
(13, '2021_07_13_103031_create_order_table', 3);

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE `order` (
  `id` bigint UNSIGNED NOT NULL,
  `order_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dish` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int NOT NULL,
  `extra_food` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double(8,2) NOT NULL,
  `veryfied` int NOT NULL DEFAULT '0',
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_nr` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
-- Indexes for table `dish`
--
ALTER TABLE `dish`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dish_dish_group_id_foreign` (`dish_group_id`);

--
-- Indexes for table `dish_extra_food`
--
ALTER TABLE `dish_extra_food`
  ADD KEY `dish_extra_food_dish_id_foreign` (`dish_id`),
  ADD KEY `dish_extra_food_extra_food_id_foreign` (`extra_food_id`);

--
-- Indexes for table `dish_group`
--
ALTER TABLE `dish_group`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `extra_food`
--
ALTER TABLE `extra_food`
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

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
-- AUTO_INCREMENT for table `dish`
--
ALTER TABLE `dish`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `dish_group`
--
ALTER TABLE `dish_group`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `extra_food`
--
ALTER TABLE `extra_food`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `dish`
--
ALTER TABLE `dish`
  ADD CONSTRAINT `dish_dish_group_id_foreign` FOREIGN KEY (`dish_group_id`) REFERENCES `dish_group` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dish_extra_food`
--
ALTER TABLE `dish_extra_food`
  ADD CONSTRAINT `dish_extra_food_dish_id_foreign` FOREIGN KEY (`dish_id`) REFERENCES `dish` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `dish_extra_food_extra_food_id_foreign` FOREIGN KEY (`extra_food_id`) REFERENCES `extra_food` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
