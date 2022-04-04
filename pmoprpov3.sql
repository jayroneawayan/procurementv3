-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 05, 2022 at 12:41 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 7.4.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pmoprpov3`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_file`
--

CREATE TABLE `tbl_file` (
  `file_id` int(11) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_location` varchar(255) NOT NULL,
  `attachment_type` varchar(255) NOT NULL,
  `worklog_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_worklog`
--

CREATE TABLE `tbl_worklog` (
  `id` int(11) NOT NULL,
  `control_number` varchar(255) NOT NULL,
  `pr_status` varchar(255) NOT NULL,
  `requesting_unit` enum('OPM','PSD','ESD','ADMIN','PPD','TMO-BALINGOAN','TMO-OPOL','TMO-CAMIGUIN','PTC','') NOT NULL,
  `project_details` varchar(255) DEFAULT NULL,
  `pr_date` varchar(255) DEFAULT NULL,
  `pr_num` varchar(255) NOT NULL,
  `approve_budget` varchar(255) DEFAULT NULL,
  `budget_action` varchar(255) DEFAULT NULL,
  `proc_mode` varchar(255) DEFAULT NULL,
  `philgeps_date` varchar(255) DEFAULT NULL,
  `rfq_no` varchar(255) DEFAULT NULL,
  `rfq_closing` varchar(255) DEFAULT NULL,
  `rfq_status` varchar(255) DEFAULT NULL,
  `rfq_opening` varchar(255) DEFAULT NULL,
  `date_abstract` varchar(255) DEFAULT NULL,
  `po_number` varchar(255) DEFAULT NULL,
  `po_date` varchar(255) DEFAULT NULL,
  `po_amount` varchar(255) DEFAULT NULL,
  `supplier` varchar(255) DEFAULT NULL,
  `po_status` varchar(255) DEFAULT NULL,
  `recieved_supplier` varchar(255) DEFAULT NULL,
  `recieved_coa` varchar(255) DEFAULT NULL,
  `recieved_bac` varchar(255) DEFAULT NULL,
  `date_delivery` varchar(255) DEFAULT NULL,
  `iar_no` varchar(255) DEFAULT NULL,
  `iar_date` varchar(255) DEFAULT NULL,
  `prip` varchar(255) DEFAULT NULL,
  `wmr` varchar(255) DEFAULT NULL,
  `ICS` varchar(255) DEFAULT NULL,
  `issued` varchar(255) DEFAULT NULL,
  `dv_no` varchar(255) DEFAULT NULL,
  `forwarded_finance` varchar(255) DEFAULT NULL,
  `recieved_by` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `check_num` varchar(255) DEFAULT NULL,
  `date_check` varchar(255) DEFAULT NULL,
  `created_at` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Triggers `tbl_worklog`
--
DELIMITER $$
CREATE TRIGGER `controlnumber` BEFORE INSERT ON `tbl_worklog` FOR EACH ROW BEGIN

  SET @v1 = (SELECT control_number FROM tbl_worklog where DATE_FORMAT(created_at,'%Y%m') =DATE_FORMAT(NOW(),'%Y%m') ORDER BY id DESC LIMIT 1);

  IF (@v1 is null) THEN 

     SET new.control_number = (CONCAT(CAST(DATE_FORMAT(NOW(),'%Y%m') as CHAR),"-1"));

  ELSE 

     SET @v2 = (CAST(SUBSTRING_INDEX(@v1,"-",-1) as int)+1);

     SET new.control_number = (CONCAT(CAST(DATE_FORMAT(NOW(),'%Y%m') as CHAR),"-",CAST(@v2 as char)));

  END IF;

  

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(250) NOT NULL,
  `password` varchar(250) NOT NULL,
  `fname` varchar(255) NOT NULL,
  `lname` varchar(255) NOT NULL,
  `usertype` enum('1','2','3','') NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `fname`, `lname`, `usertype`) VALUES
(1, 'admin', '@dmin2022', 'Jayrone', 'Awayan', '1'),
(2, 'ppapmo', 'admin', 'John', 'Doe', '1');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_file`
--
ALTER TABLE `tbl_file`
  ADD PRIMARY KEY (`file_id`),
  ADD KEY `worklog_id` (`worklog_id`);

--
-- Indexes for table `tbl_worklog`
--
ALTER TABLE `tbl_worklog`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_file`
--
ALTER TABLE `tbl_file`
  MODIFY `file_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT for table `tbl_worklog`
--
ALTER TABLE `tbl_worklog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_file`
--
ALTER TABLE `tbl_file`
  ADD CONSTRAINT `tbl_file_ibfk_1` FOREIGN KEY (`worklog_id`) REFERENCES `tbl_worklog` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
