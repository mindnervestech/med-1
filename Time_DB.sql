-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.1.44-community - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL Version:             8.0.0.4396
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table timespringsheet.apply_leave
CREATE TABLE IF NOT EXISTS `apply_leave` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `start_date` datetime DEFAULT NULL,
  `no_of_days` varchar(255) DEFAULT NULL,
  `type_of_leave` varchar(14) DEFAULT NULL,
  `last_update_date` datetime DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `status` varchar(9) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `pending_with_id` bigint(20) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `process_instance_id` varchar(255) DEFAULT NULL,
  `leave_guid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_apply_leave_user_1` (`user_id`),
  KEY `ix_apply_leave_pendingWith_2` (`pending_with_id`),
  CONSTRAINT `fk_apply_leave_pendingWith_2` FOREIGN KEY (`pending_with_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_apply_leave_user_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- Dumping data for table timespringsheet.apply_leave: ~8 rows (approximately)
/*!40000 ALTER TABLE `apply_leave` DISABLE KEYS */;
INSERT INTO `apply_leave` (`id`, `start_date`, `no_of_days`, `type_of_leave`, `last_update_date`, `remarks`, `status`, `user_id`, `pending_with_id`, `level`, `process_instance_id`, `leave_guid`) VALUES
	(2, '2014-03-18 00:00:00', '7', 'AnnualLeave', '2014-03-16 16:19:01', 'ffffg', 'Withdrawn', 13, 11, 0, '1201', 'f7d2aa4d-521f-47f6-aa4e-c3934e51d027'),
	(3, '2014-03-10 00:00:00', '2', 'SickLeave', '2014-03-16 11:47:51', 'tgttt', 'Rejected', 5, 5, 0, '1301', '8d9e3e9d-c7b5-4026-bfd6-cb5a93bb9417'),
	(4, '2014-02-23 00:00:00', '2', 'AnnualLeave', '2014-03-16 11:50:51', 'sda', 'Rejected', 5, 5, 0, '1801', '3abebb37-2759-464d-a8b4-edba9e2d8112'),
	(5, '2014-02-25 00:00:00', '3', 'SickLeave', '2014-03-16 16:20:52', 'fdh', 'Approved', 13, 16, 0, '2101', '056fbf9a-96f8-43f6-b3a3-03d78f5748b9'),
	(6, '2014-03-19 00:00:00', '4', 'MaternityLeave', '2014-03-16 17:13:24', 'dfgdrg', 'Approved', 13, 16, 0, '2201', '7b9f41fb-c5ed-423e-ba13-c34ed4bd3ba8'),
	(7, '2014-03-04 00:00:00', '8', 'SickLeave', '2014-03-16 20:29:09', 'vghv', 'Approved', 13, 16, 0, '2301', 'c2a1dae3-021c-498e-875d-90b33f4f9d5d'),
	(8, '2014-03-25 00:00:00', '2', 'MaternityLeave', '2014-03-18 14:10:49', 'abcd', 'Approved', 5, 5, 0, '2416', '3a118392-1772-47bb-a02b-8e25f22b416b'),
	(9, '2014-03-18 00:00:00', '3', 'All', '2014-03-18 17:31:01', 'asas', 'Rejected', 5, 5, 0, '2525', 'd0aa2361-22f7-4f5f-988b-20aa9a71a304');
/*!40000 ALTER TABLE `apply_leave` ENABLE KEYS */;


-- Dumping structure for table timespringsheet.client
CREATE TABLE IF NOT EXISTS `client` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_name` varchar(255) DEFAULT NULL,
  `phone_no` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `fax` int(11) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `pin` varchar(255) DEFAULT NULL,
  `contact_name` varchar(255) DEFAULT NULL,
  `contact_phone` varchar(255) DEFAULT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_client_company_3` (`company_id`),
  CONSTRAINT `fk_client_company_3` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dumping data for table timespringsheet.client: ~2 rows (approximately)
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` (`id`, `client_name`, `phone_no`, `email`, `fax`, `address`, `street`, `city`, `country`, `pin`, `contact_name`, `contact_phone`, `contact_email`, `company_id`) VALUES
	(1, 'Pravin Erande', '45312351', 'pberande1@gmail.com', 12345, 'Kothrud', 'Paud Road', 'Pune', 'India', '411038', 'Pravin Erande', '5335656', 'pberande1@gmail.com', 1),
	(2, 'Harshad', '123456789', 'harshad.gojre@gmail.com', 11355, 'Somvar Peth', 'Station Road', 'Pune', 'India', '411009', 'Gojre', '99999999', 'harshad.r.gojre@gmail.com', 1);
/*!40000 ALTER TABLE `client` ENABLE KEYS */;


-- Dumping structure for table timespringsheet.company
CREATE TABLE IF NOT EXISTS `company` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(255) DEFAULT NULL,
  `company_code` varchar(255) DEFAULT NULL,
  `company_email` varchar(255) DEFAULT NULL,
  `company_phone` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `company_status` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dumping data for table timespringsheet.company: ~2 rows (approximately)
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` (`id`, `company_name`, `company_code`, `company_email`, `company_phone`, `address`, `company_status`) VALUES
	(1, 'Google', 'gmail.com', 'google@gmail.com', '1234', 'Magarpatta, Hadapsar,Pune', 'Approved'),
	(2, 'yahoo', 'yahoo.com', '123@yahoo.com', '1234', 'Banglore , India', 'Approved');
/*!40000 ALTER TABLE `company` ENABLE KEYS */;


-- Dumping structure for table timespringsheet.delegate
CREATE TABLE IF NOT EXISTS `delegate` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `from_date` datetime DEFAULT NULL,
  `to_date` datetime DEFAULT NULL,
  `delegator_id` bigint(20) DEFAULT NULL,
  `delegated_to_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_delegate_delegator_4` (`delegator_id`),
  KEY `ix_delegate_delegatedTo_5` (`delegated_to_id`),
  CONSTRAINT `fk_delegate_delegatedTo_5` FOREIGN KEY (`delegated_to_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_delegate_delegator_4` FOREIGN KEY (`delegator_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dumping data for table timespringsheet.delegate: ~1 rows (approximately)
/*!40000 ALTER TABLE `delegate` DISABLE KEYS */;
INSERT INTO `delegate` (`id`, `from_date`, `to_date`, `delegator_id`, `delegated_to_id`) VALUES
	(2, '2014-02-24 00:00:00', '2014-03-19 00:00:00', 5, 4);
/*!40000 ALTER TABLE `delegate` ENABLE KEYS */;


-- Dumping structure for table timespringsheet.feedback
CREATE TABLE IF NOT EXISTS `feedback` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `feedback_date` datetime DEFAULT NULL,
  `feedback` longtext,
  `rating` int(11) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `manager_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_feedback_user_6` (`user_id`),
  KEY `ix_feedback_manager_7` (`manager_id`),
  CONSTRAINT `fk_feedback_manager_7` FOREIGN KEY (`manager_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_feedback_user_6` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Dumping data for table timespringsheet.feedback: ~1 rows (approximately)
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` (`id`, `feedback_date`, `feedback`, `rating`, `user_id`, `manager_id`) VALUES
	(1, '2014-03-12 21:26:12', 'gvjhkl', 2, 5, 13);
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;


-- Dumping structure for table timespringsheet.leave_level
CREATE TABLE IF NOT EXISTS `leave_level` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `leave_x_id` bigint(20) DEFAULT NULL,
  `leave_type` varchar(50) DEFAULT NULL,
  `carry_forward` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `leave_x_id` (`leave_x_id`),
  CONSTRAINT `FK_leave_level_leave_x` FOREIGN KEY (`leave_x_id`) REFERENCES `leave_x` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- Dumping data for table timespringsheet.leave_level: ~5 rows (approximately)
/*!40000 ALTER TABLE `leave_level` DISABLE KEYS */;
INSERT INTO `leave_level` (`id`, `leave_x_id`, `leave_type`, `carry_forward`) VALUES
	(4, 19, 'ABC', 'YES'),
	(5, 19, 'xyz', 'YES'),
	(6, 19, 'def', 'YES'),
	(7, 19, 'mno', 'NO'),
	(8, 19, 'sick', 'NO'),
	(9, 19, 'abc', 'NO'),
	(10, 19, 'def', 'NO'),
	(11, 19, 'xyz', 'NO');
/*!40000 ALTER TABLE `leave_level` ENABLE KEYS */;


-- Dumping structure for table timespringsheet.leave_x
CREATE TABLE IF NOT EXISTS `leave_x` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `company_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `company_id` (`company_id`),
  CONSTRAINT `FK_leave_x_company` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

-- Dumping data for table timespringsheet.leave_x: ~1 rows (approximately)
/*!40000 ALTER TABLE `leave_x` DISABLE KEYS */;
INSERT INTO `leave_x` (`id`, `company_id`) VALUES
	(19, 1);
/*!40000 ALTER TABLE `leave_x` ENABLE KEYS */;


-- Dumping structure for table timespringsheet.mail_setting
CREATE TABLE IF NOT EXISTS `mail_setting` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `host_name` varchar(255) DEFAULT NULL,
  `port_number` varchar(255) DEFAULT NULL,
  `ssl_port` tinyint(1) DEFAULT '0',
  `tls_port` tinyint(1) DEFAULT '0',
  `user_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `company_object_id` bigint(20) DEFAULT NULL,
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_mail_setting_companyObject_8` (`company_object_id`),
  CONSTRAINT `fk_mail_setting_companyObject_8` FOREIGN KEY (`company_object_id`) REFERENCES `company` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Dumping data for table timespringsheet.mail_setting: ~2 rows (approximately)
/*!40000 ALTER TABLE `mail_setting` DISABLE KEYS */;
INSERT INTO `mail_setting` (`id`, `host_name`, `port_number`, `ssl_port`, `tls_port`, `user_name`, `password`, `company_object_id`, `last_update`) VALUES
	(3, 'smtp.gmail.com', '587', 0, 0, 'mntlogin@gmail.com', 'mntabcd123', 1, '2014-03-10 15:21:22'),
	(4, NULL, NULL, NULL, NULL, '123@yahoo.com', NULL, 2, '2014-03-19 20:36:48');
/*!40000 ALTER TABLE `mail_setting` ENABLE KEYS */;


-- Dumping structure for table timespringsheet.notification
CREATE TABLE IF NOT EXISTS `notification` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `setting_as_json` varchar(255) DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_notification_company_9` (`company_id`),
  CONSTRAINT `fk_notification_company_9` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Dumping data for table timespringsheet.notification: ~2 rows (approximately)
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` (`id`, `setting_as_json`, `company_id`) VALUES
	(3, NULL, 1),
	(4, NULL, 2);
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;


-- Dumping structure for table timespringsheet.play_evolutions
CREATE TABLE IF NOT EXISTS `play_evolutions` (
  `id` int(11) NOT NULL,
  `hash` varchar(255) NOT NULL,
  `applied_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `apply_script` text,
  `revert_script` text,
  `state` varchar(255) DEFAULT NULL,
  `last_problem` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table timespringsheet.play_evolutions: ~0 rows (approximately)
/*!40000 ALTER TABLE `play_evolutions` DISABLE KEYS */;
/*!40000 ALTER TABLE `play_evolutions` ENABLE KEYS */;


-- Dumping structure for table timespringsheet.project
CREATE TABLE IF NOT EXISTS `project` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_name_id` bigint(20) DEFAULT NULL,
  `project_name` varchar(255) DEFAULT NULL,
  `project_code` varchar(255) DEFAULT NULL,
  `project_description` varchar(255) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `budget` double DEFAULT NULL,
  `currency` varchar(6) DEFAULT NULL,
  `efforts` int(11) DEFAULT NULL,
  `project_manager_id` bigint(20) DEFAULT NULL,
  `company_obj_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_project_clientName_10` (`client_name_id`),
  KEY `ix_project_projectManager_11` (`project_manager_id`),
  KEY `ix_project_companyObj_12` (`company_obj_id`),
  CONSTRAINT `fk_project_clientName_10` FOREIGN KEY (`client_name_id`) REFERENCES `client` (`id`),
  CONSTRAINT `fk_project_companyObj_12` FOREIGN KEY (`company_obj_id`) REFERENCES `company` (`id`),
  CONSTRAINT `fk_project_projectManager_11` FOREIGN KEY (`project_manager_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dumping data for table timespringsheet.project: ~2 rows (approximately)
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` (`id`, `client_name_id`, `project_name`, `project_code`, `project_description`, `start_date`, `end_date`, `budget`, `currency`, `efforts`, `project_manager_id`, `company_obj_id`) VALUES
	(1, 1, 'Time Trotter', 'A 1', 'Time Management', '2014-02-01 00:00:00', '2014-03-15 00:00:00', 100000, 'INR', 4, 18, 1),
	(2, 2, 'Time System', 'A 2', 'System Management', '2014-04-01 00:00:00', '2014-06-30 00:00:00', 100000, 'INR', 6, 5, 1);
/*!40000 ALTER TABLE `project` ENABLE KEYS */;


-- Dumping structure for table timespringsheet.project_task
CREATE TABLE IF NOT EXISTS `project_task` (
  `project_id` bigint(20) NOT NULL,
  `task_id` bigint(20) NOT NULL,
  PRIMARY KEY (`project_id`,`task_id`),
  KEY `fk_project_task_task_02` (`task_id`),
  CONSTRAINT `fk_project_task_project_01` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`),
  CONSTRAINT `fk_project_task_task_02` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table timespringsheet.project_task: ~0 rows (approximately)
/*!40000 ALTER TABLE `project_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_task` ENABLE KEYS */;


-- Dumping structure for table timespringsheet.project_user
CREATE TABLE IF NOT EXISTS `project_user` (
  `project_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`project_id`,`user_id`),
  KEY `fk_project_user_user_02` (`user_id`),
  CONSTRAINT `fk_project_user_project_01` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`),
  CONSTRAINT `fk_project_user_user_02` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table timespringsheet.project_user: ~10 rows (approximately)
/*!40000 ALTER TABLE `project_user` DISABLE KEYS */;
INSERT INTO `project_user` (`project_id`, `user_id`) VALUES
	(1, 5),
	(2, 5),
	(1, 7),
	(2, 8),
	(2, 9),
	(2, 12),
	(2, 14),
	(2, 16),
	(1, 18),
	(2, 18);
/*!40000 ALTER TABLE `project_user` ENABLE KEYS */;


-- Dumping structure for table timespringsheet.role_level
CREATE TABLE IF NOT EXISTS `role_level` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_x_id` bigint(20) DEFAULT NULL,
  `role_level` int(11) DEFAULT NULL,
  `role_name` varchar(255) DEFAULT NULL,
  `reporting_to` varchar(255) DEFAULT NULL,
  `final_approval` varchar(255) DEFAULT NULL,
  `permissions` varchar(700) DEFAULT NULL,
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_role_level_roleX_13` (`role_x_id`),
  CONSTRAINT `fk_role_level_roleX_13` FOREIGN KEY (`role_x_id`) REFERENCES `role_x` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- Dumping data for table timespringsheet.role_level: ~8 rows (approximately)
/*!40000 ALTER TABLE `role_level` DISABLE KEYS */;
INSERT INTO `role_level` (`id`, `role_x_id`, `role_level`, `role_name`, `reporting_to`, `final_approval`, `permissions`, `last_update`) VALUES
	(1, 1, 0, 'Software Engineer', 'Senior Software Engineer', 'Team Lead', 'Home|ManageUser|ManageClient|ManageProject|ManageTask|ApplyLeave|CreateTimesheet|SearchTimesheet|Delegate|FeedBackCreate|FeedBackView|RolePermissions|UserPermissions|UserRequest|MyBucket|LeaveBucket|Mail|Notification|DefineRoles|DefineLeaves|LeaveSettings|OrgHierarchy|', '2014-03-20 12:14:20'),
	(2, 1, 1, 'Senior Software Engineer', 'Team Lead', 'Project Manager', '', '2014-03-19 16:57:34'),
	(3, 1, 2, 'Team Lead', 'Project Manager', 'Director', '', '2014-03-19 16:57:34'),
	(4, 1, 3, 'Project Manager', 'Director', 'CEO', '', '2014-03-19 16:57:34'),
	(5, 1, 4, 'Director', 'CEO', 'Owner', '', '2014-03-19 16:57:34'),
	(6, 1, 5, 'CEO', 'Owner', 'Board', '', '2014-03-19 16:57:34'),
	(7, 1, 6, 'Owner', 'Board', 'Board', '', '2014-03-19 16:57:34'),
	(8, 1, 7, 'Board', 'Board', 'Board', '', '2014-03-19 16:57:34');
/*!40000 ALTER TABLE `role_level` ENABLE KEYS */;


-- Dumping structure for table timespringsheet.role_x
CREATE TABLE IF NOT EXISTS `role_x` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `company_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_role_x_company_14` (`company_id`),
  CONSTRAINT `fk_role_x_company_14` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Dumping data for table timespringsheet.role_x: ~1 rows (approximately)
/*!40000 ALTER TABLE `role_x` DISABLE KEYS */;
INSERT INTO `role_x` (`id`, `company_id`) VALUES
	(1, 1);
/*!40000 ALTER TABLE `role_x` ENABLE KEYS */;


-- Dumping structure for table timespringsheet.task
CREATE TABLE IF NOT EXISTS `task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `task_name` varchar(255) DEFAULT NULL,
  `task_code` varchar(255) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `effort` int(11) DEFAULT NULL,
  `is_billable` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dumping data for table timespringsheet.task: ~2 rows (approximately)
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT INTO `task` (`id`, `task_name`, `task_code`, `start_date`, `end_date`, `effort`, `is_billable`) VALUES
	(1, 'Time Trotter', 'T 1', '2014-02-01 00:00:00', '2014-03-15 00:00:00', 5, 'Yes'),
	(2, 'General', 'T 2', '2014-02-16 00:00:00', '2014-07-24 00:00:00', 5, 'Yes');
/*!40000 ALTER TABLE `task` ENABLE KEYS */;


-- Dumping structure for table timespringsheet.task_project
CREATE TABLE IF NOT EXISTS `task_project` (
  `task_id` bigint(20) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  PRIMARY KEY (`task_id`,`project_id`),
  KEY `fk_task_project_project_02` (`project_id`),
  CONSTRAINT `fk_task_project_project_02` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`),
  CONSTRAINT `fk_task_project_task_01` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table timespringsheet.task_project: ~4 rows (approximately)
/*!40000 ALTER TABLE `task_project` DISABLE KEYS */;
INSERT INTO `task_project` (`task_id`, `project_id`) VALUES
	(1, 1),
	(2, 1),
	(1, 2),
	(2, 2);
/*!40000 ALTER TABLE `task_project` ENABLE KEYS */;


-- Dumping structure for table timespringsheet.timesheet
CREATE TABLE IF NOT EXISTS `timesheet` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `last_update_date` datetime DEFAULT NULL,
  `week_of_year` int(11) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `timesheet_with_id` bigint(20) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `process_instance_id` varchar(255) DEFAULT NULL,
  `tid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_timesheet_user_15` (`user_id`),
  KEY `ix_timesheet_timesheetWith_16` (`timesheet_with_id`),
  CONSTRAINT `fk_timesheet_timesheetWith_16` FOREIGN KEY (`timesheet_with_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_timesheet_user_15` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- Dumping data for table timespringsheet.timesheet: ~12 rows (approximately)
/*!40000 ALTER TABLE `timesheet` DISABLE KEYS */;
INSERT INTO `timesheet` (`id`, `user_id`, `status`, `last_update_date`, `week_of_year`, `year`, `timesheet_with_id`, `level`, `process_instance_id`, `tid`) VALUES
	(6, 5, 1, '2014-03-10 20:44:49', 11, 2014, 13, 0, '901', '4c243b9a-6f16-42da-9cdc-99c7620c2e75'),
	(7, 5, 1, '2014-03-10 18:27:10', 12, 2014, 13, 0, '811', 'a109cd1f-ee3c-487c-8a14-bb992dc72788'),
	(8, 5, 2, '2014-03-10 20:45:14', 13, 2014, 5, 0, '916', '8f2ef7a9-f5ad-4c83-8b32-ec7d4f5fd665'),
	(9, 5, 0, '2014-03-11 18:47:51', 8, 2014, 5, 0, '1031', '8e0780fe-f43d-4ba1-a8c7-ae198946aedf'),
	(10, 5, 1, '2014-03-12 21:29:05', 5, 2014, 13, 0, '1328', 'f2dbcbf9-4f02-4c18-b0fd-161e1f0cd4bf'),
	(11, 5, 1, '2014-03-16 15:31:08', 10, 2014, 13, 0, '1501', 'f1c09057-fd54-4b68-bb38-d9cdcb575544'),
	(12, 5, 1, '2014-03-16 15:42:12', 9, 2014, 13, 0, '1516', '200e27ff-3364-49c9-926d-7872b39deafd'),
	(13, 5, 1, '2014-03-16 15:42:22', 53, 2013, 13, 0, '1701', '00528803-5c6a-4fdd-ac16-b72de31ed499'),
	(14, 5, 1, '2014-03-16 15:42:27', 14, 2014, 13, 0, '1716', '24384ee8-73b3-4994-b874-be60c2b7322c'),
	(15, 5, 1, '2014-03-18 14:10:29', 15, 2014, 13, 0, '2401', 'a32b010d-81db-4169-9ce1-2c7c7415904e'),
	(16, 5, 1, '2014-03-20 12:15:42', 20, 2014, 13, 0, '2540', '0d08781e-b353-4240-9583-7998995325db'),
	(17, 5, 1, '2014-03-20 12:15:50', 21, 2014, 13, 0, '2555', 'be4cf56c-2eee-4b89-93c5-221d28c88c72'),
	(18, 5, 3, '2014-03-20 12:15:17', 40, 2013, 13, 0, NULL, 'bfd1d14e-c00e-4c14-b691-682ef60086b4');
/*!40000 ALTER TABLE `timesheet` ENABLE KEYS */;


-- Dumping structure for table timespringsheet.timesheet_row
CREATE TABLE IF NOT EXISTS `timesheet_row` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `timesheet_id` bigint(20) DEFAULT NULL,
  `project_code` varchar(255) DEFAULT NULL,
  `task_code` varchar(255) DEFAULT NULL,
  `total_hrs` int(11) DEFAULT NULL,
  `sun` int(11) DEFAULT NULL,
  `mon` int(11) DEFAULT NULL,
  `tue` int(11) DEFAULT NULL,
  `wed` int(11) DEFAULT NULL,
  `thu` int(11) DEFAULT NULL,
  `fri` int(11) DEFAULT NULL,
  `sat` int(11) DEFAULT NULL,
  `over_time` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ix_timesheet_row_timesheet_17` (`timesheet_id`),
  CONSTRAINT `fk_timesheet_row_timesheet_17` FOREIGN KEY (`timesheet_id`) REFERENCES `timesheet` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

-- Dumping data for table timespringsheet.timesheet_row: ~14 rows (approximately)
/*!40000 ALTER TABLE `timesheet_row` DISABLE KEYS */;
INSERT INTO `timesheet_row` (`id`, `timesheet_id`, `project_code`, `task_code`, `total_hrs`, `sun`, `mon`, `tue`, `wed`, `thu`, `fri`, `sat`, `over_time`) VALUES
	(26, 7, 'A 1', 'T 1', 7, 1, 1, 1, 1, 1, 1, 1, NULL),
	(28, 6, 'A 1', 'T 1', 28, 7, 1, 2, 3, 4, 5, 6, NULL),
	(29, 6, 'A 1', 'T 2', 308, 77, 11, 22, 33, 44, 55, 66, NULL),
	(30, 6, 'A 2', 'T 2', 3108, 777, 111, 222, 333, 444, 555, 666, NULL),
	(34, 8, 'A 2', 'T 2', 31, 7, 1, 2, 3, 4, 5, 9, NULL),
	(38, 9, 'A 2', 'T 2', 28, 7, 1, 2, 3, 4, 5, 6, NULL),
	(39, 10, 'A 1', 'T 1', 7, 1, 1, 1, 1, 1, 1, 1, 1),
	(42, 11, 'A 2', 'T 1', 98, 77, 1, 2, 3, 4, 5, 6, 1),
	(43, 12, 'A 2', 'T 2', 21, 6, 0, 1, 2, 3, 4, 5, 1),
	(44, 13, 'A 1', 'T 1', 43, 4, 21, 0, 12, 1, 2, 3, 1),
	(45, 14, 'A 2', 'T 2', 10, 0, 0, NULL, 10, 0, 0, 0, 1),
	(46, 15, 'A 1', 'T 1', 28, 7, 1, 2, 3, 4, 5, 6, NULL),
	(47, 16, 'A 2', 'T 1', 5, NULL, 2, NULL, NULL, 3, NULL, NULL, NULL),
	(48, 17, 'A 2', 'T 2', 28, 7, 1, 2, 3, 4, 5, 6, NULL),
	(49, 18, 'A 1', 'T 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `timesheet_row` ENABLE KEYS */;


-- Dumping structure for table timespringsheet.user
CREATE TABLE IF NOT EXISTS `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `salutation` varchar(4) DEFAULT NULL,
  `employee_id` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `gender` varchar(6) DEFAULT NULL,
  `status` varchar(8) DEFAULT NULL,
  `hire_date` datetime DEFAULT NULL,
  `annual_income` double DEFAULT NULL,
  `hourlyrate` double DEFAULT NULL,
  `companyobject_id` bigint(20) DEFAULT NULL,
  `designation` varchar(255) DEFAULT NULL,
  `role_id` bigint(20) DEFAULT NULL,
  `manager_id` bigint(20) DEFAULT NULL,
  `release_date` datetime DEFAULT NULL,
  `hrmanager_id` bigint(20) DEFAULT NULL,
  `permissions` varchar(700) DEFAULT NULL,
  `temp_password` int(11) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `reset_flag` tinyint(1) DEFAULT '0',
  `failed_login_attempt` int(11) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `modified_date` datetime DEFAULT NULL,
  `password_reset` tinyint(1) DEFAULT '0',
  `user_status` varchar(15) DEFAULT NULL,
  `process_instance_id` varchar(255) DEFAULT NULL,
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_user_email` (`email`),
  KEY `ix_user_companyobject_18` (`companyobject_id`),
  KEY `ix_user_role_19` (`role_id`),
  KEY `ix_user_manager_20` (`manager_id`),
  KEY `ix_user_hrmanager_21` (`hrmanager_id`),
  CONSTRAINT `fk_user_companyobject_18` FOREIGN KEY (`companyobject_id`) REFERENCES `company` (`id`),
  CONSTRAINT `fk_user_hrmanager_21` FOREIGN KEY (`hrmanager_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_user_manager_20` FOREIGN KEY (`manager_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_user_role_19` FOREIGN KEY (`role_id`) REFERENCES `role_level` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- Dumping data for table timespringsheet.user: ~15 rows (approximately)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `salutation`, `employee_id`, `first_name`, `middle_name`, `last_name`, `email`, `gender`, `status`, `hire_date`, `annual_income`, `hourlyrate`, `companyobject_id`, `designation`, `role_id`, `manager_id`, `release_date`, `hrmanager_id`, `permissions`, `temp_password`, `password`, `reset_flag`, `failed_login_attempt`, `create_date`, `modified_date`, `password_reset`, `user_status`, `process_instance_id`, `last_update`) VALUES
	(1, 'Mr', '1', 'Jagbir', 'Singh', 'Paul', 'mindnervestech@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, 'SuperAdmin', NULL, NULL, NULL, NULL, 'SearchTimesheet|CreateTimesheet|Delegate|Leaves|ApplyLeave|FeedBackCreate|FeedBackView|UserPermissions|LeaveBucket|MyBucket|TeamRate|ProjectReport|ManageUser|ManageProject|ManageTask|ManageClient|Notification|DefineRoles|OrgHierarchy|Mail|RolePermissions', 0, 'a', 0, NULL, NULL, NULL, 0, 'Approved', NULL, '2013-07-08 13:46:15'),
	(4, NULL, NULL, 'gmail.com Admin', NULL, NULL, 'google@gmail.com', NULL, NULL, NULL, NULL, NULL, 1, 'Admin', NULL, NULL, NULL, NULL, 'Home|ManageUser|ManageClient|ManageProject|ManageTask|ApplyLeave|Delegate|FeedBackCreate|FeedBackView|RolePermissions|UserPermissions|TeamRate|ProjectReport|Notification|', 0, 'abcd123', NULL, NULL, NULL, NULL, NULL, 'Approved', NULL, '2014-03-14 19:57:46'),
	(5, 'Mr', 'E 1', 'Pravin', '', 'Erande', 'pberande1@gmail.com', 'Male', 'OnRolls', '2014-03-20 00:00:00', 1200000, 576.92, 1, 'Software Engineer', 1, 13, '2014-03-31 00:00:00', NULL, 'Home|ManageUser|ManageClient|ManageProject|ManageTask|ApplyLeave|CreateTimesheet|SearchTimesheet|Delegate|FeedBackCreate|FeedBackView|RolePermissions|UserPermissions|UserRequest|MyBucket|LeaveBucket|Mail|Notification|DefineRoles|DefineLeaves|LeaveSettings|OrgHierarchy|', 0, 'abcd123', NULL, NULL, NULL, NULL, NULL, 'Approved', NULL, '2014-03-20 12:14:20'),
	(7, 'Mr', 'E 4', 'Harshad', 'Rajendra', 'Gojare', 'harshad.gojre@gmail.com', 'Male', 'OnRolls', '2014-01-01 00:00:00', 100000, 48.08, 1, 'Software Engineer', 1, 13, '2014-04-09 00:00:00', NULL, 'Home|ManageUser|ManageClient|ManageProject|ManageTask|ApplyLeave|CreateTimesheet|SearchTimesheet|Delegate|FeedBackCreate|FeedBackView|RolePermissions|UserPermissions|UserRequest|MyBucket|LeaveBucket|Mail|Notification|DefineRoles|DefineLeaves|LeaveSettings|OrgHierarchy|', 0, 'abcd123', NULL, NULL, NULL, NULL, NULL, 'Approved', NULL, '2014-03-20 12:14:20'),
	(8, 'Mr', 'E 8', 'Shashank', '', 'Pohare', 'shwashank12@gmail.com', 'Male', 'OnRolls', '2013-12-06 00:00:00', 100000, 48.08, 1, 'Software Engineer', 1, 14, '2015-03-03 00:00:00', NULL, 'Home|ManageUser|ManageClient|ManageProject|ManageTask|ApplyLeave|CreateTimesheet|SearchTimesheet|Delegate|FeedBackCreate|FeedBackView|RolePermissions|UserPermissions|UserRequest|MyBucket|LeaveBucket|Mail|Notification|DefineRoles|DefineLeaves|LeaveSettings|OrgHierarchy|', 0, 'abcd123', NULL, NULL, NULL, NULL, NULL, 'Approved', NULL, '2014-03-20 12:14:20'),
	(9, 'Mr', 'E 6', 'Nagesh', '', 'Dalave', 'nageshdalave@gmail.com', 'Male', 'OnRolls', '2014-01-08 00:00:00', 100000, 48.08, 1, 'Software Engineer', 1, 14, '2014-07-03 00:00:00', NULL, 'Home|ManageUser|ManageClient|ManageProject|ManageTask|ApplyLeave|CreateTimesheet|SearchTimesheet|Delegate|FeedBackCreate|FeedBackView|RolePermissions|UserPermissions|UserRequest|MyBucket|LeaveBucket|Mail|Notification|DefineRoles|DefineLeaves|LeaveSettings|OrgHierarchy|', 0, 'abcd123', NULL, NULL, NULL, NULL, NULL, 'Approved', NULL, '2014-03-20 12:14:20'),
	(11, 'Mr', 'E 5', 'Jaideo', '', 'Deshmukh', 'jaideo.deshmukh100@gmail.com', 'Male', 'OnRolls', '2014-02-03 00:00:00', 150000, 72.12, 1, 'Project Manager', 4, 16, '2014-03-20 00:00:00', NULL, 'Home|ManageUser|ManageClient|ManageProject|ManageTask|ApplyLeave|UserRequest|MyBucket|LeaveBucket|', 0, 'abcd123', NULL, NULL, NULL, NULL, NULL, 'Approved', NULL, '2014-03-16 16:20:06'),
	(12, 'Mr', 'E 2', 'Sanghapal', '', 'Ahankare', 'sanghapal.ahankare@gmail.com', 'Male', 'OnRolls', '2014-03-01 00:00:00', 100000, 48.08, 1, 'Software Engineer', 1, 11, '2014-10-09 00:00:00', NULL, 'Home|ManageUser|ManageClient|ManageProject|ManageTask|ApplyLeave|CreateTimesheet|SearchTimesheet|Delegate|FeedBackCreate|FeedBackView|RolePermissions|UserPermissions|UserRequest|MyBucket|LeaveBucket|Mail|Notification|DefineRoles|DefineLeaves|LeaveSettings|OrgHierarchy|', 0, 'abcd123', NULL, NULL, NULL, NULL, NULL, 'Approved', NULL, '2014-03-20 12:14:20'),
	(13, 'Mr', 'E 3', 'Dhiraj', 'R', 'Bankar', 'dhairyashil.bankar@gmail.com', 'Male', 'OnRolls', '2012-12-01 00:00:00', 250000, 120.19, 1, 'Team Lead', 3, 11, '2014-03-19 00:00:00', NULL, 'Home|ManageUser|ManageClient|ManageProject|ManageTask|ApplyLeave|Delegate|FeedBackCreate|RolePermissions|UserPermissions|UserRequest|MyBucket|LeaveBucket|Mail|Notification|DefineRoles|OrgHierarchy|', 0, 'abcd123', NULL, NULL, NULL, NULL, NULL, 'Approved', NULL, '2014-03-14 19:57:30'),
	(14, 'Mr', 'E 7', 'Pankaj', 'Ashok', 'Muneshwar', 'pankajashokmuneshwar@gmail.com', 'Male', 'OnRolls', '2013-06-01 00:00:00', 150000, 72.12, 1, 'Team Lead', 3, 11, '2014-07-15 00:00:00', NULL, 'Home|ManageUser|ManageClient|ManageProject|ManageTask|ApplyLeave|Delegate|FeedBackCreate|FeedBackView|RolePermissions|UserPermissions|UserRequest|MyBucket|LeaveBucket|Mail|Notification|DefineRoles|OrgHierarchy|', 0, 'abcd123', NULL, NULL, NULL, NULL, NULL, 'Approved', NULL, '2014-03-14 19:58:02'),
	(16, 'Mr', 'E 9', 'PBE', '', 'Erande', 'pravinerande91@gmail.com@gmail.com', 'Male', 'OnRolls', '2012-01-01 00:00:00', 2000000, 961.54, 1, 'Director', 5, 17, '2016-03-13 00:00:00', NULL, 'ApplyLeave|FeedBackCreate|', 1, 'wwzma2', NULL, NULL, NULL, NULL, NULL, 'Approved', NULL, '2014-03-14 17:24:58'),
	(17, 'Mr', 'E 10', 'PBE12', '', 'Erande', 'pravinerande@ymail.com@gmail.com', 'Male', 'OnRolls', '2010-02-02 00:00:00', 1223243, 588.1, 1, 'CEO', 6, 18, '2014-03-19 00:00:00', NULL, 'CreateTimesheet|SearchTimesheet|FeedBackCreate|', 1, 'jx3nno', NULL, NULL, NULL, NULL, NULL, 'Approved', NULL, '2014-03-14 19:57:36'),
	(18, 'Mr', 'E 11', 'Dhairyashil', '', 'Bankar', 'dhiraj10.1988@gmail.com@gmail.com', 'Male', 'OnRolls', '2010-01-31 00:00:00', 124565766, 59887.39, 1, 'Owner', 7, 4, '2014-03-01 00:00:00', NULL, 'Home|CreateTimesheet|Delegate|FeedBackCreate|FeedBackView|', 1, 'z98hfu', NULL, NULL, NULL, NULL, NULL, 'Approved', NULL, '2014-03-14 19:58:07'),
	(19, NULL, NULL, 'yahoo.com Admin', NULL, NULL, '123@yahoo.com', NULL, NULL, NULL, NULL, NULL, 2, 'Admin', NULL, NULL, NULL, NULL, 'Home|ManageUser|ManageClient|ManageProject|ManageTask|ApplyLeave|CreateTimesheet|SearchTimesheet|Delegate|FeedBackCreate|FeedBackView|RolePermissions|UserPermissions|UserRequest|MyBucket|LeaveBucket|TeamRate|ProjectReport|Mail|Notification|DefineRoles|DefineLeaves|LeaveSettings|OrgHierarchy|', 0, 'abcd123', NULL, NULL, NULL, NULL, NULL, 'Approved', NULL, '2014-03-19 20:39:02'),
	(20, NULL, NULL, 'abc', 'def', 'xyz', 'abc@yahoo.com', NULL, 'OnRolls', NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'abcd123', NULL, NULL, NULL, NULL, NULL, 'PendingApproval', NULL, '2014-03-19 20:37:24');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;


-- Dumping structure for table timespringsheet.user_project
CREATE TABLE IF NOT EXISTS `user_project` (
  `user_id` bigint(20) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  PRIMARY KEY (`user_id`,`project_id`),
  KEY `fk_user_project_project_02` (`project_id`),
  CONSTRAINT `fk_user_project_project_02` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`),
  CONSTRAINT `fk_user_project_user_01` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table timespringsheet.user_project: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_project` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_project` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
