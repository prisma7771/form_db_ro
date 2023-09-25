-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Sep 25, 2023 at 08:21 PM
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
  `image` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `images`
--

INSERT INTO `images` (`id_venue`, `id_image`, `image`) VALUES
(67, 17, '67_KNI2OqslY5DI8GnugUdQyYvsagDi9n9EMx2nmDe7.jpg'),
(67, 18, '67_GlNYIX8WIpjbeq0wIQEGb88Ba3h8f3ad4wDeAwQN.png'),
(67, 19, '67_K9vq4dA4aWe7fZ4IWCaASHgeYWKxWpx3gPiP5N9M.jpg'),
(67, 20, '67_QAcWA8Ym7OikM4y04KqTl371Vv60Lug4BaAQ0YC4.jpg'),
(67, 21, '67_PBRv8lgegBZhpO0ptx623nFLJSmi5VLjOVCcRQHE.jpg'),
(67, 22, '67_QhXlI2mBDKZTRPhz1CxmIVwm4ciC5VHneRL0FQnn.png'),
(67, 24, '67_YAUsbmsy1S4XTS8c2H6BbMT9poSs7ZT9WbN83iM8.png'),
(67, 27, '67_O3EauAJOtvC18GGWrJ1O4U0ICGDR7Hy7Lk8XYyyB.jpg'),
(71, 28, '71_JxFUJHxSe3htMmiNWhf5BwfE74ReVGHFA3B9f4Ot.jpg'),
(67, 29, '67_SS3g3i4PWjS2oAme9scTnlVd3AQENNaeEPzh2kQ5.png'),
(67, 30, '67_ZWXtlCWvohE0msEOlonHbIzMpNjn30kqrvokMY4s.jpg'),
(70, 31, '70_R0lxCtStdbneRslJAHVt0viMTflLjcKsF7HQVCyY.png');

-- --------------------------------------------------------

--
-- Table structure for table `spots`
--

