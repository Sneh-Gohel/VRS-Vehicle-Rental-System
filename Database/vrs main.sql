-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 19, 2023 at 12:08 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vrs`
--

-- --------------------------------------------------------

--
-- Table structure for table `driver_booking`
--

CREATE TABLE `driver_booking` (
  `booking_id` bigint(20) NOT NULL,
  `starting_date` varchar(10) NOT NULL,
  `ending_date` varchar(10) NOT NULL,
  `booking_date` varchar(10) NOT NULL,
  `booking_time` varchar(8) NOT NULL,
  `days` int(11) NOT NULL,
  `price` double NOT NULL,
  `description` varchar(100) NOT NULL,
  `vehicle_model` varchar(100) NOT NULL,
  `vehicle_company` varchar(100) NOT NULL,
  `passing_year` int(4) NOT NULL,
  `wheeler_type` int(2) NOT NULL,
  `fule` varchar(15) NOT NULL,
  `transmission` varchar(15) NOT NULL,
  `visitor_id` varchar(100) NOT NULL,
  `driver_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `driver_details`
--

CREATE TABLE `driver_details` (
  `driver_id` bigint(20) NOT NULL,
  `visitor_id` varchar(100) NOT NULL,
  `active` varchar(5) NOT NULL DEFAULT 'true',
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `pin_code` bigint(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `mobile_number` bigint(20) NOT NULL,
  `birth_date` varchar(20) NOT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  `pin_code` bigint(20) NOT NULL,
  `user_id` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `driver_id` bigint(20) DEFAULT NULL,
  `driver_profile_pic` varchar(100) DEFAULT NULL,
  `driver_price` double DEFAULT NULL,
  `skill` varchar(20) DEFAULT NULL,
  `fule` varchar(50) DEFAULT NULL,
  `transmission` varchar(50) DEFAULT NULL,
  `licence_image_front` varchar(100) DEFAULT NULL,
  `licence_image_back` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`first_name`, `last_name`, `mobile_number`, `birth_date`, `gender`, `city`, `state`, `country`, `pin_code`, `user_id`, `password`, `driver_id`, `driver_profile_pic`, `driver_price`, `skill`, `fule`, `transmission`, `licence_image_front`, `licence_image_back`) VALUES
('Ayan', 'Rana', 7016641560, '04/02/2005', 'Male', 'Bharuch', 'Gujarat', 'India', 392012, 'ayan', '123', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('Harshil', 'Patel', 9328948019, '22/02/2005', 'Male', 'Bharuch', 'Gujarat', 'India', 392012, 'harshil', '123', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('Kirtan', 'Parmar ', 8140372756, '10/02/2004', 'Male', 'Bharuch', 'Gujarat', 'India', 392012, 'kirtan', '123', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('Sneh', 'Gohel', 9979150856, '10/02/2005', 'Male', 'Bharuch', 'Gujarat', 'India', 392012, 'sneh', '123', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `renter_ayan_current_booking`
--

CREATE TABLE `renter_ayan_current_booking` (
  `vehicle_booking_id` bigint(20) DEFAULT NULL,
  `booking_code` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `renter_ayan_vehicle_list`
--

CREATE TABLE `renter_ayan_vehicle_list` (
  `vehicle_list` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `renter_harshil_current_booking`
--

CREATE TABLE `renter_harshil_current_booking` (
  `vehicle_booking_id` bigint(20) DEFAULT NULL,
  `booking_code` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `renter_harshil_vehicle_list`
--

CREATE TABLE `renter_harshil_vehicle_list` (
  `vehicle_list` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `renter_kirtan_current_booking`
--

CREATE TABLE `renter_kirtan_current_booking` (
  `vehicle_booking_id` bigint(20) DEFAULT NULL,
  `booking_code` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `renter_kirtan_vehicle_list`
--

CREATE TABLE `renter_kirtan_vehicle_list` (
  `vehicle_list` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `renter_sneh_current_booking`
--

CREATE TABLE `renter_sneh_current_booking` (
  `vehicle_booking_id` bigint(20) DEFAULT NULL,
  `booking_code` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `renter_sneh_vehicle_list`
--

CREATE TABLE `renter_sneh_vehicle_list` (
  `vehicle_list` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_booking`
--

CREATE TABLE `vehicle_booking` (
  `booking_id` bigint(20) NOT NULL,
  `starting_date` varchar(10) NOT NULL,
  `ending_date` varchar(10) NOT NULL,
  `booking_date` varchar(10) NOT NULL,
  `booking_time` varchar(8) NOT NULL,
  `days` int(11) NOT NULL,
  `price` double NOT NULL,
  `description` longtext NOT NULL,
  `visitor_id` varchar(50) NOT NULL,
  `vehicle_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_details`
--

CREATE TABLE `vehicle_details` (
  `vehicle_id` bigint(20) NOT NULL,
  `vehicle_image_1` varchar(100) NOT NULL,
  `vehicle_image_2` varchar(100) DEFAULT NULL,
  `vehicle_image_3` varchar(100) DEFAULT NULL,
  `vehicle_image_4` varchar(100) DEFAULT NULL,
  `vehicle_image_5` varchar(100) DEFAULT NULL,
  `vehicle_model` varchar(100) NOT NULL,
  `vehicle_company` varchar(100) NOT NULL,
  `vehicle_price` double NOT NULL,
  `vehicle_passing_year` int(4) NOT NULL,
  `vehicle_wheeler` int(11) NOT NULL,
  `vehicle_seater` int(11) NOT NULL,
  `vehicle_fule_type` varchar(15) NOT NULL,
  `vehicle_transmission` varchar(15) NOT NULL,
  `vehicle_number` varchar(15) NOT NULL,
  `vehicle_rc_image_front` varchar(100) NOT NULL,
  `vehicle_rc_image_bottom` varchar(100) NOT NULL,
  `vehicle_owner_user_id` varchar(100) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  `pin_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `visitor_ayan_driver_active_booking`
--

CREATE TABLE `visitor_ayan_driver_active_booking` (
  `driver_booking_id` bigint(20) DEFAULT NULL,
  `booking_code` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `visitor_ayan_driver_history`
--

CREATE TABLE `visitor_ayan_driver_history` (
  `vehicle_list` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `visitor_ayan_notification`
--

CREATE TABLE `visitor_ayan_notification` (
  `id` int(11) DEFAULT NULL,
  `report_id` int(11) DEFAULT NULL,
  `module` varchar(100) DEFAULT NULL,
  `vehicle_id_report` varchar(100) DEFAULT NULL,
  `driver_id_report` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `visitor_ayan_vehicle_active_booking`
--

CREATE TABLE `visitor_ayan_vehicle_active_booking` (
  `vehicle_booking_id` bigint(20) DEFAULT NULL,
  `booking_code` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `visitor_ayan_vehicle_history`
--

CREATE TABLE `visitor_ayan_vehicle_history` (
  `driver_booking_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `visitor_harshil_driver_active_booking`
--

CREATE TABLE `visitor_harshil_driver_active_booking` (
  `driver_booking_id` bigint(20) DEFAULT NULL,
  `booking_code` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `visitor_harshil_driver_history`
--

CREATE TABLE `visitor_harshil_driver_history` (
  `vehicle_list` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `visitor_harshil_notification`
--

CREATE TABLE `visitor_harshil_notification` (
  `id` int(11) DEFAULT NULL,
  `report_id` int(11) DEFAULT NULL,
  `module` varchar(100) DEFAULT NULL,
  `vehicle_id_report` varchar(100) DEFAULT NULL,
  `driver_id_report` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `visitor_harshil_vehicle_active_booking`
--

CREATE TABLE `visitor_harshil_vehicle_active_booking` (
  `vehicle_booking_id` bigint(20) DEFAULT NULL,
  `booking_code` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `visitor_harshil_vehicle_history`
--

CREATE TABLE `visitor_harshil_vehicle_history` (
  `driver_booking_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `visitor_kirtan_driver_active_booking`
--

CREATE TABLE `visitor_kirtan_driver_active_booking` (
  `driver_booking_id` bigint(20) DEFAULT NULL,
  `booking_code` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `visitor_kirtan_driver_history`
--

CREATE TABLE `visitor_kirtan_driver_history` (
  `vehicle_list` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `visitor_kirtan_notification`
--

CREATE TABLE `visitor_kirtan_notification` (
  `id` int(11) DEFAULT NULL,
  `report_id` int(11) DEFAULT NULL,
  `module` varchar(100) DEFAULT NULL,
  `vehicle_id_report` varchar(100) DEFAULT NULL,
  `driver_id_report` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `visitor_kirtan_vehicle_active_booking`
--

CREATE TABLE `visitor_kirtan_vehicle_active_booking` (
  `vehicle_booking_id` bigint(20) DEFAULT NULL,
  `booking_code` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `visitor_kirtan_vehicle_history`
--

CREATE TABLE `visitor_kirtan_vehicle_history` (
  `driver_booking_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `visitor_sneh_driver_active_booking`
--

CREATE TABLE `visitor_sneh_driver_active_booking` (
  `driver_booking_id` bigint(20) DEFAULT NULL,
  `booking_code` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `visitor_sneh_driver_history`
--

CREATE TABLE `visitor_sneh_driver_history` (
  `vehicle_list` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `visitor_sneh_notification`
--

CREATE TABLE `visitor_sneh_notification` (
  `id` int(11) DEFAULT NULL,
  `report_id` int(11) DEFAULT NULL,
  `module` varchar(100) DEFAULT NULL,
  `vehicle_id_report` varchar(100) DEFAULT NULL,
  `driver_id_report` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `visitor_sneh_vehicle_active_booking`
--

CREATE TABLE `visitor_sneh_vehicle_active_booking` (
  `vehicle_booking_id` bigint(20) DEFAULT NULL,
  `booking_code` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `visitor_sneh_vehicle_history`
--

CREATE TABLE `visitor_sneh_vehicle_history` (
  `driver_booking_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `driver_booking`
--
ALTER TABLE `driver_booking`
  ADD PRIMARY KEY (`booking_id`);

--
-- Indexes for table `driver_details`
--
ALTER TABLE `driver_details`
  ADD PRIMARY KEY (`driver_id`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `mobile_number` (`mobile_number`);

--
-- Indexes for table `vehicle_booking`
--
ALTER TABLE `vehicle_booking`
  ADD PRIMARY KEY (`booking_id`);

--
-- Indexes for table `vehicle_details`
--
ALTER TABLE `vehicle_details`
  ADD PRIMARY KEY (`vehicle_id`),
  ADD UNIQUE KEY `vehicle_number` (`vehicle_number`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
