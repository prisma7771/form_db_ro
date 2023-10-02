-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Oct 02, 2023 at 08:20 AM
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

--
-- Dumping data for table `images`
--

INSERT INTO `images` (`id_venue`, `id_image`, `image`, `spot_id`) VALUES
(71, 89, '71/4/ZunA3ciwrRKMXTZmIlCntIvQI5f6rsixdNwSilAS.jpg', 4),
(71, 90, '71/38/dYnJmDU2sp3HpAaSQghTBDOI5FFNGo5hw6bFylsT.png', 38),
(71, 97, '71/0/g7Q1OKtDdTriKo3hxEt1tU7yaTPE9zs6YHMISjeQ.png', 0);

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
  `halfday` int(11) DEFAULT 0,
  `fullday` int(11) DEFAULT 0,
  `other_harga` text DEFAULT NULL,
  `spot_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `spots`
--

INSERT INTO `spots` (`id_venue`, `spot_name`, `kapasitas`, `indoor_outdoor`, `kursi`, `r_meeting`, `genset`, `sound_system`, `r_makeup`, `m_panggung`, `r_transit`, `listrik`, `other_fac`, `halfday`, `fullday`, `other_harga`, `spot_id`) VALUES
(71, 'Spot 5', 700, 'outdoor', 700, 3, 1, 0, 1, 1, 0, 1, 'Garden area', 550, 1100, 'Additional charges for sound system.', 4),
(73, 'Spot 7', 1000, 'indoor', 1000, 2, 1, 1, 1, 0, 0, 1, 'Projector, Whiteboard', 550, 1100, 'Audiovisual equipment available.', 5),
(76, 'Spot 10', 100, 'indoor', 100, 3, 0, 1, 1, 0, 0, 1, 'Wi-Fi, Projector', 475, 950, 'Ideal for workshops.', 6),
(77, 'Spot 11', 300, 'outdoor', 300, 2, 1, 0, 1, 1, 1, 1, 'Courtyard area', 650, 1300, 'Suitable for events.', 7),
(79, 'Spot 13', 700, 'indoor', 700, 3, 1, 1, 1, 1, 1, 1, 'Wi-Fi, Projector', 500, 1000, 'Audiovisual equipment available.', 8),
(80, 'Spot 14', 950, 'outdoor', 950, 1, 0, 1, 1, 0, 0, 1, 'Open space', 375, 750, 'No indoor access.', 9),
(81, 'Spot 15', 1200, 'indoor', 1200, 2, 1, 1, 1, 0, 0, 1, 'Projector, Whiteboard', 550, 1100, 'Suitable for presentations.', 10),
(82, 'Martapila', 100, 'indoor', 20, 30, 40, 100, 2, 3, 4, 5, 'Ga ada', 200000, 300000, '1567', 11),
(83, 'LAamat', 1000, 'outdoor', 500, 400, 300, 2, 5, 1, 2, 3, 'Banyak kali', 150000, 2000000, 'Ga Abis Thinking', 12),
(97, 'NoneMMMM', 0, '-', 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, NULL, 30),
(98, 'None', 0, '-', 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, NULL, 31),
(99, 'Kali', 375, 'indoor', 1, 2, 3, 4, 5, 6, 7, 8, 'Pa Kabar', 1500000, 2000000, 'Jual', 32),
(99, 'Galakan', 0, '-', 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, NULL, 35),
(100, 'None', 0, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, NULL, 36),
(71, 'Lucifer', 7000, 'outdoor', 0, 0, 0, 0, 0, 0, 0, 0, '-', 0, 0, '-', 38);

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
-- Dumping data for table `venues`
--

INSERT INTO `venues` (`id`, `nama_venue`, `cp_marketing`, `no_cp`, `address`, `area`, `harga_pack`, `lain_lain`, `charge`) VALUES
(71, 'Venue E', 'Emma Wilson', '076543210', '246 Cedar Street', 'Barat', 1100, 'Duis aute irure dolor in reprehenderit in voluptate.', 70),
(73, 'Venue G', 'Grace Green', '0712345678', '777 Redwood Street', 'Timur', 1300, 'Nisi ut aliquip ex ea commodo consequat.', 45000),
(76, 'Venue J', 'James Green', NULL, '111 Oak Street', 'Selatan', 880, 'Proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 50),
(77, 'Venue K', 'Katherine Davis', NULL, '222 Birch Street', 'Timur', 1150, 'In voluptate velit esse cillum dolore eu fugiat nulla pariatur.', 75),
(79, 'Venue Man', 'Mia Johnson', '0765432101', '444 Oak Street', 'Barat', 1020, 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 55),
(80, 'Venue N', 'Noah Brown', '0812345670', '555 Pine Street', 'Selatan', 890, 'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.', 40),
(81, 'Venue O', 'Olivia Green', '0958374615', '666 Cedar Street', 'Timur', 1100, 'Excepteur sint occaecat cupidatat non proident.', 60),
(82, 'Sayonara', 'Kalllen', '089639927748', 'Gang rumahan', 'Utara', 65000, 'Mulih', 198),
(83, 'ImaSan', 'Kayo', '089639927748', 'Rumahnya', 'Timur', 12000000, 'Piye kabare', 500),
(97, 'SarahCan', '-', '-', '-', '-', 0, '-', 0),
(98, 'NoahKun', '-', '-', '-', '-', 0, '-', 0),
(99, 'Samlekom', 'Ima', '089639927748', 'Pasar', 'Barat', 8000000, 'Jual', 5000000),
(100, 'Kamen', '-', '-', '-', '-', 0, '-', 0);

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
  MODIFY `id_image` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- AUTO_INCREMENT for table `spots`
--
ALTER TABLE `spots`
  MODIFY `spot_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `venues`
--
ALTER TABLE `venues`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `spots`
--
ALTER TABLE `spots`
  ADD CONSTRAINT `fk_venue_id` FOREIGN KEY (`id_venue`) REFERENCES `venues` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