CREATE TABLE `spots` (
  `id_venue` int(11) NOT NULL,
  `total_spot` int(11) NOT NULL DEFAULT 0,
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
  `other_harga` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `spots`
--

INSERT INTO `spots` (`id_venue`, `total_spot`, `spot_name`, `kapasitas`, `indoor_outdoor`, `kursi`, `r_meeting`, `genset`, `sound_system`, `r_makeup`, `m_panggung`, `r_transit`, `listrik`, `other_fac`, `halfday`, `fullday`, `other_harga`) VALUES
(67, 50, 'Spot 19876', 50, 'indoor', 50, 2, 1, 1, 1, 1, 1, 1, 'Wi-Fi, Projector', 500, 1000, 'Additional charges apply for catering.'),
(68, 100, 'Spot 2', 100, 'indoor', 100, 1, 0, 1, 1, 0, 1, 1, 'Projector, Whiteboard', 400, 800, 'Full-day rental includes AV equipment.'),
(70, 450, 'Spot 4', 450, 'indoor', 450, 2, 0, 1, 1, 0, 0, 1, 'Whiteboard', 350, 700, 'No outdoor access.'),
(71, 700, 'Spot 5', 700, 'outdoor', 700, 3, 1, 0, 1, 1, 0, 1, 'Garden area', 550, 1100, 'Additional charges for sound system.'),
(73, 1000, 'Spot 7', 1000, 'indoor', 1000, 2, 1, 1, 1, 0, 0, 1, 'Projector, Whiteboard', 550, 1100, 'Audiovisual equipment available.'),
(76, 100, 'Spot 10', 100, 'indoor', 100, 3, 0, 1, 1, 0, 0, 1, 'Wi-Fi, Projector', 475, 950, 'Ideal for workshops.'),
(77, 300, 'Spot 11', 300, 'outdoor', 300, 2, 1, 0, 1, 1, 1, 1, 'Courtyard area', 650, 1300, 'Suitable for events.'),
(79, 700, 'Spot 13', 700, 'indoor', 700, 3, 1, 1, 1, 1, 1, 1, 'Wi-Fi, Projector', 500, 1000, 'Audiovisual equipment available.'),
(80, 950, 'Spot 14', 950, 'outdoor', 950, 1, 0, 1, 1, 0, 0, 1, 'Open space', 375, 750, 'No indoor access.'),
(81, 1200, 'Spot 15', 1200, 'indoor', 1200, 2, 1, 1, 1, 0, 0, 1, 'Projector, Whiteboard', 550, 1100, 'Suitable for presentations.'),
(82, 2, 'Martapila', 100, 'indoor', 20, 30, 40, 100, 2, 3, 4, 5, 'Ga ada', 200000, 300000, '1567'),
(83, 2, 'LAamat', 1000, 'outdoor', 500, 400, 300, 2, 5, 1, 2, 3, 'Banyak kali', 150000, 2000000, 'Ga Abis Thinking'),
(85, 0, 'None', 0, '-', 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, NULL),
(86, 0, 'None', 0, '-', 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, NULL),
(87, 0, 'None', 0, '-', 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, NULL),
(88, 0, 'None', 0, '-', 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `venues`
--

CREATE TABLE `venues` (
  `id` int(11) NOT NULL,
  `nama_venue` varchar(50) NOT NULL,
  `cp_marketing` varchar(50) DEFAULT NULL,
  `no_cp` varchar(15) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `area` enum('Barat','Timur','Selatan','Utara','Tengah') DEFAULT NULL,
  `harga_pack` int(11) DEFAULT 0,
  `lain_lain` text DEFAULT NULL,
  `charge` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `venues`
--

INSERT INTO `venues` (`id`, `nama_venue`, `cp_marketing`, `no_cp`, `address`, `area`, `harga_pack`, `lain_lain`, `charge`) VALUES
(67, 'Venue A', 'John Doe', '089639927748', '123 Main Street', 'Barat', 2500000, 'Lorem ipsum dolor sit amet.', 5000000),
(68, 'Venue Bagas', 'Jane Smith', '081234567890', '456 Elm Street', 'Selatan', 800, 'Consectetur adipiscing elit.', 30),
(70, 'Venue D', 'David Brown', '083333333333', '555 Pine Street', 'Tengah', 900, 'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.', 40),
(71, 'Venue E', 'Emma Wilson', '076543210', '246 Cedar Street', 'Barat', 1100, 'Duis aute irure dolor in reprehenderit in voluptate.', 70),
(73, 'Venue G', 'Grace Green', '0712345678', '777 Redwood Street', 'Timur', 1300, 'Nisi ut aliquip ex ea commodo consequat.', 45000),
(76, 'Venue J', 'James Green', NULL, '111 Oak Street', 'Selatan', 880, 'Proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 50),
(77, 'Venue K', 'Katherine Davis', NULL, '222 Birch Street', 'Timur', 1150, 'In voluptate velit esse cillum dolore eu fugiat nulla pariatur.', 75),
(79, 'Venue M', 'Mia Johnson', '0765432101', '444 Oak Street', 'Barat', 1020, 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 55),
(80, 'Venue N', 'Noah Brown', '0812345670', '555 Pine Street', 'Selatan', 890, 'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.', 40),
(81, 'Venue O', 'Olivia Green', '0958374615', '666 Cedar Street', 'Timur', 1100, 'Excepteur sint occaecat cupidatat non proident.', 60),
(82, 'Sayonara', 'Kalllen', '089639927748', 'Gang rumahan', 'Utara', 65000, 'Mulih', 198),
(83, 'ImaSan', 'Kayo', '089639927748', 'Rumahnya', 'Timur', 12000000, 'Piye kabare', 500),
(85, 'JagoanNepn', NULL, NULL, '-', NULL, 0, NULL, 0),
(86, 'Sholatatat', NULL, NULL, '-', NULL, 0, NULL, 0),
(87, 'ImaChan', NULL, NULL, '-', NULL, 0, NULL, 0),
(88, 'Rika', NULL, NULL, '-', NULL, 0, NULL, 0);

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
  MODIFY `id_image` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `venues`
--
ALTER TABLE `venues`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

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
