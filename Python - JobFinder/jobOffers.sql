-- phpMyAdmin SQL Dump
-- version 4.9.7deb1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 22, 2022 at 09:46 PM
-- Server version: 8.0.27-0ubuntu0.21.04.1
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
-- Database: `jobOffers`
--

-- --------------------------------------------------------

--
-- Table structure for table `jobOffers`
--

CREATE TABLE `jobOffers` (
  `id` int NOT NULL,
  `jobName` varchar(256) COLLATE utf8_polish_ci NOT NULL,
  `linkToOffer` varchar(256) COLLATE utf8_polish_ci NOT NULL,
  `companyName` varchar(256) COLLATE utf8_polish_ci NOT NULL,
  `offerSpec` varchar(256) COLLATE utf8_polish_ci NOT NULL,
  `dateOfPub` varchar(256) COLLATE utf8_polish_ci NOT NULL,
  `jobLocation` varchar(256) COLLATE utf8_polish_ci NOT NULL,
  `companyLink` varchar(256) COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_polish_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `jobOffers`
--
ALTER TABLE `jobOffers`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `jobOffers`
--
ALTER TABLE `jobOffers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
