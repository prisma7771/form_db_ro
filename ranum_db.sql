-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Oct 07, 2023 at 06:38 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ranum_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE `images` (
  `id_venue` int(11) NOT NULL,
  `id_image` int(11) NOT NULL,
  `image` text NOT NULL,
  `spot_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `spots`
--

CREATE TABLE `spots` (
  `id_venue` int(11) NOT NULL,
  `spot_name` text NOT NULL,
  `kapasitas` int(11) DEFAULT 0,
  `indoor_outdoor` enum('indoor','outdoor','-') DEFAULT NULL,
  `kursi` int(11) DEFAULT 0,
  `r_meeting` int(11) DEFAULT 0,
  `genset` int(11) DEFAULT 0,
  `sound_system` int(11) DEFAULT 0,
  `r_makeup` int(11) DEFAULT 0,
  `m_panggung` int(11) DEFAULT 0,
  `r_transit` int(11) DEFAULT 0,
  `listrik` int(11) DEFAULT 0,
  `other_fac` text DEFAULT NULL,
  `halfday` bigint(20) DEFAULT 0,
  `fullday` bigint(20) DEFAULT 0,
  `other_harga` text DEFAULT NULL,
  `spot_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `venues`
--

CREATE TABLE `venues` (
  `id` int(11) NOT NULL,
  `nama_venue` varchar(50) NOT NULL,
  `cp_marketing` varchar(50) DEFAULT '-',
  `no_cp` varchar(15) DEFAULT '-',
  `address` varchar(255) DEFAULT '-',
  `area` enum('Barat','Timur','Selatan','Utara','Tengah','-') DEFAULT NULL,
  `harga_pack` int(11) DEFAULT 0,
  `lain_lain` varchar(255) DEFAULT '-',
  `charge` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id_image`),
  ADD KEY `fk_images_venue` (`id_venue`);

--
-- Indexes for table `spots`
--
ALTER TABLE `spots`
  ADD PRIMARY KEY (`spot_id`),
  ADD KEY `id_venue` (`id_venue`);

--
-- Indexes for table `venues`
--
ALTER TABLE `venues`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `images`
--
ALTER TABLE `images`
  MODIFY `id_image` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `spots`
--
ALTER TABLE `spots`
  MODIFY `spot_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `venues`
--
ALTER TABLE `venues`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `images`
--
ALTER TABLE `images`
  ADD CONSTRAINT `fk_images_venue` FOREIGN KEY (`id_venue`) REFERENCES `venues` (`id`);

--
-- Constraints for table `spots`
--
ALTER TABLE `spots`
  ADD CONSTRAINT `fk_venue_id` FOREIGN KEY (`id_venue`) REFERENCES `venues` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
