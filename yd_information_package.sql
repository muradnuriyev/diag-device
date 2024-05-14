-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Май 06 2024 г., 08:58
-- Версия сервера: 10.4.28-MariaDB
-- Версия PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `yd_information_package`
--

DELIMITER $$
--
-- Процедуры
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_yd_tables` ()   BEGIN
    DECLARE counter INT DEFAULT 2;
    DECLARE new_table_name VARCHAR(50);
    DECLARE sql_query VARCHAR(1000);
    
    WHILE counter <= 58 DO
        SET new_table_name = CONCAT('yd_', counter);
        SET sql_query = CONCAT('CREATE TABLE ', new_table_name, ' AS SELECT * FROM yd_1;');
        PREPARE stmt FROM sql_query;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
        SET counter = counter + 1;
    END WHILE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Delete_All_Data` ()   BEGIN
    DECLARE counter INT DEFAULT 1;
    DECLARE table_name VARCHAR(50);

    WHILE counter <= 58 DO
        SET table_name = CONCAT('yd_', counter);
        SET @sql_query = CONCAT('TRUNCATE TABLE ', table_name, ';');
        PREPARE stmt FROM @sql_query;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
        SET counter = counter + 1;
    END WHILE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Rename_Columns` ()   BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE tableName VARCHAR(100);
    DECLARE cur CURSOR FOR
        SELECT TABLE_NAME
        FROM INFORMATION_SCHEMA.TABLES
        WHERE TABLE_SCHEMA = 'yd_information_package'
        AND TABLE_NAME LIKE 'yd_%';  -- Assuming all your tables start with 'yd_'

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = 1;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO tableName;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SET @alterQuery = CONCAT('ALTER TABLE ', tableName, ' CHANGE COLUMN U3 U_AC VARCHAR(100);');
        PREPARE stmt FROM @alterQuery;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END LOOP;

    CLOSE cur;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `yd_1`
--

CREATE TABLE `yd_1` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_1`
--

INSERT INTO `yd_1` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 1, 5, 3, 1, 1, 4, 3, 1, 1, 2, 26, 1, ' 3 ', ' 114 ', ' 137 ', ' 129 ', 2.17, 3.5, 2.09, 2.09, 2.19, 2.13, 3.5, 3.5, 2.1, 2.5, 3.5, 3.15, 3.5, 7, 10, '2024-05-02 09:56:32'),
(2, 1, 14, 0, 1, 1, 2, 4, 1, 1, 1, 39, 1, ' 0 ', ' 149 ', ' 109 ', ' 107 ', 2.08, 2.5, 2.5, 2.1, 2.17, 2.3, 2.75, 2.09, 2.25, 2.15, 3.13, 3.17, 3.21, 7, 9, '2024-05-02 09:58:11'),
(3, 1, 15, 0, 0, 1, 4, 1, 0, 1, 0, 29, 1, ' 0 ', ' 115 ', ' 100 ', ' 138 ', 2.09, 2.25, 2.19, 2.14, 2.38, 2.5, 2.21, 2.3, 2.3, 2.25, 4.5, 3.12, 3.14, 5, 9, '2024-05-02 09:58:50'),
(4, 1, 5, 3, 1, 1, 4, 3, 1, 1, 2, 26, 1, ' 3 ', ' 114 ', ' 137 ', ' 129 ', 2.17, 3.5, 2.09, 2.09, 2.19, 2.13, 3.5, 3.5, 2.1, 2.5, 3.5, 3.15, 3.5, 7, 10, '2024-05-02 10:12:05'),
(5, 1, 5, 3, 1, 1, 4, 3, 1, 1, 2, 26, 1, ' 3 ', ' 114 ', ' 137 ', ' 129 ', 2.17, 3.5, 2.09, 2.09, 2.19, 2.13, 3.5, 3.5, 2.1, 2.5, 3.5, 3.15, 3.5, 7, 10, '2024-05-02 10:29:06'),
(6, 1, 5, 3, 1, 1, 4, 3, 1, 1, 2, 26, 1, ' 3 ', ' 114 ', ' 137 ', ' 129 ', 2.17, 3.5, 2.09, 2.09, 2.19, 2.13, 3.5, 3.5, 2.1, 2.5, 3.5, 3.15, 3.5, 7, 10, '2024-05-02 11:50:55'),
(7, 1, 14, 0, 1, 1, 2, 4, 1, 1, 1, 39, 1, ' 0 ', ' 149 ', ' 109 ', ' 107 ', 2.08, 2.5, 2.5, 2.1, 2.17, 2.3, 2.75, 2.09, 2.25, 2.15, 3.13, 3.17, 3.21, 7, 9, '2024-05-02 11:52:33'),
(8, 1, 5, 3, 1, 1, 4, 3, 1, 1, 2, 26, 1, ' 3 ', ' 114 ', ' 137 ', ' 129 ', 2.17, 3.5, 2.09, 2.09, 2.19, 2.13, 3.5, 3.5, 2.1, 2.5, 3.5, 3.15, 3.5, 7, 10, '2024-05-02 12:09:27'),
(9, 1, 14, 0, 1, 1, 2, 4, 1, 1, 1, 39, 1, ' 0 ', ' 149 ', ' 109 ', ' 107 ', 2.08, 2.5, 2.5, 2.1, 2.17, 2.3, 2.75, 2.09, 2.25, 2.15, 3.13, 3.17, 3.21, 7, 9, '2024-05-02 12:11:06'),
(10, 1, 15, 0, 0, 1, 4, 1, 0, 1, 0, 29, 1, ' 0 ', ' 115 ', ' 100 ', ' 138 ', 2.09, 2.25, 2.19, 2.14, 2.38, 2.5, 2.21, 2.3, 2.3, 2.25, 4.5, 3.12, 3.14, 5, 9, '2024-05-02 12:11:45'),
(11, 1, 5, 3, 1, 1, 4, 3, 1, 1, 2, 26, 1, ' 3 ', ' 114 ', ' 137 ', ' 129 ', 2.17, 3.5, 2.09, 2.09, 2.19, 2.13, 3.5, 3.5, 2.1, 2.5, 3.5, 3.15, 3.5, 7, 10, '2024-05-02 12:38:23'),
(12, 1, 5, 3, 1, 1, 4, 3, 1, 1, 2, 26, 1, ' 3 ', ' 114 ', ' 137 ', ' 129 ', 2.17, 3.5, 2.09, 2.09, 2.19, 2.13, 3.5, 3.5, 2.1, 2.5, 3.5, 3.15, 3.5, 7, 10, '2024-05-03 11:34:56'),
(13, 1, 14, 0, 1, 1, 2, 4, 1, 1, 1, 39, 1, ' 0 ', ' 149 ', ' 109 ', ' 107 ', 2.08, 2.5, 2.5, 2.1, 2.17, 2.3, 2.75, 2.09, 2.25, 2.15, 3.13, 3.17, 3.21, 7, 9, '2024-05-03 11:37:33'),
(14, 1, 15, 0, 0, 1, 4, 1, 0, 1, 0, 29, 1, ' 0 ', ' 115 ', ' 100 ', ' 138 ', 2.09, 2.25, 2.19, 2.14, 2.38, 2.5, 2.21, 2.3, 2.3, 2.25, 4.5, 3.12, 3.14, 5, 9, '2024-05-03 11:37:45'),
(15, 1, 5, 3, 1, 1, 4, 3, 1, 1, 2, 26, 1, ' 3 ', ' 114 ', ' 137 ', ' 129 ', 2.17, 3.5, 2.09, 2.09, 2.19, 2.13, 3.5, 3.5, 2.1, 2.5, 3.5, 3.15, 3.5, 7, 10, '2024-05-03 11:52:15'),
(16, 1, 14, 0, 1, 1, 2, 4, 1, 1, 1, 39, 1, ' 0 ', ' 149 ', ' 109 ', ' 107 ', 2.08, 2.5, 2.5, 2.1, 2.17, 2.3, 2.75, 2.09, 2.25, 2.15, 3.13, 3.17, 3.21, 7, 9, '2024-05-03 11:53:54'),
(17, 1, 15, 0, 0, 1, 4, 1, 0, 1, 0, 29, 1, ' 0 ', ' 115 ', ' 100 ', ' 138 ', 2.09, 2.25, 2.19, 2.14, 2.38, 2.5, 2.21, 2.3, 2.3, 2.25, 4.5, 3.12, 3.14, 5, 9, '2024-05-03 11:54:33'),
(18, 1, 10, 0, 0, 0, 5, 4, 0, 0, 1, 26, 1, ' 1 ', ' 129 ', ' 126 ', ' 112 ', 2.13, 2.3, 2.12, 2.13, 2.13, 2.3, 2.09, 2.75, 2.09, 2.15, 3.08, 3.11, 3.12, 4, 11, '2024-05-03 11:57:22'),
(19, 1, 18, 6, 1, 0, 0, 2, 1, 0, 2, 39, 0, ' 1 ', ' 118 ', ' 109 ', ' 141 ', 2.09, 2.75, 2.17, 2.13, 2.5, 2.19, 2.3, 2.21, 2.75, 3.5, 3.09, 3.3, 3.08, 4, 10, '2024-05-03 11:58:42'),
(20, 1, 7, 3, 1, 1, 3, 3, 0, 1, 4, 27, 1, ' 3 ', ' 118 ', ' 145 ', ' 141 ', 2.19, 2.08, 2.21, 2.38, 2.5, 3.5, 2.09, 2.21, 2.17, 3.5, 3.14, 4.5, 3.17, 4, 11, '2024-05-03 11:59:33'),
(21, 1, 2, 7, 0, 1, 0, 3, 1, 0, 4, 47, 1, ' 2 ', ' 111 ', ' 104 ', ' 117 ', 2.12, 2.75, 2.08, 2.14, 2.19, 2.14, 2.08, 2.17, 3.5, 2.3, 3.17, 3.38, 3.09, 5, 7, '2024-05-03 12:00:21'),
(22, 1, 11, 2, 0, 1, 4, 0, 1, 1, 3, 40, 0, ' 2 ', ' 131 ', ' 109 ', ' 144 ', 2.08, 2.75, 2.25, 2.3, 2.17, 2.17, 2.1, 2.25, 2.17, 2.25, 3.12, 3.08, 3.09, 5, 9, '2024-05-03 12:05:43'),
(23, 1, 7, 2, 0, 1, 3, 0, 1, 0, 1, 27, 0, ' 1 ', ' 114 ', ' 125 ', ' 109 ', 2.3, 2.19, 2.38, 2.38, 2.14, 2.08, 2.13, 2.09, 3.5, 2.08, 3.5, 3.5, 3.25, 7, 9, '2024-05-03 12:06:14'),
(24, 1, 1, 3, 1, 1, 3, 2, 1, 1, 2, 46, 1, ' 0 ', ' 123 ', ' 127 ', ' 111 ', 2.17, 2.38, 2.1, 2.25, 2.38, 2.08, 2.75, 2.17, 2.11, 3.5, 3.75, 3.11, 3.25, 7, 12, '2024-05-03 12:07:43'),
(25, 1, 6, 9, 0, 0, 4, 5, 1, 1, 2, 29, 0, ' 2 ', ' 141 ', ' 101 ', ' 143 ', 2.75, 2.08, 2.5, 2.75, 2.08, 2.25, 2.09, 2.15, 2.13, 2.5, 3.11, 3.09, 3.08, 4, 7, '2024-05-03 12:07:55'),
(26, 1, 11, 3, 1, 0, 2, 3, 0, 1, 4, 31, 1, ' 2 ', ' 115 ', ' 123 ', ' 134 ', 2.3, 2.15, 2.25, 2.11, 2.75, 2.19, 2.3, 2.13, 2.3, 2.3, 3.5, 3.21, 3.11, 6, 7, '2024-05-03 12:08:55');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_2`
--

CREATE TABLE `yd_2` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_2`
--

INSERT INTO `yd_2` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 2, 14, 6, 0, 0, 2, 0, 0, 0, 0, 30, 1, ' 2 ', ' 139 ', ' 148 ', ' 101 ', 2.75, 2.08, 2.21, 2.13, 2.08, 2.13, 2.09, 2.14, 2.38, 3.5, 3.21, 3.08, 3.12, 7, 12, '2024-05-02 09:56:13'),
(2, 2, 11, 3, 0, 0, 4, 3, 1, 0, 4, 30, 1, ' 1 ', ' 120 ', ' 141 ', ' 119 ', 2.14, 2.5, 2.09, 2.09, 2.11, 2.12, 2.3, 2.25, 2.09, 2.14, 3.75, 3.17, 3.3, 6, 11, '2024-05-02 09:56:15'),
(3, 2, 2, 2, 0, 0, 3, 1, 0, 1, 4, 44, 1, ' 2 ', ' 133 ', ' 130 ', ' 106 ', 2.19, 2.75, 2.12, 2.11, 2.11, 3.5, 2.15, 2.75, 2.19, 2.21, 3.08, 3.09, 3.09, 7, 7, '2024-05-02 09:57:01'),
(4, 2, 18, 6, 1, 0, 0, 0, 1, 1, 1, 47, 0, ' 1 ', ' 146 ', ' 128 ', ' 106 ', 2.38, 3.5, 2.5, 2.12, 2.08, 2.38, 2.09, 2.12, 2.38, 2.13, 3.13, 3.12, 3.08, 6, 9, '2024-05-02 09:58:25'),
(5, 2, 14, 6, 0, 0, 2, 0, 0, 0, 0, 30, 1, ' 2 ', ' 139 ', ' 148 ', ' 101 ', 2.75, 2.08, 2.21, 2.13, 2.08, 2.13, 2.09, 2.14, 2.38, 3.5, 3.21, 3.08, 3.12, 7, 12, '2024-05-02 10:11:46'),
(6, 2, 11, 3, 0, 0, 4, 3, 1, 0, 4, 30, 1, ' 1 ', ' 120 ', ' 141 ', ' 119 ', 2.14, 2.5, 2.09, 2.09, 2.11, 2.12, 2.3, 2.25, 2.09, 2.14, 3.75, 3.17, 3.3, 6, 11, '2024-05-02 10:11:48'),
(7, 2, 2, 2, 0, 0, 3, 1, 0, 1, 4, 44, 1, ' 2 ', ' 133 ', ' 130 ', ' 106 ', 2.19, 2.75, 2.12, 2.11, 2.11, 3.5, 2.15, 2.75, 2.19, 2.21, 3.08, 3.09, 3.09, 7, 7, '2024-05-02 10:12:34'),
(8, 2, 14, 6, 0, 0, 2, 0, 0, 0, 0, 30, 1, ' 2 ', ' 139 ', ' 148 ', ' 101 ', 2.75, 2.08, 2.21, 2.13, 2.08, 2.13, 2.09, 2.14, 2.38, 3.5, 3.21, 3.08, 3.12, 7, 12, '2024-05-02 10:13:32'),
(9, 2, 11, 3, 0, 0, 4, 3, 1, 0, 4, 30, 1, ' 1 ', ' 120 ', ' 141 ', ' 119 ', 2.14, 2.5, 2.09, 2.09, 2.11, 2.12, 2.3, 2.25, 2.09, 2.14, 3.75, 3.17, 3.3, 6, 11, '2024-05-02 10:13:34'),
(10, 2, 14, 6, 0, 0, 2, 0, 0, 0, 0, 30, 1, ' 2 ', ' 139 ', ' 148 ', ' 101 ', 2.75, 2.08, 2.21, 2.13, 2.08, 2.13, 2.09, 2.14, 2.38, 3.5, 3.21, 3.08, 3.12, 7, 12, '2024-05-02 10:23:41'),
(11, 2, 11, 3, 0, 0, 4, 3, 1, 0, 4, 30, 1, ' 1 ', ' 120 ', ' 141 ', ' 119 ', 2.14, 2.5, 2.09, 2.09, 2.11, 2.12, 2.3, 2.25, 2.09, 2.14, 3.75, 3.17, 3.3, 6, 11, '2024-05-02 10:23:43'),
(12, 2, 14, 6, 0, 0, 2, 0, 0, 0, 0, 30, 1, ' 2 ', ' 139 ', ' 148 ', ' 101 ', 2.75, 2.08, 2.21, 2.13, 2.08, 2.13, 2.09, 2.14, 2.38, 3.5, 3.21, 3.08, 3.12, 7, 12, '2024-05-02 10:26:33'),
(13, 2, 11, 3, 0, 0, 4, 3, 1, 0, 4, 30, 1, ' 1 ', ' 120 ', ' 141 ', ' 119 ', 2.14, 2.5, 2.09, 2.09, 2.11, 2.12, 2.3, 2.25, 2.09, 2.14, 3.75, 3.17, 3.3, 6, 11, '2024-05-02 10:26:35'),
(14, 2, 14, 6, 0, 0, 2, 0, 0, 0, 0, 30, 1, ' 2 ', ' 139 ', ' 148 ', ' 101 ', 2.75, 2.08, 2.21, 2.13, 2.08, 2.13, 2.09, 2.14, 2.38, 3.5, 3.21, 3.08, 3.12, 7, 12, '2024-05-02 10:28:48'),
(15, 2, 11, 3, 0, 0, 4, 3, 1, 0, 4, 30, 1, ' 1 ', ' 120 ', ' 141 ', ' 119 ', 2.14, 2.5, 2.09, 2.09, 2.11, 2.12, 2.3, 2.25, 2.09, 2.14, 3.75, 3.17, 3.3, 6, 11, '2024-05-02 10:28:50'),
(16, 2, 14, 6, 0, 0, 2, 0, 0, 0, 0, 30, 1, ' 2 ', ' 139 ', ' 148 ', ' 101 ', 2.75, 2.08, 2.21, 2.13, 2.08, 2.13, 2.09, 2.14, 2.38, 3.5, 3.21, 3.08, 3.12, 7, 12, '2024-05-02 11:50:36'),
(17, 2, 11, 3, 0, 0, 4, 3, 1, 0, 4, 30, 1, ' 1 ', ' 120 ', ' 141 ', ' 119 ', 2.14, 2.5, 2.09, 2.09, 2.11, 2.12, 2.3, 2.25, 2.09, 2.14, 3.75, 3.17, 3.3, 6, 11, '2024-05-02 11:50:38'),
(18, 2, 2, 2, 0, 0, 3, 1, 0, 1, 4, 44, 1, ' 2 ', ' 133 ', ' 130 ', ' 106 ', 2.19, 2.75, 2.12, 2.11, 2.11, 3.5, 2.15, 2.75, 2.19, 2.21, 3.08, 3.09, 3.09, 7, 7, '2024-05-02 11:51:23'),
(19, 2, 18, 6, 1, 0, 0, 0, 1, 1, 1, 47, 0, ' 1 ', ' 146 ', ' 128 ', ' 106 ', 2.38, 3.5, 2.5, 2.12, 2.08, 2.38, 2.09, 2.12, 2.38, 2.13, 3.13, 3.12, 3.08, 6, 9, '2024-05-02 11:52:48'),
(20, 2, 14, 6, 0, 0, 2, 0, 0, 0, 0, 30, 1, ' 2 ', ' 139 ', ' 148 ', ' 101 ', 2.75, 2.08, 2.21, 2.13, 2.08, 2.13, 2.09, 2.14, 2.38, 3.5, 3.21, 3.08, 3.12, 7, 12, '2024-05-02 12:09:09'),
(21, 2, 11, 3, 0, 0, 4, 3, 1, 0, 4, 30, 1, ' 1 ', ' 120 ', ' 141 ', ' 119 ', 2.14, 2.5, 2.09, 2.09, 2.11, 2.12, 2.3, 2.25, 2.09, 2.14, 3.75, 3.17, 3.3, 6, 11, '2024-05-02 12:09:11'),
(22, 2, 2, 2, 0, 0, 3, 1, 0, 1, 4, 44, 1, ' 2 ', ' 133 ', ' 130 ', ' 106 ', 2.19, 2.75, 2.12, 2.11, 2.11, 3.5, 2.15, 2.75, 2.19, 2.21, 3.08, 3.09, 3.09, 7, 7, '2024-05-02 12:09:56'),
(23, 2, 18, 6, 1, 0, 0, 0, 1, 1, 1, 47, 0, ' 1 ', ' 146 ', ' 128 ', ' 106 ', 2.38, 3.5, 2.5, 2.12, 2.08, 2.38, 2.09, 2.12, 2.38, 2.13, 3.13, 3.12, 3.08, 6, 9, '2024-05-02 12:11:20'),
(24, 2, 14, 6, 0, 0, 2, 0, 0, 0, 0, 30, 1, ' 2 ', ' 139 ', ' 148 ', ' 101 ', 2.75, 2.08, 2.21, 2.13, 2.08, 2.13, 2.09, 2.14, 2.38, 3.5, 3.21, 3.08, 3.12, 7, 12, '2024-05-02 12:38:05'),
(25, 2, 11, 3, 0, 0, 4, 3, 1, 0, 4, 30, 1, ' 1 ', ' 120 ', ' 141 ', ' 119 ', 2.14, 2.5, 2.09, 2.09, 2.11, 2.12, 2.3, 2.25, 2.09, 2.14, 3.75, 3.17, 3.3, 6, 11, '2024-05-02 12:38:07'),
(26, 2, 2, 2, 0, 0, 3, 1, 0, 1, 4, 44, 1, ' 2 ', ' 133 ', ' 130 ', ' 106 ', 2.19, 2.75, 2.12, 2.11, 2.11, 3.5, 2.15, 2.75, 2.19, 2.21, 3.08, 3.09, 3.09, 7, 7, '2024-05-02 12:38:52'),
(27, 2, 14, 6, 0, 0, 2, 0, 0, 0, 0, 30, 1, ' 2 ', ' 139 ', ' 148 ', ' 101 ', 2.75, 2.08, 2.21, 2.13, 2.08, 2.13, 2.09, 2.14, 2.38, 3.5, 3.21, 3.08, 3.12, 7, 12, '2024-05-03 11:34:33'),
(28, 2, 11, 3, 0, 0, 4, 3, 1, 0, 4, 30, 1, ' 1 ', ' 120 ', ' 141 ', ' 119 ', 2.14, 2.5, 2.09, 2.09, 2.11, 2.12, 2.3, 2.25, 2.09, 2.14, 3.75, 3.17, 3.3, 6, 11, '2024-05-03 11:34:37'),
(29, 2, 2, 2, 0, 0, 3, 1, 0, 1, 4, 44, 1, ' 2 ', ' 133 ', ' 130 ', ' 106 ', 2.19, 2.75, 2.12, 2.11, 2.11, 3.5, 2.15, 2.75, 2.19, 2.21, 3.08, 3.09, 3.09, 7, 7, '2024-05-03 11:36:48'),
(30, 2, 18, 6, 1, 0, 0, 0, 1, 1, 1, 47, 0, ' 1 ', ' 146 ', ' 128 ', ' 106 ', 2.38, 3.5, 2.5, 2.12, 2.08, 2.38, 2.09, 2.12, 2.38, 2.13, 3.13, 3.12, 3.08, 6, 9, '2024-05-03 11:37:38'),
(31, 2, 24, 9, 1, 1, 0, 3, 1, 1, 2, 33, 0, ' 0 ', ' 147 ', ' 106 ', ' 115 ', 2.08, 2.19, 2.25, 2.1, 3.5, 2.13, 2.75, 2.14, 2.38, 2.17, 3.1, 3.09, 3.5, 4, 11, '2024-05-03 11:37:57'),
(32, 2, 14, 6, 0, 0, 2, 0, 0, 0, 0, 30, 1, ' 2 ', ' 139 ', ' 148 ', ' 101 ', 2.75, 2.08, 2.21, 2.13, 2.08, 2.13, 2.09, 2.14, 2.38, 3.5, 3.21, 3.08, 3.12, 7, 12, '2024-05-03 11:51:57'),
(33, 2, 11, 3, 0, 0, 4, 3, 1, 0, 4, 30, 1, ' 1 ', ' 120 ', ' 141 ', ' 119 ', 2.14, 2.5, 2.09, 2.09, 2.11, 2.12, 2.3, 2.25, 2.09, 2.14, 3.75, 3.17, 3.3, 6, 11, '2024-05-03 11:51:59'),
(34, 2, 2, 2, 0, 0, 3, 1, 0, 1, 4, 44, 1, ' 2 ', ' 133 ', ' 130 ', ' 106 ', 2.19, 2.75, 2.12, 2.11, 2.11, 3.5, 2.15, 2.75, 2.19, 2.21, 3.08, 3.09, 3.09, 7, 7, '2024-05-03 11:52:44'),
(35, 2, 18, 6, 1, 0, 0, 0, 1, 1, 1, 47, 0, ' 1 ', ' 146 ', ' 128 ', ' 106 ', 2.38, 3.5, 2.5, 2.12, 2.08, 2.38, 2.09, 2.12, 2.38, 2.13, 3.13, 3.12, 3.08, 6, 9, '2024-05-03 11:54:08'),
(36, 2, 24, 9, 1, 1, 0, 3, 1, 1, 2, 33, 0, ' 0 ', ' 147 ', ' 106 ', ' 115 ', 2.08, 2.19, 2.25, 2.1, 3.5, 2.13, 2.75, 2.14, 2.38, 2.17, 3.1, 3.09, 3.5, 4, 11, '2024-05-03 11:55:18'),
(37, 2, 1, 7, 0, 0, 0, 4, 1, 0, 0, 48, 1, ' 0 ', ' 135 ', ' 128 ', ' 108 ', 2.19, 2.12, 2.1, 2.15, 2.09, 2.09, 2.25, 3.5, 2.14, 3.5, 3.11, 3.25, 3.21, 6, 12, '2024-05-03 11:57:17'),
(38, 2, 3, 2, 1, 1, 3, 2, 0, 0, 1, 47, 1, ' 3 ', ' 147 ', ' 134 ', ' 116 ', 2.13, 2.12, 2.38, 2.17, 2.08, 2.12, 2.5, 2.25, 2.19, 2.19, 3.09, 3.09, 4.5, 7, 12, '2024-05-03 11:57:48'),
(39, 2, 2, 3, 0, 0, 2, 2, 1, 0, 4, 29, 0, ' 1 ', ' 148 ', ' 105 ', ' 147 ', 2.1, 2.13, 2.08, 2.13, 2.25, 2.08, 2.12, 2.13, 2.08, 2.11, 3.21, 3.08, 3.21, 7, 12, '2024-05-03 11:58:21'),
(40, 2, 3, 7, 1, 0, 0, 5, 1, 1, 0, 44, 1, ' 2 ', ' 137 ', ' 108 ', ' 106 ', 2.19, 2.75, 2.1, 2.21, 2.38, 2.5, 3.5, 2.1, 2.12, 3.5, 3.15, 3.3, 3.5, 5, 11, '2024-05-03 11:58:31');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_3`
--

CREATE TABLE `yd_3` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_3`
--

INSERT INTO `yd_3` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 3, 1, 6, 0, 1, 2, 2, 0, 1, 4, 28, 1, ' 2 ', ' 145 ', ' 116 ', ' 127 ', 2.08, 2.17, 2.75, 2.09, 3.5, 2.21, 2.11, 2.1, 2.38, 2.08, 3.5, 3.09, 3.19, 7, 11, '2024-05-02 09:56:44'),
(2, 3, 8, 6, 0, 0, 5, 1, 1, 1, 3, 32, 0, ' 3 ', ' 101 ', ' 122 ', ' 137 ', 3.5, 2.08, 2.75, 2.14, 2.19, 2.09, 2.13, 2.14, 2.08, 2.12, 3.21, 3.08, 3.14, 7, 8, '2024-05-02 09:58:17'),
(3, 3, 11, 0, 1, 0, 0, 4, 0, 0, 3, 35, 1, ' 2 ', ' 103 ', ' 114 ', ' 122 ', 2.19, 2.08, 2.09, 2.38, 3.5, 2.12, 2.75, 2.21, 2.11, 2.5, 4.5, 3.19, 3.14, 3, 8, '2024-05-02 09:59:08'),
(4, 3, 1, 6, 0, 1, 2, 2, 0, 1, 4, 28, 1, ' 2 ', ' 145 ', ' 116 ', ' 127 ', 2.08, 2.17, 2.75, 2.09, 3.5, 2.21, 2.11, 2.1, 2.38, 2.08, 3.5, 3.09, 3.19, 7, 11, '2024-05-02 10:12:17'),
(5, 3, 1, 6, 0, 1, 2, 2, 0, 1, 4, 28, 1, ' 2 ', ' 145 ', ' 116 ', ' 127 ', 2.08, 2.17, 2.75, 2.09, 3.5, 2.21, 2.11, 2.1, 2.38, 2.08, 3.5, 3.09, 3.19, 7, 11, '2024-05-02 11:51:07'),
(6, 3, 8, 6, 0, 0, 5, 1, 1, 1, 3, 32, 0, ' 3 ', ' 101 ', ' 122 ', ' 137 ', 3.5, 2.08, 2.75, 2.14, 2.19, 2.09, 2.13, 2.14, 2.08, 2.12, 3.21, 3.08, 3.14, 7, 8, '2024-05-02 11:52:40'),
(7, 3, 1, 6, 0, 1, 2, 2, 0, 1, 4, 28, 1, ' 2 ', ' 145 ', ' 116 ', ' 127 ', 2.08, 2.17, 2.75, 2.09, 3.5, 2.21, 2.11, 2.1, 2.38, 2.08, 3.5, 3.09, 3.19, 7, 11, '2024-05-02 12:09:39'),
(8, 3, 8, 6, 0, 0, 5, 1, 1, 1, 3, 32, 0, ' 3 ', ' 101 ', ' 122 ', ' 137 ', 3.5, 2.08, 2.75, 2.14, 2.19, 2.09, 2.13, 2.14, 2.08, 2.12, 3.21, 3.08, 3.14, 7, 8, '2024-05-02 12:11:12'),
(9, 3, 1, 6, 0, 1, 2, 2, 0, 1, 4, 28, 1, ' 2 ', ' 145 ', ' 116 ', ' 127 ', 2.08, 2.17, 2.75, 2.09, 3.5, 2.21, 2.11, 2.1, 2.38, 2.08, 3.5, 3.09, 3.19, 7, 11, '2024-05-02 12:38:35'),
(10, 3, 1, 6, 0, 1, 2, 2, 0, 1, 4, 28, 1, ' 2 ', ' 145 ', ' 116 ', ' 127 ', 2.08, 2.17, 2.75, 2.09, 3.5, 2.21, 2.11, 2.1, 2.38, 2.08, 3.5, 3.09, 3.19, 7, 11, '2024-05-03 11:36:24'),
(11, 3, 8, 6, 0, 0, 5, 1, 1, 1, 3, 32, 0, ' 3 ', ' 101 ', ' 122 ', ' 137 ', 3.5, 2.08, 2.75, 2.14, 2.19, 2.09, 2.13, 2.14, 2.08, 2.12, 3.21, 3.08, 3.14, 7, 8, '2024-05-03 11:37:36'),
(12, 3, 11, 0, 1, 0, 0, 4, 0, 0, 3, 35, 1, ' 2 ', ' 103 ', ' 114 ', ' 122 ', 2.19, 2.08, 2.09, 2.38, 3.5, 2.12, 2.75, 2.21, 2.11, 2.5, 4.5, 3.19, 3.14, 3, 8, '2024-05-03 11:37:49'),
(13, 3, 1, 6, 0, 1, 2, 2, 0, 1, 4, 28, 1, ' 2 ', ' 145 ', ' 116 ', ' 127 ', 2.08, 2.17, 2.75, 2.09, 3.5, 2.21, 2.11, 2.1, 2.38, 2.08, 3.5, 3.09, 3.19, 7, 11, '2024-05-03 11:52:27'),
(14, 3, 8, 6, 0, 0, 5, 1, 1, 1, 3, 32, 0, ' 3 ', ' 101 ', ' 122 ', ' 137 ', 3.5, 2.08, 2.75, 2.14, 2.19, 2.09, 2.13, 2.14, 2.08, 2.12, 3.21, 3.08, 3.14, 7, 8, '2024-05-03 11:54:00'),
(15, 3, 11, 0, 1, 0, 0, 4, 0, 0, 3, 35, 1, ' 2 ', ' 103 ', ' 114 ', ' 122 ', 2.19, 2.08, 2.09, 2.38, 3.5, 2.12, 2.75, 2.21, 2.11, 2.5, 4.5, 3.19, 3.14, 3, 8, '2024-05-03 11:54:51'),
(16, 3, 24, 2, 1, 1, 3, 1, 0, 1, 4, 32, 0, ' 3 ', ' 133 ', ' 129 ', ' 102 ', 2.21, 2.11, 2.75, 2.15, 2.08, 2.09, 2.09, 2.08, 2.09, 2.1, 3.11, 3.21, 3.15, 3, 8, '2024-05-03 11:56:28'),
(17, 3, 9, 7, 1, 0, 2, 3, 1, 0, 3, 41, 1, ' 1 ', ' 149 ', ' 113 ', ' 143 ', 2.25, 2.09, 2.12, 2.21, 2.11, 2.15, 3.5, 2.1, 2.25, 2.08, 3.15, 3.1, 3.38, 6, 10, '2024-05-03 11:56:45'),
(18, 3, 17, 9, 0, 1, 0, 3, 1, 1, 4, 44, 0, ' 2 ', ' 130 ', ' 114 ', ' 105 ', 2.15, 2.21, 2.09, 2.08, 2.3, 2.75, 2.14, 2.14, 3.5, 2.08, 3.14, 3.1, 3.1, 4, 11, '2024-05-03 12:00:23'),
(19, 3, 14, 8, 1, 1, 2, 2, 0, 1, 0, 32, 0, ' 0 ', ' 129 ', ' 146 ', ' 146 ', 2.08, 3.5, 2.09, 2.08, 3.5, 2.13, 2.75, 2.1, 2.11, 2.15, 3.15, 3.13, 3.09, 7, 10, '2024-05-03 12:00:47'),
(20, 3, 9, 9, 0, 0, 3, 4, 1, 0, 3, 46, 1, ' 3 ', ' 132 ', ' 143 ', ' 106 ', 2.09, 2.38, 2.25, 2.09, 2.15, 2.1, 2.12, 2.17, 2.09, 2.38, 4.5, 3.38, 4.5, 4, 12, '2024-05-03 12:01:22'),
(21, 3, 15, 9, 1, 1, 4, 2, 1, 0, 3, 43, 0, ' 4 ', ' 129 ', ' 149 ', ' 135 ', 2.14, 2.38, 3.5, 2.12, 2.11, 2.08, 2.09, 2.25, 2.19, 2.3, 3.12, 3.08, 3.17, 7, 8, '2024-05-03 12:03:19'),
(22, 3, 18, 1, 1, 1, 3, 0, 0, 1, 3, 41, 1, ' 1 ', ' 132 ', ' 117 ', ' 119 ', 2.75, 2.14, 2.38, 2.19, 3.5, 2.11, 2.12, 2.3, 2.38, 2.3, 3.1, 3.11, 3.5, 5, 7, '2024-05-03 12:04:09'),
(23, 3, 7, 9, 1, 0, 0, 2, 0, 0, 4, 42, 1, ' 0 ', ' 101 ', ' 148 ', ' 124 ', 2.13, 2.5, 3.5, 2.17, 2.08, 2.08, 2.75, 2.08, 2.25, 2.17, 3.21, 3.08, 3.1, 3, 10, '2024-05-03 12:04:38'),
(24, 3, 20, 1, 0, 0, 4, 2, 0, 1, 5, 40, 0, ' 0 ', ' 145 ', ' 119 ', ' 129 ', 2.12, 2.09, 2.12, 2.09, 2.5, 2.11, 2.12, 2.14, 2.5, 2.1, 3.08, 3.38, 3.09, 5, 10, '2024-05-03 12:05:00'),
(25, 3, 18, 3, 0, 1, 5, 5, 1, 0, 4, 45, 0, ' 2 ', ' 139 ', ' 127 ', ' 111 ', 2.25, 2.11, 2.17, 2.09, 2.75, 2.15, 2.25, 3.5, 2.15, 2.75, 3.15, 3.15, 3.11, 6, 10, '2024-05-03 12:06:31'),
(26, 3, 24, 8, 1, 1, 0, 4, 0, 1, 2, 42, 1, ' 3 ', ' 136 ', ' 100 ', ' 117 ', 2.1, 2.75, 2.13, 2.15, 2.25, 2.15, 2.25, 2.09, 2.38, 2.13, 3.08, 3.15, 3.5, 3, 8, '2024-05-03 12:08:57');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_4`
--

CREATE TABLE `yd_4` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_4`
--

INSERT INTO `yd_4` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 4, 2, 0, 1, 0, 2, 0, 1, 1, 5, 45, 1, ' 4 ', ' 100 ', ' 118 ', ' 117 ', 2.19, 2.09, 2.75, 2.25, 2.08, 3.5, 2.17, 3.5, 2.17, 2.15, 3.3, 3.12, 3.5, 3, 7, '2024-05-02 09:57:23'),
(2, 4, 2, 0, 1, 0, 2, 0, 1, 1, 5, 45, 1, ' 4 ', ' 100 ', ' 118 ', ' 117 ', 2.19, 2.09, 2.75, 2.25, 2.08, 3.5, 2.17, 3.5, 2.17, 2.15, 3.3, 3.12, 3.5, 3, 7, '2024-05-02 11:51:46'),
(3, 4, 2, 0, 1, 0, 2, 0, 1, 1, 5, 45, 1, ' 4 ', ' 100 ', ' 118 ', ' 117 ', 2.19, 2.09, 2.75, 2.25, 2.08, 3.5, 2.17, 3.5, 2.17, 2.15, 3.3, 3.12, 3.5, 3, 7, '2024-05-02 12:10:18'),
(4, 4, 2, 0, 1, 0, 2, 0, 1, 1, 5, 45, 1, ' 4 ', ' 100 ', ' 118 ', ' 117 ', 2.19, 2.09, 2.75, 2.25, 2.08, 3.5, 2.17, 3.5, 2.17, 2.15, 3.3, 3.12, 3.5, 3, 7, '2024-05-02 12:39:15'),
(5, 4, 2, 0, 1, 0, 2, 0, 1, 1, 5, 45, 1, ' 4 ', ' 100 ', ' 118 ', ' 117 ', 2.19, 2.09, 2.75, 2.25, 2.08, 3.5, 2.17, 3.5, 2.17, 2.15, 3.3, 3.12, 3.5, 3, 7, '2024-05-03 11:37:04'),
(6, 4, 2, 0, 1, 0, 2, 0, 1, 1, 5, 45, 1, ' 4 ', ' 100 ', ' 118 ', ' 117 ', 2.19, 2.09, 2.75, 2.25, 2.08, 3.5, 2.17, 3.5, 2.17, 2.15, 3.3, 3.12, 3.5, 3, 7, '2024-05-03 11:53:06'),
(7, 4, 6, 3, 1, 1, 4, 3, 1, 1, 5, 32, 0, ' 3 ', ' 129 ', ' 125 ', ' 143 ', 2.09, 2.25, 2.75, 2.11, 2.1, 2.25, 2.08, 2.1, 2.75, 2.15, 3.17, 3.13, 3.19, 5, 11, '2024-05-03 11:57:30'),
(8, 4, 14, 8, 0, 1, 2, 4, 0, 1, 0, 39, 1, ' 2 ', ' 134 ', ' 131 ', ' 111 ', 2.5, 2.19, 3.5, 2.1, 2.5, 2.08, 2.09, 2.1, 2.09, 2.12, 3.14, 3.3, 3.14, 3, 10, '2024-05-03 11:58:27'),
(9, 4, 24, 6, 0, 1, 4, 5, 1, 0, 4, 42, 0, ' 2 ', ' 125 ', ' 126 ', ' 138 ', 2.08, 2.1, 2.13, 2.17, 2.25, 2.12, 2.12, 2.21, 2.09, 2.21, 3.15, 3.09, 3.15, 5, 12, '2024-05-03 11:59:23'),
(10, 4, 17, 5, 1, 1, 2, 5, 1, 1, 0, 35, 1, ' 3 ', ' 127 ', ' 106 ', ' 131 ', 2.5, 2.21, 2.25, 2.13, 2.38, 2.19, 2.08, 2.09, 2.12, 2.25, 3.5, 3.17, 3.75, 4, 12, '2024-05-03 12:04:25');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_5`
--

CREATE TABLE `yd_5` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_5`
--

INSERT INTO `yd_5` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 5, 1, 6, 1, 0, 3, 0, 0, 0, 4, 39, 0, ' 4 ', ' 128 ', ' 121 ', ' 120 ', 2.09, 2.15, 2.09, 2.1, 3.5, 2.75, 3.5, 2.09, 2.75, 2.25, 3.09, 3.38, 3.21, 5, 11, '2024-05-02 09:56:34'),
(2, 5, 1, 6, 1, 0, 3, 0, 0, 0, 4, 39, 0, ' 4 ', ' 128 ', ' 121 ', ' 120 ', 2.09, 2.15, 2.09, 2.1, 3.5, 2.75, 3.5, 2.09, 2.75, 2.25, 3.09, 3.38, 3.21, 5, 11, '2024-05-02 10:12:07'),
(3, 5, 1, 6, 1, 0, 3, 0, 0, 0, 4, 39, 0, ' 4 ', ' 128 ', ' 121 ', ' 120 ', 2.09, 2.15, 2.09, 2.1, 3.5, 2.75, 3.5, 2.09, 2.75, 2.25, 3.09, 3.38, 3.21, 5, 11, '2024-05-02 11:50:57'),
(4, 5, 1, 6, 1, 0, 3, 0, 0, 0, 4, 39, 0, ' 4 ', ' 128 ', ' 121 ', ' 120 ', 2.09, 2.15, 2.09, 2.1, 3.5, 2.75, 3.5, 2.09, 2.75, 2.25, 3.09, 3.38, 3.21, 5, 11, '2024-05-02 12:09:29'),
(5, 5, 1, 6, 1, 0, 3, 0, 0, 0, 4, 39, 0, ' 4 ', ' 128 ', ' 121 ', ' 120 ', 2.09, 2.15, 2.09, 2.1, 3.5, 2.75, 3.5, 2.09, 2.75, 2.25, 3.09, 3.38, 3.21, 5, 11, '2024-05-02 12:38:25'),
(6, 5, 1, 6, 1, 0, 3, 0, 0, 0, 4, 39, 0, ' 4 ', ' 128 ', ' 121 ', ' 120 ', 2.09, 2.15, 2.09, 2.1, 3.5, 2.75, 3.5, 2.09, 2.75, 2.25, 3.09, 3.38, 3.21, 5, 11, '2024-05-03 11:36:01'),
(7, 5, 15, 6, 0, 0, 2, 1, 1, 0, 5, 40, 1, ' 4 ', ' 124 ', ' 129 ', ' 108 ', 2.25, 2.15, 2.38, 2.1, 2.09, 2.21, 3.5, 2.14, 2.11, 2.13, 3.5, 4.5, 3.17, 7, 8, '2024-05-03 11:37:55'),
(8, 5, 1, 6, 1, 0, 3, 0, 0, 0, 4, 39, 0, ' 4 ', ' 128 ', ' 121 ', ' 120 ', 2.09, 2.15, 2.09, 2.1, 3.5, 2.75, 3.5, 2.09, 2.75, 2.25, 3.09, 3.38, 3.21, 5, 11, '2024-05-03 11:52:17'),
(9, 5, 15, 6, 0, 0, 2, 1, 1, 0, 5, 40, 1, ' 4 ', ' 124 ', ' 129 ', ' 108 ', 2.25, 2.15, 2.38, 2.1, 2.09, 2.21, 3.5, 2.14, 2.11, 2.13, 3.5, 4.5, 3.17, 7, 8, '2024-05-03 11:55:02'),
(10, 5, 19, 3, 1, 1, 1, 4, 0, 0, 1, 39, 1, ' 3 ', ' 133 ', ' 120 ', ' 117 ', 2.09, 2.25, 2.21, 2.09, 2.14, 2.11, 2.5, 2.19, 2.15, 2.38, 3.14, 3.5, 3.25, 5, 10, '2024-05-03 11:56:12'),
(11, 5, 19, 9, 0, 0, 1, 5, 1, 0, 3, 26, 0, ' 4 ', ' 149 ', ' 145 ', ' 129 ', 2.09, 2.75, 2.08, 2.15, 2.11, 2.09, 2.38, 2.14, 2.08, 2.5, 3.19, 3.25, 3.14, 3, 10, '2024-05-03 11:56:16'),
(12, 5, 21, 2, 1, 1, 5, 4, 0, 1, 3, 41, 1, ' 3 ', ' 118 ', ' 143 ', ' 118 ', 2.21, 2.08, 2.3, 2.25, 2.14, 2.15, 2.5, 2.12, 2.19, 2.11, 3.09, 4.5, 3.11, 7, 11, '2024-05-03 11:57:09'),
(13, 5, 17, 4, 0, 1, 4, 4, 1, 0, 5, 42, 0, ' 0 ', ' 140 ', ' 100 ', ' 149 ', 2.1, 2.38, 2.11, 2.08, 2.13, 2.3, 2.17, 2.3, 2.08, 3.5, 3.21, 4.5, 3.09, 4, 9, '2024-05-03 11:59:31'),
(14, 5, 11, 2, 0, 1, 0, 2, 0, 0, 5, 25, 0, ' 4 ', ' 104 ', ' 147 ', ' 146 ', 2.25, 2.25, 2.75, 2.75, 2.25, 2.15, 2.15, 2.25, 2.75, 2.08, 3.11, 3.14, 3.08, 6, 9, '2024-05-03 12:06:25'),
(15, 5, 21, 6, 0, 1, 5, 0, 1, 1, 0, 35, 1, ' 3 ', ' 100 ', ' 149 ', ' 108 ', 2.13, 2.25, 2.09, 2.13, 2.1, 2.08, 3.5, 2.38, 2.12, 2.21, 3.08, 3.12, 3.3, 6, 9, '2024-05-03 12:06:51'),
(16, 5, 2, 5, 0, 1, 3, 2, 1, 0, 0, 48, 0, ' 3 ', ' 120 ', ' 114 ', ' 110 ', 2.75, 2.75, 2.13, 2.09, 2.08, 2.13, 2.12, 2.13, 2.21, 2.38, 3.21, 3.09, 3.14, 3, 7, '2024-05-03 12:08:51');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_6`
--

CREATE TABLE `yd_6` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_6`
--

INSERT INTO `yd_6` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 6, 20, 4, 0, 1, 1, 2, 1, 0, 4, 29, 1, ' 3 ', ' 143 ', ' 138 ', ' 128 ', 2.08, 2.14, 2.17, 2.17, 2.75, 2.75, 2.14, 2.19, 2.09, 2.5, 3.1, 3.08, 3.09, 3, 12, '2024-05-03 11:38:03'),
(2, 6, 20, 4, 0, 1, 1, 2, 1, 0, 4, 29, 1, ' 3 ', ' 143 ', ' 138 ', ' 128 ', 2.08, 2.14, 2.17, 2.17, 2.75, 2.75, 2.14, 2.19, 2.09, 2.5, 3.1, 3.08, 3.09, 3, 12, '2024-05-03 11:55:33'),
(3, 6, 13, 3, 1, 0, 2, 2, 1, 1, 2, 49, 0, ' 0 ', ' 143 ', ' 143 ', ' 118 ', 2.08, 2.25, 2.13, 2.15, 2.08, 2.75, 2.14, 2.12, 2.11, 2.19, 3.12, 3.09, 3.75, 7, 10, '2024-05-03 11:56:22'),
(4, 6, 23, 2, 1, 0, 3, 5, 0, 1, 3, 40, 1, ' 1 ', ' 118 ', ' 137 ', ' 109 ', 2.19, 2.09, 2.1, 2.3, 2.1, 2.25, 2.19, 2.1, 2.19, 2.38, 4.5, 3.38, 3.3, 7, 12, '2024-05-03 11:59:21'),
(5, 6, 12, 2, 1, 0, 1, 5, 0, 1, 1, 26, 1, ' 0 ', ' 115 ', ' 144 ', ' 111 ', 3.5, 2.11, 2.13, 2.21, 2.15, 2.08, 2.13, 2.08, 2.13, 2.5, 3.11, 3.09, 3.5, 4, 10, '2024-05-03 12:01:32'),
(6, 6, 19, 4, 0, 1, 1, 1, 1, 1, 4, 43, 1, ' 3 ', ' 111 ', ' 124 ', ' 123 ', 2.1, 2.19, 2.5, 2.15, 2.14, 2.1, 2.3, 2.09, 2.75, 3.5, 3.08, 3.08, 3.17, 5, 12, '2024-05-03 12:04:11'),
(7, 6, 16, 5, 0, 0, 0, 2, 1, 0, 2, 37, 0, ' 3 ', ' 123 ', ' 123 ', ' 109 ', 2.09, 2.75, 2.5, 2.5, 2.38, 2.11, 2.08, 3.5, 2.25, 2.09, 3.14, 3.25, 3.21, 5, 10, '2024-05-03 12:05:21'),
(8, 6, 0, 3, 1, 0, 3, 2, 0, 0, 5, 39, 1, ' 2 ', ' 145 ', ' 108 ', ' 142 ', 2.19, 2.5, 2.5, 2.5, 2.75, 2.25, 2.17, 2.75, 2.08, 2.08, 3.3, 3.75, 3.09, 7, 8, '2024-05-03 12:05:27'),
(9, 6, 13, 2, 1, 0, 2, 2, 1, 0, 5, 40, 0, ' 0 ', ' 138 ', ' 127 ', ' 122 ', 2.19, 2.09, 2.08, 2.38, 3.5, 2.11, 2.5, 2.13, 2.17, 2.17, 3.19, 3.15, 3.21, 5, 7, '2024-05-03 12:05:35'),
(10, 6, 10, 1, 1, 0, 3, 2, 1, 1, 3, 37, 1, ' 2 ', ' 141 ', ' 132 ', ' 122 ', 2.1, 2.25, 2.08, 2.17, 2.38, 2.3, 2.11, 2.3, 2.19, 2.17, 3.5, 3.12, 3.09, 6, 8, '2024-05-03 12:08:44');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_7`
--

CREATE TABLE `yd_7` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_7`
--

INSERT INTO `yd_7` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 7, 13, 3, 0, 0, 1, 5, 0, 1, 4, 34, 1, ' 0 ', ' 135 ', ' 112 ', ' 134 ', 3.5, 2.14, 2.25, 2.15, 2.09, 2.09, 2.08, 2.09, 2.25, 2.15, 3.25, 3.19, 3.11, 4, 9, '2024-05-02 09:56:19'),
(2, 7, 13, 3, 0, 0, 1, 5, 0, 1, 4, 34, 1, ' 0 ', ' 135 ', ' 112 ', ' 134 ', 3.5, 2.14, 2.25, 2.15, 2.09, 2.09, 2.08, 2.09, 2.25, 2.15, 3.25, 3.19, 3.11, 4, 9, '2024-05-02 10:11:53'),
(3, 7, 13, 3, 0, 0, 1, 5, 0, 1, 4, 34, 1, ' 0 ', ' 135 ', ' 112 ', ' 134 ', 3.5, 2.14, 2.25, 2.15, 2.09, 2.09, 2.08, 2.09, 2.25, 2.15, 3.25, 3.19, 3.11, 4, 9, '2024-05-02 10:13:38'),
(4, 7, 13, 3, 0, 0, 1, 5, 0, 1, 4, 34, 1, ' 0 ', ' 135 ', ' 112 ', ' 134 ', 3.5, 2.14, 2.25, 2.15, 2.09, 2.09, 2.08, 2.09, 2.25, 2.15, 3.25, 3.19, 3.11, 4, 9, '2024-05-02 10:23:47'),
(5, 7, 13, 3, 0, 0, 1, 5, 0, 1, 4, 34, 1, ' 0 ', ' 135 ', ' 112 ', ' 134 ', 3.5, 2.14, 2.25, 2.15, 2.09, 2.09, 2.08, 2.09, 2.25, 2.15, 3.25, 3.19, 3.11, 4, 9, '2024-05-02 10:26:39'),
(6, 7, 13, 3, 0, 0, 1, 5, 0, 1, 4, 34, 1, ' 0 ', ' 135 ', ' 112 ', ' 134 ', 3.5, 2.14, 2.25, 2.15, 2.09, 2.09, 2.08, 2.09, 2.25, 2.15, 3.25, 3.19, 3.11, 4, 9, '2024-05-02 10:28:54'),
(7, 7, 13, 3, 0, 0, 1, 5, 0, 1, 4, 34, 1, ' 0 ', ' 135 ', ' 112 ', ' 134 ', 3.5, 2.14, 2.25, 2.15, 2.09, 2.09, 2.08, 2.09, 2.25, 2.15, 3.25, 3.19, 3.11, 4, 9, '2024-05-02 11:50:42'),
(8, 7, 13, 3, 0, 0, 1, 5, 0, 1, 4, 34, 1, ' 0 ', ' 135 ', ' 112 ', ' 134 ', 3.5, 2.14, 2.25, 2.15, 2.09, 2.09, 2.08, 2.09, 2.25, 2.15, 3.25, 3.19, 3.11, 4, 9, '2024-05-02 12:09:15'),
(9, 7, 13, 3, 0, 0, 1, 5, 0, 1, 4, 34, 1, ' 0 ', ' 135 ', ' 112 ', ' 134 ', 3.5, 2.14, 2.25, 2.15, 2.09, 2.09, 2.08, 2.09, 2.25, 2.15, 3.25, 3.19, 3.11, 4, 9, '2024-05-02 12:38:11'),
(10, 7, 13, 3, 0, 0, 1, 5, 0, 1, 4, 34, 1, ' 0 ', ' 135 ', ' 112 ', ' 134 ', 3.5, 2.14, 2.25, 2.15, 2.09, 2.09, 2.08, 2.09, 2.25, 2.15, 3.25, 3.19, 3.11, 4, 9, '2024-05-03 11:34:41'),
(11, 7, 13, 3, 0, 0, 1, 5, 0, 1, 4, 34, 1, ' 0 ', ' 135 ', ' 112 ', ' 134 ', 3.5, 2.14, 2.25, 2.15, 2.09, 2.09, 2.08, 2.09, 2.25, 2.15, 3.25, 3.19, 3.11, 4, 9, '2024-05-03 11:52:03'),
(12, 7, 3, 8, 0, 1, 3, 2, 1, 1, 4, 39, 0, ' 1 ', ' 120 ', ' 125 ', ' 129 ', 2.17, 2.19, 2.5, 2.3, 2.1, 2.1, 2.3, 2.14, 2.13, 2.25, 3.12, 3.09, 3.38, 4, 9, '2024-05-03 11:55:43'),
(13, 7, 14, 5, 1, 1, 1, 5, 0, 0, 4, 25, 1, ' 0 ', ' 138 ', ' 144 ', ' 102 ', 2.17, 2.15, 2.38, 2.38, 2.19, 2.5, 2.13, 2.21, 2.17, 2.3, 3.19, 3.25, 3.08, 7, 11, '2024-05-03 11:56:14'),
(14, 7, 4, 9, 0, 0, 0, 5, 0, 1, 2, 27, 0, ' 0 ', ' 149 ', ' 106 ', ' 135 ', 2.21, 2.3, 2.75, 2.14, 2.09, 2.14, 2.38, 2.1, 2.1, 2.5, 3.17, 3.5, 3.3, 5, 9, '2024-05-03 11:58:48'),
(15, 7, 2, 5, 0, 0, 0, 5, 0, 0, 0, 49, 0, ' 1 ', ' 102 ', ' 135 ', ' 130 ', 2.17, 2.75, 2.25, 2.15, 2.15, 2.1, 2.17, 2.21, 2.3, 2.19, 3.15, 3.25, 3.09, 4, 8, '2024-05-03 12:00:35'),
(16, 7, 5, 7, 0, 0, 0, 5, 0, 1, 5, 26, 1, ' 3 ', ' 105 ', ' 140 ', ' 121 ', 2.3, 2.09, 2.25, 2.25, 2.08, 2.12, 2.38, 2.3, 2.09, 2.13, 4.5, 3.14, 3.15, 7, 11, '2024-05-03 12:02:53'),
(17, 7, 12, 3, 0, 1, 0, 1, 0, 0, 2, 25, 0, ' 0 ', ' 142 ', ' 139 ', ' 135 ', 2.3, 2.14, 2.38, 2.25, 2.09, 2.11, 2.09, 2.09, 2.14, 2.1, 3.19, 3.1, 3.19, 7, 8, '2024-05-03 12:04:29'),
(18, 7, 1, 6, 1, 1, 0, 0, 0, 1, 0, 47, 0, ' 0 ', ' 113 ', ' 113 ', ' 114 ', 2.08, 2.21, 2.1, 2.11, 2.09, 2.08, 2.15, 2.5, 2.38, 2.09, 3.08, 3.08, 3.38, 3, 9, '2024-05-03 12:06:10');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_8`
--

CREATE TABLE `yd_8` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_8`
--

INSERT INTO `yd_8` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 8, 18, 5, 0, 1, 1, 4, 1, 0, 1, 47, 0, ' 4 ', ' 134 ', ' 105 ', ' 139 ', 2.09, 2.17, 2.09, 3.5, 2.17, 2.3, 2.13, 2.19, 2.25, 2.5, 3.08, 3.13, 3.17, 7, 7, '2024-05-02 09:56:01'),
(2, 8, 4, 2, 0, 1, 1, 3, 0, 1, 2, 43, 1, ' 0 ', ' 146 ', ' 120 ', ' 104 ', 2.08, 2.13, 2.13, 2.15, 2.25, 2.15, 2.08, 2.15, 2.75, 2.08, 3.75, 3.08, 3.08, 3, 10, '2024-05-02 09:56:38'),
(3, 8, 14, 4, 1, 0, 5, 5, 0, 1, 3, 45, 1, ' 3 ', ' 144 ', ' 127 ', ' 137 ', 2.21, 2.3, 2.75, 2.21, 2.19, 2.09, 2.1, 2.21, 2.09, 2.08, 3.19, 3.1, 3.1, 5, 11, '2024-05-02 09:57:42'),
(4, 8, 18, 5, 0, 1, 1, 4, 1, 0, 1, 47, 0, ' 4 ', ' 134 ', ' 105 ', ' 139 ', 2.09, 2.17, 2.09, 3.5, 2.17, 2.3, 2.13, 2.19, 2.25, 2.5, 3.08, 3.13, 3.17, 7, 7, '2024-05-02 10:08:56'),
(5, 8, 18, 5, 0, 1, 1, 4, 1, 0, 1, 47, 0, ' 4 ', ' 134 ', ' 105 ', ' 139 ', 2.09, 2.17, 2.09, 3.5, 2.17, 2.3, 2.13, 2.19, 2.25, 2.5, 3.08, 3.13, 3.17, 7, 7, '2024-05-02 10:11:34'),
(6, 8, 4, 2, 0, 1, 1, 3, 0, 1, 2, 43, 1, ' 0 ', ' 146 ', ' 120 ', ' 104 ', 2.08, 2.13, 2.13, 2.15, 2.25, 2.15, 2.08, 2.15, 2.75, 2.08, 3.75, 3.08, 3.08, 3, 10, '2024-05-02 10:12:11'),
(7, 8, 18, 5, 0, 1, 1, 4, 1, 0, 1, 47, 0, ' 4 ', ' 134 ', ' 105 ', ' 139 ', 2.09, 2.17, 2.09, 3.5, 2.17, 2.3, 2.13, 2.19, 2.25, 2.5, 3.08, 3.13, 3.17, 7, 7, '2024-05-02 10:13:19'),
(8, 8, 18, 5, 0, 1, 1, 4, 1, 0, 1, 47, 0, ' 4 ', ' 134 ', ' 105 ', ' 139 ', 2.09, 2.17, 2.09, 3.5, 2.17, 2.3, 2.13, 2.19, 2.25, 2.5, 3.08, 3.13, 3.17, 7, 7, '2024-05-02 10:14:21'),
(9, 8, 18, 5, 0, 1, 1, 4, 1, 0, 1, 47, 0, ' 4 ', ' 134 ', ' 105 ', ' 139 ', 2.09, 2.17, 2.09, 3.5, 2.17, 2.3, 2.13, 2.19, 2.25, 2.5, 3.08, 3.13, 3.17, 7, 7, '2024-05-02 10:17:56'),
(10, 8, 18, 5, 0, 1, 1, 4, 1, 0, 1, 47, 0, ' 4 ', ' 134 ', ' 105 ', ' 139 ', 2.09, 2.17, 2.09, 3.5, 2.17, 2.3, 2.13, 2.19, 2.25, 2.5, 3.08, 3.13, 3.17, 7, 7, '2024-05-02 10:23:29'),
(11, 8, 18, 5, 0, 1, 1, 4, 1, 0, 1, 47, 0, ' 4 ', ' 134 ', ' 105 ', ' 139 ', 2.09, 2.17, 2.09, 3.5, 2.17, 2.3, 2.13, 2.19, 2.25, 2.5, 3.08, 3.13, 3.17, 7, 7, '2024-05-02 10:26:21'),
(12, 8, 18, 5, 0, 1, 1, 4, 1, 0, 1, 47, 0, ' 4 ', ' 134 ', ' 105 ', ' 139 ', 2.09, 2.17, 2.09, 3.5, 2.17, 2.3, 2.13, 2.19, 2.25, 2.5, 3.08, 3.13, 3.17, 7, 7, '2024-05-02 10:28:35'),
(13, 8, 18, 5, 0, 1, 1, 4, 1, 0, 1, 47, 0, ' 4 ', ' 134 ', ' 105 ', ' 139 ', 2.09, 2.17, 2.09, 3.5, 2.17, 2.3, 2.13, 2.19, 2.25, 2.5, 3.08, 3.13, 3.17, 7, 7, '2024-05-02 10:46:19'),
(14, 8, 18, 5, 0, 1, 1, 4, 1, 0, 1, 47, 0, ' 4 ', ' 134 ', ' 105 ', ' 139 ', 2.09, 2.17, 2.09, 3.5, 2.17, 2.3, 2.13, 2.19, 2.25, 2.5, 3.08, 3.13, 3.17, 7, 7, '2024-05-02 11:50:24'),
(15, 8, 4, 2, 0, 1, 1, 3, 0, 1, 2, 43, 1, ' 0 ', ' 146 ', ' 120 ', ' 104 ', 2.08, 2.13, 2.13, 2.15, 2.25, 2.15, 2.08, 2.15, 2.75, 2.08, 3.75, 3.08, 3.08, 3, 10, '2024-05-02 11:51:01'),
(16, 8, 14, 4, 1, 0, 5, 5, 0, 1, 3, 45, 1, ' 3 ', ' 144 ', ' 127 ', ' 137 ', 2.21, 2.3, 2.75, 2.21, 2.19, 2.09, 2.1, 2.21, 2.09, 2.08, 3.19, 3.1, 3.1, 5, 11, '2024-05-02 11:52:05'),
(17, 8, 18, 5, 0, 1, 1, 4, 1, 0, 1, 47, 0, ' 4 ', ' 134 ', ' 105 ', ' 139 ', 2.09, 2.17, 2.09, 3.5, 2.17, 2.3, 2.13, 2.19, 2.25, 2.5, 3.08, 3.13, 3.17, 7, 7, '2024-05-02 12:01:03'),
(18, 8, 18, 5, 0, 1, 1, 4, 1, 0, 1, 47, 0, ' 4 ', ' 134 ', ' 105 ', ' 139 ', 2.09, 2.17, 2.09, 3.5, 2.17, 2.3, 2.13, 2.19, 2.25, 2.5, 3.08, 3.13, 3.17, 7, 7, '2024-05-02 12:08:56'),
(19, 8, 4, 2, 0, 1, 1, 3, 0, 1, 2, 43, 1, ' 0 ', ' 146 ', ' 120 ', ' 104 ', 2.08, 2.13, 2.13, 2.15, 2.25, 2.15, 2.08, 2.15, 2.75, 2.08, 3.75, 3.08, 3.08, 3, 10, '2024-05-02 12:09:33'),
(20, 8, 14, 4, 1, 0, 5, 5, 0, 1, 3, 45, 1, ' 3 ', ' 144 ', ' 127 ', ' 137 ', 2.21, 2.3, 2.75, 2.21, 2.19, 2.09, 2.1, 2.21, 2.09, 2.08, 3.19, 3.1, 3.1, 5, 11, '2024-05-02 12:10:37'),
(21, 8, 18, 5, 0, 1, 1, 4, 1, 0, 1, 47, 0, ' 4 ', ' 134 ', ' 105 ', ' 139 ', 2.09, 2.17, 2.09, 3.5, 2.17, 2.3, 2.13, 2.19, 2.25, 2.5, 3.08, 3.13, 3.17, 7, 7, '2024-05-02 12:37:52'),
(22, 8, 4, 2, 0, 1, 1, 3, 0, 1, 2, 43, 1, ' 0 ', ' 146 ', ' 120 ', ' 104 ', 2.08, 2.13, 2.13, 2.15, 2.25, 2.15, 2.08, 2.15, 2.75, 2.08, 3.75, 3.08, 3.08, 3, 10, '2024-05-02 12:38:29'),
(23, 8, 14, 4, 1, 0, 5, 5, 0, 1, 3, 45, 1, ' 3 ', ' 144 ', ' 127 ', ' 137 ', 2.21, 2.3, 2.75, 2.21, 2.19, 2.09, 2.1, 2.21, 2.09, 2.08, 3.19, 3.1, 3.1, 5, 11, '2024-05-02 12:39:33'),
(24, 8, 18, 5, 0, 1, 1, 4, 1, 0, 1, 47, 0, ' 4 ', ' 134 ', ' 105 ', ' 139 ', 2.09, 2.17, 2.09, 3.5, 2.17, 2.3, 2.13, 2.19, 2.25, 2.5, 3.08, 3.13, 3.17, 7, 7, '2024-05-02 12:52:23'),
(25, 8, 18, 5, 0, 1, 1, 4, 1, 0, 1, 47, 0, ' 4 ', ' 134 ', ' 105 ', ' 139 ', 2.09, 2.17, 2.09, 3.5, 2.17, 2.3, 2.13, 2.19, 2.25, 2.5, 3.08, 3.13, 3.17, 7, 7, '2024-05-03 11:34:16'),
(26, 8, 4, 2, 0, 1, 1, 3, 0, 1, 2, 43, 1, ' 0 ', ' 146 ', ' 120 ', ' 104 ', 2.08, 2.13, 2.13, 2.15, 2.25, 2.15, 2.08, 2.15, 2.75, 2.08, 3.75, 3.08, 3.08, 3, 10, '2024-05-03 11:36:11'),
(27, 8, 14, 4, 1, 0, 5, 5, 0, 1, 3, 45, 1, ' 3 ', ' 144 ', ' 127 ', ' 137 ', 2.21, 2.3, 2.75, 2.21, 2.19, 2.09, 2.1, 2.21, 2.09, 2.08, 3.19, 3.1, 3.1, 5, 11, '2024-05-03 11:37:15'),
(28, 8, 19, 1, 1, 1, 3, 1, 1, 0, 2, 29, 1, ' 3 ', ' 146 ', ' 126 ', ' 113 ', 2.09, 2.38, 2.3, 2.75, 2.09, 2.38, 2.11, 2.08, 2.14, 2.15, 3.3, 3.75, 4.5, 3, 11, '2024-05-03 11:37:56'),
(29, 8, 18, 5, 0, 1, 1, 4, 1, 0, 1, 47, 0, ' 4 ', ' 134 ', ' 105 ', ' 139 ', 2.09, 2.17, 2.09, 3.5, 2.17, 2.3, 2.13, 2.19, 2.25, 2.5, 3.08, 3.13, 3.17, 7, 7, '2024-05-03 11:51:44'),
(30, 8, 4, 2, 0, 1, 1, 3, 0, 1, 2, 43, 1, ' 0 ', ' 146 ', ' 120 ', ' 104 ', 2.08, 2.13, 2.13, 2.15, 2.25, 2.15, 2.08, 2.15, 2.75, 2.08, 3.75, 3.08, 3.08, 3, 10, '2024-05-03 11:52:21'),
(31, 8, 14, 4, 1, 0, 5, 5, 0, 1, 3, 45, 1, ' 3 ', ' 144 ', ' 127 ', ' 137 ', 2.21, 2.3, 2.75, 2.21, 2.19, 2.09, 2.1, 2.21, 2.09, 2.08, 3.19, 3.1, 3.1, 5, 11, '2024-05-03 11:53:25'),
(32, 8, 19, 1, 1, 1, 3, 1, 1, 0, 2, 29, 1, ' 3 ', ' 146 ', ' 126 ', ' 113 ', 2.09, 2.38, 2.3, 2.75, 2.09, 2.38, 2.11, 2.08, 2.14, 2.15, 3.3, 3.75, 4.5, 3, 11, '2024-05-03 11:55:06'),
(33, 8, 4, 5, 0, 0, 1, 4, 0, 1, 4, 38, 0, ' 3 ', ' 103 ', ' 110 ', ' 100 ', 2.75, 3.5, 2.21, 3.5, 2.15, 2.75, 2.5, 2.1, 2.17, 2.21, 3.15, 3.09, 3.38, 6, 9, '2024-05-03 12:00:33'),
(34, 8, 22, 9, 1, 1, 3, 5, 0, 0, 2, 30, 1, ' 3 ', ' 112 ', ' 125 ', ' 115 ', 2.3, 2.13, 2.3, 2.12, 2.5, 2.13, 3.5, 2.12, 2.08, 2.12, 3.5, 3.08, 3.75, 4, 11, '2024-05-03 12:02:36'),
(35, 8, 12, 3, 0, 1, 5, 2, 0, 0, 0, 34, 1, ' 1 ', ' 104 ', ' 113 ', ' 103 ', 2.08, 2.09, 2.38, 2.08, 2.08, 2.17, 2.13, 2.21, 2.11, 2.13, 3.17, 3.38, 3.3, 4, 8, '2024-05-03 12:03:32');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_9`
--

CREATE TABLE `yd_9` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_9`
--

INSERT INTO `yd_9` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 9, 23, 5, 1, 1, 2, 2, 0, 1, 1, 28, 0, ' 4 ', ' 137 ', ' 133 ', ' 141 ', 2.14, 2.17, 2.09, 2.21, 2.14, 3.5, 2.1, 2.17, 2.09, 2.08, 3.09, 3.14, 3.08, 6, 9, '2024-05-02 09:56:05'),
(2, 9, 8, 8, 1, 0, 0, 0, 1, 1, 1, 40, 0, ' 0 ', ' 143 ', ' 103 ', ' 115 ', 2.08, 2.19, 2.21, 2.09, 2.08, 2.08, 3.5, 2.09, 2.12, 2.3, 3.17, 3.08, 3.13, 3, 8, '2024-05-02 09:56:11'),
(3, 9, 7, 5, 0, 0, 2, 1, 0, 0, 1, 37, 0, ' 0 ', ' 138 ', ' 142 ', ' 115 ', 3.5, 2.09, 2.1, 2.15, 2.17, 2.13, 2.1, 2.21, 2.38, 2.3, 3.09, 3.15, 3.15, 5, 12, '2024-05-02 09:57:36'),
(4, 9, 23, 5, 1, 1, 2, 2, 0, 1, 1, 28, 0, ' 4 ', ' 137 ', ' 133 ', ' 141 ', 2.14, 2.17, 2.09, 2.21, 2.14, 3.5, 2.1, 2.17, 2.09, 2.08, 3.09, 3.14, 3.08, 6, 9, '2024-05-02 10:09:00'),
(5, 9, 8, 8, 1, 0, 0, 0, 1, 1, 1, 40, 0, ' 0 ', ' 143 ', ' 103 ', ' 115 ', 2.08, 2.19, 2.21, 2.09, 2.08, 2.08, 3.5, 2.09, 2.12, 2.3, 3.17, 3.08, 3.13, 3, 8, '2024-05-02 10:09:06'),
(6, 9, 23, 5, 1, 1, 2, 2, 0, 1, 1, 28, 0, ' 4 ', ' 137 ', ' 133 ', ' 141 ', 2.14, 2.17, 2.09, 2.21, 2.14, 3.5, 2.1, 2.17, 2.09, 2.08, 3.09, 3.14, 3.08, 6, 9, '2024-05-02 10:11:38'),
(7, 9, 8, 8, 1, 0, 0, 0, 1, 1, 1, 40, 0, ' 0 ', ' 143 ', ' 103 ', ' 115 ', 2.08, 2.19, 2.21, 2.09, 2.08, 2.08, 3.5, 2.09, 2.12, 2.3, 3.17, 3.08, 3.13, 3, 8, '2024-05-02 10:11:44'),
(8, 9, 23, 5, 1, 1, 2, 2, 0, 1, 1, 28, 0, ' 4 ', ' 137 ', ' 133 ', ' 141 ', 2.14, 2.17, 2.09, 2.21, 2.14, 3.5, 2.1, 2.17, 2.09, 2.08, 3.09, 3.14, 3.08, 6, 9, '2024-05-02 10:13:23'),
(9, 9, 8, 8, 1, 0, 0, 0, 1, 1, 1, 40, 0, ' 0 ', ' 143 ', ' 103 ', ' 115 ', 2.08, 2.19, 2.21, 2.09, 2.08, 2.08, 3.5, 2.09, 2.12, 2.3, 3.17, 3.08, 3.13, 3, 8, '2024-05-02 10:13:29'),
(10, 9, 23, 5, 1, 1, 2, 2, 0, 1, 1, 28, 0, ' 4 ', ' 137 ', ' 133 ', ' 141 ', 2.14, 2.17, 2.09, 2.21, 2.14, 3.5, 2.1, 2.17, 2.09, 2.08, 3.09, 3.14, 3.08, 6, 9, '2024-05-02 10:14:25'),
(11, 9, 23, 5, 1, 1, 2, 2, 0, 1, 1, 28, 0, ' 4 ', ' 137 ', ' 133 ', ' 141 ', 2.14, 2.17, 2.09, 2.21, 2.14, 3.5, 2.1, 2.17, 2.09, 2.08, 3.09, 3.14, 3.08, 6, 9, '2024-05-02 10:18:00'),
(12, 9, 23, 5, 1, 1, 2, 2, 0, 1, 1, 28, 0, ' 4 ', ' 137 ', ' 133 ', ' 141 ', 2.14, 2.17, 2.09, 2.21, 2.14, 3.5, 2.1, 2.17, 2.09, 2.08, 3.09, 3.14, 3.08, 6, 9, '2024-05-02 10:23:33'),
(13, 9, 8, 8, 1, 0, 0, 0, 1, 1, 1, 40, 0, ' 0 ', ' 143 ', ' 103 ', ' 115 ', 2.08, 2.19, 2.21, 2.09, 2.08, 2.08, 3.5, 2.09, 2.12, 2.3, 3.17, 3.08, 3.13, 3, 8, '2024-05-02 10:23:39'),
(14, 9, 23, 5, 1, 1, 2, 2, 0, 1, 1, 28, 0, ' 4 ', ' 137 ', ' 133 ', ' 141 ', 2.14, 2.17, 2.09, 2.21, 2.14, 3.5, 2.1, 2.17, 2.09, 2.08, 3.09, 3.14, 3.08, 6, 9, '2024-05-02 10:26:25'),
(15, 9, 8, 8, 1, 0, 0, 0, 1, 1, 1, 40, 0, ' 0 ', ' 143 ', ' 103 ', ' 115 ', 2.08, 2.19, 2.21, 2.09, 2.08, 2.08, 3.5, 2.09, 2.12, 2.3, 3.17, 3.08, 3.13, 3, 8, '2024-05-02 10:26:31'),
(16, 9, 23, 5, 1, 1, 2, 2, 0, 1, 1, 28, 0, ' 4 ', ' 137 ', ' 133 ', ' 141 ', 2.14, 2.17, 2.09, 2.21, 2.14, 3.5, 2.1, 2.17, 2.09, 2.08, 3.09, 3.14, 3.08, 6, 9, '2024-05-02 10:28:40'),
(17, 9, 8, 8, 1, 0, 0, 0, 1, 1, 1, 40, 0, ' 0 ', ' 143 ', ' 103 ', ' 115 ', 2.08, 2.19, 2.21, 2.09, 2.08, 2.08, 3.5, 2.09, 2.12, 2.3, 3.17, 3.08, 3.13, 3, 8, '2024-05-02 10:28:46'),
(18, 9, 23, 5, 1, 1, 2, 2, 0, 1, 1, 28, 0, ' 4 ', ' 137 ', ' 133 ', ' 141 ', 2.14, 2.17, 2.09, 2.21, 2.14, 3.5, 2.1, 2.17, 2.09, 2.08, 3.09, 3.14, 3.08, 6, 9, '2024-05-02 11:50:28'),
(19, 9, 8, 8, 1, 0, 0, 0, 1, 1, 1, 40, 0, ' 0 ', ' 143 ', ' 103 ', ' 115 ', 2.08, 2.19, 2.21, 2.09, 2.08, 2.08, 3.5, 2.09, 2.12, 2.3, 3.17, 3.08, 3.13, 3, 8, '2024-05-02 11:50:34'),
(20, 9, 7, 5, 0, 0, 2, 1, 0, 0, 1, 37, 0, ' 0 ', ' 138 ', ' 142 ', ' 115 ', 3.5, 2.09, 2.1, 2.15, 2.17, 2.13, 2.1, 2.21, 2.38, 2.3, 3.09, 3.15, 3.15, 5, 12, '2024-05-02 11:51:58'),
(21, 9, 23, 5, 1, 1, 2, 2, 0, 1, 1, 28, 0, ' 4 ', ' 137 ', ' 133 ', ' 141 ', 2.14, 2.17, 2.09, 2.21, 2.14, 3.5, 2.1, 2.17, 2.09, 2.08, 3.09, 3.14, 3.08, 6, 9, '2024-05-02 12:01:07'),
(22, 9, 23, 5, 1, 1, 2, 2, 0, 1, 1, 28, 0, ' 4 ', ' 137 ', ' 133 ', ' 141 ', 2.14, 2.17, 2.09, 2.21, 2.14, 3.5, 2.1, 2.17, 2.09, 2.08, 3.09, 3.14, 3.08, 6, 9, '2024-05-02 12:09:00'),
(23, 9, 8, 8, 1, 0, 0, 0, 1, 1, 1, 40, 0, ' 0 ', ' 143 ', ' 103 ', ' 115 ', 2.08, 2.19, 2.21, 2.09, 2.08, 2.08, 3.5, 2.09, 2.12, 2.3, 3.17, 3.08, 3.13, 3, 8, '2024-05-02 12:09:07'),
(24, 9, 7, 5, 0, 0, 2, 1, 0, 0, 1, 37, 0, ' 0 ', ' 138 ', ' 142 ', ' 115 ', 3.5, 2.09, 2.1, 2.15, 2.17, 2.13, 2.1, 2.21, 2.38, 2.3, 3.09, 3.15, 3.15, 5, 12, '2024-05-02 12:10:31'),
(25, 9, 23, 5, 1, 1, 2, 2, 0, 1, 1, 28, 0, ' 4 ', ' 137 ', ' 133 ', ' 141 ', 2.14, 2.17, 2.09, 2.21, 2.14, 3.5, 2.1, 2.17, 2.09, 2.08, 3.09, 3.14, 3.08, 6, 9, '2024-05-02 12:37:56'),
(26, 9, 8, 8, 1, 0, 0, 0, 1, 1, 1, 40, 0, ' 0 ', ' 143 ', ' 103 ', ' 115 ', 2.08, 2.19, 2.21, 2.09, 2.08, 2.08, 3.5, 2.09, 2.12, 2.3, 3.17, 3.08, 3.13, 3, 8, '2024-05-02 12:38:03'),
(27, 9, 7, 5, 0, 0, 2, 1, 0, 0, 1, 37, 0, ' 0 ', ' 138 ', ' 142 ', ' 115 ', 3.5, 2.09, 2.1, 2.15, 2.17, 2.13, 2.1, 2.21, 2.38, 2.3, 3.09, 3.15, 3.15, 5, 12, '2024-05-02 12:39:27'),
(28, 9, 23, 5, 1, 1, 2, 2, 0, 1, 1, 28, 0, ' 4 ', ' 137 ', ' 133 ', ' 141 ', 2.14, 2.17, 2.09, 2.21, 2.14, 3.5, 2.1, 2.17, 2.09, 2.08, 3.09, 3.14, 3.08, 6, 9, '2024-05-03 11:34:26'),
(29, 9, 8, 8, 1, 0, 0, 0, 1, 1, 1, 40, 0, ' 0 ', ' 143 ', ' 103 ', ' 115 ', 2.08, 2.19, 2.21, 2.09, 2.08, 2.08, 3.5, 2.09, 2.12, 2.3, 3.17, 3.08, 3.13, 3, 8, '2024-05-03 11:34:31'),
(30, 9, 7, 5, 0, 0, 2, 1, 0, 0, 1, 37, 0, ' 0 ', ' 138 ', ' 142 ', ' 115 ', 3.5, 2.09, 2.1, 2.15, 2.17, 2.13, 2.1, 2.21, 2.38, 2.3, 3.09, 3.15, 3.15, 5, 12, '2024-05-03 11:37:12'),
(31, 9, 23, 5, 1, 1, 2, 2, 0, 1, 1, 28, 0, ' 4 ', ' 137 ', ' 133 ', ' 141 ', 2.14, 2.17, 2.09, 2.21, 2.14, 3.5, 2.1, 2.17, 2.09, 2.08, 3.09, 3.14, 3.08, 6, 9, '2024-05-03 11:51:48'),
(32, 9, 8, 8, 1, 0, 0, 0, 1, 1, 1, 40, 0, ' 0 ', ' 143 ', ' 103 ', ' 115 ', 2.08, 2.19, 2.21, 2.09, 2.08, 2.08, 3.5, 2.09, 2.12, 2.3, 3.17, 3.08, 3.13, 3, 8, '2024-05-03 11:51:55'),
(33, 9, 7, 5, 0, 0, 2, 1, 0, 0, 1, 37, 0, ' 0 ', ' 138 ', ' 142 ', ' 115 ', 3.5, 2.09, 2.1, 2.15, 2.17, 2.13, 2.1, 2.21, 2.38, 2.3, 3.09, 3.15, 3.15, 5, 12, '2024-05-03 11:53:19'),
(34, 9, 13, 7, 1, 0, 2, 2, 1, 1, 1, 36, 1, ' 4 ', ' 116 ', ' 129 ', ' 116 ', 2.13, 2.25, 2.09, 2.11, 2.17, 2.14, 2.1, 2.09, 2.19, 2.19, 3.09, 3.25, 3.75, 3, 9, '2024-05-03 11:57:42'),
(35, 9, 20, 5, 0, 0, 3, 2, 0, 1, 2, 37, 1, ' 0 ', ' 101 ', ' 101 ', ' 133 ', 2.38, 2.38, 2.75, 2.75, 2.3, 2.09, 2.08, 2.08, 2.1, 2.75, 3.75, 3.25, 3.13, 5, 12, '2024-05-03 11:59:02'),
(36, 9, 15, 7, 1, 0, 2, 2, 0, 1, 3, 38, 1, ' 3 ', ' 138 ', ' 138 ', ' 149 ', 2.5, 2.25, 3.5, 2.17, 2.17, 2.11, 2.09, 2.11, 2.5, 2.09, 3.08, 3.09, 3.21, 7, 12, '2024-05-03 12:04:52'),
(37, 9, 15, 2, 1, 1, 4, 5, 1, 0, 0, 26, 0, ' 4 ', ' 124 ', ' 141 ', ' 108 ', 2.38, 2.1, 2.14, 2.3, 2.15, 2.19, 2.5, 2.3, 2.09, 2.38, 3.15, 3.38, 3.38, 3, 9, '2024-05-03 12:05:33'),
(38, 9, 23, 5, 1, 1, 2, 3, 0, 1, 1, 38, 0, ' 2 ', ' 141 ', ' 104 ', ' 135 ', 2.5, 2.13, 2.17, 2.13, 2.75, 2.09, 2.75, 2.5, 2.09, 2.09, 3.17, 3.11, 3.09, 6, 12, '2024-05-03 12:08:03'),
(39, 9, 10, 7, 1, 0, 4, 1, 1, 0, 2, 47, 0, ' 3 ', ' 122 ', ' 114 ', ' 143 ', 2.11, 2.11, 2.25, 2.75, 2.17, 2.08, 2.38, 2.5, 2.17, 2.19, 3.3, 3.1, 3.11, 5, 11, '2024-05-03 12:08:20');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_10`
--

CREATE TABLE `yd_10` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_10`
--

INSERT INTO `yd_10` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 10, 0, 7, 1, 1, 1, 4, 0, 1, 1, 34, 1, ' 1 ', ' 149 ', ' 114 ', ' 143 ', 2.08, 2.08, 2.09, 2.38, 2.75, 2.11, 2.75, 2.5, 2.15, 2.38, 3.09, 3.38, 3.38, 7, 9, '2024-05-02 09:56:52'),
(2, 10, 0, 7, 1, 1, 1, 4, 0, 1, 1, 34, 1, ' 1 ', ' 149 ', ' 114 ', ' 143 ', 2.08, 2.08, 2.09, 2.38, 2.75, 2.11, 2.75, 2.5, 2.15, 2.38, 3.09, 3.38, 3.38, 7, 9, '2024-05-02 10:12:25'),
(3, 10, 0, 7, 1, 1, 1, 4, 0, 1, 1, 34, 1, ' 1 ', ' 149 ', ' 114 ', ' 143 ', 2.08, 2.08, 2.09, 2.38, 2.75, 2.11, 2.75, 2.5, 2.15, 2.38, 3.09, 3.38, 3.38, 7, 9, '2024-05-02 11:51:15'),
(4, 10, 0, 7, 1, 1, 1, 4, 0, 1, 1, 34, 1, ' 1 ', ' 149 ', ' 114 ', ' 143 ', 2.08, 2.08, 2.09, 2.38, 2.75, 2.11, 2.75, 2.5, 2.15, 2.38, 3.09, 3.38, 3.38, 7, 9, '2024-05-02 12:09:48'),
(5, 10, 0, 7, 1, 1, 1, 4, 0, 1, 1, 34, 1, ' 1 ', ' 149 ', ' 114 ', ' 143 ', 2.08, 2.08, 2.09, 2.38, 2.75, 2.11, 2.75, 2.5, 2.15, 2.38, 3.09, 3.38, 3.38, 7, 9, '2024-05-02 12:38:44'),
(6, 10, 0, 7, 1, 1, 1, 4, 0, 1, 1, 34, 1, ' 1 ', ' 149 ', ' 114 ', ' 143 ', 2.08, 2.08, 2.09, 2.38, 2.75, 2.11, 2.75, 2.5, 2.15, 2.38, 3.09, 3.38, 3.38, 7, 9, '2024-05-03 11:36:36'),
(7, 10, 0, 7, 1, 1, 1, 4, 0, 1, 1, 34, 1, ' 1 ', ' 149 ', ' 114 ', ' 143 ', 2.08, 2.08, 2.09, 2.38, 2.75, 2.11, 2.75, 2.5, 2.15, 2.38, 3.09, 3.38, 3.38, 7, 9, '2024-05-03 11:52:36'),
(8, 10, 21, 0, 1, 0, 1, 4, 1, 1, 5, 36, 1, ' 2 ', ' 123 ', ' 131 ', ' 135 ', 2.09, 2.5, 2.09, 2.38, 2.17, 2.38, 2.17, 2.1, 2.15, 2.17, 3.09, 3.11, 3.1, 6, 11, '2024-05-03 11:55:57'),
(9, 10, 23, 0, 1, 1, 2, 1, 1, 0, 5, 48, 1, ' 3 ', ' 136 ', ' 108 ', ' 102 ', 2.15, 2.19, 2.13, 2.75, 2.5, 3.5, 2.25, 2.09, 2.75, 2.19, 3.5, 3.3, 3.13, 5, 9, '2024-05-03 11:56:03'),
(10, 10, 19, 7, 1, 1, 2, 1, 1, 0, 1, 36, 1, ' 1 ', ' 147 ', ' 103 ', ' 120 ', 2.38, 2.38, 2.38, 2.08, 2.25, 2.75, 2.13, 2.38, 2.09, 2.3, 3.75, 3.19, 3.09, 6, 10, '2024-05-03 11:57:46'),
(11, 10, 17, 7, 1, 1, 1, 2, 0, 0, 4, 44, 0, ' 3 ', ' 116 ', ' 146 ', ' 105 ', 2.38, 2.13, 2.17, 2.38, 2.09, 2.15, 2.14, 2.12, 2.19, 2.15, 3.3, 3.25, 3.15, 6, 7, '2024-05-03 11:59:04'),
(12, 10, 0, 3, 0, 0, 4, 0, 1, 0, 2, 44, 0, ' 4 ', ' 142 ', ' 119 ', ' 130 ', 2.08, 2.09, 2.08, 2.13, 2.13, 2.25, 3.5, 2.19, 2.14, 2.09, 3.75, 4.5, 3.21, 7, 7, '2024-05-03 11:59:54'),
(13, 10, 17, 3, 1, 0, 1, 3, 0, 0, 2, 46, 1, ' 0 ', ' 102 ', ' 135 ', ' 103 ', 2.19, 2.08, 2.19, 2.11, 2.11, 2.08, 2.08, 2.3, 2.09, 2.12, 3.11, 3.08, 3.09, 6, 8, '2024-05-03 12:03:50'),
(14, 10, 22, 5, 1, 1, 0, 4, 1, 0, 4, 36, 1, ' 0 ', ' 105 ', ' 147 ', ' 138 ', 2.25, 2.1, 2.12, 2.5, 2.75, 2.13, 2.17, 2.17, 2.19, 2.14, 3.25, 3.08, 3.09, 5, 10, '2024-05-03 12:05:58'),
(15, 10, 9, 7, 1, 0, 2, 0, 1, 1, 4, 34, 1, ' 1 ', ' 132 ', ' 132 ', ' 145 ', 2.38, 2.09, 2.17, 2.1, 2.13, 2.1, 2.19, 2.14, 2.19, 2.12, 3.15, 3.15, 3.19, 3, 7, '2024-05-03 12:08:24');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_11`
--

CREATE TABLE `yd_11` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_11`
--

INSERT INTO `yd_11` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 11, 24, 1, 1, 1, 5, 3, 1, 1, 5, 43, 0, ' 1 ', ' 130 ', ' 124 ', ' 107 ', 2.38, 2.19, 2.21, 2.1, 2.75, 2.19, 2.5, 2.15, 2.15, 2.38, 3.08, 3.1, 3.09, 7, 11, '2024-05-02 09:59:02'),
(2, 11, 24, 1, 1, 1, 5, 3, 1, 1, 5, 43, 0, ' 1 ', ' 130 ', ' 124 ', ' 107 ', 2.38, 2.19, 2.21, 2.1, 2.75, 2.19, 2.5, 2.15, 2.15, 2.38, 3.08, 3.1, 3.09, 7, 11, '2024-05-03 11:37:48'),
(3, 11, 24, 1, 1, 1, 5, 3, 1, 1, 5, 43, 0, ' 1 ', ' 130 ', ' 124 ', ' 107 ', 2.38, 2.19, 2.21, 2.1, 2.75, 2.19, 2.5, 2.15, 2.15, 2.38, 3.08, 3.1, 3.09, 7, 11, '2024-05-03 11:54:45'),
(4, 11, 8, 2, 0, 0, 1, 4, 1, 0, 1, 45, 1, ' 2 ', ' 124 ', ' 127 ', ' 142 ', 2.09, 3.5, 2.25, 2.38, 2.08, 2.09, 2.25, 2.25, 2.25, 2.14, 3.38, 3.08, 3.08, 7, 8, '2024-05-03 11:56:26'),
(5, 11, 2, 0, 0, 0, 3, 0, 1, 1, 4, 43, 1, ' 3 ', ' 112 ', ' 106 ', ' 101 ', 2.08, 2.38, 2.17, 2.13, 2.38, 2.19, 3.5, 3.5, 2.12, 2.08, 3.5, 3.15, 3.1, 3, 12, '2024-05-03 11:56:40'),
(6, 11, 6, 5, 0, 0, 2, 5, 1, 0, 3, 47, 1, ' 2 ', ' 130 ', ' 133 ', ' 106 ', 2.08, 2.09, 3.5, 2.15, 2.38, 2.08, 2.5, 2.19, 2.38, 2.09, 3.38, 3.14, 3.5, 6, 12, '2024-05-03 11:58:36'),
(7, 11, 18, 4, 0, 0, 3, 2, 0, 0, 5, 46, 1, ' 3 ', ' 110 ', ' 129 ', ' 141 ', 2.3, 2.08, 2.09, 2.1, 2.17, 3.5, 2.09, 2.08, 2.13, 2.15, 3.21, 3.13, 3.1, 6, 8, '2024-05-03 12:00:14'),
(8, 11, 0, 7, 1, 1, 0, 1, 0, 1, 0, 32, 0, ' 2 ', ' 148 ', ' 118 ', ' 100 ', 2.14, 2.13, 2.09, 3.5, 2.38, 2.15, 2.21, 3.5, 2.17, 2.14, 3.21, 3.17, 3.09, 3, 10, '2024-05-03 12:06:45'),
(9, 11, 15, 0, 0, 1, 1, 0, 1, 1, 0, 39, 1, ' 2 ', ' 122 ', ' 107 ', ' 123 ', 2.17, 2.08, 2.12, 2.08, 2.08, 2.09, 2.25, 2.08, 2.17, 2.25, 3.3, 3.1, 3.3, 4, 8, '2024-05-03 12:07:32'),
(10, 11, 18, 9, 1, 1, 1, 2, 0, 1, 5, 33, 1, ' 1 ', ' 104 ', ' 125 ', ' 146 ', 2.19, 2.14, 2.08, 2.09, 2.25, 2.13, 2.12, 2.08, 2.1, 2.09, 3.08, 3.38, 3.1, 3, 11, '2024-05-03 12:07:51');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_12`
--

CREATE TABLE `yd_12` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_12`
--

INSERT INTO `yd_12` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 12, 20, 8, 1, 0, 1, 5, 1, 0, 4, 43, 0, ' 4 ', ' 146 ', ' 130 ', ' 103 ', 2.09, 2.19, 2.12, 2.1, 2.09, 2.5, 2.25, 2.1, 2.75, 2.17, 3.12, 3.1, 3.21, 3, 9, '2024-05-02 09:55:53'),
(2, 12, 20, 8, 1, 0, 1, 5, 1, 0, 4, 43, 0, ' 4 ', ' 146 ', ' 130 ', ' 103 ', 2.09, 2.19, 2.12, 2.1, 2.09, 2.5, 2.25, 2.1, 2.75, 2.17, 3.12, 3.1, 3.21, 3, 9, '2024-05-02 10:08:47'),
(3, 12, 20, 8, 1, 0, 1, 5, 1, 0, 4, 43, 0, ' 4 ', ' 146 ', ' 130 ', ' 103 ', 2.09, 2.19, 2.12, 2.1, 2.09, 2.5, 2.25, 2.1, 2.75, 2.17, 3.12, 3.1, 3.21, 3, 9, '2024-05-02 10:11:26'),
(4, 12, 20, 8, 1, 0, 1, 5, 1, 0, 4, 43, 0, ' 4 ', ' 146 ', ' 130 ', ' 103 ', 2.09, 2.19, 2.12, 2.1, 2.09, 2.5, 2.25, 2.1, 2.75, 2.17, 3.12, 3.1, 3.21, 3, 9, '2024-05-02 10:13:11'),
(5, 12, 20, 8, 1, 0, 1, 5, 1, 0, 4, 43, 0, ' 4 ', ' 146 ', ' 130 ', ' 103 ', 2.09, 2.19, 2.12, 2.1, 2.09, 2.5, 2.25, 2.1, 2.75, 2.17, 3.12, 3.1, 3.21, 3, 9, '2024-05-02 10:14:13'),
(6, 12, 20, 8, 1, 0, 1, 5, 1, 0, 4, 43, 0, ' 4 ', ' 146 ', ' 130 ', ' 103 ', 2.09, 2.19, 2.12, 2.1, 2.09, 2.5, 2.25, 2.1, 2.75, 2.17, 3.12, 3.1, 3.21, 3, 9, '2024-05-02 10:17:48'),
(7, 12, 20, 8, 1, 0, 1, 5, 1, 0, 4, 43, 0, ' 4 ', ' 146 ', ' 130 ', ' 103 ', 2.09, 2.19, 2.12, 2.1, 2.09, 2.5, 2.25, 2.1, 2.75, 2.17, 3.12, 3.1, 3.21, 3, 9, '2024-05-02 10:23:20'),
(8, 12, 20, 8, 1, 0, 1, 5, 1, 0, 4, 43, 0, ' 4 ', ' 146 ', ' 130 ', ' 103 ', 2.09, 2.19, 2.12, 2.1, 2.09, 2.5, 2.25, 2.1, 2.75, 2.17, 3.12, 3.1, 3.21, 3, 9, '2024-05-02 10:26:12'),
(9, 12, 20, 8, 1, 0, 1, 5, 1, 0, 4, 43, 0, ' 4 ', ' 146 ', ' 130 ', ' 103 ', 2.09, 2.19, 2.12, 2.1, 2.09, 2.5, 2.25, 2.1, 2.75, 2.17, 3.12, 3.1, 3.21, 3, 9, '2024-05-02 10:28:27'),
(10, 12, 20, 8, 1, 0, 1, 5, 1, 0, 4, 43, 0, ' 4 ', ' 146 ', ' 130 ', ' 103 ', 2.09, 2.19, 2.12, 2.1, 2.09, 2.5, 2.25, 2.1, 2.75, 2.17, 3.12, 3.1, 3.21, 3, 9, '2024-05-02 10:46:11'),
(11, 12, 20, 8, 1, 0, 1, 5, 1, 0, 4, 43, 0, ' 4 ', ' 146 ', ' 130 ', ' 103 ', 2.09, 2.19, 2.12, 2.1, 2.09, 2.5, 2.25, 2.1, 2.75, 2.17, 3.12, 3.1, 3.21, 3, 9, '2024-05-02 10:51:31'),
(12, 12, 20, 8, 1, 0, 1, 5, 1, 0, 4, 43, 0, ' 4 ', ' 146 ', ' 130 ', ' 103 ', 2.09, 2.19, 2.12, 2.1, 2.09, 2.5, 2.25, 2.1, 2.75, 2.17, 3.12, 3.1, 3.21, 3, 9, '2024-05-02 10:54:47'),
(13, 12, 20, 8, 1, 0, 1, 5, 1, 0, 4, 43, 0, ' 4 ', ' 146 ', ' 130 ', ' 103 ', 2.09, 2.19, 2.12, 2.1, 2.09, 2.5, 2.25, 2.1, 2.75, 2.17, 3.12, 3.1, 3.21, 3, 9, '2024-05-02 10:58:47'),
(14, 12, 20, 8, 1, 0, 1, 5, 1, 0, 4, 43, 0, ' 4 ', ' 146 ', ' 130 ', ' 103 ', 2.09, 2.19, 2.12, 2.1, 2.09, 2.5, 2.25, 2.1, 2.75, 2.17, 3.12, 3.1, 3.21, 3, 9, '2024-05-02 11:01:44'),
(15, 12, 20, 8, 1, 0, 1, 5, 1, 0, 4, 43, 0, ' 4 ', ' 146 ', ' 130 ', ' 103 ', 2.09, 2.19, 2.12, 2.1, 2.09, 2.5, 2.25, 2.1, 2.75, 2.17, 3.12, 3.1, 3.21, 3, 9, '2024-05-02 11:02:00'),
(16, 12, 20, 8, 1, 0, 1, 5, 1, 0, 4, 43, 0, ' 4 ', ' 146 ', ' 130 ', ' 103 ', 2.09, 2.19, 2.12, 2.1, 2.09, 2.5, 2.25, 2.1, 2.75, 2.17, 3.12, 3.1, 3.21, 3, 9, '2024-05-02 11:30:44'),
(17, 12, 20, 8, 1, 0, 1, 5, 1, 0, 4, 43, 0, ' 4 ', ' 146 ', ' 130 ', ' 103 ', 2.09, 2.19, 2.12, 2.1, 2.09, 2.5, 2.25, 2.1, 2.75, 2.17, 3.12, 3.1, 3.21, 3, 9, '2024-05-02 11:47:40'),
(18, 12, 20, 8, 1, 0, 1, 5, 1, 0, 4, 43, 0, ' 4 ', ' 146 ', ' 130 ', ' 103 ', 2.09, 2.19, 2.12, 2.1, 2.09, 2.5, 2.25, 2.1, 2.75, 2.17, 3.12, 3.1, 3.21, 3, 9, '2024-05-02 11:50:16'),
(19, 12, 20, 8, 1, 0, 1, 5, 1, 0, 4, 43, 0, ' 4 ', ' 146 ', ' 130 ', ' 103 ', 2.09, 2.19, 2.12, 2.1, 2.09, 2.5, 2.25, 2.1, 2.75, 2.17, 3.12, 3.1, 3.21, 3, 9, '2024-05-02 12:00:15'),
(20, 12, 20, 8, 1, 0, 1, 5, 1, 0, 4, 43, 0, ' 4 ', ' 146 ', ' 130 ', ' 103 ', 2.09, 2.19, 2.12, 2.1, 2.09, 2.5, 2.25, 2.1, 2.75, 2.17, 3.12, 3.1, 3.21, 3, 9, '2024-05-02 12:00:54'),
(21, 12, 20, 8, 1, 0, 1, 5, 1, 0, 4, 43, 0, ' 4 ', ' 146 ', ' 130 ', ' 103 ', 2.09, 2.19, 2.12, 2.1, 2.09, 2.5, 2.25, 2.1, 2.75, 2.17, 3.12, 3.1, 3.21, 3, 9, '2024-05-02 12:08:48'),
(22, 12, 20, 8, 1, 0, 1, 5, 1, 0, 4, 43, 0, ' 4 ', ' 146 ', ' 130 ', ' 103 ', 2.09, 2.19, 2.12, 2.1, 2.09, 2.5, 2.25, 2.1, 2.75, 2.17, 3.12, 3.1, 3.21, 3, 9, '2024-05-02 12:37:44'),
(23, 12, 20, 8, 1, 0, 1, 5, 1, 0, 4, 43, 0, ' 4 ', ' 146 ', ' 130 ', ' 103 ', 2.09, 2.19, 2.12, 2.1, 2.09, 2.5, 2.25, 2.1, 2.75, 2.17, 3.12, 3.1, 3.21, 3, 9, '2024-05-02 12:41:28'),
(24, 12, 20, 8, 1, 0, 1, 5, 1, 0, 4, 43, 0, ' 4 ', ' 146 ', ' 130 ', ' 103 ', 2.09, 2.19, 2.12, 2.1, 2.09, 2.5, 2.25, 2.1, 2.75, 2.17, 3.12, 3.1, 3.21, 3, 9, '2024-05-02 12:52:15'),
(25, 12, 20, 8, 1, 0, 1, 5, 1, 0, 4, 43, 0, ' 4 ', ' 146 ', ' 130 ', ' 103 ', 2.09, 2.19, 2.12, 2.1, 2.09, 2.5, 2.25, 2.1, 2.75, 2.17, 3.12, 3.1, 3.21, 3, 9, '2024-05-03 11:34:07'),
(26, 12, 20, 8, 1, 0, 1, 5, 1, 0, 4, 43, 0, ' 4 ', ' 146 ', ' 130 ', ' 103 ', 2.09, 2.19, 2.12, 2.1, 2.09, 2.5, 2.25, 2.1, 2.75, 2.17, 3.12, 3.1, 3.21, 3, 9, '2024-05-03 11:51:36'),
(27, 12, 17, 7, 1, 1, 3, 1, 1, 1, 0, 30, 1, ' 0 ', ' 103 ', ' 112 ', ' 100 ', 2.21, 2.75, 2.1, 2.08, 2.5, 2.19, 2.19, 2.15, 2.21, 2.08, 3.15, 3.75, 3.19, 6, 11, '2024-05-03 11:57:03'),
(28, 12, 8, 0, 0, 1, 1, 4, 1, 1, 3, 25, 0, ' 3 ', ' 137 ', ' 132 ', ' 111 ', 2.5, 2.09, 2.25, 2.15, 2.75, 2.11, 2.14, 2.3, 2.09, 2.17, 4.5, 3.1, 3.75, 6, 12, '2024-05-03 11:58:58'),
(29, 12, 1, 6, 0, 1, 5, 5, 0, 0, 2, 40, 1, ' 0 ', ' 114 ', ' 101 ', ' 140 ', 2.38, 2.12, 2.75, 2.14, 2.3, 2.11, 2.38, 2.21, 2.5, 2.14, 4.5, 3.25, 3.13, 7, 9, '2024-05-03 12:03:21'),
(30, 12, 21, 6, 1, 1, 3, 1, 0, 0, 1, 48, 1, ' 4 ', ' 115 ', ' 142 ', ' 119 ', 2.14, 2.75, 2.13, 2.3, 3.5, 2.19, 2.1, 2.1, 2.12, 2.13, 3.25, 3.15, 3.13, 5, 7, '2024-05-03 12:04:05'),
(31, 12, 11, 8, 1, 0, 4, 5, 0, 0, 2, 49, 0, ' 3 ', ' 101 ', ' 110 ', ' 112 ', 2.08, 2.25, 2.5, 2.11, 2.14, 3.5, 2.11, 2.13, 2.5, 2.1, 3.19, 3.14, 3.15, 4, 12, '2024-05-03 12:06:33'),
(32, 12, 7, 8, 0, 1, 1, 0, 1, 0, 2, 37, 1, ' 0 ', ' 102 ', ' 130 ', ' 135 ', 2.38, 2.19, 2.21, 2.25, 2.08, 2.3, 3.5, 2.08, 2.25, 2.09, 3.11, 3.38, 3.09, 3, 10, '2024-05-03 12:08:59');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_13`
--

CREATE TABLE `yd_13` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_13`
--

INSERT INTO `yd_13` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 13, 9, 2, 0, 1, 2, 0, 0, 0, 1, 26, 1, ' 0 ', ' 140 ', ' 123 ', ' 138 ', 2.13, 2.08, 2.3, 2.38, 3.5, 2.75, 2.08, 2.12, 2.21, 2.25, 3.21, 3.21, 3.38, 3, 8, '2024-05-03 11:55:59'),
(2, 13, 4, 3, 0, 1, 0, 3, 1, 1, 0, 42, 0, ' 0 ', ' 144 ', ' 126 ', ' 139 ', 2.5, 2.15, 2.13, 2.1, 2.09, 2.09, 2.5, 2.21, 2.1, 2.09, 3.5, 3.11, 3.25, 6, 11, '2024-05-03 11:56:05'),
(3, 13, 3, 5, 0, 1, 4, 4, 1, 1, 3, 31, 0, ' 0 ', ' 137 ', ' 107 ', ' 119 ', 2.11, 3.5, 2.38, 2.3, 3.5, 2.11, 2.17, 2.38, 2.19, 2.12, 3.5, 3.17, 3.25, 3, 12, '2024-05-03 11:56:57'),
(4, 13, 17, 1, 1, 0, 3, 4, 1, 1, 4, 45, 1, ' 3 ', ' 122 ', ' 115 ', ' 122 ', 2.75, 2.08, 2.1, 2.25, 2.17, 2.75, 2.19, 2.08, 2.3, 2.1, 3.15, 3.09, 3.09, 3, 7, '2024-05-03 11:59:11'),
(5, 13, 18, 8, 1, 0, 5, 2, 1, 1, 4, 41, 1, ' 0 ', ' 126 ', ' 132 ', ' 116 ', 2.13, 2.25, 2.09, 2.38, 2.08, 3.5, 2.25, 2.11, 2.3, 3.5, 3.08, 3.15, 3.1, 4, 8, '2024-05-03 11:59:41'),
(6, 13, 15, 6, 1, 0, 5, 2, 1, 1, 5, 40, 0, ' 4 ', ' 134 ', ' 149 ', ' 116 ', 2.14, 2.17, 2.1, 2.14, 2.25, 2.08, 2.38, 2.11, 2.19, 2.08, 3.11, 3.19, 3.3, 3, 11, '2024-05-03 12:01:30'),
(7, 13, 16, 9, 1, 0, 4, 0, 1, 1, 4, 28, 0, ' 3 ', ' 138 ', ' 149 ', ' 115 ', 2.5, 2.38, 2.15, 2.12, 2.3, 2.25, 2.15, 2.15, 2.1, 2.13, 3.12, 3.15, 3.21, 5, 7, '2024-05-03 12:01:51'),
(8, 13, 17, 8, 1, 0, 0, 3, 0, 1, 5, 43, 0, ' 0 ', ' 104 ', ' 126 ', ' 122 ', 2.08, 2.08, 2.38, 2.21, 2.08, 2.21, 2.25, 2.25, 2.14, 2.3, 3.08, 3.19, 3.13, 4, 10, '2024-05-03 12:03:24'),
(9, 13, 10, 0, 1, 1, 2, 1, 0, 0, 2, 46, 0, ' 4 ', ' 122 ', ' 104 ', ' 149 ', 2.75, 2.09, 2.1, 2.25, 2.38, 2.11, 2.12, 2.15, 2.75, 2.17, 3.12, 3.13, 4.5, 3, 7, '2024-05-03 12:03:44'),
(10, 13, 10, 9, 0, 1, 3, 1, 1, 0, 3, 28, 1, ' 3 ', ' 101 ', ' 128 ', ' 139 ', 2.12, 2.5, 2.5, 2.13, 2.08, 2.17, 2.09, 2.17, 2.19, 2.75, 3.12, 3.12, 3.75, 4, 11, '2024-05-03 12:06:57'),
(11, 13, 12, 2, 1, 0, 4, 1, 1, 0, 5, 30, 0, ' 2 ', ' 109 ', ' 115 ', ' 146 ', 2.21, 2.21, 2.09, 3.5, 2.1, 2.75, 2.13, 2.5, 2.75, 2.14, 3.75, 3.75, 3.5, 5, 10, '2024-05-03 12:07:59');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_14`
--

CREATE TABLE `yd_14` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_14`
--

INSERT INTO `yd_14` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 14, 9, 7, 1, 0, 5, 5, 0, 1, 3, 47, 0, ' 1 ', ' 128 ', ' 133 ', ' 109 ', 2.25, 2.75, 2.5, 2.25, 2.13, 2.1, 2.17, 2.12, 2.3, 2.75, 3.09, 3.08, 3.08, 7, 7, '2024-05-03 11:38:09'),
(2, 14, 9, 7, 1, 0, 5, 5, 0, 1, 3, 47, 0, ' 1 ', ' 128 ', ' 133 ', ' 109 ', 2.25, 2.75, 2.5, 2.25, 2.13, 2.1, 2.17, 2.12, 2.3, 2.75, 3.09, 3.08, 3.08, 7, 7, '2024-05-03 11:55:39'),
(3, 14, 12, 6, 0, 1, 1, 1, 1, 0, 3, 32, 1, ' 0 ', ' 124 ', ' 132 ', ' 110 ', 2.08, 2.08, 2.5, 2.75, 2.12, 2.09, 2.25, 2.08, 2.19, 2.25, 3.09, 3.25, 3.11, 6, 7, '2024-05-03 11:58:23'),
(4, 14, 16, 0, 0, 0, 1, 1, 0, 0, 5, 46, 1, ' 1 ', ' 111 ', ' 148 ', ' 102 ', 2.12, 2.5, 2.17, 3.5, 2.11, 2.11, 2.3, 2.08, 2.1, 2.38, 3.3, 3.12, 3.08, 3, 9, '2024-05-03 12:01:12'),
(5, 14, 16, 1, 1, 0, 5, 3, 0, 0, 1, 46, 0, ' 2 ', ' 135 ', ' 129 ', ' 137 ', 2.12, 2.75, 2.14, 2.09, 2.1, 2.38, 2.14, 3.5, 2.15, 2.25, 3.1, 3.3, 3.1, 4, 8, '2024-05-03 12:05:04'),
(6, 14, 7, 2, 0, 1, 2, 0, 1, 0, 5, 46, 0, ' 2 ', ' 121 ', ' 109 ', ' 133 ', 2.38, 2.09, 2.75, 2.21, 2.08, 2.1, 2.08, 2.09, 2.5, 2.75, 3.5, 3.15, 3.38, 4, 8, '2024-05-03 12:07:22'),
(7, 14, 10, 5, 0, 1, 3, 0, 0, 1, 3, 31, 1, ' 2 ', ' 121 ', ' 126 ', ' 146 ', 2.25, 2.25, 2.08, 2.15, 3.5, 2.15, 2.08, 2.08, 2.38, 2.21, 3.12, 3.14, 3.14, 5, 9, '2024-05-03 12:08:34');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_15`
--

CREATE TABLE `yd_15` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_15`
--

INSERT INTO `yd_15` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 15, 7, 7, 0, 1, 1, 1, 1, 0, 3, 43, 1, ' 1 ', ' 115 ', ' 107 ', ' 105 ', 2.13, 2.11, 2.13, 2.15, 2.38, 2.08, 2.15, 3.5, 2.3, 2.21, 3.12, 3.25, 3.08, 3, 10, '2024-05-02 09:57:09'),
(2, 15, 11, 0, 1, 1, 2, 5, 1, 0, 3, 46, 0, ' 3 ', ' 146 ', ' 127 ', ' 115 ', 2.09, 2.12, 2.11, 2.19, 2.13, 2.5, 2.21, 2.25, 2.09, 2.11, 3.08, 3.19, 3.09, 3, 9, '2024-05-02 09:58:39'),
(3, 15, 2, 0, 1, 0, 4, 2, 1, 0, 1, 27, 0, ' 0 ', ' 136 ', ' 124 ', ' 110 ', 2.1, 2.08, 2.21, 2.19, 2.08, 2.5, 2.1, 2.17, 3.5, 2.19, 3.14, 3.08, 3.5, 6, 8, '2024-05-02 09:58:58'),
(4, 15, 2, 3, 1, 0, 1, 4, 1, 0, 5, 25, 0, ' 0 ', ' 114 ', ' 107 ', ' 121 ', 2.11, 3.5, 2.08, 2.75, 2.09, 2.1, 2.5, 2.1, 2.38, 2.13, 3.21, 3.15, 3.3, 6, 10, '2024-05-02 09:59:12'),
(5, 15, 7, 7, 0, 1, 1, 1, 1, 0, 3, 43, 1, ' 1 ', ' 115 ', ' 107 ', ' 105 ', 2.13, 2.11, 2.13, 2.15, 2.38, 2.08, 2.15, 3.5, 2.3, 2.21, 3.12, 3.25, 3.08, 3, 10, '2024-05-02 11:51:32'),
(6, 15, 7, 7, 0, 1, 1, 1, 1, 0, 3, 43, 1, ' 1 ', ' 115 ', ' 107 ', ' 105 ', 2.13, 2.11, 2.13, 2.15, 2.38, 2.08, 2.15, 3.5, 2.3, 2.21, 3.12, 3.25, 3.08, 3, 10, '2024-05-02 12:10:04'),
(7, 15, 11, 0, 1, 1, 2, 5, 1, 0, 3, 46, 0, ' 3 ', ' 146 ', ' 127 ', ' 115 ', 2.09, 2.12, 2.11, 2.19, 2.13, 2.5, 2.21, 2.25, 2.09, 2.11, 3.08, 3.19, 3.09, 3, 9, '2024-05-02 12:11:35'),
(8, 15, 7, 7, 0, 1, 1, 1, 1, 0, 3, 43, 1, ' 1 ', ' 115 ', ' 107 ', ' 105 ', 2.13, 2.11, 2.13, 2.15, 2.38, 2.08, 2.15, 3.5, 2.3, 2.21, 3.12, 3.25, 3.08, 3, 10, '2024-05-02 12:39:00'),
(9, 15, 7, 7, 0, 1, 1, 1, 1, 0, 3, 43, 1, ' 1 ', ' 115 ', ' 107 ', ' 105 ', 2.13, 2.11, 2.13, 2.15, 2.38, 2.08, 2.15, 3.5, 2.3, 2.21, 3.12, 3.25, 3.08, 3, 10, '2024-05-03 11:36:53'),
(10, 15, 11, 0, 1, 1, 2, 5, 1, 0, 3, 46, 0, ' 3 ', ' 146 ', ' 127 ', ' 115 ', 2.09, 2.12, 2.11, 2.19, 2.13, 2.5, 2.21, 2.25, 2.09, 2.11, 3.08, 3.19, 3.09, 3, 9, '2024-05-03 11:37:43'),
(11, 15, 2, 0, 1, 0, 4, 2, 1, 0, 1, 27, 0, ' 0 ', ' 136 ', ' 124 ', ' 110 ', 2.1, 2.08, 2.21, 2.19, 2.08, 2.5, 2.1, 2.17, 3.5, 2.19, 3.14, 3.08, 3.5, 6, 8, '2024-05-03 11:37:46'),
(12, 15, 2, 3, 1, 0, 1, 4, 1, 0, 5, 25, 0, ' 0 ', ' 114 ', ' 107 ', ' 121 ', 2.11, 3.5, 2.08, 2.75, 2.09, 2.1, 2.5, 2.1, 2.38, 2.13, 3.21, 3.15, 3.3, 6, 10, '2024-05-03 11:37:50'),
(13, 15, 13, 5, 0, 1, 0, 0, 0, 0, 3, 43, 0, ' 3 ', ' 148 ', ' 137 ', ' 146 ', 2.5, 2.11, 2.5, 2.17, 2.1, 2.13, 2.17, 2.5, 3.5, 2.12, 3.12, 4.5, 3.19, 6, 12, '2024-05-03 11:37:54'),
(14, 15, 7, 7, 0, 1, 1, 1, 1, 0, 3, 43, 1, ' 1 ', ' 115 ', ' 107 ', ' 105 ', 2.13, 2.11, 2.13, 2.15, 2.38, 2.08, 2.15, 3.5, 2.3, 2.21, 3.12, 3.25, 3.08, 3, 10, '2024-05-03 11:52:52'),
(15, 15, 11, 0, 1, 1, 2, 5, 1, 0, 3, 46, 0, ' 3 ', ' 146 ', ' 127 ', ' 115 ', 2.09, 2.12, 2.11, 2.19, 2.13, 2.5, 2.21, 2.25, 2.09, 2.11, 3.08, 3.19, 3.09, 3, 9, '2024-05-03 11:54:23'),
(16, 15, 2, 0, 1, 0, 4, 2, 1, 0, 1, 27, 0, ' 0 ', ' 136 ', ' 124 ', ' 110 ', 2.1, 2.08, 2.21, 2.19, 2.08, 2.5, 2.1, 2.17, 3.5, 2.19, 3.14, 3.08, 3.5, 6, 8, '2024-05-03 11:54:41'),
(17, 15, 2, 3, 1, 0, 1, 4, 1, 0, 5, 25, 0, ' 0 ', ' 114 ', ' 107 ', ' 121 ', 2.11, 3.5, 2.08, 2.75, 2.09, 2.1, 2.5, 2.1, 2.38, 2.13, 3.21, 3.15, 3.3, 6, 10, '2024-05-03 11:54:56'),
(18, 15, 13, 5, 0, 1, 0, 0, 0, 0, 3, 43, 0, ' 3 ', ' 148 ', ' 137 ', ' 146 ', 2.5, 2.11, 2.5, 2.17, 2.1, 2.13, 2.17, 2.5, 3.5, 2.12, 3.12, 4.5, 3.19, 6, 12, '2024-05-03 11:55:00'),
(19, 15, 11, 1, 1, 1, 5, 5, 0, 0, 1, 39, 1, ' 1 ', ' 144 ', ' 137 ', ' 146 ', 2.75, 2.09, 3.5, 2.08, 2.11, 2.3, 2.13, 2.13, 2.19, 2.3, 3.75, 3.19, 3.14, 7, 8, '2024-05-03 11:56:49'),
(20, 15, 9, 5, 0, 1, 2, 4, 0, 0, 5, 33, 1, ' 4 ', ' 125 ', ' 116 ', ' 146 ', 2.21, 2.12, 2.14, 3.5, 2.3, 2.09, 2.13, 2.13, 2.13, 2.5, 3.15, 3.15, 3.5, 7, 8, '2024-05-03 11:58:44'),
(21, 15, 18, 2, 1, 1, 4, 1, 0, 1, 3, 28, 1, ' 0 ', ' 104 ', ' 128 ', ' 117 ', 2.25, 2.25, 2.25, 2.21, 2.13, 2.12, 2.21, 2.38, 2.08, 2.09, 3.14, 3.3, 3.09, 7, 12, '2024-05-03 12:00:37'),
(22, 15, 6, 4, 0, 0, 2, 1, 0, 0, 2, 33, 0, ' 4 ', ' 113 ', ' 131 ', ' 131 ', 2.09, 2.13, 2.38, 2.14, 2.19, 2.75, 2.38, 2.3, 3.5, 2.25, 3.25, 3.3, 3.11, 6, 7, '2024-05-03 12:01:04'),
(23, 15, 24, 6, 0, 1, 1, 0, 1, 0, 2, 27, 0, ' 2 ', ' 131 ', ' 139 ', ' 111 ', 2.13, 2.1, 2.5, 2.12, 2.19, 2.14, 2.11, 2.09, 2.17, 2.09, 4.5, 3.09, 3.75, 5, 12, '2024-05-03 12:01:28'),
(24, 15, 12, 8, 1, 1, 0, 4, 0, 0, 5, 42, 0, ' 4 ', ' 149 ', ' 138 ', ' 121 ', 2.21, 2.5, 2.5, 2.75, 2.15, 2.09, 2.11, 3.5, 2.75, 2.19, 3.08, 3.21, 3.17, 5, 7, '2024-05-03 12:02:07'),
(25, 15, 0, 3, 0, 0, 5, 3, 0, 1, 5, 38, 0, ' 1 ', ' 140 ', ' 139 ', ' 134 ', 2.5, 2.3, 2.25, 2.09, 2.13, 3.5, 2.13, 2.21, 2.14, 2.12, 3.17, 3.13, 3.17, 4, 12, '2024-05-03 12:03:09'),
(26, 15, 0, 2, 1, 0, 5, 3, 0, 1, 3, 39, 1, ' 3 ', ' 111 ', ' 119 ', ' 137 ', 2.38, 2.38, 2.11, 2.11, 2.15, 2.3, 2.1, 2.5, 3.5, 2.75, 3.13, 3.38, 4.5, 7, 7, '2024-05-03 12:07:57'),
(27, 15, 3, 7, 1, 0, 5, 0, 0, 0, 5, 42, 1, ' 3 ', ' 125 ', ' 144 ', ' 103 ', 2.08, 2.21, 2.19, 2.19, 2.19, 2.09, 2.14, 2.3, 2.5, 2.14, 4.5, 3.75, 3.38, 5, 7, '2024-05-03 12:08:07'),
(28, 15, 16, 5, 1, 0, 1, 4, 0, 1, 5, 28, 1, ' 0 ', ' 113 ', ' 103 ', ' 148 ', 2.3, 2.5, 2.15, 2.09, 2.38, 3.5, 2.09, 2.08, 2.1, 2.38, 3.13, 3.13, 3.13, 6, 7, '2024-05-03 12:08:18');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_16`
--

CREATE TABLE `yd_16` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_16`
--

INSERT INTO `yd_16` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 16, 1, 6, 0, 1, 4, 5, 0, 0, 4, 29, 1, ' 4 ', ' 101 ', ' 114 ', ' 114 ', 2.11, 2.09, 2.12, 2.13, 2.5, 2.21, 2.08, 2.75, 2.38, 2.25, 3.17, 3.3, 3.3, 6, 11, '2024-05-02 09:58:19'),
(2, 16, 21, 1, 0, 0, 5, 4, 1, 0, 4, 38, 1, ' 2 ', ' 148 ', ' 131 ', ' 140 ', 2.21, 2.11, 2.75, 2.11, 2.09, 2.11, 2.21, 2.19, 2.08, 2.12, 3.11, 3.3, 3.09, 3, 11, '2024-05-02 09:58:35'),
(3, 16, 1, 6, 0, 1, 4, 5, 0, 0, 4, 29, 1, ' 4 ', ' 101 ', ' 114 ', ' 114 ', 2.11, 2.09, 2.12, 2.13, 2.5, 2.21, 2.08, 2.75, 2.38, 2.25, 3.17, 3.3, 3.3, 6, 11, '2024-05-02 11:52:42'),
(4, 16, 1, 6, 0, 1, 4, 5, 0, 0, 4, 29, 1, ' 4 ', ' 101 ', ' 114 ', ' 114 ', 2.11, 2.09, 2.12, 2.13, 2.5, 2.21, 2.08, 2.75, 2.38, 2.25, 3.17, 3.3, 3.3, 6, 11, '2024-05-02 12:11:14'),
(5, 16, 21, 1, 0, 0, 5, 4, 1, 0, 4, 38, 1, ' 2 ', ' 148 ', ' 131 ', ' 140 ', 2.21, 2.11, 2.75, 2.11, 2.09, 2.11, 2.21, 2.19, 2.08, 2.12, 3.11, 3.3, 3.09, 3, 11, '2024-05-02 12:11:30'),
(6, 16, 1, 6, 0, 1, 4, 5, 0, 0, 4, 29, 1, ' 4 ', ' 101 ', ' 114 ', ' 114 ', 2.11, 2.09, 2.12, 2.13, 2.5, 2.21, 2.08, 2.75, 2.38, 2.25, 3.17, 3.3, 3.3, 6, 11, '2024-05-03 11:37:36'),
(7, 16, 21, 1, 0, 0, 5, 4, 1, 0, 4, 38, 1, ' 2 ', ' 148 ', ' 131 ', ' 140 ', 2.21, 2.11, 2.75, 2.11, 2.09, 2.11, 2.21, 2.19, 2.08, 2.12, 3.11, 3.3, 3.09, 3, 11, '2024-05-03 11:37:42'),
(8, 16, 1, 6, 0, 1, 4, 5, 0, 0, 4, 29, 1, ' 4 ', ' 101 ', ' 114 ', ' 114 ', 2.11, 2.09, 2.12, 2.13, 2.5, 2.21, 2.08, 2.75, 2.38, 2.25, 3.17, 3.3, 3.3, 6, 11, '2024-05-03 11:54:02'),
(9, 16, 21, 1, 0, 0, 5, 4, 1, 0, 4, 38, 1, ' 2 ', ' 148 ', ' 131 ', ' 140 ', 2.21, 2.11, 2.75, 2.11, 2.09, 2.11, 2.21, 2.19, 2.08, 2.12, 3.11, 3.3, 3.09, 3, 11, '2024-05-03 11:54:18'),
(10, 16, 19, 9, 1, 1, 3, 2, 1, 0, 2, 34, 0, ' 3 ', ' 111 ', ' 139 ', ' 124 ', 2.09, 2.11, 2.3, 2.15, 2.1, 2.19, 2.08, 2.09, 2.13, 3.5, 3.12, 3.3, 3.19, 3, 10, '2024-05-03 11:56:55'),
(11, 16, 0, 7, 1, 0, 3, 5, 0, 1, 1, 48, 1, ' 0 ', ' 146 ', ' 126 ', ' 144 ', 2.12, 2.5, 2.25, 2.09, 2.14, 2.12, 2.13, 3.5, 2.15, 2.19, 3.17, 3.13, 3.08, 7, 12, '2024-05-03 11:59:08'),
(12, 16, 14, 0, 0, 0, 3, 5, 1, 0, 0, 27, 0, ' 3 ', ' 140 ', ' 127 ', ' 137 ', 2.3, 2.11, 2.17, 2.11, 2.38, 2.14, 2.75, 2.3, 2.14, 2.13, 3.14, 3.11, 3.1, 3, 10, '2024-05-03 12:03:36'),
(13, 16, 22, 7, 0, 1, 5, 3, 1, 0, 1, 30, 0, ' 4 ', ' 112 ', ' 131 ', ' 105 ', 2.13, 2.15, 3.5, 2.25, 2.19, 2.12, 2.19, 2.13, 2.14, 2.12, 3.3, 3.1, 3.17, 4, 8, '2024-05-03 12:05:29'),
(14, 16, 3, 2, 0, 0, 4, 0, 0, 1, 5, 25, 0, ' 4 ', ' 114 ', ' 140 ', ' 108 ', 2.38, 2.15, 2.1, 2.75, 2.15, 2.09, 2.21, 2.09, 2.12, 2.12, 3.21, 3.09, 3.21, 6, 7, '2024-05-03 12:07:30'),
(15, 16, 20, 3, 1, 1, 3, 0, 1, 1, 0, 27, 1, ' 1 ', ' 143 ', ' 138 ', ' 133 ', 2.17, 2.14, 2.09, 2.08, 2.38, 2.38, 2.09, 2.5, 2.38, 2.13, 3.17, 3.38, 3.08, 4, 12, '2024-05-03 12:08:30');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_17`
--

CREATE TABLE `yd_17` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_17`
--

INSERT INTO `yd_17` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 17, 23, 1, 1, 1, 1, 3, 1, 0, 1, 40, 1, ' 1 ', ' 132 ', ' 122 ', ' 119 ', 2.08, 2.19, 3.5, 2.21, 2.5, 2.11, 2.14, 3.5, 2.17, 2.3, 3.19, 3.75, 3.11, 4, 10, '2024-05-02 09:57:48'),
(2, 17, 23, 1, 1, 1, 1, 3, 1, 0, 1, 40, 1, ' 1 ', ' 132 ', ' 122 ', ' 119 ', 2.08, 2.19, 3.5, 2.21, 2.5, 2.11, 2.14, 3.5, 2.17, 2.3, 3.19, 3.75, 3.11, 4, 10, '2024-05-02 11:52:11'),
(3, 17, 23, 1, 1, 1, 1, 3, 1, 0, 1, 40, 1, ' 1 ', ' 132 ', ' 122 ', ' 119 ', 2.08, 2.19, 3.5, 2.21, 2.5, 2.11, 2.14, 3.5, 2.17, 2.3, 3.19, 3.75, 3.11, 4, 10, '2024-05-02 12:10:43'),
(4, 17, 23, 1, 1, 1, 1, 3, 1, 0, 1, 40, 1, ' 1 ', ' 132 ', ' 122 ', ' 119 ', 2.08, 2.19, 3.5, 2.21, 2.5, 2.11, 2.14, 3.5, 2.17, 2.3, 3.19, 3.75, 3.11, 4, 10, '2024-05-02 12:39:39'),
(5, 17, 23, 1, 1, 1, 1, 3, 1, 0, 1, 40, 1, ' 1 ', ' 132 ', ' 122 ', ' 119 ', 2.08, 2.19, 3.5, 2.21, 2.5, 2.11, 2.14, 3.5, 2.17, 2.3, 3.19, 3.75, 3.11, 4, 10, '2024-05-03 11:37:17'),
(6, 17, 23, 1, 1, 1, 1, 3, 1, 0, 1, 40, 1, ' 1 ', ' 132 ', ' 122 ', ' 119 ', 2.08, 2.19, 3.5, 2.21, 2.5, 2.11, 2.14, 3.5, 2.17, 2.3, 3.19, 3.75, 3.11, 4, 10, '2024-05-03 11:53:31'),
(7, 17, 24, 3, 1, 0, 5, 4, 1, 0, 4, 34, 0, ' 0 ', ' 138 ', ' 115 ', ' 108 ', 2.12, 2.15, 2.08, 2.11, 2.75, 2.17, 2.19, 2.3, 2.25, 2.09, 3.5, 3.14, 3.3, 4, 12, '2024-05-03 11:59:19'),
(8, 17, 2, 6, 0, 1, 5, 0, 0, 1, 1, 45, 0, ' 1 ', ' 128 ', ' 115 ', ' 144 ', 2.21, 2.09, 2.21, 2.21, 2.1, 2.5, 2.19, 2.09, 2.38, 2.25, 3.38, 4.5, 3.08, 6, 10, '2024-05-03 12:00:55'),
(9, 17, 18, 7, 0, 1, 2, 4, 1, 0, 2, 38, 1, ' 2 ', ' 137 ', ' 106 ', ' 121 ', 3.5, 2.21, 2.11, 2.13, 2.11, 3.5, 2.21, 2.14, 2.08, 2.08, 3.08, 3.12, 3.11, 4, 9, '2024-05-03 12:04:19'),
(10, 17, 21, 2, 1, 1, 4, 2, 1, 1, 5, 39, 0, ' 4 ', ' 104 ', ' 112 ', ' 110 ', 2.13, 2.3, 2.1, 2.5, 2.11, 2.11, 2.3, 2.5, 2.13, 2.15, 3.12, 3.09, 3.08, 5, 10, '2024-05-03 12:04:46'),
(11, 17, 24, 6, 0, 0, 0, 4, 1, 0, 2, 45, 1, ' 1 ', ' 123 ', ' 134 ', ' 142 ', 2.11, 2.13, 2.11, 2.09, 2.5, 2.1, 2.15, 2.15, 2.17, 2.09, 3.09, 3.25, 3.1, 7, 10, '2024-05-03 12:08:11');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_18`
--

CREATE TABLE `yd_18` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_18`
--

INSERT INTO `yd_18` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 18, 6, 6, 1, 1, 4, 3, 0, 0, 5, 41, 1, ' 2 ', ' 133 ', ' 103 ', ' 130 ', 2.19, 2.11, 2.38, 2.25, 2.13, 2.75, 2.75, 2.08, 2.14, 2.08, 3.19, 3.09, 3.08, 5, 10, '2024-05-02 09:57:07'),
(2, 18, 24, 5, 1, 1, 0, 0, 1, 0, 3, 31, 1, ' 1 ', ' 129 ', ' 120 ', ' 124 ', 2.12, 2.15, 2.21, 2.11, 2.5, 2.75, 2.09, 2.17, 2.09, 2.12, 3.19, 3.38, 3.75, 7, 12, '2024-05-02 09:57:38'),
(3, 18, 19, 5, 1, 1, 1, 2, 1, 1, 1, 31, 0, ' 0 ', ' 143 ', ' 106 ', ' 143 ', 2.09, 2.1, 3.5, 2.08, 2.25, 2.17, 2.21, 2.13, 2.09, 2.11, 3.19, 3.15, 3.09, 3, 12, '2024-05-02 09:58:41'),
(4, 18, 22, 7, 1, 1, 4, 2, 0, 0, 0, 44, 1, ' 3 ', ' 124 ', ' 108 ', ' 119 ', 2.38, 2.21, 2.08, 2.1, 2.08, 2.25, 2.3, 2.21, 2.75, 3.5, 3.12, 3.38, 3.75, 4, 12, '2024-05-02 09:59:10'),
(5, 18, 6, 6, 1, 1, 4, 3, 0, 0, 5, 41, 1, ' 2 ', ' 133 ', ' 103 ', ' 130 ', 2.19, 2.11, 2.38, 2.25, 2.13, 2.75, 2.75, 2.08, 2.14, 2.08, 3.19, 3.09, 3.08, 5, 10, '2024-05-02 11:51:30'),
(6, 18, 24, 5, 1, 1, 0, 0, 1, 0, 3, 31, 1, ' 1 ', ' 129 ', ' 120 ', ' 124 ', 2.12, 2.15, 2.21, 2.11, 2.5, 2.75, 2.09, 2.17, 2.09, 2.12, 3.19, 3.38, 3.75, 7, 12, '2024-05-02 11:52:00'),
(7, 18, 6, 6, 1, 1, 4, 3, 0, 0, 5, 41, 1, ' 2 ', ' 133 ', ' 103 ', ' 130 ', 2.19, 2.11, 2.38, 2.25, 2.13, 2.75, 2.75, 2.08, 2.14, 2.08, 3.19, 3.09, 3.08, 5, 10, '2024-05-02 12:10:02'),
(8, 18, 24, 5, 1, 1, 0, 0, 1, 0, 3, 31, 1, ' 1 ', ' 129 ', ' 120 ', ' 124 ', 2.12, 2.15, 2.21, 2.11, 2.5, 2.75, 2.09, 2.17, 2.09, 2.12, 3.19, 3.38, 3.75, 7, 12, '2024-05-02 12:10:33'),
(9, 18, 19, 5, 1, 1, 1, 2, 1, 1, 1, 31, 0, ' 0 ', ' 143 ', ' 106 ', ' 143 ', 2.09, 2.1, 3.5, 2.08, 2.25, 2.17, 2.21, 2.13, 2.09, 2.11, 3.19, 3.15, 3.09, 3, 12, '2024-05-02 12:11:37'),
(10, 18, 6, 6, 1, 1, 4, 3, 0, 0, 5, 41, 1, ' 2 ', ' 133 ', ' 103 ', ' 130 ', 2.19, 2.11, 2.38, 2.25, 2.13, 2.75, 2.75, 2.08, 2.14, 2.08, 3.19, 3.09, 3.08, 5, 10, '2024-05-02 12:38:58'),
(11, 18, 24, 5, 1, 1, 0, 0, 1, 0, 3, 31, 1, ' 1 ', ' 129 ', ' 120 ', ' 124 ', 2.12, 2.15, 2.21, 2.11, 2.5, 2.75, 2.09, 2.17, 2.09, 2.12, 3.19, 3.38, 3.75, 7, 12, '2024-05-02 12:39:29'),
(12, 18, 6, 6, 1, 1, 4, 3, 0, 0, 5, 41, 1, ' 2 ', ' 133 ', ' 103 ', ' 130 ', 2.19, 2.11, 2.38, 2.25, 2.13, 2.75, 2.75, 2.08, 2.14, 2.08, 3.19, 3.09, 3.08, 5, 10, '2024-05-03 11:36:52'),
(13, 18, 24, 5, 1, 1, 0, 0, 1, 0, 3, 31, 1, ' 1 ', ' 129 ', ' 120 ', ' 124 ', 2.12, 2.15, 2.21, 2.11, 2.5, 2.75, 2.09, 2.17, 2.09, 2.12, 3.19, 3.38, 3.75, 7, 12, '2024-05-03 11:37:13'),
(14, 18, 19, 5, 1, 1, 1, 2, 1, 1, 1, 31, 0, ' 0 ', ' 143 ', ' 106 ', ' 143 ', 2.09, 2.1, 3.5, 2.08, 2.25, 2.17, 2.21, 2.13, 2.09, 2.11, 3.19, 3.15, 3.09, 3, 12, '2024-05-03 11:37:43'),
(15, 18, 22, 7, 1, 1, 4, 2, 0, 0, 0, 44, 1, ' 3 ', ' 124 ', ' 108 ', ' 119 ', 2.38, 2.21, 2.08, 2.1, 2.08, 2.25, 2.3, 2.21, 2.75, 3.5, 3.12, 3.38, 3.75, 4, 12, '2024-05-03 11:37:50'),
(16, 18, 6, 6, 1, 1, 4, 3, 0, 0, 5, 41, 1, ' 2 ', ' 133 ', ' 103 ', ' 130 ', 2.19, 2.11, 2.38, 2.25, 2.13, 2.75, 2.75, 2.08, 2.14, 2.08, 3.19, 3.09, 3.08, 5, 10, '2024-05-03 11:52:50'),
(17, 18, 24, 5, 1, 1, 0, 0, 1, 0, 3, 31, 1, ' 1 ', ' 129 ', ' 120 ', ' 124 ', 2.12, 2.15, 2.21, 2.11, 2.5, 2.75, 2.09, 2.17, 2.09, 2.12, 3.19, 3.38, 3.75, 7, 12, '2024-05-03 11:53:21'),
(18, 18, 19, 5, 1, 1, 1, 2, 1, 1, 1, 31, 0, ' 0 ', ' 143 ', ' 106 ', ' 143 ', 2.09, 2.1, 3.5, 2.08, 2.25, 2.17, 2.21, 2.13, 2.09, 2.11, 3.19, 3.15, 3.09, 3, 12, '2024-05-03 11:54:25'),
(19, 18, 22, 7, 1, 1, 4, 2, 0, 0, 0, 44, 1, ' 3 ', ' 124 ', ' 108 ', ' 119 ', 2.38, 2.21, 2.08, 2.1, 2.08, 2.25, 2.3, 2.21, 2.75, 3.5, 3.12, 3.38, 3.75, 4, 12, '2024-05-03 11:54:53'),
(20, 18, 8, 9, 1, 1, 4, 0, 1, 0, 0, 48, 0, ' 0 ', ' 118 ', ' 122 ', ' 125 ', 2.11, 2.09, 2.15, 2.08, 2.1, 2.11, 2.12, 2.17, 2.09, 2.12, 3.1, 3.09, 3.11, 5, 11, '2024-05-03 11:57:59'),
(21, 18, 3, 8, 0, 1, 4, 4, 1, 0, 4, 26, 0, ' 3 ', ' 129 ', ' 132 ', ' 109 ', 2.5, 2.14, 2.14, 2.25, 2.75, 2.15, 2.38, 2.09, 2.15, 2.09, 3.38, 3.09, 3.15, 5, 9, '2024-05-03 12:01:14'),
(22, 18, 1, 0, 0, 1, 2, 3, 0, 1, 5, 47, 0, ' 3 ', ' 114 ', ' 148 ', ' 148 ', 2.21, 2.12, 2.38, 2.3, 2.38, 2.11, 2.21, 2.08, 2.19, 2.12, 3.12, 3.11, 3.21, 5, 11, '2024-05-03 12:01:20'),
(23, 18, 20, 4, 0, 1, 3, 2, 1, 0, 1, 31, 0, ' 3 ', ' 106 ', ' 146 ', ' 134 ', 2.12, 2.75, 2.09, 2.17, 2.3, 2.19, 2.08, 2.15, 2.14, 2.25, 3.15, 3.14, 3.19, 6, 10, '2024-05-03 12:02:20'),
(24, 18, 17, 7, 1, 0, 2, 1, 1, 0, 5, 28, 0, ' 2 ', ' 120 ', ' 145 ', ' 143 ', 2.21, 2.75, 2.5, 2.08, 2.14, 2.08, 2.09, 2.08, 2.09, 2.5, 3.75, 3.25, 4.5, 5, 7, '2024-05-03 12:04:40'),
(25, 18, 24, 2, 1, 1, 4, 3, 0, 1, 0, 36, 1, ' 0 ', ' 127 ', ' 109 ', ' 119 ', 2.12, 2.21, 2.17, 2.09, 3.5, 2.12, 2.09, 2.21, 2.38, 2.15, 3.3, 3.19, 3.1, 6, 9, '2024-05-03 12:06:06'),
(26, 18, 5, 9, 0, 0, 3, 2, 0, 1, 3, 48, 0, ' 3 ', ' 132 ', ' 106 ', ' 133 ', 2.25, 2.15, 2.25, 2.25, 2.13, 2.5, 2.21, 2.17, 2.3, 2.09, 3.21, 3.25, 3.21, 3, 8, '2024-05-03 12:06:39'),
(27, 18, 23, 4, 1, 1, 1, 2, 0, 0, 1, 46, 0, ' 3 ', ' 102 ', ' 114 ', ' 135 ', 2.3, 2.13, 2.12, 2.12, 2.19, 3.5, 3.5, 2.25, 2.19, 2.09, 3.12, 3.19, 3.08, 5, 7, '2024-05-03 12:06:55');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_19`
--

CREATE TABLE `yd_19` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_19`
--

INSERT INTO `yd_19` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 19, 14, 3, 0, 1, 0, 1, 0, 0, 2, 43, 1, ' 3 ', ' 111 ', ' 116 ', ' 143 ', 2.09, 2.08, 2.11, 2.08, 2.17, 2.13, 2.17, 2.08, 2.25, 2.11, 3.75, 3.09, 3.08, 4, 7, '2024-05-02 09:58:04'),
(2, 19, 14, 3, 0, 1, 0, 1, 0, 0, 2, 43, 1, ' 3 ', ' 111 ', ' 116 ', ' 143 ', 2.09, 2.08, 2.11, 2.08, 2.17, 2.13, 2.17, 2.08, 2.25, 2.11, 3.75, 3.09, 3.08, 4, 7, '2024-05-02 11:52:27'),
(3, 19, 14, 3, 0, 1, 0, 1, 0, 0, 2, 43, 1, ' 3 ', ' 111 ', ' 116 ', ' 143 ', 2.09, 2.08, 2.11, 2.08, 2.17, 2.13, 2.17, 2.08, 2.25, 2.11, 3.75, 3.09, 3.08, 4, 7, '2024-05-02 12:11:00'),
(4, 19, 14, 3, 0, 1, 0, 1, 0, 0, 2, 43, 1, ' 3 ', ' 111 ', ' 116 ', ' 143 ', 2.09, 2.08, 2.11, 2.08, 2.17, 2.13, 2.17, 2.08, 2.25, 2.11, 3.75, 3.09, 3.08, 4, 7, '2024-05-03 11:37:24'),
(5, 19, 14, 3, 0, 1, 0, 1, 0, 0, 2, 43, 1, ' 3 ', ' 111 ', ' 116 ', ' 143 ', 2.09, 2.08, 2.11, 2.08, 2.17, 2.13, 2.17, 2.08, 2.25, 2.11, 3.75, 3.09, 3.08, 4, 7, '2024-05-03 11:53:48'),
(6, 19, 19, 8, 0, 1, 2, 0, 1, 1, 2, 25, 0, ' 2 ', ' 114 ', ' 118 ', ' 100 ', 2.3, 2.19, 2.25, 2.25, 2.09, 2.17, 2.3, 2.13, 2.12, 2.08, 3.25, 3.19, 4.5, 3, 12, '2024-05-03 11:56:01'),
(7, 19, 22, 0, 1, 1, 4, 5, 0, 1, 2, 35, 0, ' 1 ', ' 112 ', ' 133 ', ' 120 ', 2.12, 2.15, 2.15, 2.1, 2.19, 2.17, 3.5, 2.11, 2.14, 2.08, 3.08, 3.12, 3.12, 6, 11, '2024-05-03 11:59:56'),
(8, 19, 24, 5, 1, 0, 4, 0, 0, 1, 1, 40, 0, ' 2 ', ' 126 ', ' 137 ', ' 105 ', 2.19, 2.13, 2.08, 2.09, 2.21, 2.14, 2.38, 2.38, 2.13, 2.08, 3.08, 3.11, 3.5, 3, 10, '2024-05-03 12:03:07'),
(9, 19, 19, 0, 1, 0, 5, 2, 1, 0, 0, 41, 1, ' 3 ', ' 117 ', ' 121 ', ' 108 ', 2.14, 2.13, 2.38, 2.12, 2.25, 2.38, 2.3, 3.5, 2.13, 3.5, 3.75, 3.21, 3.11, 3, 7, '2024-05-03 12:04:56'),
(10, 19, 15, 5, 0, 1, 0, 3, 0, 1, 5, 33, 1, ' 1 ', ' 142 ', ' 138 ', ' 138 ', 2.1, 2.17, 2.21, 2.3, 2.75, 2.75, 2.75, 2.11, 3.5, 2.11, 3.13, 3.75, 3.15, 3, 10, '2024-05-03 12:05:56');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_20`
--

CREATE TABLE `yd_20` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_20`
--

INSERT INTO `yd_20` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 20, 13, 5, 1, 0, 4, 2, 0, 1, 3, 27, 1, ' 0 ', ' 126 ', ' 114 ', ' 110 ', 2.1, 2.15, 2.17, 2.75, 2.09, 2.5, 2.21, 2.09, 2.17, 3.5, 3.5, 3.12, 3.19, 6, 11, '2024-05-03 11:37:58'),
(2, 20, 13, 5, 1, 0, 4, 2, 0, 1, 3, 27, 1, ' 0 ', ' 126 ', ' 114 ', ' 110 ', 2.1, 2.15, 2.17, 2.75, 2.09, 2.5, 2.21, 2.09, 2.17, 3.5, 3.5, 3.12, 3.19, 6, 11, '2024-05-03 11:55:20'),
(3, 20, 24, 9, 0, 1, 2, 2, 0, 0, 1, 39, 1, ' 4 ', ' 146 ', ' 136 ', ' 127 ', 2.75, 2.1, 2.19, 2.08, 2.5, 2.5, 2.09, 2.11, 2.38, 2.3, 3.13, 3.5, 4.5, 5, 10, '2024-05-03 11:57:34'),
(4, 20, 17, 4, 1, 1, 0, 5, 1, 0, 1, 35, 1, ' 3 ', ' 103 ', ' 119 ', ' 113 ', 2.1, 2.08, 2.08, 2.08, 2.14, 2.25, 2.12, 2.14, 2.08, 2.11, 3.15, 3.09, 3.08, 7, 10, '2024-05-03 11:58:01'),
(5, 20, 24, 3, 0, 0, 3, 5, 1, 1, 2, 29, 1, ' 2 ', ' 116 ', ' 127 ', ' 144 ', 2.21, 2.21, 2.09, 2.08, 3.5, 2.17, 2.12, 2.75, 2.15, 2.09, 3.12, 3.09, 3.09, 5, 12, '2024-05-03 11:59:00'),
(6, 20, 15, 9, 0, 1, 1, 2, 1, 0, 1, 33, 0, ' 0 ', ' 138 ', ' 128 ', ' 119 ', 2.08, 2.14, 2.38, 2.5, 2.17, 2.17, 2.75, 2.12, 2.14, 2.14, 3.75, 3.09, 3.75, 7, 7, '2024-05-03 12:02:01'),
(7, 20, 11, 5, 0, 1, 3, 5, 1, 1, 1, 31, 1, ' 2 ', ' 141 ', ' 107 ', ' 112 ', 2.25, 3.5, 2.17, 2.19, 2.3, 2.17, 2.17, 2.08, 2.13, 2.13, 3.3, 3.08, 3.17, 4, 8, '2024-05-03 12:02:24'),
(8, 20, 3, 8, 0, 1, 0, 0, 0, 0, 3, 26, 1, ' 1 ', ' 147 ', ' 141 ', ' 116 ', 2.5, 2.08, 2.25, 2.21, 2.19, 2.5, 2.08, 2.21, 2.21, 2.38, 3.17, 3.13, 3.17, 7, 12, '2024-05-03 12:03:54'),
(9, 20, 5, 2, 0, 0, 5, 3, 1, 1, 2, 26, 1, ' 3 ', ' 131 ', ' 123 ', ' 104 ', 2.11, 2.09, 2.5, 2.12, 2.5, 2.13, 2.75, 2.5, 2.5, 2.75, 3.21, 3.25, 3.3, 7, 12, '2024-05-03 12:04:48'),
(10, 20, 3, 1, 1, 1, 3, 4, 0, 1, 5, 32, 1, ' 0 ', ' 123 ', ' 115 ', ' 124 ', 2.5, 2.15, 2.14, 2.09, 2.11, 2.15, 2.75, 2.19, 2.09, 2.11, 3.09, 3.25, 3.14, 3, 10, '2024-05-03 12:08:09'),
(11, 20, 19, 5, 1, 1, 4, 1, 0, 0, 3, 42, 0, ' 4 ', ' 118 ', ' 143 ', ' 101 ', 3.5, 2.08, 2.1, 2.09, 2.21, 2.08, 2.08, 2.11, 2.25, 2.38, 3.09, 3.17, 3.14, 3, 11, '2024-05-03 12:08:42');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_21`
--

CREATE TABLE `yd_21` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_21`
--

INSERT INTO `yd_21` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 21, 9, 7, 0, 1, 2, 4, 1, 0, 5, 48, 1, ' 1 ', ' 102 ', ' 128 ', ' 137 ', 2.19, 2.25, 2.3, 2.25, 2.21, 2.15, 2.12, 2.08, 2.13, 2.21, 3.11, 3.14, 3.13, 7, 9, '2024-05-03 11:58:17'),
(2, 21, 6, 1, 1, 1, 3, 1, 0, 1, 2, 44, 1, ' 4 ', ' 120 ', ' 100 ', ' 120 ', 2.25, 2.25, 2.5, 2.5, 2.09, 2.5, 2.38, 2.75, 2.09, 2.38, 3.09, 3.38, 4.5, 7, 12, '2024-05-03 12:00:08'),
(3, 21, 15, 7, 1, 0, 1, 5, 0, 0, 1, 37, 0, ' 0 ', ' 120 ', ' 104 ', ' 102 ', 2.08, 2.08, 2.15, 2.3, 2.25, 2.38, 2.08, 2.11, 2.08, 2.38, 3.19, 3.5, 3.13, 3, 8, '2024-05-03 12:01:26'),
(4, 21, 9, 1, 0, 0, 3, 2, 1, 1, 3, 42, 1, ' 0 ', ' 139 ', ' 149 ', ' 104 ', 2.11, 2.12, 2.3, 2.09, 2.1, 2.19, 2.17, 2.38, 2.5, 2.3, 3.08, 3.12, 4.5, 3, 10, '2024-05-03 12:01:43'),
(5, 21, 11, 3, 0, 1, 2, 1, 1, 1, 2, 35, 0, ' 1 ', ' 118 ', ' 134 ', ' 148 ', 3.5, 2.38, 2.11, 2.08, 2.14, 2.09, 2.17, 2.3, 2.12, 2.14, 3.09, 3.15, 3.08, 3, 7, '2024-05-03 12:04:31'),
(6, 21, 11, 5, 0, 1, 1, 0, 0, 1, 4, 25, 0, ' 1 ', ' 108 ', ' 127 ', ' 130 ', 2.12, 2.19, 2.09, 2.13, 2.14, 2.08, 2.12, 2.11, 2.08, 2.5, 3.15, 3.17, 3.11, 7, 9, '2024-05-03 12:05:15'),
(7, 21, 11, 7, 1, 0, 3, 3, 1, 0, 5, 38, 1, ' 3 ', ' 137 ', ' 103 ', ' 121 ', 2.38, 2.12, 2.5, 2.1, 2.08, 2.38, 2.15, 2.21, 2.75, 2.38, 4.5, 3.75, 3.38, 7, 12, '2024-05-03 12:08:01');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_22`
--

CREATE TABLE `yd_22` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_22`
--

INSERT INTO `yd_22` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 22, 14, 9, 0, 1, 1, 3, 0, 0, 3, 25, 0, ' 3 ', ' 119 ', ' 105 ', ' 143 ', 2.21, 2.1, 2.12, 2.08, 2.12, 2.5, 2.17, 2.17, 2.17, 2.09, 3.21, 3.12, 3.25, 7, 9, '2024-05-02 09:56:24'),
(2, 22, 10, 8, 1, 1, 1, 5, 0, 1, 3, 25, 0, ' 0 ', ' 139 ', ' 112 ', ' 104 ', 2.25, 2.11, 2.09, 2.15, 2.09, 2.15, 2.09, 2.19, 2.21, 2.12, 3.09, 3.15, 3.75, 6, 12, '2024-05-02 09:56:28'),
(3, 22, 21, 9, 1, 1, 3, 2, 0, 1, 2, 35, 0, ' 3 ', ' 142 ', ' 138 ', ' 132 ', 2.14, 2.3, 2.19, 2.3, 2.3, 2.75, 2.09, 2.5, 2.08, 2.08, 3.13, 3.25, 3.19, 7, 11, '2024-05-02 09:56:30'),
(4, 22, 0, 3, 1, 1, 2, 3, 1, 0, 1, 46, 1, ' 1 ', ' 106 ', ' 130 ', ' 131 ', 2.08, 3.5, 2.3, 2.09, 2.75, 2.3, 3.5, 2.15, 2.13, 2.12, 3.17, 3.1, 3.09, 6, 10, '2024-05-02 09:57:29'),
(5, 22, 19, 9, 1, 1, 5, 0, 0, 1, 3, 37, 1, ' 4 ', ' 124 ', ' 115 ', ' 116 ', 2.21, 2.21, 2.1, 2.19, 2.19, 2.75, 2.21, 2.09, 3.5, 2.13, 3.12, 3.08, 3.75, 4, 9, '2024-05-02 09:57:54'),
(6, 22, 14, 9, 0, 1, 1, 3, 0, 0, 3, 25, 0, ' 3 ', ' 119 ', ' 105 ', ' 143 ', 2.21, 2.1, 2.12, 2.08, 2.12, 2.5, 2.17, 2.17, 2.17, 2.09, 3.21, 3.12, 3.25, 7, 9, '2024-05-02 10:11:57'),
(7, 22, 10, 8, 1, 1, 1, 5, 0, 1, 3, 25, 0, ' 0 ', ' 139 ', ' 112 ', ' 104 ', 2.25, 2.11, 2.09, 2.15, 2.09, 2.15, 2.09, 2.19, 2.21, 2.12, 3.09, 3.15, 3.75, 6, 12, '2024-05-02 10:12:01'),
(8, 22, 21, 9, 1, 1, 3, 2, 0, 1, 2, 35, 0, ' 3 ', ' 142 ', ' 138 ', ' 132 ', 2.14, 2.3, 2.19, 2.3, 2.3, 2.75, 2.09, 2.5, 2.08, 2.08, 3.13, 3.25, 3.19, 7, 11, '2024-05-02 10:12:03'),
(9, 22, 14, 9, 0, 1, 1, 3, 0, 0, 3, 25, 0, ' 3 ', ' 119 ', ' 105 ', ' 143 ', 2.21, 2.1, 2.12, 2.08, 2.12, 2.5, 2.17, 2.17, 2.17, 2.09, 3.21, 3.12, 3.25, 7, 9, '2024-05-02 10:23:51'),
(10, 22, 14, 9, 0, 1, 1, 3, 0, 0, 3, 25, 0, ' 3 ', ' 119 ', ' 105 ', ' 143 ', 2.21, 2.1, 2.12, 2.08, 2.12, 2.5, 2.17, 2.17, 2.17, 2.09, 3.21, 3.12, 3.25, 7, 9, '2024-05-02 10:26:43'),
(11, 22, 14, 9, 0, 1, 1, 3, 0, 0, 3, 25, 0, ' 3 ', ' 119 ', ' 105 ', ' 143 ', 2.21, 2.1, 2.12, 2.08, 2.12, 2.5, 2.17, 2.17, 2.17, 2.09, 3.21, 3.12, 3.25, 7, 9, '2024-05-02 10:28:58'),
(12, 22, 10, 8, 1, 1, 1, 5, 0, 1, 3, 25, 0, ' 0 ', ' 139 ', ' 112 ', ' 104 ', 2.25, 2.11, 2.09, 2.15, 2.09, 2.15, 2.09, 2.19, 2.21, 2.12, 3.09, 3.15, 3.75, 6, 12, '2024-05-02 10:29:02'),
(13, 22, 21, 9, 1, 1, 3, 2, 0, 1, 2, 35, 0, ' 3 ', ' 142 ', ' 138 ', ' 132 ', 2.14, 2.3, 2.19, 2.3, 2.3, 2.75, 2.09, 2.5, 2.08, 2.08, 3.13, 3.25, 3.19, 7, 11, '2024-05-02 10:29:04'),
(14, 22, 14, 9, 0, 1, 1, 3, 0, 0, 3, 25, 0, ' 3 ', ' 119 ', ' 105 ', ' 143 ', 2.21, 2.1, 2.12, 2.08, 2.12, 2.5, 2.17, 2.17, 2.17, 2.09, 3.21, 3.12, 3.25, 7, 9, '2024-05-02 11:50:46'),
(15, 22, 10, 8, 1, 1, 1, 5, 0, 1, 3, 25, 0, ' 0 ', ' 139 ', ' 112 ', ' 104 ', 2.25, 2.11, 2.09, 2.15, 2.09, 2.15, 2.09, 2.19, 2.21, 2.12, 3.09, 3.15, 3.75, 6, 12, '2024-05-02 11:50:51'),
(16, 22, 21, 9, 1, 1, 3, 2, 0, 1, 2, 35, 0, ' 3 ', ' 142 ', ' 138 ', ' 132 ', 2.14, 2.3, 2.19, 2.3, 2.3, 2.75, 2.09, 2.5, 2.08, 2.08, 3.13, 3.25, 3.19, 7, 11, '2024-05-02 11:50:53'),
(17, 22, 0, 3, 1, 1, 2, 3, 1, 0, 1, 46, 1, ' 1 ', ' 106 ', ' 130 ', ' 131 ', 2.08, 3.5, 2.3, 2.09, 2.75, 2.3, 3.5, 2.15, 2.13, 2.12, 3.17, 3.1, 3.09, 6, 10, '2024-05-02 11:51:52'),
(18, 22, 19, 9, 1, 1, 5, 0, 0, 1, 3, 37, 1, ' 4 ', ' 124 ', ' 115 ', ' 116 ', 2.21, 2.21, 2.1, 2.19, 2.19, 2.75, 2.21, 2.09, 3.5, 2.13, 3.12, 3.08, 3.75, 4, 9, '2024-05-02 11:52:17'),
(19, 22, 14, 9, 0, 1, 1, 3, 0, 0, 3, 25, 0, ' 3 ', ' 119 ', ' 105 ', ' 143 ', 2.21, 2.1, 2.12, 2.08, 2.12, 2.5, 2.17, 2.17, 2.17, 2.09, 3.21, 3.12, 3.25, 7, 9, '2024-05-02 12:09:19'),
(20, 22, 10, 8, 1, 1, 1, 5, 0, 1, 3, 25, 0, ' 0 ', ' 139 ', ' 112 ', ' 104 ', 2.25, 2.11, 2.09, 2.15, 2.09, 2.15, 2.09, 2.19, 2.21, 2.12, 3.09, 3.15, 3.75, 6, 12, '2024-05-02 12:09:23'),
(21, 22, 21, 9, 1, 1, 3, 2, 0, 1, 2, 35, 0, ' 3 ', ' 142 ', ' 138 ', ' 132 ', 2.14, 2.3, 2.19, 2.3, 2.3, 2.75, 2.09, 2.5, 2.08, 2.08, 3.13, 3.25, 3.19, 7, 11, '2024-05-02 12:09:25'),
(22, 22, 0, 3, 1, 1, 2, 3, 1, 0, 1, 46, 1, ' 1 ', ' 106 ', ' 130 ', ' 131 ', 2.08, 3.5, 2.3, 2.09, 2.75, 2.3, 3.5, 2.15, 2.13, 2.12, 3.17, 3.1, 3.09, 6, 10, '2024-05-02 12:10:25'),
(23, 22, 19, 9, 1, 1, 5, 0, 0, 1, 3, 37, 1, ' 4 ', ' 124 ', ' 115 ', ' 116 ', 2.21, 2.21, 2.1, 2.19, 2.19, 2.75, 2.21, 2.09, 3.5, 2.13, 3.12, 3.08, 3.75, 4, 9, '2024-05-02 12:10:49'),
(24, 22, 14, 9, 0, 1, 1, 3, 0, 0, 3, 25, 0, ' 3 ', ' 119 ', ' 105 ', ' 143 ', 2.21, 2.1, 2.12, 2.08, 2.12, 2.5, 2.17, 2.17, 2.17, 2.09, 3.21, 3.12, 3.25, 7, 9, '2024-05-02 12:38:15'),
(25, 22, 10, 8, 1, 1, 1, 5, 0, 1, 3, 25, 0, ' 0 ', ' 139 ', ' 112 ', ' 104 ', 2.25, 2.11, 2.09, 2.15, 2.09, 2.15, 2.09, 2.19, 2.21, 2.12, 3.09, 3.15, 3.75, 6, 12, '2024-05-02 12:38:19'),
(26, 22, 21, 9, 1, 1, 3, 2, 0, 1, 2, 35, 0, ' 3 ', ' 142 ', ' 138 ', ' 132 ', 2.14, 2.3, 2.19, 2.3, 2.3, 2.75, 2.09, 2.5, 2.08, 2.08, 3.13, 3.25, 3.19, 7, 11, '2024-05-02 12:38:21'),
(27, 22, 0, 3, 1, 1, 2, 3, 1, 0, 1, 46, 1, ' 1 ', ' 106 ', ' 130 ', ' 131 ', 2.08, 3.5, 2.3, 2.09, 2.75, 2.3, 3.5, 2.15, 2.13, 2.12, 3.17, 3.1, 3.09, 6, 10, '2024-05-02 12:39:21'),
(28, 22, 14, 9, 0, 1, 1, 3, 0, 0, 3, 25, 0, ' 3 ', ' 119 ', ' 105 ', ' 143 ', 2.21, 2.1, 2.12, 2.08, 2.12, 2.5, 2.17, 2.17, 2.17, 2.09, 3.21, 3.12, 3.25, 7, 9, '2024-05-03 11:34:43'),
(29, 22, 10, 8, 1, 1, 1, 5, 0, 1, 3, 25, 0, ' 0 ', ' 139 ', ' 112 ', ' 104 ', 2.25, 2.11, 2.09, 2.15, 2.09, 2.15, 2.09, 2.19, 2.21, 2.12, 3.09, 3.15, 3.75, 6, 12, '2024-05-03 11:34:49'),
(30, 22, 21, 9, 1, 1, 3, 2, 0, 1, 2, 35, 0, ' 3 ', ' 142 ', ' 138 ', ' 132 ', 2.14, 2.3, 2.19, 2.3, 2.3, 2.75, 2.09, 2.5, 2.08, 2.08, 3.13, 3.25, 3.19, 7, 11, '2024-05-03 11:34:53'),
(31, 22, 0, 3, 1, 1, 2, 3, 1, 0, 1, 46, 1, ' 1 ', ' 106 ', ' 130 ', ' 131 ', 2.08, 3.5, 2.3, 2.09, 2.75, 2.3, 3.5, 2.15, 2.13, 2.12, 3.17, 3.1, 3.09, 6, 10, '2024-05-03 11:37:09'),
(32, 22, 19, 9, 1, 1, 5, 0, 0, 1, 3, 37, 1, ' 4 ', ' 124 ', ' 115 ', ' 116 ', 2.21, 2.21, 2.1, 2.19, 2.19, 2.75, 2.21, 2.09, 3.5, 2.13, 3.12, 3.08, 3.75, 4, 9, '2024-05-03 11:37:18'),
(33, 22, 14, 9, 0, 1, 1, 3, 0, 0, 3, 25, 0, ' 3 ', ' 119 ', ' 105 ', ' 143 ', 2.21, 2.1, 2.12, 2.08, 2.12, 2.5, 2.17, 2.17, 2.17, 2.09, 3.21, 3.12, 3.25, 7, 9, '2024-05-03 11:52:07'),
(34, 22, 10, 8, 1, 1, 1, 5, 0, 1, 3, 25, 0, ' 0 ', ' 139 ', ' 112 ', ' 104 ', 2.25, 2.11, 2.09, 2.15, 2.09, 2.15, 2.09, 2.19, 2.21, 2.12, 3.09, 3.15, 3.75, 6, 12, '2024-05-03 11:52:11'),
(35, 22, 21, 9, 1, 1, 3, 2, 0, 1, 2, 35, 0, ' 3 ', ' 142 ', ' 138 ', ' 132 ', 2.14, 2.3, 2.19, 2.3, 2.3, 2.75, 2.09, 2.5, 2.08, 2.08, 3.13, 3.25, 3.19, 7, 11, '2024-05-03 11:52:13'),
(36, 22, 0, 3, 1, 1, 2, 3, 1, 0, 1, 46, 1, ' 1 ', ' 106 ', ' 130 ', ' 131 ', 2.08, 3.5, 2.3, 2.09, 2.75, 2.3, 3.5, 2.15, 2.13, 2.12, 3.17, 3.1, 3.09, 6, 10, '2024-05-03 11:53:13'),
(37, 22, 19, 9, 1, 1, 5, 0, 0, 1, 3, 37, 1, ' 4 ', ' 124 ', ' 115 ', ' 116 ', 2.21, 2.21, 2.1, 2.19, 2.19, 2.75, 2.21, 2.09, 3.5, 2.13, 3.12, 3.08, 3.75, 4, 9, '2024-05-03 11:53:37'),
(38, 22, 24, 0, 0, 0, 4, 0, 1, 0, 2, 42, 0, ' 4 ', ' 115 ', ' 100 ', ' 115 ', 2.12, 3.5, 2.11, 2.08, 2.09, 2.17, 2.09, 2.11, 2.75, 2.14, 3.19, 3.09, 3.1, 6, 9, '2024-05-03 11:59:58'),
(39, 22, 3, 0, 0, 1, 2, 3, 1, 1, 2, 47, 1, ' 4 ', ' 117 ', ' 129 ', ' 111 ', 2.3, 2.25, 2.17, 2.38, 2.09, 2.1, 2.1, 2.21, 2.08, 2.09, 3.15, 3.21, 3.08, 6, 11, '2024-05-03 12:01:08'),
(40, 22, 10, 3, 0, 0, 5, 1, 0, 1, 1, 46, 1, ' 2 ', ' 107 ', ' 114 ', ' 132 ', 2.25, 2.5, 2.08, 2.13, 2.75, 2.75, 2.14, 2.08, 2.14, 2.13, 3.19, 3.19, 3.19, 7, 9, '2024-05-03 12:02:44'),
(41, 22, 8, 9, 0, 0, 2, 4, 0, 1, 4, 48, 1, ' 1 ', ' 127 ', ' 138 ', ' 128 ', 3.5, 2.17, 2.17, 2.09, 2.08, 2.25, 2.1, 2.13, 2.5, 2.19, 3.08, 3.38, 3.19, 7, 10, '2024-05-03 12:08:05');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_23`
--

CREATE TABLE `yd_23` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_23`
--

INSERT INTO `yd_23` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 23, 4, 2, 0, 1, 4, 5, 1, 0, 1, 33, 0, ' 0 ', ' 123 ', ' 100 ', ' 121 ', 2.25, 2.15, 2.11, 2.38, 2.17, 2.21, 2.15, 2.11, 2.08, 2.75, 3.08, 3.3, 3.15, 3, 12, '2024-05-02 09:56:09'),
(2, 23, 2, 8, 1, 0, 4, 5, 0, 1, 0, 48, 0, ' 4 ', ' 105 ', ' 124 ', ' 122 ', 2.11, 2.15, 2.14, 2.09, 2.21, 2.09, 3.5, 2.14, 2.15, 2.13, 3.15, 3.19, 3.25, 6, 8, '2024-05-02 09:57:31'),
(3, 23, 4, 2, 0, 1, 4, 5, 1, 0, 1, 33, 0, ' 0 ', ' 123 ', ' 100 ', ' 121 ', 2.25, 2.15, 2.11, 2.38, 2.17, 2.21, 2.15, 2.11, 2.08, 2.75, 3.08, 3.3, 3.15, 3, 12, '2024-05-02 10:09:04'),
(4, 23, 4, 2, 0, 1, 4, 5, 1, 0, 1, 33, 0, ' 0 ', ' 123 ', ' 100 ', ' 121 ', 2.25, 2.15, 2.11, 2.38, 2.17, 2.21, 2.15, 2.11, 2.08, 2.75, 3.08, 3.3, 3.15, 3, 12, '2024-05-02 10:11:42'),
(5, 23, 4, 2, 0, 1, 4, 5, 1, 0, 1, 33, 0, ' 0 ', ' 123 ', ' 100 ', ' 121 ', 2.25, 2.15, 2.11, 2.38, 2.17, 2.21, 2.15, 2.11, 2.08, 2.75, 3.08, 3.3, 3.15, 3, 12, '2024-05-02 10:13:27'),
(6, 23, 4, 2, 0, 1, 4, 5, 1, 0, 1, 33, 0, ' 0 ', ' 123 ', ' 100 ', ' 121 ', 2.25, 2.15, 2.11, 2.38, 2.17, 2.21, 2.15, 2.11, 2.08, 2.75, 3.08, 3.3, 3.15, 3, 12, '2024-05-02 10:23:37'),
(7, 23, 4, 2, 0, 1, 4, 5, 1, 0, 1, 33, 0, ' 0 ', ' 123 ', ' 100 ', ' 121 ', 2.25, 2.15, 2.11, 2.38, 2.17, 2.21, 2.15, 2.11, 2.08, 2.75, 3.08, 3.3, 3.15, 3, 12, '2024-05-02 10:26:29'),
(8, 23, 4, 2, 0, 1, 4, 5, 1, 0, 1, 33, 0, ' 0 ', ' 123 ', ' 100 ', ' 121 ', 2.25, 2.15, 2.11, 2.38, 2.17, 2.21, 2.15, 2.11, 2.08, 2.75, 3.08, 3.3, 3.15, 3, 12, '2024-05-02 10:28:44'),
(9, 23, 4, 2, 0, 1, 4, 5, 1, 0, 1, 33, 0, ' 0 ', ' 123 ', ' 100 ', ' 121 ', 2.25, 2.15, 2.11, 2.38, 2.17, 2.21, 2.15, 2.11, 2.08, 2.75, 3.08, 3.3, 3.15, 3, 12, '2024-05-02 11:50:32'),
(10, 23, 2, 8, 1, 0, 4, 5, 0, 1, 0, 48, 0, ' 4 ', ' 105 ', ' 124 ', ' 122 ', 2.11, 2.15, 2.14, 2.09, 2.21, 2.09, 3.5, 2.14, 2.15, 2.13, 3.15, 3.19, 3.25, 6, 8, '2024-05-02 11:51:54'),
(11, 23, 4, 2, 0, 1, 4, 5, 1, 0, 1, 33, 0, ' 0 ', ' 123 ', ' 100 ', ' 121 ', 2.25, 2.15, 2.11, 2.38, 2.17, 2.21, 2.15, 2.11, 2.08, 2.75, 3.08, 3.3, 3.15, 3, 12, '2024-05-02 12:01:11'),
(12, 23, 4, 2, 0, 1, 4, 5, 1, 0, 1, 33, 0, ' 0 ', ' 123 ', ' 100 ', ' 121 ', 2.25, 2.15, 2.11, 2.38, 2.17, 2.21, 2.15, 2.11, 2.08, 2.75, 3.08, 3.3, 3.15, 3, 12, '2024-05-02 12:09:04'),
(13, 23, 2, 8, 1, 0, 4, 5, 0, 1, 0, 48, 0, ' 4 ', ' 105 ', ' 124 ', ' 122 ', 2.11, 2.15, 2.14, 2.09, 2.21, 2.09, 3.5, 2.14, 2.15, 2.13, 3.15, 3.19, 3.25, 6, 8, '2024-05-02 12:10:27'),
(14, 23, 4, 2, 0, 1, 4, 5, 1, 0, 1, 33, 0, ' 0 ', ' 123 ', ' 100 ', ' 121 ', 2.25, 2.15, 2.11, 2.38, 2.17, 2.21, 2.15, 2.11, 2.08, 2.75, 3.08, 3.3, 3.15, 3, 12, '2024-05-02 12:38:00'),
(15, 23, 2, 8, 1, 0, 4, 5, 0, 1, 0, 48, 0, ' 4 ', ' 105 ', ' 124 ', ' 122 ', 2.11, 2.15, 2.14, 2.09, 2.21, 2.09, 3.5, 2.14, 2.15, 2.13, 3.15, 3.19, 3.25, 6, 8, '2024-05-02 12:39:23'),
(16, 23, 4, 2, 0, 1, 4, 5, 1, 0, 1, 33, 0, ' 0 ', ' 123 ', ' 100 ', ' 121 ', 2.25, 2.15, 2.11, 2.38, 2.17, 2.21, 2.15, 2.11, 2.08, 2.75, 3.08, 3.3, 3.15, 3, 12, '2024-05-03 11:34:28'),
(17, 23, 2, 8, 1, 0, 4, 5, 0, 1, 0, 48, 0, ' 4 ', ' 105 ', ' 124 ', ' 122 ', 2.11, 2.15, 2.14, 2.09, 2.21, 2.09, 3.5, 2.14, 2.15, 2.13, 3.15, 3.19, 3.25, 6, 8, '2024-05-03 11:37:10'),
(18, 23, 4, 2, 0, 1, 4, 5, 1, 0, 1, 33, 0, ' 0 ', ' 123 ', ' 100 ', ' 121 ', 2.25, 2.15, 2.11, 2.38, 2.17, 2.21, 2.15, 2.11, 2.08, 2.75, 3.08, 3.3, 3.15, 3, 12, '2024-05-03 11:51:52'),
(19, 23, 2, 8, 1, 0, 4, 5, 0, 1, 0, 48, 0, ' 4 ', ' 105 ', ' 124 ', ' 122 ', 2.11, 2.15, 2.14, 2.09, 2.21, 2.09, 3.5, 2.14, 2.15, 2.13, 3.15, 3.19, 3.25, 6, 8, '2024-05-03 11:53:15'),
(20, 23, 11, 7, 0, 0, 3, 0, 0, 1, 5, 34, 0, ' 3 ', ' 137 ', ' 115 ', ' 139 ', 2.12, 2.21, 2.1, 2.1, 2.5, 2.21, 2.14, 2.13, 2.08, 2.19, 3.15, 3.09, 3.38, 7, 12, '2024-05-03 11:57:01'),
(21, 23, 21, 5, 0, 0, 2, 0, 0, 0, 1, 47, 0, ' 1 ', ' 127 ', ' 133 ', ' 144 ', 2.15, 2.09, 2.13, 2.19, 2.21, 2.09, 2.38, 2.75, 2.13, 2.75, 3.08, 3.17, 3.19, 7, 7, '2024-05-03 12:02:18'),
(22, 23, 19, 6, 1, 1, 2, 0, 0, 1, 3, 26, 0, ' 2 ', ' 110 ', ' 131 ', ' 135 ', 2.21, 2.17, 2.25, 2.21, 2.13, 3.5, 2.13, 2.75, 2.21, 2.25, 3.25, 3.13, 3.3, 4, 12, '2024-05-03 12:05:25'),
(23, 23, 20, 0, 1, 1, 3, 5, 1, 0, 2, 45, 1, ' 0 ', ' 117 ', ' 133 ', ' 104 ', 2.25, 2.3, 2.13, 2.08, 3.5, 2.08, 2.12, 2.08, 2.21, 2.09, 3.15, 3.15, 3.25, 5, 9, '2024-05-03 12:06:43'),
(24, 23, 9, 5, 0, 0, 5, 4, 1, 0, 0, 43, 0, ' 2 ', ' 100 ', ' 118 ', ' 149 ', 2.13, 2.12, 2.09, 2.08, 2.12, 3.5, 2.1, 2.14, 2.17, 2.5, 3.21, 3.5, 3.09, 5, 10, '2024-05-03 12:06:49'),
(25, 23, 8, 6, 1, 0, 4, 3, 0, 1, 3, 33, 1, ' 1 ', ' 143 ', ' 146 ', ' 119 ', 2.13, 2.21, 2.08, 2.17, 2.15, 2.38, 2.25, 2.12, 2.13, 2.75, 3.11, 3.12, 3.21, 6, 10, '2024-05-03 12:07:28');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_24`
--

CREATE TABLE `yd_24` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_24`
--

INSERT INTO `yd_24` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 24, 22, 4, 1, 0, 1, 4, 0, 1, 2, 46, 1, ' 4 ', ' 122 ', ' 113 ', ' 131 ', 2.21, 3.5, 2.17, 2.09, 2.09, 2.14, 2.1, 2.3, 2.19, 2.09, 3.08, 3.25, 3.11, 7, 7, '2024-05-02 09:56:59'),
(2, 24, 21, 9, 1, 0, 5, 4, 1, 1, 2, 48, 1, ' 0 ', ' 130 ', ' 147 ', ' 127 ', 2.13, 2.75, 2.14, 2.11, 2.25, 2.09, 2.3, 2.25, 2.14, 2.3, 3.3, 3.12, 3.19, 3, 9, '2024-05-02 09:58:08'),
(3, 24, 22, 4, 1, 0, 1, 4, 0, 1, 2, 46, 1, ' 4 ', ' 122 ', ' 113 ', ' 131 ', 2.21, 3.5, 2.17, 2.09, 2.09, 2.14, 2.1, 2.3, 2.19, 2.09, 3.08, 3.25, 3.11, 7, 7, '2024-05-02 10:12:32'),
(4, 24, 22, 4, 1, 0, 1, 4, 0, 1, 2, 46, 1, ' 4 ', ' 122 ', ' 113 ', ' 131 ', 2.21, 3.5, 2.17, 2.09, 2.09, 2.14, 2.1, 2.3, 2.19, 2.09, 3.08, 3.25, 3.11, 7, 7, '2024-05-02 11:51:21'),
(5, 24, 21, 9, 1, 0, 5, 4, 1, 1, 2, 48, 1, ' 0 ', ' 130 ', ' 147 ', ' 127 ', 2.13, 2.75, 2.14, 2.11, 2.25, 2.09, 2.3, 2.25, 2.14, 2.3, 3.3, 3.12, 3.19, 3, 9, '2024-05-02 11:52:31'),
(6, 24, 22, 4, 1, 0, 1, 4, 0, 1, 2, 46, 1, ' 4 ', ' 122 ', ' 113 ', ' 131 ', 2.21, 3.5, 2.17, 2.09, 2.09, 2.14, 2.1, 2.3, 2.19, 2.09, 3.08, 3.25, 3.11, 7, 7, '2024-05-02 12:09:54'),
(7, 24, 21, 9, 1, 0, 5, 4, 1, 1, 2, 48, 1, ' 0 ', ' 130 ', ' 147 ', ' 127 ', 2.13, 2.75, 2.14, 2.11, 2.25, 2.09, 2.3, 2.25, 2.14, 2.3, 3.3, 3.12, 3.19, 3, 9, '2024-05-02 12:11:04'),
(8, 24, 22, 4, 1, 0, 1, 4, 0, 1, 2, 46, 1, ' 4 ', ' 122 ', ' 113 ', ' 131 ', 2.21, 3.5, 2.17, 2.09, 2.09, 2.14, 2.1, 2.3, 2.19, 2.09, 3.08, 3.25, 3.11, 7, 7, '2024-05-02 12:38:50'),
(9, 24, 22, 4, 1, 0, 1, 4, 0, 1, 2, 46, 1, ' 4 ', ' 122 ', ' 113 ', ' 131 ', 2.21, 3.5, 2.17, 2.09, 2.09, 2.14, 2.1, 2.3, 2.19, 2.09, 3.08, 3.25, 3.11, 7, 7, '2024-05-03 11:36:47'),
(10, 24, 21, 9, 1, 0, 5, 4, 1, 1, 2, 48, 1, ' 0 ', ' 130 ', ' 147 ', ' 127 ', 2.13, 2.75, 2.14, 2.11, 2.25, 2.09, 2.3, 2.25, 2.14, 2.3, 3.3, 3.12, 3.19, 3, 9, '2024-05-03 11:37:32'),
(11, 24, 22, 4, 1, 0, 1, 4, 0, 1, 2, 46, 1, ' 4 ', ' 122 ', ' 113 ', ' 131 ', 2.21, 3.5, 2.17, 2.09, 2.09, 2.14, 2.1, 2.3, 2.19, 2.09, 3.08, 3.25, 3.11, 7, 7, '2024-05-03 11:52:42'),
(12, 24, 21, 9, 1, 0, 5, 4, 1, 1, 2, 48, 1, ' 0 ', ' 130 ', ' 147 ', ' 127 ', 2.13, 2.75, 2.14, 2.11, 2.25, 2.09, 2.3, 2.25, 2.14, 2.3, 3.3, 3.12, 3.19, 3, 9, '2024-05-03 11:53:52'),
(13, 24, 13, 9, 1, 0, 5, 1, 0, 1, 3, 35, 0, ' 0 ', ' 109 ', ' 118 ', ' 108 ', 2.15, 2.08, 2.21, 2.09, 2.19, 2.19, 2.5, 2.13, 2.13, 3.5, 3.11, 3.21, 3.14, 6, 11, '2024-05-03 11:57:11'),
(14, 24, 6, 0, 1, 1, 0, 5, 0, 1, 4, 42, 0, ' 3 ', ' 139 ', ' 148 ', ' 129 ', 2.1, 2.19, 2.1, 2.14, 3.5, 2.5, 2.25, 2.08, 2.11, 2.09, 4.5, 3.09, 3.08, 3, 10, '2024-05-03 12:00:12'),
(15, 24, 12, 1, 1, 0, 5, 0, 1, 0, 5, 34, 0, ' 2 ', ' 129 ', ' 137 ', ' 149 ', 2.09, 2.75, 2.09, 2.09, 2.17, 2.75, 2.12, 2.38, 2.38, 2.3, 3.3, 3.08, 4.5, 5, 12, '2024-05-03 12:00:41'),
(16, 24, 3, 0, 1, 1, 3, 3, 1, 1, 2, 40, 1, ' 2 ', ' 146 ', ' 102 ', ' 146 ', 2.75, 2.09, 2.1, 2.15, 2.12, 2.38, 2.3, 2.09, 2.21, 2.15, 3.25, 3.75, 3.5, 4, 11, '2024-05-03 12:02:05'),
(17, 24, 8, 7, 1, 1, 1, 5, 1, 1, 1, 31, 0, ' 1 ', ' 115 ', ' 124 ', ' 112 ', 2.15, 2.3, 2.12, 2.12, 2.21, 3.5, 2.08, 2.1, 2.75, 2.38, 3.12, 3.11, 3.08, 7, 11, '2024-05-03 12:02:47'),
(18, 24, 8, 9, 0, 0, 5, 1, 0, 1, 4, 39, 1, ' 3 ', ' 127 ', ' 128 ', ' 140 ', 2.13, 2.15, 2.11, 2.14, 2.08, 2.15, 2.38, 2.19, 2.14, 2.09, 3.25, 3.75, 3.14, 3, 10, '2024-05-03 12:03:13'),
(19, 24, 10, 9, 1, 1, 2, 4, 1, 1, 2, 39, 1, ' 3 ', ' 118 ', ' 125 ', ' 147 ', 2.09, 2.5, 2.38, 2.11, 2.17, 2.15, 2.12, 2.09, 2.08, 2.08, 3.3, 3.19, 3.1, 3, 9, '2024-05-03 12:04:21'),
(20, 24, 18, 0, 1, 1, 3, 1, 0, 0, 3, 26, 1, ' 1 ', ' 109 ', ' 111 ', ' 138 ', 2.3, 2.38, 2.17, 2.09, 2.09, 2.08, 2.5, 2.25, 2.38, 2.09, 3.13, 3.09, 3.25, 6, 11, '2024-05-03 12:05:10'),
(21, 24, 16, 4, 0, 0, 3, 4, 1, 1, 5, 30, 0, ' 1 ', ' 106 ', ' 110 ', ' 121 ', 2.09, 2.15, 2.17, 2.17, 2.15, 3.5, 3.5, 2.09, 2.08, 2.1, 3.09, 3.19, 3.13, 6, 11, '2024-05-03 12:06:27'),
(22, 24, 1, 1, 0, 1, 0, 3, 0, 1, 0, 44, 0, ' 1 ', ' 102 ', ' 123 ', ' 132 ', 2.09, 2.5, 3.5, 2.13, 2.75, 2.25, 2.15, 2.11, 2.13, 2.25, 3.15, 3.08, 3.12, 5, 9, '2024-05-03 12:07:04'),
(23, 24, 14, 1, 1, 0, 2, 2, 1, 1, 5, 33, 0, ' 2 ', ' 106 ', ' 120 ', ' 108 ', 2.13, 2.25, 2.14, 3.5, 2.3, 2.3, 2.12, 2.38, 2.09, 2.1, 3.1, 3.08, 3.1, 5, 7, '2024-05-03 12:07:47'),
(24, 24, 11, 0, 0, 0, 5, 4, 0, 1, 3, 37, 1, ' 3 ', ' 143 ', ' 108 ', ' 145 ', 2.38, 2.14, 2.09, 2.12, 2.15, 2.75, 2.08, 2.11, 2.19, 2.08, 3.21, 3.17, 4.5, 6, 8, '2024-05-03 12:08:38'),
(25, 24, 7, 8, 0, 0, 1, 5, 1, 1, 0, 36, 0, ' 0 ', ' 136 ', ' 123 ', ' 106 ', 2.08, 2.08, 2.21, 2.09, 2.5, 2.21, 2.17, 2.12, 2.75, 2.19, 3.11, 3.5, 3.09, 6, 11, '2024-05-03 12:08:53');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_25`
--

CREATE TABLE `yd_25` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_25`
--

INSERT INTO `yd_25` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 25, 15, 6, 0, 0, 1, 2, 0, 1, 0, 27, 0, ' 0 ', ' 122 ', ' 137 ', ' 135 ', 2.25, 2.17, 2.13, 2.3, 2.11, 2.21, 2.13, 2.11, 2.75, 3.5, 3.15, 3.1, 3.75, 5, 10, '2024-05-02 09:57:19'),
(2, 25, 15, 6, 0, 0, 1, 2, 0, 1, 0, 27, 0, ' 0 ', ' 122 ', ' 137 ', ' 135 ', 2.25, 2.17, 2.13, 2.3, 2.11, 2.21, 2.13, 2.11, 2.75, 3.5, 3.15, 3.1, 3.75, 5, 10, '2024-05-02 11:51:42'),
(3, 25, 15, 6, 0, 0, 1, 2, 0, 1, 0, 27, 0, ' 0 ', ' 122 ', ' 137 ', ' 135 ', 2.25, 2.17, 2.13, 2.3, 2.11, 2.21, 2.13, 2.11, 2.75, 3.5, 3.15, 3.1, 3.75, 5, 10, '2024-05-02 12:10:14'),
(4, 25, 15, 6, 0, 0, 1, 2, 0, 1, 0, 27, 0, ' 0 ', ' 122 ', ' 137 ', ' 135 ', 2.25, 2.17, 2.13, 2.3, 2.11, 2.21, 2.13, 2.11, 2.75, 3.5, 3.15, 3.1, 3.75, 5, 10, '2024-05-02 12:39:10'),
(5, 25, 15, 6, 0, 0, 1, 2, 0, 1, 0, 27, 0, ' 0 ', ' 122 ', ' 137 ', ' 135 ', 2.25, 2.17, 2.13, 2.3, 2.11, 2.21, 2.13, 2.11, 2.75, 3.5, 3.15, 3.1, 3.75, 5, 10, '2024-05-03 11:37:01'),
(6, 25, 0, 4, 0, 1, 4, 5, 1, 0, 5, 34, 1, ' 0 ', ' 114 ', ' 117 ', ' 130 ', 2.09, 2.3, 2.09, 2.08, 2.19, 2.38, 2.08, 2.09, 2.13, 2.15, 3.17, 3.12, 3.1, 4, 9, '2024-05-03 11:38:07'),
(7, 25, 15, 6, 0, 0, 1, 2, 0, 1, 0, 27, 0, ' 0 ', ' 122 ', ' 137 ', ' 135 ', 2.25, 2.17, 2.13, 2.3, 2.11, 2.21, 2.13, 2.11, 2.75, 3.5, 3.15, 3.1, 3.75, 5, 10, '2024-05-03 11:53:02'),
(8, 25, 0, 4, 0, 1, 4, 5, 1, 0, 5, 34, 1, ' 0 ', ' 114 ', ' 117 ', ' 130 ', 2.09, 2.3, 2.09, 2.08, 2.19, 2.38, 2.08, 2.09, 2.13, 2.15, 3.17, 3.12, 3.1, 4, 9, '2024-05-03 11:55:37'),
(9, 25, 11, 7, 0, 1, 5, 2, 0, 1, 2, 44, 1, ' 1 ', ' 136 ', ' 141 ', ' 119 ', 2.25, 2.14, 2.08, 2.08, 2.11, 3.5, 2.09, 2.1, 2.75, 2.12, 3.09, 3.09, 3.08, 5, 12, '2024-05-03 11:56:53'),
(10, 25, 21, 4, 1, 1, 3, 1, 1, 0, 5, 30, 0, ' 4 ', ' 101 ', ' 134 ', ' 109 ', 2.38, 2.19, 2.15, 2.14, 2.12, 2.09, 2.08, 2.08, 2.13, 2.75, 3.75, 3.75, 3.21, 4, 11, '2024-05-03 11:57:07'),
(11, 25, 13, 3, 0, 1, 0, 0, 1, 1, 2, 27, 1, ' 2 ', ' 141 ', ' 118 ', ' 110 ', 2.21, 2.1, 2.75, 3.5, 2.25, 2.09, 2.12, 2.75, 2.12, 2.09, 3.21, 3.14, 3.08, 7, 8, '2024-05-03 11:59:35'),
(12, 25, 1, 8, 0, 0, 0, 3, 1, 0, 3, 26, 0, ' 4 ', ' 125 ', ' 105 ', ' 131 ', 2.15, 2.11, 2.08, 2.09, 2.3, 2.09, 2.11, 2.11, 2.17, 2.38, 3.08, 3.08, 4.5, 7, 9, '2024-05-03 12:00:39'),
(13, 25, 20, 3, 0, 0, 5, 2, 1, 0, 2, 44, 0, ' 1 ', ' 125 ', ' 141 ', ' 100 ', 2.09, 2.08, 2.19, 2.11, 2.12, 2.21, 2.5, 2.09, 2.09, 2.17, 3.15, 3.38, 4.5, 7, 8, '2024-05-03 12:00:57'),
(14, 25, 17, 4, 0, 0, 0, 1, 1, 1, 3, 45, 1, ' 2 ', ' 113 ', ' 121 ', ' 137 ', 2.25, 2.19, 2.1, 2.38, 2.08, 2.3, 2.1, 2.08, 2.09, 2.19, 3.38, 3.14, 3.38, 7, 12, '2024-05-03 12:01:41'),
(15, 25, 12, 2, 0, 1, 0, 4, 0, 0, 2, 27, 0, ' 3 ', ' 138 ', ' 135 ', ' 114 ', 2.15, 2.12, 2.17, 2.13, 2.08, 2.08, 2.19, 2.15, 2.09, 2.25, 3.19, 3.3, 3.08, 6, 11, '2024-05-03 12:02:16'),
(16, 25, 16, 7, 0, 0, 2, 0, 1, 1, 3, 33, 0, ' 1 ', ' 104 ', ' 107 ', ' 120 ', 2.21, 2.1, 2.5, 2.09, 2.21, 2.08, 2.08, 2.25, 2.5, 2.3, 3.25, 3.75, 3.5, 6, 11, '2024-05-03 12:02:22'),
(17, 25, 22, 8, 0, 0, 5, 5, 1, 1, 0, 47, 1, ' 1 ', ' 129 ', ' 119 ', ' 114 ', 2.75, 2.75, 2.25, 2.09, 2.19, 2.13, 2.15, 2.19, 2.1, 2.75, 3.08, 3.08, 3.38, 3, 12, '2024-05-03 12:03:26'),
(18, 25, 4, 1, 0, 0, 2, 5, 1, 0, 1, 40, 1, ' 3 ', ' 110 ', ' 107 ', ' 110 ', 2.1, 2.38, 2.75, 2.08, 3.5, 2.19, 3.5, 2.13, 2.38, 2.25, 3.12, 3.75, 3.17, 4, 9, '2024-05-03 12:03:46'),
(19, 25, 15, 9, 0, 1, 3, 0, 1, 0, 2, 33, 0, ' 3 ', ' 114 ', ' 135 ', ' 126 ', 2.38, 2.11, 2.25, 2.21, 2.09, 2.25, 2.5, 2.11, 2.25, 2.25, 3.09, 3.25, 3.1, 6, 12, '2024-05-03 12:09:03');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_26`
--

CREATE TABLE `yd_26` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_26`
--

INSERT INTO `yd_26` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 26, 10, 4, 0, 1, 3, 3, 1, 1, 0, 42, 1, ' 4 ', ' 117 ', ' 147 ', ' 119 ', 2.38, 2.1, 2.25, 2.08, 2.15, 2.19, 2.09, 3.5, 2.12, 2.25, 3.19, 3.17, 3.17, 3, 11, '2024-05-02 09:56:07'),
(2, 26, 10, 4, 0, 1, 3, 3, 1, 1, 0, 42, 1, ' 4 ', ' 117 ', ' 147 ', ' 119 ', 2.38, 2.1, 2.25, 2.08, 2.15, 2.19, 2.09, 3.5, 2.12, 2.25, 3.19, 3.17, 3.17, 3, 11, '2024-05-02 10:09:02'),
(3, 26, 10, 4, 0, 1, 3, 3, 1, 1, 0, 42, 1, ' 4 ', ' 117 ', ' 147 ', ' 119 ', 2.38, 2.1, 2.25, 2.08, 2.15, 2.19, 2.09, 3.5, 2.12, 2.25, 3.19, 3.17, 3.17, 3, 11, '2024-05-02 10:11:40'),
(4, 26, 10, 4, 0, 1, 3, 3, 1, 1, 0, 42, 1, ' 4 ', ' 117 ', ' 147 ', ' 119 ', 2.38, 2.1, 2.25, 2.08, 2.15, 2.19, 2.09, 3.5, 2.12, 2.25, 3.19, 3.17, 3.17, 3, 11, '2024-05-02 10:13:25'),
(5, 26, 10, 4, 0, 1, 3, 3, 1, 1, 0, 42, 1, ' 4 ', ' 117 ', ' 147 ', ' 119 ', 2.38, 2.1, 2.25, 2.08, 2.15, 2.19, 2.09, 3.5, 2.12, 2.25, 3.19, 3.17, 3.17, 3, 11, '2024-05-02 10:23:35'),
(6, 26, 10, 4, 0, 1, 3, 3, 1, 1, 0, 42, 1, ' 4 ', ' 117 ', ' 147 ', ' 119 ', 2.38, 2.1, 2.25, 2.08, 2.15, 2.19, 2.09, 3.5, 2.12, 2.25, 3.19, 3.17, 3.17, 3, 11, '2024-05-02 10:26:27'),
(7, 26, 10, 4, 0, 1, 3, 3, 1, 1, 0, 42, 1, ' 4 ', ' 117 ', ' 147 ', ' 119 ', 2.38, 2.1, 2.25, 2.08, 2.15, 2.19, 2.09, 3.5, 2.12, 2.25, 3.19, 3.17, 3.17, 3, 11, '2024-05-02 10:28:42'),
(8, 26, 10, 4, 0, 1, 3, 3, 1, 1, 0, 42, 1, ' 4 ', ' 117 ', ' 147 ', ' 119 ', 2.38, 2.1, 2.25, 2.08, 2.15, 2.19, 2.09, 3.5, 2.12, 2.25, 3.19, 3.17, 3.17, 3, 11, '2024-05-02 11:50:30'),
(9, 26, 10, 4, 0, 1, 3, 3, 1, 1, 0, 42, 1, ' 4 ', ' 117 ', ' 147 ', ' 119 ', 2.38, 2.1, 2.25, 2.08, 2.15, 2.19, 2.09, 3.5, 2.12, 2.25, 3.19, 3.17, 3.17, 3, 11, '2024-05-02 12:01:09'),
(10, 26, 10, 4, 0, 1, 3, 3, 1, 1, 0, 42, 1, ' 4 ', ' 117 ', ' 147 ', ' 119 ', 2.38, 2.1, 2.25, 2.08, 2.15, 2.19, 2.09, 3.5, 2.12, 2.25, 3.19, 3.17, 3.17, 3, 11, '2024-05-02 12:09:02'),
(11, 26, 10, 4, 0, 1, 3, 3, 1, 1, 0, 42, 1, ' 4 ', ' 117 ', ' 147 ', ' 119 ', 2.38, 2.1, 2.25, 2.08, 2.15, 2.19, 2.09, 3.5, 2.12, 2.25, 3.19, 3.17, 3.17, 3, 11, '2024-05-02 12:37:58'),
(12, 26, 10, 4, 0, 1, 3, 3, 1, 1, 0, 42, 1, ' 4 ', ' 117 ', ' 147 ', ' 119 ', 2.38, 2.1, 2.25, 2.08, 2.15, 2.19, 2.09, 3.5, 2.12, 2.25, 3.19, 3.17, 3.17, 3, 11, '2024-05-03 11:34:27'),
(13, 26, 10, 4, 0, 1, 3, 3, 1, 1, 0, 42, 1, ' 4 ', ' 117 ', ' 147 ', ' 119 ', 2.38, 2.1, 2.25, 2.08, 2.15, 2.19, 2.09, 3.5, 2.12, 2.25, 3.19, 3.17, 3.17, 3, 11, '2024-05-03 11:51:50'),
(14, 26, 1, 6, 0, 0, 4, 1, 1, 0, 1, 48, 1, ' 1 ', ' 144 ', ' 137 ', ' 113 ', 2.08, 2.38, 2.25, 2.25, 2.08, 2.11, 2.1, 2.12, 2.09, 2.12, 3.75, 3.3, 3.12, 4, 9, '2024-05-03 11:55:53'),
(15, 26, 19, 2, 0, 1, 4, 1, 0, 1, 2, 25, 1, ' 4 ', ' 107 ', ' 130 ', ' 115 ', 2.17, 2.38, 2.11, 2.08, 3.5, 2.21, 2.21, 2.21, 2.19, 2.17, 3.5, 3.75, 3.15, 4, 8, '2024-05-03 11:57:50'),
(16, 26, 5, 3, 1, 1, 0, 0, 1, 1, 3, 44, 1, ' 2 ', ' 128 ', ' 139 ', ' 128 ', 2.75, 2.14, 2.25, 2.75, 2.1, 2.09, 2.75, 2.15, 2.5, 2.5, 3.38, 3.21, 3.15, 5, 10, '2024-05-03 11:59:48'),
(17, 26, 14, 3, 1, 0, 3, 1, 0, 0, 4, 47, 0, ' 1 ', ' 137 ', ' 149 ', ' 122 ', 2.08, 2.21, 2.75, 2.15, 2.17, 2.12, 2.08, 2.11, 2.38, 2.1, 3.09, 3.1, 3.15, 6, 11, '2024-05-03 12:01:59'),
(18, 26, 0, 7, 0, 0, 0, 2, 0, 0, 2, 30, 0, ' 1 ', ' 135 ', ' 122 ', ' 104 ', 2.08, 2.09, 2.09, 2.5, 2.08, 2.1, 2.21, 2.13, 2.12, 2.08, 3.21, 3.19, 3.09, 6, 12, '2024-05-03 12:04:15'),
(19, 26, 19, 7, 1, 0, 0, 5, 0, 1, 1, 47, 1, ' 4 ', ' 101 ', ' 119 ', ' 105 ', 2.09, 2.09, 2.75, 2.25, 2.17, 2.09, 2.12, 2.08, 2.08, 2.11, 3.1, 3.11, 3.13, 3, 10, '2024-05-03 12:05:39');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_27`
--

CREATE TABLE `yd_27` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_27`
--

INSERT INTO `yd_27` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 27, 0, 5, 1, 0, 2, 1, 0, 0, 5, 37, 1, ' 2 ', ' 137 ', ' 114 ', ' 145 ', 2.13, 2.75, 2.19, 2.21, 2.09, 2.17, 2.09, 2.19, 2.38, 2.12, 3.12, 3.12, 3.25, 4, 9, '2024-05-02 09:58:21'),
(2, 27, 0, 5, 1, 0, 2, 1, 0, 0, 5, 37, 1, ' 2 ', ' 137 ', ' 114 ', ' 145 ', 2.13, 2.75, 2.19, 2.21, 2.09, 2.17, 2.09, 2.19, 2.38, 2.12, 3.12, 3.12, 3.25, 4, 9, '2024-05-02 11:52:44'),
(3, 27, 0, 5, 1, 0, 2, 1, 0, 0, 5, 37, 1, ' 2 ', ' 137 ', ' 114 ', ' 145 ', 2.13, 2.75, 2.19, 2.21, 2.09, 2.17, 2.09, 2.19, 2.38, 2.12, 3.12, 3.12, 3.25, 4, 9, '2024-05-02 12:11:16'),
(4, 27, 0, 5, 1, 0, 2, 1, 0, 0, 5, 37, 1, ' 2 ', ' 137 ', ' 114 ', ' 145 ', 2.13, 2.75, 2.19, 2.21, 2.09, 2.17, 2.09, 2.19, 2.38, 2.12, 3.12, 3.12, 3.25, 4, 9, '2024-05-03 11:37:37'),
(5, 27, 0, 5, 1, 0, 2, 1, 0, 0, 5, 37, 1, ' 2 ', ' 137 ', ' 114 ', ' 145 ', 2.13, 2.75, 2.19, 2.21, 2.09, 2.17, 2.09, 2.19, 2.38, 2.12, 3.12, 3.12, 3.25, 4, 9, '2024-05-03 11:54:04'),
(6, 27, 16, 0, 1, 1, 3, 1, 0, 1, 0, 48, 1, ' 0 ', ' 121 ', ' 111 ', ' 119 ', 2.09, 2.09, 2.3, 2.5, 2.09, 2.19, 2.08, 2.38, 2.08, 2.08, 3.09, 3.12, 3.25, 7, 10, '2024-05-03 11:57:05'),
(7, 27, 10, 8, 0, 0, 1, 5, 0, 0, 4, 49, 0, ' 0 ', ' 107 ', ' 128 ', ' 126 ', 2.21, 2.19, 2.21, 2.15, 2.19, 2.19, 2.08, 2.11, 2.13, 2.09, 3.09, 3.17, 3.13, 4, 12, '2024-05-03 11:58:46'),
(8, 27, 18, 6, 0, 1, 4, 3, 0, 1, 4, 41, 1, ' 4 ', ' 111 ', ' 111 ', ' 133 ', 2.5, 2.09, 2.09, 2.17, 2.08, 2.13, 2.11, 2.11, 2.25, 2.15, 3.08, 3.09, 4.5, 3, 7, '2024-05-03 12:01:40');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_28`
--

CREATE TABLE `yd_28` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_28`
--

INSERT INTO `yd_28` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 28, 7, 2, 1, 0, 5, 1, 0, 1, 1, 47, 0, ' 4 ', ' 117 ', ' 116 ', ' 148 ', 2.11, 2.3, 3.5, 2.19, 2.21, 2.3, 2.15, 2.08, 2.3, 2.08, 3.11, 3.21, 3.11, 3, 12, '2024-05-02 09:56:22'),
(2, 28, 18, 2, 0, 1, 4, 1, 0, 1, 5, 48, 1, ' 2 ', ' 141 ', ' 107 ', ' 102 ', 2.3, 2.25, 2.75, 2.12, 2.08, 2.14, 2.75, 2.5, 2.3, 2.17, 3.09, 3.09, 3.13, 4, 7, '2024-05-02 09:58:43'),
(3, 28, 7, 2, 1, 0, 5, 1, 0, 1, 1, 47, 0, ' 4 ', ' 117 ', ' 116 ', ' 148 ', 2.11, 2.3, 3.5, 2.19, 2.21, 2.3, 2.15, 2.08, 2.3, 2.08, 3.11, 3.21, 3.11, 3, 12, '2024-05-02 10:11:55'),
(4, 28, 7, 2, 1, 0, 5, 1, 0, 1, 1, 47, 0, ' 4 ', ' 117 ', ' 116 ', ' 148 ', 2.11, 2.3, 3.5, 2.19, 2.21, 2.3, 2.15, 2.08, 2.3, 2.08, 3.11, 3.21, 3.11, 3, 12, '2024-05-02 10:23:49'),
(5, 28, 7, 2, 1, 0, 5, 1, 0, 1, 1, 47, 0, ' 4 ', ' 117 ', ' 116 ', ' 148 ', 2.11, 2.3, 3.5, 2.19, 2.21, 2.3, 2.15, 2.08, 2.3, 2.08, 3.11, 3.21, 3.11, 3, 12, '2024-05-02 10:26:41'),
(6, 28, 7, 2, 1, 0, 5, 1, 0, 1, 1, 47, 0, ' 4 ', ' 117 ', ' 116 ', ' 148 ', 2.11, 2.3, 3.5, 2.19, 2.21, 2.3, 2.15, 2.08, 2.3, 2.08, 3.11, 3.21, 3.11, 3, 12, '2024-05-02 10:28:56'),
(7, 28, 7, 2, 1, 0, 5, 1, 0, 1, 1, 47, 0, ' 4 ', ' 117 ', ' 116 ', ' 148 ', 2.11, 2.3, 3.5, 2.19, 2.21, 2.3, 2.15, 2.08, 2.3, 2.08, 3.11, 3.21, 3.11, 3, 12, '2024-05-02 11:50:44'),
(8, 28, 7, 2, 1, 0, 5, 1, 0, 1, 1, 47, 0, ' 4 ', ' 117 ', ' 116 ', ' 148 ', 2.11, 2.3, 3.5, 2.19, 2.21, 2.3, 2.15, 2.08, 2.3, 2.08, 3.11, 3.21, 3.11, 3, 12, '2024-05-02 12:09:17'),
(9, 28, 18, 2, 0, 1, 4, 1, 0, 1, 5, 48, 1, ' 2 ', ' 141 ', ' 107 ', ' 102 ', 2.3, 2.25, 2.75, 2.12, 2.08, 2.14, 2.75, 2.5, 2.3, 2.17, 3.09, 3.09, 3.13, 4, 7, '2024-05-02 12:11:39'),
(10, 28, 7, 2, 1, 0, 5, 1, 0, 1, 1, 47, 0, ' 4 ', ' 117 ', ' 116 ', ' 148 ', 2.11, 2.3, 3.5, 2.19, 2.21, 2.3, 2.15, 2.08, 2.3, 2.08, 3.11, 3.21, 3.11, 3, 12, '2024-05-02 12:38:13'),
(11, 28, 7, 2, 1, 0, 5, 1, 0, 1, 1, 47, 0, ' 4 ', ' 117 ', ' 116 ', ' 148 ', 2.11, 2.3, 3.5, 2.19, 2.21, 2.3, 2.15, 2.08, 2.3, 2.08, 3.11, 3.21, 3.11, 3, 12, '2024-05-03 11:34:42'),
(12, 28, 18, 2, 0, 1, 4, 1, 0, 1, 5, 48, 1, ' 2 ', ' 141 ', ' 107 ', ' 102 ', 2.3, 2.25, 2.75, 2.12, 2.08, 2.14, 2.75, 2.5, 2.3, 2.17, 3.09, 3.09, 3.13, 4, 7, '2024-05-03 11:37:43'),
(13, 28, 7, 2, 1, 0, 5, 1, 0, 1, 1, 47, 0, ' 4 ', ' 117 ', ' 116 ', ' 148 ', 2.11, 2.3, 3.5, 2.19, 2.21, 2.3, 2.15, 2.08, 2.3, 2.08, 3.11, 3.21, 3.11, 3, 12, '2024-05-03 11:52:05'),
(14, 28, 18, 2, 0, 1, 4, 1, 0, 1, 5, 48, 1, ' 2 ', ' 141 ', ' 107 ', ' 102 ', 2.3, 2.25, 2.75, 2.12, 2.08, 2.14, 2.75, 2.5, 2.3, 2.17, 3.09, 3.09, 3.13, 4, 7, '2024-05-03 11:54:27'),
(15, 28, 12, 9, 1, 1, 5, 2, 1, 0, 2, 49, 0, ' 1 ', ' 106 ', ' 122 ', ' 111 ', 2.17, 2.09, 2.09, 2.38, 2.17, 2.13, 2.12, 2.11, 2.17, 2.15, 3.08, 3.5, 3.09, 7, 7, '2024-05-03 11:56:18'),
(16, 28, 13, 2, 0, 1, 3, 2, 1, 1, 2, 44, 0, ' 1 ', ' 118 ', ' 111 ', ' 120 ', 2.14, 2.1, 2.15, 2.12, 2.12, 2.21, 2.3, 2.1, 2.11, 2.1, 3.13, 3.15, 3.17, 3, 9, '2024-05-03 11:57:28'),
(17, 28, 16, 2, 0, 0, 2, 5, 1, 0, 0, 45, 0, ' 3 ', ' 116 ', ' 127 ', ' 123 ', 2.21, 2.08, 2.12, 2.1, 2.1, 2.38, 2.13, 2.17, 2.19, 2.09, 3.5, 3.12, 3.19, 4, 12, '2024-05-03 11:59:29'),
(18, 28, 17, 7, 1, 0, 4, 3, 0, 0, 2, 26, 0, ' 3 ', ' 149 ', ' 101 ', ' 135 ', 2.14, 2.1, 2.17, 2.15, 2.08, 2.15, 2.1, 2.11, 2.09, 2.25, 3.08, 4.5, 3.25, 5, 10, '2024-05-03 12:02:59'),
(19, 28, 12, 6, 1, 0, 5, 5, 0, 1, 1, 46, 1, ' 0 ', ' 142 ', ' 124 ', ' 132 ', 2.17, 2.11, 2.75, 2.21, 2.5, 2.15, 2.12, 2.09, 2.09, 2.21, 3.09, 3.15, 3.09, 7, 11, '2024-05-03 12:07:49');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_29`
--

CREATE TABLE `yd_29` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_29`
--

INSERT INTO `yd_29` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 29, 17, 1, 0, 1, 5, 5, 0, 1, 1, 39, 1, ' 2 ', ' 119 ', ' 130 ', ' 126 ', 3.5, 2.25, 2.09, 2.3, 2.1, 3.5, 2.19, 2.09, 2.75, 2.12, 3.75, 4.5, 3.5, 5, 11, '2024-05-02 09:57:21'),
(2, 29, 14, 4, 0, 1, 3, 5, 1, 1, 2, 37, 1, ' 4 ', ' 118 ', ' 113 ', ' 100 ', 2.09, 2.09, 2.09, 2.3, 2.3, 2.75, 3.5, 2.19, 2.14, 2.38, 3.13, 3.3, 3.09, 6, 12, '2024-05-02 09:57:40'),
(3, 29, 17, 1, 0, 1, 5, 5, 0, 1, 1, 39, 1, ' 2 ', ' 119 ', ' 130 ', ' 126 ', 3.5, 2.25, 2.09, 2.3, 2.1, 3.5, 2.19, 2.09, 2.75, 2.12, 3.75, 4.5, 3.5, 5, 11, '2024-05-02 11:51:44'),
(4, 29, 14, 4, 0, 1, 3, 5, 1, 1, 2, 37, 1, ' 4 ', ' 118 ', ' 113 ', ' 100 ', 2.09, 2.09, 2.09, 2.3, 2.3, 2.75, 3.5, 2.19, 2.14, 2.38, 3.13, 3.3, 3.09, 6, 12, '2024-05-02 11:52:03'),
(5, 29, 17, 1, 0, 1, 5, 5, 0, 1, 1, 39, 1, ' 2 ', ' 119 ', ' 130 ', ' 126 ', 3.5, 2.25, 2.09, 2.3, 2.1, 3.5, 2.19, 2.09, 2.75, 2.12, 3.75, 4.5, 3.5, 5, 11, '2024-05-02 12:10:16'),
(6, 29, 14, 4, 0, 1, 3, 5, 1, 1, 2, 37, 1, ' 4 ', ' 118 ', ' 113 ', ' 100 ', 2.09, 2.09, 2.09, 2.3, 2.3, 2.75, 3.5, 2.19, 2.14, 2.38, 3.13, 3.3, 3.09, 6, 12, '2024-05-02 12:10:35'),
(7, 29, 17, 1, 0, 1, 5, 5, 0, 1, 1, 39, 1, ' 2 ', ' 119 ', ' 130 ', ' 126 ', 3.5, 2.25, 2.09, 2.3, 2.1, 3.5, 2.19, 2.09, 2.75, 2.12, 3.75, 4.5, 3.5, 5, 11, '2024-05-02 12:39:12'),
(8, 29, 14, 4, 0, 1, 3, 5, 1, 1, 2, 37, 1, ' 4 ', ' 118 ', ' 113 ', ' 100 ', 2.09, 2.09, 2.09, 2.3, 2.3, 2.75, 3.5, 2.19, 2.14, 2.38, 3.13, 3.3, 3.09, 6, 12, '2024-05-02 12:39:31'),
(9, 29, 17, 1, 0, 1, 5, 5, 0, 1, 1, 39, 1, ' 2 ', ' 119 ', ' 130 ', ' 126 ', 3.5, 2.25, 2.09, 2.3, 2.1, 3.5, 2.19, 2.09, 2.75, 2.12, 3.75, 4.5, 3.5, 5, 11, '2024-05-03 11:37:02'),
(10, 29, 14, 4, 0, 1, 3, 5, 1, 1, 2, 37, 1, ' 4 ', ' 118 ', ' 113 ', ' 100 ', 2.09, 2.09, 2.09, 2.3, 2.3, 2.75, 3.5, 2.19, 2.14, 2.38, 3.13, 3.3, 3.09, 6, 12, '2024-05-03 11:37:14'),
(11, 29, 22, 0, 0, 0, 4, 2, 1, 0, 5, 27, 1, ' 0 ', ' 142 ', ' 141 ', ' 106 ', 2.1, 2.75, 2.75, 2.25, 2.09, 3.5, 2.25, 2.75, 2.15, 2.08, 3.08, 3.13, 3.08, 5, 8, '2024-05-03 11:37:57'),
(12, 29, 17, 1, 0, 1, 5, 5, 0, 1, 1, 39, 1, ' 2 ', ' 119 ', ' 130 ', ' 126 ', 3.5, 2.25, 2.09, 2.3, 2.1, 3.5, 2.19, 2.09, 2.75, 2.12, 3.75, 4.5, 3.5, 5, 11, '2024-05-03 11:53:04'),
(13, 29, 14, 4, 0, 1, 3, 5, 1, 1, 2, 37, 1, ' 4 ', ' 118 ', ' 113 ', ' 100 ', 2.09, 2.09, 2.09, 2.3, 2.3, 2.75, 3.5, 2.19, 2.14, 2.38, 3.13, 3.3, 3.09, 6, 12, '2024-05-03 11:53:23'),
(14, 29, 22, 0, 0, 0, 4, 2, 1, 0, 5, 27, 1, ' 0 ', ' 142 ', ' 141 ', ' 106 ', 2.1, 2.75, 2.75, 2.25, 2.09, 3.5, 2.25, 2.75, 2.15, 2.08, 3.08, 3.13, 3.08, 5, 8, '2024-05-03 11:55:16'),
(15, 29, 0, 8, 1, 0, 2, 1, 1, 0, 1, 49, 1, ' 3 ', ' 115 ', ' 141 ', ' 125 ', 2.1, 2.13, 2.09, 2.15, 2.21, 2.1, 2.09, 2.13, 2.08, 2.17, 4.5, 3.3, 3.1, 5, 8, '2024-05-03 11:59:52'),
(16, 29, 9, 3, 0, 0, 2, 5, 0, 1, 1, 42, 1, ' 2 ', ' 132 ', ' 149 ', ' 116 ', 2.08, 2.5, 2.21, 2.3, 2.75, 2.1, 2.08, 2.25, 2.08, 2.12, 3.08, 3.19, 3.19, 5, 10, '2024-05-03 12:00:10'),
(17, 29, 4, 0, 1, 1, 5, 4, 0, 1, 3, 25, 1, ' 2 ', ' 137 ', ' 120 ', ' 136 ', 2.25, 2.21, 2.14, 2.08, 2.19, 2.11, 2.09, 2.12, 2.21, 2.21, 3.5, 4.5, 3.25, 4, 12, '2024-05-03 12:00:53'),
(18, 29, 10, 2, 0, 0, 4, 5, 1, 0, 0, 42, 0, ' 3 ', ' 124 ', ' 112 ', ' 130 ', 2.14, 2.1, 2.1, 3.5, 2.14, 2.12, 2.08, 2.12, 3.5, 2.1, 3.11, 3.08, 3.14, 6, 12, '2024-05-03 12:02:26'),
(19, 29, 13, 8, 1, 1, 3, 2, 1, 0, 5, 38, 1, ' 1 ', ' 122 ', ' 147 ', ' 146 ', 2.14, 2.5, 2.13, 2.14, 2.09, 2.12, 2.17, 2.14, 2.09, 2.75, 3.75, 3.17, 4.5, 5, 12, '2024-05-03 12:03:40'),
(20, 29, 2, 0, 1, 0, 2, 2, 1, 1, 1, 38, 0, ' 3 ', ' 140 ', ' 148 ', ' 111 ', 2.08, 2.08, 2.12, 2.25, 2.09, 2.08, 2.25, 2.21, 2.09, 2.15, 3.08, 3.3, 3.15, 3, 10, '2024-05-03 12:03:48');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_30`
--

CREATE TABLE `yd_30` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_30`
--

INSERT INTO `yd_30` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 30, 22, 3, 0, 0, 1, 3, 0, 0, 0, 47, 0, ' 1 ', ' 143 ', ' 144 ', ' 102 ', 2.15, 2.08, 2.1, 2.75, 2.14, 2.08, 3.5, 2.19, 2.38, 2.12, 3.14, 3.21, 3.25, 6, 9, '2024-05-02 09:58:06'),
(2, 30, 22, 3, 0, 0, 1, 3, 0, 0, 0, 47, 0, ' 1 ', ' 143 ', ' 144 ', ' 102 ', 2.15, 2.08, 2.1, 2.75, 2.14, 2.08, 3.5, 2.19, 2.38, 2.12, 3.14, 3.21, 3.25, 6, 9, '2024-05-02 11:52:29'),
(3, 30, 22, 3, 0, 0, 1, 3, 0, 0, 0, 47, 0, ' 1 ', ' 143 ', ' 144 ', ' 102 ', 2.15, 2.08, 2.1, 2.75, 2.14, 2.08, 3.5, 2.19, 2.38, 2.12, 3.14, 3.21, 3.25, 6, 9, '2024-05-02 12:11:02'),
(4, 30, 22, 3, 0, 0, 1, 3, 0, 0, 0, 47, 0, ' 1 ', ' 143 ', ' 144 ', ' 102 ', 2.15, 2.08, 2.1, 2.75, 2.14, 2.08, 3.5, 2.19, 2.38, 2.12, 3.14, 3.21, 3.25, 6, 9, '2024-05-03 11:37:30'),
(5, 30, 22, 3, 0, 0, 1, 3, 0, 0, 0, 47, 0, ' 1 ', ' 143 ', ' 144 ', ' 102 ', 2.15, 2.08, 2.1, 2.75, 2.14, 2.08, 3.5, 2.19, 2.38, 2.12, 3.14, 3.21, 3.25, 6, 9, '2024-05-03 11:53:50'),
(6, 30, 1, 5, 0, 0, 3, 1, 0, 1, 3, 37, 0, ' 3 ', ' 143 ', ' 104 ', ' 149 ', 2.09, 2.21, 2.17, 2.08, 2.19, 2.09, 2.19, 2.09, 2.09, 2.3, 3.12, 3.09, 3.09, 6, 8, '2024-05-03 11:56:47'),
(7, 30, 16, 9, 0, 0, 2, 3, 0, 1, 4, 47, 1, ' 2 ', ' 143 ', ' 142 ', ' 112 ', 2.19, 2.09, 2.15, 2.3, 2.19, 2.25, 2.12, 2.75, 3.5, 2.14, 4.5, 3.75, 3.25, 7, 11, '2024-05-03 11:57:40'),
(8, 30, 19, 9, 0, 0, 5, 5, 1, 0, 1, 37, 0, ' 4 ', ' 103 ', ' 106 ', ' 148 ', 2.3, 2.09, 2.3, 2.21, 2.25, 2.11, 2.38, 2.21, 2.75, 2.15, 3.5, 3.17, 3.08, 7, 11, '2024-05-03 12:00:02'),
(9, 30, 11, 1, 0, 1, 1, 2, 1, 0, 1, 36, 0, ' 0 ', ' 136 ', ' 110 ', ' 111 ', 2.17, 2.11, 2.14, 2.08, 2.21, 2.15, 2.75, 2.38, 2.38, 2.12, 3.21, 3.14, 3.13, 5, 12, '2024-05-03 12:00:16'),
(10, 30, 12, 9, 1, 1, 1, 1, 0, 1, 2, 46, 1, ' 4 ', ' 115 ', ' 142 ', ' 130 ', 2.13, 2.08, 2.09, 2.17, 2.1, 2.09, 2.15, 2.75, 2.25, 2.09, 3.75, 3.09, 3.3, 5, 8, '2024-05-03 12:04:13'),
(11, 30, 5, 0, 1, 0, 3, 2, 1, 0, 1, 33, 1, ' 2 ', ' 114 ', ' 117 ', ' 137 ', 2.12, 2.5, 2.5, 2.13, 2.12, 2.15, 2.21, 2.11, 2.17, 2.38, 3.3, 3.09, 3.38, 3, 9, '2024-05-03 12:05:37'),
(12, 30, 5, 5, 0, 0, 0, 3, 1, 1, 4, 27, 0, ' 2 ', ' 144 ', ' 108 ', ' 104 ', 2.08, 2.08, 2.21, 2.12, 2.15, 2.12, 2.25, 2.17, 2.08, 2.08, 3.1, 3.08, 3.21, 7, 8, '2024-05-03 12:07:12'),
(13, 30, 9, 2, 0, 1, 0, 5, 0, 0, 4, 47, 1, ' 2 ', ' 127 ', ' 119 ', ' 125 ', 3.5, 2.08, 2.15, 2.11, 2.15, 3.5, 2.13, 2.38, 2.5, 2.15, 3.38, 3.08, 3.3, 6, 12, '2024-05-03 12:07:36');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_31`
--

CREATE TABLE `yd_31` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_31`
--

INSERT INTO `yd_31` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 31, 9, 7, 1, 0, 0, 3, 1, 0, 3, 29, 0, ' 2 ', ' 112 ', ' 139 ', ' 129 ', 2.09, 3.5, 2.13, 2.11, 2.21, 2.14, 2.08, 2.5, 2.08, 2.13, 3.17, 3.38, 3.15, 7, 7, '2024-05-02 09:59:14'),
(2, 31, 9, 7, 1, 0, 0, 3, 1, 0, 3, 29, 0, ' 2 ', ' 112 ', ' 139 ', ' 129 ', 2.09, 3.5, 2.13, 2.11, 2.21, 2.14, 2.08, 2.5, 2.08, 2.13, 3.17, 3.38, 3.15, 7, 7, '2024-05-03 11:37:51'),
(3, 31, 9, 7, 1, 0, 0, 3, 1, 0, 3, 29, 0, ' 2 ', ' 112 ', ' 139 ', ' 129 ', 2.09, 3.5, 2.13, 2.11, 2.21, 2.14, 2.08, 2.5, 2.08, 2.13, 3.17, 3.38, 3.15, 7, 7, '2024-05-03 11:54:58'),
(4, 31, 7, 5, 1, 1, 2, 2, 0, 0, 4, 31, 1, ' 2 ', ' 110 ', ' 142 ', ' 102 ', 2.19, 3.5, 2.38, 2.14, 2.5, 2.08, 2.08, 2.17, 2.19, 2.3, 3.08, 3.38, 3.38, 5, 12, '2024-05-03 11:57:44'),
(5, 31, 3, 5, 0, 1, 3, 5, 0, 1, 4, 33, 1, ' 1 ', ' 126 ', ' 142 ', ' 115 ', 2.14, 2.25, 2.75, 2.08, 2.75, 2.17, 2.09, 2.15, 2.19, 3.5, 3.25, 3.38, 4.5, 4, 8, '2024-05-03 11:59:15'),
(6, 31, 7, 6, 1, 0, 0, 1, 1, 1, 3, 37, 0, ' 2 ', ' 140 ', ' 142 ', ' 126 ', 2.11, 2.25, 2.09, 2.08, 2.75, 2.38, 2.19, 2.21, 2.12, 2.17, 3.75, 3.25, 3.38, 7, 8, '2024-05-03 11:59:46'),
(7, 31, 14, 9, 1, 0, 2, 4, 0, 1, 5, 39, 1, ' 3 ', ' 138 ', ' 136 ', ' 101 ', 2.19, 2.14, 2.1, 2.14, 2.09, 2.09, 2.19, 2.5, 2.09, 2.08, 3.11, 3.12, 3.09, 5, 9, '2024-05-03 12:00:25'),
(8, 31, 18, 4, 0, 1, 5, 4, 1, 0, 1, 44, 0, ' 0 ', ' 103 ', ' 133 ', ' 148 ', 2.25, 2.08, 2.08, 2.13, 2.15, 2.25, 2.75, 2.14, 2.25, 2.38, 3.09, 3.1, 3.75, 3, 7, '2024-05-03 12:03:28'),
(9, 31, 4, 1, 0, 0, 0, 4, 1, 0, 5, 27, 0, ' 2 ', ' 148 ', ' 120 ', ' 105 ', 2.17, 2.17, 2.09, 2.17, 2.09, 2.15, 2.11, 2.5, 2.15, 2.3, 3.08, 3.5, 3.14, 7, 9, '2024-05-03 12:07:45');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_32`
--

CREATE TABLE `yd_32` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_32`
--

INSERT INTO `yd_32` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 32, 9, 5, 1, 1, 1, 3, 1, 0, 0, 40, 0, ' 2 ', ' 122 ', ' 121 ', ' 110 ', 3.5, 2.38, 2.17, 2.08, 2.14, 3.5, 2.38, 2.25, 2.09, 2.15, 3.13, 3.11, 3.13, 7, 10, '2024-05-02 09:58:00'),
(2, 32, 7, 1, 1, 0, 4, 2, 0, 0, 0, 43, 1, ' 0 ', ' 122 ', ' 147 ', ' 143 ', 2.1, 2.21, 2.14, 2.17, 2.17, 2.14, 2.21, 2.75, 2.14, 2.11, 3.08, 3.08, 3.3, 4, 11, '2024-05-02 09:58:54'),
(3, 32, 9, 5, 1, 1, 1, 3, 1, 0, 0, 40, 0, ' 2 ', ' 122 ', ' 121 ', ' 110 ', 3.5, 2.38, 2.17, 2.08, 2.14, 3.5, 2.38, 2.25, 2.09, 2.15, 3.13, 3.11, 3.13, 7, 10, '2024-05-02 11:52:23'),
(4, 32, 9, 5, 1, 1, 1, 3, 1, 0, 0, 40, 0, ' 2 ', ' 122 ', ' 121 ', ' 110 ', 3.5, 2.38, 2.17, 2.08, 2.14, 3.5, 2.38, 2.25, 2.09, 2.15, 3.13, 3.11, 3.13, 7, 10, '2024-05-02 12:10:56'),
(5, 32, 7, 1, 1, 0, 4, 2, 0, 0, 0, 43, 1, ' 0 ', ' 122 ', ' 147 ', ' 143 ', 2.1, 2.21, 2.14, 2.17, 2.17, 2.14, 2.21, 2.75, 2.14, 2.11, 3.08, 3.08, 3.3, 4, 11, '2024-05-02 12:11:49'),
(6, 32, 9, 5, 1, 1, 1, 3, 1, 0, 0, 40, 0, ' 2 ', ' 122 ', ' 121 ', ' 110 ', 3.5, 2.38, 2.17, 2.08, 2.14, 3.5, 2.38, 2.25, 2.09, 2.15, 3.13, 3.11, 3.13, 7, 10, '2024-05-03 11:37:19'),
(7, 32, 7, 1, 1, 0, 4, 2, 0, 0, 0, 43, 1, ' 0 ', ' 122 ', ' 147 ', ' 143 ', 2.1, 2.21, 2.14, 2.17, 2.17, 2.14, 2.21, 2.75, 2.14, 2.11, 3.08, 3.08, 3.3, 4, 11, '2024-05-03 11:37:46'),
(8, 32, 2, 4, 0, 1, 0, 4, 0, 1, 4, 44, 1, ' 4 ', ' 117 ', ' 121 ', ' 145 ', 2.11, 2.09, 2.38, 2.09, 2.1, 2.08, 2.08, 2.12, 3.5, 2.15, 3.21, 3.38, 3.75, 7, 10, '2024-05-03 11:37:59'),
(9, 32, 9, 5, 1, 1, 1, 3, 1, 0, 0, 40, 0, ' 2 ', ' 122 ', ' 121 ', ' 110 ', 3.5, 2.38, 2.17, 2.08, 2.14, 3.5, 2.38, 2.25, 2.09, 2.15, 3.13, 3.11, 3.13, 7, 10, '2024-05-03 11:53:44'),
(10, 32, 7, 1, 1, 0, 4, 2, 0, 0, 0, 43, 1, ' 0 ', ' 122 ', ' 147 ', ' 143 ', 2.1, 2.21, 2.14, 2.17, 2.17, 2.14, 2.21, 2.75, 2.14, 2.11, 3.08, 3.08, 3.3, 4, 11, '2024-05-03 11:54:37'),
(11, 32, 2, 4, 0, 1, 0, 4, 0, 1, 4, 44, 1, ' 4 ', ' 117 ', ' 121 ', ' 145 ', 2.11, 2.09, 2.38, 2.09, 2.1, 2.08, 2.08, 2.12, 3.5, 2.15, 3.21, 3.38, 3.75, 7, 10, '2024-05-03 11:55:28'),
(12, 32, 3, 9, 1, 0, 0, 4, 0, 0, 0, 38, 0, ' 1 ', ' 106 ', ' 112 ', ' 103 ', 2.14, 2.09, 2.09, 2.09, 2.08, 2.21, 2.1, 2.08, 2.17, 2.75, 3.21, 3.08, 3.25, 3, 8, '2024-05-03 11:55:47'),
(13, 32, 10, 9, 0, 1, 4, 2, 1, 1, 4, 48, 1, ' 2 ', ' 124 ', ' 134 ', ' 144 ', 2.08, 2.08, 2.19, 2.11, 2.09, 2.11, 2.21, 2.5, 2.19, 2.19, 3.75, 3.08, 3.75, 3, 10, '2024-05-03 11:58:56'),
(14, 32, 0, 1, 0, 1, 3, 3, 0, 1, 2, 36, 0, ' 0 ', ' 114 ', ' 107 ', ' 105 ', 2.1, 2.13, 2.08, 2.09, 2.09, 2.3, 2.08, 2.17, 2.15, 2.08, 3.15, 3.11, 3.25, 4, 8, '2024-05-03 12:05:13'),
(15, 32, 5, 5, 0, 0, 2, 0, 1, 0, 5, 35, 1, ' 4 ', ' 139 ', ' 129 ', ' 136 ', 2.3, 2.15, 2.21, 2.12, 2.12, 2.3, 2.13, 2.09, 2.3, 2.3, 3.5, 3.09, 3.13, 4, 10, '2024-05-03 12:06:12'),
(16, 32, 1, 7, 0, 1, 2, 1, 0, 1, 3, 38, 1, ' 3 ', ' 144 ', ' 103 ', ' 130 ', 2.14, 2.14, 2.38, 2.11, 2.15, 3.5, 2.08, 2.09, 2.11, 2.11, 3.17, 3.15, 3.14, 4, 10, '2024-05-03 12:07:41');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_33`
--

CREATE TABLE `yd_33` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_33`
--

INSERT INTO `yd_33` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 33, 10, 9, 1, 1, 3, 2, 1, 1, 4, 37, 1, ' 1 ', ' 140 ', ' 119 ', ' 106 ', 2.25, 2.21, 2.08, 2.1, 2.1, 2.25, 2.75, 2.17, 2.15, 2.19, 3.5, 3.25, 3.75, 4, 8, '2024-05-03 11:55:55'),
(2, 33, 21, 7, 0, 0, 1, 2, 1, 1, 3, 25, 1, ' 1 ', ' 137 ', ' 120 ', ' 145 ', 2.19, 2.19, 2.3, 2.12, 2.14, 2.3, 2.14, 2.1, 2.38, 2.14, 3.75, 3.14, 3.19, 5, 8, '2024-05-03 12:01:10'),
(3, 33, 20, 8, 0, 1, 1, 2, 0, 0, 0, 40, 1, ' 1 ', ' 141 ', ' 142 ', ' 105 ', 2.08, 2.09, 2.15, 2.38, 2.3, 2.19, 2.15, 2.3, 2.15, 2.15, 3.13, 3.12, 3.5, 4, 12, '2024-05-03 12:03:38'),
(4, 33, 6, 6, 0, 1, 5, 0, 1, 1, 4, 31, 0, ' 0 ', ' 132 ', ' 149 ', ' 110 ', 2.15, 2.08, 2.15, 2.1, 2.25, 2.19, 2.08, 2.11, 2.08, 2.17, 3.09, 3.13, 3.38, 6, 11, '2024-05-03 12:06:00'),
(5, 33, 7, 3, 0, 1, 4, 1, 1, 1, 2, 33, 1, ' 3 ', ' 127 ', ' 130 ', ' 129 ', 2.09, 2.75, 2.14, 2.08, 2.25, 2.14, 2.38, 2.25, 2.08, 2.08, 3.13, 3.12, 3.09, 7, 10, '2024-05-03 12:08:32');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_34`
--

CREATE TABLE `yd_34` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_34`
--

INSERT INTO `yd_34` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 34, 20, 4, 0, 1, 4, 3, 0, 1, 1, 44, 0, ' 4 ', ' 131 ', ' 111 ', ' 135 ', 2.09, 2.75, 2.08, 2.13, 2.13, 2.09, 2.11, 2.3, 2.38, 2.5, 3.13, 3.19, 3.75, 4, 9, '2024-05-02 09:57:56'),
(2, 34, 11, 1, 0, 0, 4, 0, 1, 0, 1, 32, 1, ' 2 ', ' 106 ', ' 121 ', ' 118 ', 2.38, 2.75, 2.75, 2.25, 2.75, 2.09, 2.09, 2.1, 2.5, 2.19, 3.09, 3.09, 3.11, 6, 7, '2024-05-02 09:59:04'),
(3, 34, 20, 4, 0, 1, 4, 3, 0, 1, 1, 44, 0, ' 4 ', ' 131 ', ' 111 ', ' 135 ', 2.09, 2.75, 2.08, 2.13, 2.13, 2.09, 2.11, 2.3, 2.38, 2.5, 3.13, 3.19, 3.75, 4, 9, '2024-05-02 11:52:19'),
(4, 34, 20, 4, 0, 1, 4, 3, 0, 1, 1, 44, 0, ' 4 ', ' 131 ', ' 111 ', ' 135 ', 2.09, 2.75, 2.08, 2.13, 2.13, 2.09, 2.11, 2.3, 2.38, 2.5, 3.13, 3.19, 3.75, 4, 9, '2024-05-02 12:10:51'),
(5, 34, 20, 4, 0, 1, 4, 3, 0, 1, 1, 44, 0, ' 4 ', ' 131 ', ' 111 ', ' 135 ', 2.09, 2.75, 2.08, 2.13, 2.13, 2.09, 2.11, 2.3, 2.38, 2.5, 3.13, 3.19, 3.75, 4, 9, '2024-05-03 11:37:18'),
(6, 34, 11, 1, 0, 0, 4, 0, 1, 0, 1, 32, 1, ' 2 ', ' 106 ', ' 121 ', ' 118 ', 2.38, 2.75, 2.75, 2.25, 2.75, 2.09, 2.09, 2.1, 2.5, 2.19, 3.09, 3.09, 3.11, 6, 7, '2024-05-03 11:37:48'),
(7, 34, 20, 4, 0, 1, 4, 3, 0, 1, 1, 44, 0, ' 4 ', ' 131 ', ' 111 ', ' 135 ', 2.09, 2.75, 2.08, 2.13, 2.13, 2.09, 2.11, 2.3, 2.38, 2.5, 3.13, 3.19, 3.75, 4, 9, '2024-05-03 11:53:39'),
(8, 34, 11, 1, 0, 0, 4, 0, 1, 0, 1, 32, 1, ' 2 ', ' 106 ', ' 121 ', ' 118 ', 2.38, 2.75, 2.75, 2.25, 2.75, 2.09, 2.09, 2.1, 2.5, 2.19, 3.09, 3.09, 3.11, 6, 7, '2024-05-03 11:54:47'),
(9, 34, 6, 8, 0, 0, 4, 5, 0, 1, 0, 35, 1, ' 1 ', ' 123 ', ' 111 ', ' 146 ', 2.13, 2.19, 2.75, 2.75, 2.11, 2.21, 2.25, 2.21, 2.15, 2.5, 3.12, 3.21, 3.15, 7, 10, '2024-05-03 11:56:38'),
(10, 34, 15, 5, 1, 0, 4, 4, 0, 0, 2, 34, 0, ' 1 ', ' 112 ', ' 131 ', ' 133 ', 2.09, 3.5, 2.13, 2.1, 2.09, 2.3, 2.17, 2.3, 2.1, 2.09, 3.3, 3.5, 3.19, 7, 9, '2024-05-03 11:59:25'),
(11, 34, 0, 3, 0, 1, 4, 3, 1, 0, 1, 33, 0, ' 2 ', ' 142 ', ' 131 ', ' 122 ', 2.21, 2.3, 2.75, 2.19, 2.12, 2.5, 2.17, 2.1, 2.21, 2.15, 3.15, 3.12, 3.09, 6, 8, '2024-05-03 12:00:04'),
(12, 34, 6, 6, 1, 0, 3, 1, 0, 0, 2, 30, 1, ' 4 ', ' 106 ', ' 113 ', ' 133 ', 2.17, 2.15, 2.3, 3.5, 2.3, 2.17, 2.38, 2.08, 2.17, 2.15, 3.19, 3.14, 3.21, 3, 9, '2024-05-03 12:00:06'),
(13, 34, 1, 6, 0, 0, 2, 3, 1, 1, 2, 36, 0, ' 3 ', ' 132 ', ' 142 ', ' 100 ', 2.19, 2.08, 3.5, 2.21, 2.13, 2.08, 2.09, 2.08, 2.15, 2.38, 3.19, 3.15, 3.38, 7, 8, '2024-05-03 12:00:18'),
(14, 34, 19, 9, 0, 1, 5, 0, 0, 0, 5, 43, 1, ' 1 ', ' 111 ', ' 142 ', ' 122 ', 2.25, 2.11, 2.5, 2.08, 2.21, 2.25, 2.19, 2.12, 2.08, 2.1, 3.11, 3.12, 3.13, 6, 12, '2024-05-03 12:00:51'),
(15, 34, 24, 2, 0, 1, 2, 2, 1, 0, 1, 45, 1, ' 3 ', ' 139 ', ' 139 ', ' 111 ', 2.08, 2.38, 2.09, 2.09, 2.21, 2.15, 2.19, 2.08, 2.21, 2.25, 3.13, 3.12, 3.21, 6, 8, '2024-05-03 12:02:38'),
(16, 34, 14, 1, 1, 1, 5, 1, 1, 0, 5, 48, 1, ' 2 ', ' 106 ', ' 141 ', ' 111 ', 2.12, 2.5, 2.21, 2.3, 2.3, 2.75, 2.5, 2.3, 2.12, 2.75, 4.5, 3.14, 3.08, 7, 8, '2024-05-03 12:07:26');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_35`
--

CREATE TABLE `yd_35` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_35`
--

INSERT INTO `yd_35` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 35, 5, 4, 0, 0, 3, 3, 1, 1, 0, 39, 0, ' 4 ', ' 135 ', ' 109 ', ' 138 ', 2.09, 2.14, 2.75, 2.09, 2.13, 2.09, 2.08, 2.11, 2.08, 2.1, 3.17, 3.09, 3.25, 5, 7, '2024-05-02 09:57:34'),
(2, 35, 11, 5, 0, 1, 3, 0, 0, 1, 0, 39, 1, ' 4 ', ' 114 ', ' 137 ', ' 145 ', 2.11, 2.38, 2.1, 2.19, 2.13, 2.5, 2.21, 2.08, 2.12, 2.14, 3.12, 3.25, 3.08, 5, 12, '2024-05-02 09:58:02'),
(3, 35, 14, 2, 0, 1, 4, 1, 0, 1, 3, 38, 1, ' 3 ', ' 132 ', ' 131 ', ' 103 ', 2.38, 2.5, 2.25, 2.11, 2.1, 3.5, 2.13, 2.08, 2.3, 2.1, 3.25, 3.09, 3.09, 5, 9, '2024-05-02 09:58:15'),
(4, 35, 5, 4, 0, 0, 3, 3, 1, 1, 0, 39, 0, ' 4 ', ' 135 ', ' 109 ', ' 138 ', 2.09, 2.14, 2.75, 2.09, 2.13, 2.09, 2.08, 2.11, 2.08, 2.1, 3.17, 3.09, 3.25, 5, 7, '2024-05-02 11:51:56'),
(5, 35, 11, 5, 0, 1, 3, 0, 0, 1, 0, 39, 1, ' 4 ', ' 114 ', ' 137 ', ' 145 ', 2.11, 2.38, 2.1, 2.19, 2.13, 2.5, 2.21, 2.08, 2.12, 2.14, 3.12, 3.25, 3.08, 5, 12, '2024-05-02 11:52:25'),
(6, 35, 14, 2, 0, 1, 4, 1, 0, 1, 3, 38, 1, ' 3 ', ' 132 ', ' 131 ', ' 103 ', 2.38, 2.5, 2.25, 2.11, 2.1, 3.5, 2.13, 2.08, 2.3, 2.1, 3.25, 3.09, 3.09, 5, 9, '2024-05-02 11:52:37'),
(7, 35, 5, 4, 0, 0, 3, 3, 1, 1, 0, 39, 0, ' 4 ', ' 135 ', ' 109 ', ' 138 ', 2.09, 2.14, 2.75, 2.09, 2.13, 2.09, 2.08, 2.11, 2.08, 2.1, 3.17, 3.09, 3.25, 5, 7, '2024-05-02 12:10:29'),
(8, 35, 11, 5, 0, 1, 3, 0, 0, 1, 0, 39, 1, ' 4 ', ' 114 ', ' 137 ', ' 145 ', 2.11, 2.38, 2.1, 2.19, 2.13, 2.5, 2.21, 2.08, 2.12, 2.14, 3.12, 3.25, 3.08, 5, 12, '2024-05-02 12:10:58'),
(9, 35, 14, 2, 0, 1, 4, 1, 0, 1, 3, 38, 1, ' 3 ', ' 132 ', ' 131 ', ' 103 ', 2.38, 2.5, 2.25, 2.11, 2.1, 3.5, 2.13, 2.08, 2.3, 2.1, 3.25, 3.09, 3.09, 5, 9, '2024-05-02 12:11:10'),
(10, 35, 5, 4, 0, 0, 3, 3, 1, 1, 0, 39, 0, ' 4 ', ' 135 ', ' 109 ', ' 138 ', 2.09, 2.14, 2.75, 2.09, 2.13, 2.09, 2.08, 2.11, 2.08, 2.1, 3.17, 3.09, 3.25, 5, 7, '2024-05-02 12:39:25'),
(11, 35, 5, 4, 0, 0, 3, 3, 1, 1, 0, 39, 0, ' 4 ', ' 135 ', ' 109 ', ' 138 ', 2.09, 2.14, 2.75, 2.09, 2.13, 2.09, 2.08, 2.11, 2.08, 2.1, 3.17, 3.09, 3.25, 5, 7, '2024-05-03 11:37:11'),
(12, 35, 11, 5, 0, 1, 3, 0, 0, 1, 0, 39, 1, ' 4 ', ' 114 ', ' 137 ', ' 145 ', 2.11, 2.38, 2.1, 2.19, 2.13, 2.5, 2.21, 2.08, 2.12, 2.14, 3.12, 3.25, 3.08, 5, 12, '2024-05-03 11:37:20'),
(13, 35, 14, 2, 0, 1, 4, 1, 0, 1, 3, 38, 1, ' 3 ', ' 132 ', ' 131 ', ' 103 ', 2.38, 2.5, 2.25, 2.11, 2.1, 3.5, 2.13, 2.08, 2.3, 2.1, 3.25, 3.09, 3.09, 5, 9, '2024-05-03 11:37:34'),
(14, 35, 13, 5, 0, 1, 2, 2, 0, 0, 2, 34, 0, ' 2 ', ' 143 ', ' 142 ', ' 126 ', 2.09, 2.19, 2.1, 2.08, 2.19, 2.25, 2.09, 2.3, 2.19, 2.75, 3.21, 3.12, 3.11, 3, 12, '2024-05-03 11:37:57'),
(15, 35, 5, 4, 0, 0, 3, 3, 1, 1, 0, 39, 0, ' 4 ', ' 135 ', ' 109 ', ' 138 ', 2.09, 2.14, 2.75, 2.09, 2.13, 2.09, 2.08, 2.11, 2.08, 2.1, 3.17, 3.09, 3.25, 5, 7, '2024-05-03 11:53:17'),
(16, 35, 11, 5, 0, 1, 3, 0, 0, 1, 0, 39, 1, ' 4 ', ' 114 ', ' 137 ', ' 145 ', 2.11, 2.38, 2.1, 2.19, 2.13, 2.5, 2.21, 2.08, 2.12, 2.14, 3.12, 3.25, 3.08, 5, 12, '2024-05-03 11:53:46'),
(17, 35, 14, 2, 0, 1, 4, 1, 0, 1, 3, 38, 1, ' 3 ', ' 132 ', ' 131 ', ' 103 ', 2.38, 2.5, 2.25, 2.11, 2.1, 3.5, 2.13, 2.08, 2.3, 2.1, 3.25, 3.09, 3.09, 5, 9, '2024-05-03 11:53:58'),
(18, 35, 13, 5, 0, 1, 2, 2, 0, 0, 2, 34, 0, ' 2 ', ' 143 ', ' 142 ', ' 126 ', 2.09, 2.19, 2.1, 2.08, 2.19, 2.25, 2.09, 2.3, 2.19, 2.75, 3.21, 3.12, 3.11, 3, 12, '2024-05-03 11:55:14'),
(19, 35, 0, 5, 0, 0, 5, 2, 1, 0, 5, 26, 1, ' 2 ', ' 124 ', ' 143 ', ' 131 ', 2.25, 2.15, 2.15, 2.5, 2.11, 2.15, 2.09, 2.5, 2.13, 2.13, 3.13, 3.08, 3.19, 3, 10, '2024-05-03 11:57:57'),
(20, 35, 23, 7, 0, 1, 0, 1, 1, 1, 1, 42, 1, ' 2 ', ' 121 ', ' 149 ', ' 133 ', 2.15, 2.12, 2.19, 2.09, 2.09, 2.08, 2.3, 2.14, 2.1, 2.38, 3.12, 3.14, 4.5, 3, 10, '2024-05-03 11:58:11'),
(21, 35, 1, 1, 0, 0, 1, 2, 0, 0, 5, 30, 1, ' 2 ', ' 105 ', ' 134 ', ' 107 ', 2.3, 2.09, 2.13, 2.75, 2.5, 2.12, 2.12, 2.38, 2.19, 2.11, 3.25, 3.09, 3.25, 5, 11, '2024-05-03 11:59:37'),
(22, 35, 3, 1, 1, 1, 4, 1, 0, 0, 2, 29, 1, ' 3 ', ' 138 ', ' 123 ', ' 129 ', 2.21, 2.09, 2.5, 3.5, 2.12, 2.08, 2.08, 2.19, 3.5, 2.5, 3.15, 3.38, 4.5, 7, 12, '2024-05-03 12:03:11');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_36`
--

CREATE TABLE `yd_36` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_36`
--

INSERT INTO `yd_36` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 36, 13, 1, 1, 1, 2, 5, 1, 0, 4, 48, 0, ' 1 ', ' 132 ', ' 109 ', ' 106 ', 2.21, 2.08, 2.21, 2.75, 2.12, 2.08, 2.15, 2.5, 2.1, 2.09, 3.19, 3.75, 3.08, 5, 8, '2024-05-02 09:57:25'),
(2, 36, 17, 6, 0, 0, 0, 0, 0, 0, 2, 31, 0, ' 4 ', ' 102 ', ' 134 ', ' 125 ', 2.15, 2.17, 2.14, 2.15, 2.08, 2.14, 2.21, 2.5, 3.5, 2.21, 3.1, 3.08, 3.08, 5, 7, '2024-05-02 09:58:29'),
(3, 36, 13, 2, 0, 1, 1, 4, 0, 1, 4, 28, 1, ' 4 ', ' 117 ', ' 136 ', ' 136 ', 2.08, 2.38, 2.09, 2.1, 2.15, 2.3, 2.14, 2.75, 2.11, 2.15, 4.5, 3.11, 3.12, 4, 12, '2024-05-02 09:58:52'),
(4, 36, 13, 1, 1, 1, 2, 5, 1, 0, 4, 48, 0, ' 1 ', ' 132 ', ' 109 ', ' 106 ', 2.21, 2.08, 2.21, 2.75, 2.12, 2.08, 2.15, 2.5, 2.1, 2.09, 3.19, 3.75, 3.08, 5, 8, '2024-05-02 11:51:48'),
(5, 36, 17, 6, 0, 0, 0, 0, 0, 0, 2, 31, 0, ' 4 ', ' 102 ', ' 134 ', ' 125 ', 2.15, 2.17, 2.14, 2.15, 2.08, 2.14, 2.21, 2.5, 3.5, 2.21, 3.1, 3.08, 3.08, 5, 7, '2024-05-02 11:52:52'),
(6, 36, 13, 1, 1, 1, 2, 5, 1, 0, 4, 48, 0, ' 1 ', ' 132 ', ' 109 ', ' 106 ', 2.21, 2.08, 2.21, 2.75, 2.12, 2.08, 2.15, 2.5, 2.1, 2.09, 3.19, 3.75, 3.08, 5, 8, '2024-05-02 12:10:21'),
(7, 36, 17, 6, 0, 0, 0, 0, 0, 0, 2, 31, 0, ' 4 ', ' 102 ', ' 134 ', ' 125 ', 2.15, 2.17, 2.14, 2.15, 2.08, 2.14, 2.21, 2.5, 3.5, 2.21, 3.1, 3.08, 3.08, 5, 7, '2024-05-02 12:11:24'),
(8, 36, 13, 2, 0, 1, 1, 4, 0, 1, 4, 28, 1, ' 4 ', ' 117 ', ' 136 ', ' 136 ', 2.08, 2.38, 2.09, 2.1, 2.15, 2.3, 2.14, 2.75, 2.11, 2.15, 4.5, 3.11, 3.12, 4, 12, '2024-05-02 12:11:47'),
(9, 36, 13, 1, 1, 1, 2, 5, 1, 0, 4, 48, 0, ' 1 ', ' 132 ', ' 109 ', ' 106 ', 2.21, 2.08, 2.21, 2.75, 2.12, 2.08, 2.15, 2.5, 2.1, 2.09, 3.19, 3.75, 3.08, 5, 8, '2024-05-02 12:39:17'),
(10, 36, 13, 1, 1, 1, 2, 5, 1, 0, 4, 48, 0, ' 1 ', ' 132 ', ' 109 ', ' 106 ', 2.21, 2.08, 2.21, 2.75, 2.12, 2.08, 2.15, 2.5, 2.1, 2.09, 3.19, 3.75, 3.08, 5, 8, '2024-05-03 11:37:05'),
(11, 36, 17, 6, 0, 0, 0, 0, 0, 0, 2, 31, 0, ' 4 ', ' 102 ', ' 134 ', ' 125 ', 2.15, 2.17, 2.14, 2.15, 2.08, 2.14, 2.21, 2.5, 3.5, 2.21, 3.1, 3.08, 3.08, 5, 7, '2024-05-03 11:37:39'),
(12, 36, 13, 2, 0, 1, 1, 4, 0, 1, 4, 28, 1, ' 4 ', ' 117 ', ' 136 ', ' 136 ', 2.08, 2.38, 2.09, 2.1, 2.15, 2.3, 2.14, 2.75, 2.11, 2.15, 4.5, 3.11, 3.12, 4, 12, '2024-05-03 11:37:45'),
(13, 36, 1, 6, 0, 1, 2, 3, 0, 0, 4, 45, 1, ' 2 ', ' 146 ', ' 101 ', ' 143 ', 3.5, 2.11, 2.25, 2.08, 2.38, 2.11, 2.17, 2.38, 2.1, 2.5, 3.5, 3.1, 3.25, 7, 7, '2024-05-03 11:37:58'),
(14, 36, 13, 1, 1, 1, 2, 5, 1, 0, 4, 48, 0, ' 1 ', ' 132 ', ' 109 ', ' 106 ', 2.21, 2.08, 2.21, 2.75, 2.12, 2.08, 2.15, 2.5, 2.1, 2.09, 3.19, 3.75, 3.08, 5, 8, '2024-05-03 11:53:09'),
(15, 36, 17, 6, 0, 0, 0, 0, 0, 0, 2, 31, 0, ' 4 ', ' 102 ', ' 134 ', ' 125 ', 2.15, 2.17, 2.14, 2.15, 2.08, 2.14, 2.21, 2.5, 3.5, 2.21, 3.1, 3.08, 3.08, 5, 7, '2024-05-03 11:54:12'),
(16, 36, 13, 2, 0, 1, 1, 4, 0, 1, 4, 28, 1, ' 4 ', ' 117 ', ' 136 ', ' 136 ', 2.08, 2.38, 2.09, 2.1, 2.15, 2.3, 2.14, 2.75, 2.11, 2.15, 4.5, 3.11, 3.12, 4, 12, '2024-05-03 11:54:35'),
(17, 36, 1, 6, 0, 1, 2, 3, 0, 0, 4, 45, 1, ' 2 ', ' 146 ', ' 101 ', ' 143 ', 3.5, 2.11, 2.25, 2.08, 2.38, 2.11, 2.17, 2.38, 2.1, 2.5, 3.5, 3.1, 3.25, 7, 7, '2024-05-03 11:55:26'),
(18, 36, 10, 0, 1, 1, 5, 2, 1, 0, 4, 41, 1, ' 3 ', ' 124 ', ' 133 ', ' 107 ', 2.17, 2.3, 2.14, 2.25, 2.14, 2.13, 2.14, 2.1, 2.09, 2.19, 3.15, 3.75, 3.25, 4, 8, '2024-05-03 12:00:45'),
(19, 36, 0, 5, 1, 0, 5, 5, 0, 0, 2, 25, 0, ' 4 ', ' 123 ', ' 129 ', ' 132 ', 3.5, 3.5, 2.25, 2.21, 2.12, 2.3, 2.17, 2.09, 2.09, 2.15, 3.12, 3.75, 3.5, 4, 9, '2024-05-03 12:01:18'),
(20, 36, 1, 9, 1, 1, 3, 2, 1, 1, 3, 25, 0, ' 1 ', ' 130 ', ' 148 ', ' 102 ', 2.25, 2.08, 3.5, 2.08, 2.13, 2.25, 2.19, 2.17, 2.5, 2.25, 3.11, 3.14, 3.75, 7, 10, '2024-05-03 12:01:37'),
(21, 36, 24, 4, 0, 1, 2, 0, 0, 1, 3, 27, 1, ' 2 ', ' 149 ', ' 113 ', ' 132 ', 2.17, 2.1, 2.17, 2.25, 2.1, 2.13, 2.75, 2.21, 2.09, 2.3, 3.13, 3.3, 3.11, 6, 11, '2024-05-03 12:01:53'),
(22, 36, 23, 0, 1, 0, 2, 2, 0, 0, 4, 47, 0, ' 1 ', ' 105 ', ' 113 ', ' 124 ', 3.5, 2.08, 2.15, 2.5, 2.17, 2.1, 2.5, 2.11, 2.38, 2.08, 3.14, 4.5, 3.5, 6, 12, '2024-05-03 12:02:28'),
(23, 36, 11, 6, 1, 0, 0, 5, 0, 1, 0, 49, 1, ' 4 ', ' 103 ', ' 101 ', ' 142 ', 2.08, 2.08, 2.15, 2.19, 2.1, 2.19, 2.11, 2.09, 2.08, 2.15, 3.5, 3.17, 3.12, 6, 11, '2024-05-03 12:02:49'),
(24, 36, 12, 9, 1, 0, 5, 0, 0, 0, 0, 25, 0, ' 3 ', ' 102 ', ' 103 ', ' 135 ', 2.17, 2.08, 2.75, 2.09, 2.75, 2.38, 2.3, 2.5, 2.17, 2.5, 3.1, 4.5, 3.19, 7, 12, '2024-05-03 12:02:51'),
(25, 36, 6, 1, 0, 1, 0, 0, 0, 1, 3, 28, 0, ' 4 ', ' 102 ', ' 108 ', ' 145 ', 2.09, 2.11, 2.12, 2.19, 2.08, 2.21, 2.38, 2.21, 2.13, 2.5, 3.09, 3.5, 3.08, 6, 10, '2024-05-03 12:04:54'),
(26, 36, 21, 6, 1, 0, 0, 1, 1, 0, 5, 38, 1, ' 2 ', ' 135 ', ' 130 ', ' 100 ', 2.08, 2.14, 3.5, 2.25, 2.21, 2.21, 2.09, 2.09, 2.17, 2.09, 3.09, 3.09, 3.3, 7, 11, '2024-05-03 12:05:52'),
(27, 36, 5, 1, 1, 0, 5, 3, 0, 0, 2, 49, 0, ' 4 ', ' 138 ', ' 135 ', ' 145 ', 2.5, 2.09, 2.14, 2.38, 2.1, 2.17, 2.21, 3.5, 2.3, 2.25, 3.09, 3.09, 3.09, 7, 7, '2024-05-03 12:06:18');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_37`
--

CREATE TABLE `yd_37` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_37`
--

INSERT INTO `yd_37` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 37, 10, 8, 0, 0, 5, 3, 0, 0, 3, 39, 0, ' 4 ', ' 148 ', ' 147 ', ' 145 ', 2.3, 3.5, 3.5, 2.12, 2.21, 2.08, 3.5, 2.11, 2.15, 2.15, 3.11, 3.14, 3.13, 5, 7, '2024-05-02 09:57:44'),
(2, 37, 17, 7, 0, 1, 3, 5, 0, 0, 1, 27, 0, ' 4 ', ' 126 ', ' 104 ', ' 148 ', 2.75, 2.21, 2.11, 3.5, 2.75, 2.3, 2.15, 2.21, 2.13, 2.75, 3.15, 3.17, 3.75, 7, 10, '2024-05-02 09:58:33'),
(3, 37, 10, 8, 0, 0, 5, 3, 0, 0, 3, 39, 0, ' 4 ', ' 148 ', ' 147 ', ' 145 ', 2.3, 3.5, 3.5, 2.12, 2.21, 2.08, 3.5, 2.11, 2.15, 2.15, 3.11, 3.14, 3.13, 5, 7, '2024-05-02 11:52:07'),
(4, 37, 10, 8, 0, 0, 5, 3, 0, 0, 3, 39, 0, ' 4 ', ' 148 ', ' 147 ', ' 145 ', 2.3, 3.5, 3.5, 2.12, 2.21, 2.08, 3.5, 2.11, 2.15, 2.15, 3.11, 3.14, 3.13, 5, 7, '2024-05-02 12:10:39'),
(5, 37, 17, 7, 0, 1, 3, 5, 0, 0, 1, 27, 0, ' 4 ', ' 126 ', ' 104 ', ' 148 ', 2.75, 2.21, 2.11, 3.5, 2.75, 2.3, 2.15, 2.21, 2.13, 2.75, 3.15, 3.17, 3.75, 7, 10, '2024-05-02 12:11:28'),
(6, 37, 10, 8, 0, 0, 5, 3, 0, 0, 3, 39, 0, ' 4 ', ' 148 ', ' 147 ', ' 145 ', 2.3, 3.5, 3.5, 2.12, 2.21, 2.08, 3.5, 2.11, 2.15, 2.15, 3.11, 3.14, 3.13, 5, 7, '2024-05-02 12:39:35'),
(7, 37, 10, 8, 0, 0, 5, 3, 0, 0, 3, 39, 0, ' 4 ', ' 148 ', ' 147 ', ' 145 ', 2.3, 3.5, 3.5, 2.12, 2.21, 2.08, 3.5, 2.11, 2.15, 2.15, 3.11, 3.14, 3.13, 5, 7, '2024-05-03 11:37:16'),
(8, 37, 17, 7, 0, 1, 3, 5, 0, 0, 1, 27, 0, ' 4 ', ' 126 ', ' 104 ', ' 148 ', 2.75, 2.21, 2.11, 3.5, 2.75, 2.3, 2.15, 2.21, 2.13, 2.75, 3.15, 3.17, 3.75, 7, 10, '2024-05-03 11:37:41'),
(9, 37, 10, 8, 0, 0, 5, 3, 0, 0, 3, 39, 0, ' 4 ', ' 148 ', ' 147 ', ' 145 ', 2.3, 3.5, 3.5, 2.12, 2.21, 2.08, 3.5, 2.11, 2.15, 2.15, 3.11, 3.14, 3.13, 5, 7, '2024-05-03 11:53:27'),
(10, 37, 17, 7, 0, 1, 3, 5, 0, 0, 1, 27, 0, ' 4 ', ' 126 ', ' 104 ', ' 148 ', 2.75, 2.21, 2.11, 3.5, 2.75, 2.3, 2.15, 2.21, 2.13, 2.75, 3.15, 3.17, 3.75, 7, 10, '2024-05-03 11:54:16'),
(11, 37, 12, 6, 0, 0, 5, 4, 1, 1, 5, 27, 1, ' 1 ', ' 148 ', ' 113 ', ' 146 ', 2.15, 2.11, 2.25, 2.08, 2.21, 2.38, 2.13, 2.21, 2.09, 2.75, 3.25, 3.13, 3.13, 4, 11, '2024-05-03 11:58:34'),
(12, 37, 22, 1, 0, 0, 5, 2, 0, 0, 3, 28, 0, ' 0 ', ' 129 ', ' 112 ', ' 120 ', 2.08, 2.09, 2.13, 2.1, 2.75, 2.15, 2.15, 3.5, 2.15, 3.5, 3.1, 3.5, 3.38, 4, 11, '2024-05-03 11:59:43'),
(13, 37, 15, 3, 1, 1, 2, 2, 1, 0, 3, 41, 1, ' 0 ', ' 132 ', ' 128 ', ' 140 ', 2.75, 2.3, 2.09, 2.09, 2.3, 2.75, 2.08, 2.08, 2.25, 2.09, 3.08, 3.08, 3.13, 5, 7, '2024-05-03 12:01:16'),
(14, 37, 9, 7, 1, 1, 3, 3, 0, 1, 5, 40, 0, ' 0 ', ' 109 ', ' 117 ', ' 119 ', 2.11, 2.09, 2.12, 2.75, 2.12, 2.25, 3.5, 2.12, 2.1, 2.11, 4.5, 3.08, 3.25, 6, 9, '2024-05-03 12:02:12'),
(15, 37, 3, 7, 0, 1, 2, 5, 0, 0, 5, 38, 1, ' 1 ', ' 148 ', ' 109 ', ' 149 ', 2.09, 2.13, 2.3, 2.3, 2.19, 2.38, 3.5, 2.25, 2.08, 2.15, 3.15, 3.15, 4.5, 5, 11, '2024-05-03 12:05:02'),
(16, 37, 11, 7, 0, 1, 0, 0, 1, 1, 2, 36, 1, ' 4 ', ' 112 ', ' 104 ', ' 110 ', 2.15, 2.17, 2.38, 2.5, 2.25, 2.11, 2.17, 2.14, 2.11, 2.21, 3.08, 3.1, 4.5, 5, 11, '2024-05-03 12:07:24');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_38`
--

CREATE TABLE `yd_38` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_38`
--

INSERT INTO `yd_38` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 38, 7, 6, 1, 0, 2, 5, 1, 0, 3, 28, 0, ' 1 ', ' 105 ', ' 100 ', ' 125 ', 2.09, 2.17, 2.1, 2.75, 2.08, 3.5, 2.21, 2.09, 2.3, 2.75, 3.08, 3.13, 3.19, 7, 11, '2024-05-02 09:58:23'),
(2, 38, 7, 6, 1, 0, 2, 5, 1, 0, 3, 28, 0, ' 1 ', ' 105 ', ' 100 ', ' 125 ', 2.09, 2.17, 2.1, 2.75, 2.08, 3.5, 2.21, 2.09, 2.3, 2.75, 3.08, 3.13, 3.19, 7, 11, '2024-05-02 11:52:46'),
(3, 38, 7, 6, 1, 0, 2, 5, 1, 0, 3, 28, 0, ' 1 ', ' 105 ', ' 100 ', ' 125 ', 2.09, 2.17, 2.1, 2.75, 2.08, 3.5, 2.21, 2.09, 2.3, 2.75, 3.08, 3.13, 3.19, 7, 11, '2024-05-02 12:11:18'),
(4, 38, 7, 6, 1, 0, 2, 5, 1, 0, 3, 28, 0, ' 1 ', ' 105 ', ' 100 ', ' 125 ', 2.09, 2.17, 2.1, 2.75, 2.08, 3.5, 2.21, 2.09, 2.3, 2.75, 3.08, 3.13, 3.19, 7, 11, '2024-05-03 11:37:38'),
(5, 38, 7, 6, 1, 0, 2, 5, 1, 0, 3, 28, 0, ' 1 ', ' 105 ', ' 100 ', ' 125 ', 2.09, 2.17, 2.1, 2.75, 2.08, 3.5, 2.21, 2.09, 2.3, 2.75, 3.08, 3.13, 3.19, 7, 11, '2024-05-03 11:54:06'),
(6, 38, 17, 8, 0, 0, 0, 5, 1, 1, 2, 48, 1, ' 4 ', ' 140 ', ' 108 ', ' 100 ', 2.12, 2.25, 2.15, 2.12, 2.19, 2.14, 2.09, 2.14, 2.08, 2.5, 3.12, 3.21, 3.12, 3, 10, '2024-05-03 11:56:51'),
(7, 38, 14, 1, 0, 0, 4, 0, 1, 1, 5, 33, 0, ' 2 ', ' 139 ', ' 135 ', ' 113 ', 3.5, 2.08, 3.5, 2.15, 2.09, 2.1, 2.1, 2.14, 2.5, 2.38, 3.75, 3.21, 3.11, 7, 10, '2024-05-03 11:57:32'),
(8, 38, 23, 5, 1, 0, 5, 5, 0, 0, 4, 40, 0, ' 1 ', ' 119 ', ' 117 ', ' 120 ', 2.3, 2.13, 2.1, 2.1, 2.13, 2.5, 3.5, 2.75, 2.38, 2.21, 3.14, 3.14, 3.5, 7, 8, '2024-05-03 12:03:15'),
(9, 38, 20, 4, 0, 1, 0, 3, 1, 1, 3, 49, 0, ' 1 ', ' 115 ', ' 137 ', ' 117 ', 2.13, 2.3, 2.19, 2.19, 2.21, 2.75, 2.08, 2.75, 2.75, 2.25, 3.11, 3.09, 3.3, 4, 12, '2024-05-03 12:04:58'),
(10, 38, 13, 4, 0, 0, 4, 3, 0, 0, 0, 45, 0, ' 2 ', ' 126 ', ' 145 ', ' 120 ', 2.21, 2.38, 2.11, 2.19, 2.14, 2.5, 3.5, 2.19, 2.11, 2.5, 3.15, 3.75, 3.15, 5, 12, '2024-05-03 12:08:14'),
(11, 38, 17, 3, 1, 1, 3, 5, 0, 1, 0, 47, 0, ' 1 ', ' 147 ', ' 108 ', ' 108 ', 3.5, 2.11, 2.12, 2.08, 2.08, 2.09, 2.12, 2.3, 2.17, 2.09, 3.17, 3.11, 3.19, 7, 12, '2024-05-03 12:08:22');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_39`
--

CREATE TABLE `yd_39` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_39`
--

INSERT INTO `yd_39` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 39, 6, 3, 1, 0, 2, 4, 0, 0, 5, 30, 0, ' 4 ', ' 113 ', ' 123 ', ' 112 ', 2.3, 2.13, 2.38, 2.75, 2.1, 2.19, 2.19, 2.08, 2.19, 2.38, 3.1, 3.3, 3.14, 3, 8, '2024-05-02 09:57:15'),
(2, 39, 6, 3, 1, 0, 2, 4, 0, 0, 5, 30, 0, ' 4 ', ' 113 ', ' 123 ', ' 112 ', 2.3, 2.13, 2.38, 2.75, 2.1, 2.19, 2.19, 2.08, 2.19, 2.38, 3.1, 3.3, 3.14, 3, 8, '2024-05-02 11:51:38'),
(3, 39, 6, 3, 1, 0, 2, 4, 0, 0, 5, 30, 0, ' 4 ', ' 113 ', ' 123 ', ' 112 ', 2.3, 2.13, 2.38, 2.75, 2.1, 2.19, 2.19, 2.08, 2.19, 2.38, 3.1, 3.3, 3.14, 3, 8, '2024-05-02 12:10:10'),
(4, 39, 6, 3, 1, 0, 2, 4, 0, 0, 5, 30, 0, ' 4 ', ' 113 ', ' 123 ', ' 112 ', 2.3, 2.13, 2.38, 2.75, 2.1, 2.19, 2.19, 2.08, 2.19, 2.38, 3.1, 3.3, 3.14, 3, 8, '2024-05-02 12:39:06'),
(5, 39, 6, 3, 1, 0, 2, 4, 0, 0, 5, 30, 0, ' 4 ', ' 113 ', ' 123 ', ' 112 ', 2.3, 2.13, 2.38, 2.75, 2.1, 2.19, 2.19, 2.08, 2.19, 2.38, 3.1, 3.3, 3.14, 3, 8, '2024-05-03 11:36:59'),
(6, 39, 6, 3, 1, 0, 2, 4, 0, 0, 5, 30, 0, ' 4 ', ' 113 ', ' 123 ', ' 112 ', 2.3, 2.13, 2.38, 2.75, 2.1, 2.19, 2.19, 2.08, 2.19, 2.38, 3.1, 3.3, 3.14, 3, 8, '2024-05-03 11:52:58'),
(7, 39, 20, 6, 1, 0, 2, 4, 1, 0, 2, 38, 0, ' 3 ', ' 134 ', ' 103 ', ' 124 ', 2.11, 2.12, 2.3, 2.3, 2.15, 2.12, 2.11, 2.14, 2.38, 2.75, 3.75, 3.1, 3.09, 5, 8, '2024-05-03 11:57:38'),
(8, 39, 5, 0, 0, 0, 5, 5, 1, 0, 2, 47, 1, ' 2 ', ' 114 ', ' 141 ', ' 144 ', 2.11, 2.09, 2.11, 2.09, 2.09, 2.5, 2.09, 2.75, 2.1, 2.14, 3.11, 3.1, 3.38, 7, 9, '2024-05-03 11:58:52'),
(9, 39, 24, 6, 1, 0, 1, 0, 0, 1, 1, 37, 1, ' 4 ', ' 132 ', ' 146 ', ' 132 ', 2.17, 2.38, 2.3, 2.19, 2.09, 2.25, 2.38, 2.14, 2.09, 3.5, 3.08, 3.08, 3.11, 3, 10, '2024-05-03 12:00:29'),
(10, 39, 13, 9, 0, 0, 2, 2, 0, 0, 4, 34, 1, ' 2 ', ' 141 ', ' 105 ', ' 136 ', 2.75, 2.5, 2.3, 2.5, 2.15, 2.25, 2.38, 3.5, 2.08, 2.25, 3.09, 3.25, 3.19, 7, 8, '2024-05-03 12:04:17'),
(11, 39, 3, 6, 0, 0, 5, 4, 0, 0, 1, 34, 1, ' 2 ', ' 117 ', ' 134 ', ' 121 ', 2.15, 2.14, 2.3, 2.13, 2.25, 2.3, 2.38, 2.08, 2.21, 2.14, 3.75, 3.21, 3.09, 6, 11, '2024-05-03 12:05:08'),
(12, 39, 5, 1, 0, 1, 5, 5, 1, 0, 0, 34, 1, ' 0 ', ' 125 ', ' 130 ', ' 111 ', 2.25, 2.17, 2.38, 2.25, 2.08, 2.11, 2.09, 3.5, 3.5, 2.15, 3.75, 3.14, 3.25, 3, 8, '2024-05-03 12:06:16'),
(13, 39, 17, 6, 1, 1, 4, 2, 1, 1, 2, 43, 1, ' 1 ', ' 103 ', ' 126 ', ' 107 ', 2.09, 2.09, 2.11, 2.25, 2.25, 2.19, 2.75, 2.15, 2.19, 2.14, 3.21, 3.21, 3.12, 5, 11, '2024-05-03 12:07:39'),
(14, 39, 9, 5, 0, 0, 5, 2, 1, 0, 3, 38, 0, ' 2 ', ' 136 ', ' 120 ', ' 115 ', 2.1, 2.12, 2.08, 2.12, 2.5, 2.75, 2.5, 3.5, 3.5, 2.13, 3.08, 3.3, 3.75, 5, 7, '2024-05-03 12:08:16'),
(15, 39, 20, 5, 0, 1, 2, 1, 1, 0, 0, 41, 1, ' 4 ', ' 109 ', ' 112 ', ' 127 ', 3.5, 2.12, 2.19, 2.08, 2.5, 2.14, 2.75, 2.3, 2.21, 2.09, 3.14, 3.21, 3.09, 4, 11, '2024-05-03 12:09:01');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_40`
--

CREATE TABLE `yd_40` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_40`
--

INSERT INTO `yd_40` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 40, 23, 0, 0, 0, 0, 4, 1, 1, 0, 30, 0, ' 4 ', ' 110 ', ' 120 ', ' 140 ', 2.38, 3.5, 2.14, 2.21, 2.09, 2.25, 2.08, 3.5, 2.08, 2.11, 3.11, 3.21, 3.09, 5, 10, '2024-05-02 09:58:13'),
(2, 40, 15, 7, 1, 1, 1, 1, 0, 0, 3, 38, 1, ' 1 ', ' 120 ', ' 119 ', ' 143 ', 2.11, 2.13, 2.14, 2.09, 2.25, 2.13, 2.17, 2.08, 2.1, 2.15, 3.09, 3.17, 3.19, 3, 7, '2024-05-02 09:59:06'),
(3, 40, 23, 0, 0, 0, 0, 4, 1, 1, 0, 30, 0, ' 4 ', ' 110 ', ' 120 ', ' 140 ', 2.38, 3.5, 2.14, 2.21, 2.09, 2.25, 2.08, 3.5, 2.08, 2.11, 3.11, 3.21, 3.09, 5, 10, '2024-05-02 11:52:35'),
(4, 40, 23, 0, 0, 0, 0, 4, 1, 1, 0, 30, 0, ' 4 ', ' 110 ', ' 120 ', ' 140 ', 2.38, 3.5, 2.14, 2.21, 2.09, 2.25, 2.08, 3.5, 2.08, 2.11, 3.11, 3.21, 3.09, 5, 10, '2024-05-02 12:11:08'),
(5, 40, 23, 0, 0, 0, 0, 4, 1, 1, 0, 30, 0, ' 4 ', ' 110 ', ' 120 ', ' 140 ', 2.38, 3.5, 2.14, 2.21, 2.09, 2.25, 2.08, 3.5, 2.08, 2.11, 3.11, 3.21, 3.09, 5, 10, '2024-05-03 11:37:33'),
(6, 40, 15, 7, 1, 1, 1, 1, 0, 0, 3, 38, 1, ' 1 ', ' 120 ', ' 119 ', ' 143 ', 2.11, 2.13, 2.14, 2.09, 2.25, 2.13, 2.17, 2.08, 2.1, 2.15, 3.09, 3.17, 3.19, 3, 7, '2024-05-03 11:37:49'),
(7, 40, 23, 0, 0, 0, 0, 4, 1, 1, 0, 30, 0, ' 4 ', ' 110 ', ' 120 ', ' 140 ', 2.38, 3.5, 2.14, 2.21, 2.09, 2.25, 2.08, 3.5, 2.08, 2.11, 3.11, 3.21, 3.09, 5, 10, '2024-05-03 11:53:56'),
(8, 40, 15, 7, 1, 1, 1, 1, 0, 0, 3, 38, 1, ' 1 ', ' 120 ', ' 119 ', ' 143 ', 2.11, 2.13, 2.14, 2.09, 2.25, 2.13, 2.17, 2.08, 2.1, 2.15, 3.09, 3.17, 3.19, 3, 7, '2024-05-03 11:54:49'),
(9, 40, 11, 6, 1, 1, 5, 0, 0, 1, 2, 31, 1, ' 2 ', ' 121 ', ' 138 ', ' 121 ', 2.1, 2.08, 2.19, 2.21, 2.11, 2.09, 2.14, 2.38, 2.12, 2.3, 3.09, 3.75, 3.19, 7, 9, '2024-05-03 12:02:14'),
(10, 40, 9, 1, 0, 1, 4, 2, 0, 0, 5, 45, 0, ' 3 ', ' 148 ', ' 106 ', ' 108 ', 2.38, 2.19, 2.11, 2.1, 2.38, 3.5, 2.19, 2.09, 2.19, 2.08, 3.17, 3.19, 3.1, 3, 8, '2024-05-03 12:02:32'),
(11, 40, 22, 7, 1, 1, 0, 1, 0, 1, 1, 26, 0, ' 1 ', ' 120 ', ' 102 ', ' 100 ', 2.75, 2.11, 2.15, 2.38, 2.11, 2.5, 2.09, 2.09, 2.38, 2.09, 3.09, 3.38, 3.1, 3, 12, '2024-05-03 12:02:42'),
(12, 40, 15, 0, 0, 1, 2, 1, 1, 0, 0, 37, 0, ' 4 ', ' 118 ', ' 138 ', ' 134 ', 2.75, 3.5, 3.5, 2.21, 2.3, 2.1, 2.75, 2.12, 2.09, 2.25, 3.1, 4.5, 3.08, 5, 9, '2024-05-03 12:05:31'),
(13, 40, 23, 5, 0, 0, 5, 5, 0, 1, 2, 34, 0, ' 0 ', ' 104 ', ' 102 ', ' 134 ', 2.08, 2.19, 2.17, 2.21, 2.38, 2.38, 2.17, 2.19, 2.08, 2.08, 3.38, 3.19, 4.5, 6, 12, '2024-05-03 12:06:20'),
(14, 40, 16, 8, 1, 1, 5, 1, 0, 0, 4, 25, 1, ' 0 ', ' 115 ', ' 124 ', ' 119 ', 2.15, 2.75, 2.1, 2.3, 2.19, 2.11, 2.1, 2.19, 2.17, 2.3, 3.08, 3.15, 3.19, 3, 7, '2024-05-03 12:07:53');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_41`
--

CREATE TABLE `yd_41` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_41`
--

INSERT INTO `yd_41` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 41, 9, 3, 1, 1, 1, 2, 1, 1, 3, 46, 1, ' 3 ', ' 120 ', ' 144 ', ' 118 ', 2.11, 2.38, 2.14, 2.15, 2.75, 2.1, 2.14, 2.25, 2.1, 2.21, 3.11, 3.13, 3.14, 4, 10, '2024-05-02 09:55:59'),
(2, 41, 22, 9, 1, 1, 0, 4, 0, 1, 2, 43, 1, ' 4 ', ' 103 ', ' 133 ', ' 123 ', 2.21, 2.14, 2.08, 2.08, 3.5, 2.12, 2.13, 2.12, 2.11, 2.17, 3.08, 3.75, 3.17, 5, 7, '2024-05-02 09:57:13'),
(3, 41, 9, 3, 1, 1, 1, 2, 1, 1, 3, 46, 1, ' 3 ', ' 120 ', ' 144 ', ' 118 ', 2.11, 2.38, 2.14, 2.15, 2.75, 2.1, 2.14, 2.25, 2.1, 2.21, 3.11, 3.13, 3.14, 4, 10, '2024-05-02 10:08:54'),
(4, 41, 9, 3, 1, 1, 1, 2, 1, 1, 3, 46, 1, ' 3 ', ' 120 ', ' 144 ', ' 118 ', 2.11, 2.38, 2.14, 2.15, 2.75, 2.1, 2.14, 2.25, 2.1, 2.21, 3.11, 3.13, 3.14, 4, 10, '2024-05-02 10:11:32'),
(5, 41, 9, 3, 1, 1, 1, 2, 1, 1, 3, 46, 1, ' 3 ', ' 120 ', ' 144 ', ' 118 ', 2.11, 2.38, 2.14, 2.15, 2.75, 2.1, 2.14, 2.25, 2.1, 2.21, 3.11, 3.13, 3.14, 4, 10, '2024-05-02 10:13:17'),
(6, 41, 9, 3, 1, 1, 1, 2, 1, 1, 3, 46, 1, ' 3 ', ' 120 ', ' 144 ', ' 118 ', 2.11, 2.38, 2.14, 2.15, 2.75, 2.1, 2.14, 2.25, 2.1, 2.21, 3.11, 3.13, 3.14, 4, 10, '2024-05-02 10:14:19'),
(7, 41, 9, 3, 1, 1, 1, 2, 1, 1, 3, 46, 1, ' 3 ', ' 120 ', ' 144 ', ' 118 ', 2.11, 2.38, 2.14, 2.15, 2.75, 2.1, 2.14, 2.25, 2.1, 2.21, 3.11, 3.13, 3.14, 4, 10, '2024-05-02 10:17:54'),
(8, 41, 9, 3, 1, 1, 1, 2, 1, 1, 3, 46, 1, ' 3 ', ' 120 ', ' 144 ', ' 118 ', 2.11, 2.38, 2.14, 2.15, 2.75, 2.1, 2.14, 2.25, 2.1, 2.21, 3.11, 3.13, 3.14, 4, 10, '2024-05-02 10:23:27'),
(9, 41, 9, 3, 1, 1, 1, 2, 1, 1, 3, 46, 1, ' 3 ', ' 120 ', ' 144 ', ' 118 ', 2.11, 2.38, 2.14, 2.15, 2.75, 2.1, 2.14, 2.25, 2.1, 2.21, 3.11, 3.13, 3.14, 4, 10, '2024-05-02 10:26:18'),
(10, 41, 9, 3, 1, 1, 1, 2, 1, 1, 3, 46, 1, ' 3 ', ' 120 ', ' 144 ', ' 118 ', 2.11, 2.38, 2.14, 2.15, 2.75, 2.1, 2.14, 2.25, 2.1, 2.21, 3.11, 3.13, 3.14, 4, 10, '2024-05-02 10:28:33'),
(11, 41, 9, 3, 1, 1, 1, 2, 1, 1, 3, 46, 1, ' 3 ', ' 120 ', ' 144 ', ' 118 ', 2.11, 2.38, 2.14, 2.15, 2.75, 2.1, 2.14, 2.25, 2.1, 2.21, 3.11, 3.13, 3.14, 4, 10, '2024-05-02 10:46:17'),
(12, 41, 9, 3, 1, 1, 1, 2, 1, 1, 3, 46, 1, ' 3 ', ' 120 ', ' 144 ', ' 118 ', 2.11, 2.38, 2.14, 2.15, 2.75, 2.1, 2.14, 2.25, 2.1, 2.21, 3.11, 3.13, 3.14, 4, 10, '2024-05-02 10:51:37'),
(13, 41, 9, 3, 1, 1, 1, 2, 1, 1, 3, 46, 1, ' 3 ', ' 120 ', ' 144 ', ' 118 ', 2.11, 2.38, 2.14, 2.15, 2.75, 2.1, 2.14, 2.25, 2.1, 2.21, 3.11, 3.13, 3.14, 4, 10, '2024-05-02 10:54:53'),
(14, 41, 9, 3, 1, 1, 1, 2, 1, 1, 3, 46, 1, ' 3 ', ' 120 ', ' 144 ', ' 118 ', 2.11, 2.38, 2.14, 2.15, 2.75, 2.1, 2.14, 2.25, 2.1, 2.21, 3.11, 3.13, 3.14, 4, 10, '2024-05-02 11:47:46'),
(15, 41, 9, 3, 1, 1, 1, 2, 1, 1, 3, 46, 1, ' 3 ', ' 120 ', ' 144 ', ' 118 ', 2.11, 2.38, 2.14, 2.15, 2.75, 2.1, 2.14, 2.25, 2.1, 2.21, 3.11, 3.13, 3.14, 4, 10, '2024-05-02 11:50:22'),
(16, 41, 22, 9, 1, 1, 0, 4, 0, 1, 2, 43, 1, ' 4 ', ' 103 ', ' 133 ', ' 123 ', 2.21, 2.14, 2.08, 2.08, 3.5, 2.12, 2.13, 2.12, 2.11, 2.17, 3.08, 3.75, 3.17, 5, 7, '2024-05-02 11:51:36'),
(17, 41, 9, 3, 1, 1, 1, 2, 1, 1, 3, 46, 1, ' 3 ', ' 120 ', ' 144 ', ' 118 ', 2.11, 2.38, 2.14, 2.15, 2.75, 2.1, 2.14, 2.25, 2.1, 2.21, 3.11, 3.13, 3.14, 4, 10, '2024-05-02 12:01:00'),
(18, 41, 9, 3, 1, 1, 1, 2, 1, 1, 3, 46, 1, ' 3 ', ' 120 ', ' 144 ', ' 118 ', 2.11, 2.38, 2.14, 2.15, 2.75, 2.1, 2.14, 2.25, 2.1, 2.21, 3.11, 3.13, 3.14, 4, 10, '2024-05-02 12:08:54'),
(19, 41, 22, 9, 1, 1, 0, 4, 0, 1, 2, 43, 1, ' 4 ', ' 103 ', ' 133 ', ' 123 ', 2.21, 2.14, 2.08, 2.08, 3.5, 2.12, 2.13, 2.12, 2.11, 2.17, 3.08, 3.75, 3.17, 5, 7, '2024-05-02 12:10:08'),
(20, 41, 9, 3, 1, 1, 1, 2, 1, 1, 3, 46, 1, ' 3 ', ' 120 ', ' 144 ', ' 118 ', 2.11, 2.38, 2.14, 2.15, 2.75, 2.1, 2.14, 2.25, 2.1, 2.21, 3.11, 3.13, 3.14, 4, 10, '2024-05-02 12:37:50'),
(21, 41, 22, 9, 1, 1, 0, 4, 0, 1, 2, 43, 1, ' 4 ', ' 103 ', ' 133 ', ' 123 ', 2.21, 2.14, 2.08, 2.08, 3.5, 2.12, 2.13, 2.12, 2.11, 2.17, 3.08, 3.75, 3.17, 5, 7, '2024-05-02 12:39:04'),
(22, 41, 9, 3, 1, 1, 1, 2, 1, 1, 3, 46, 1, ' 3 ', ' 120 ', ' 144 ', ' 118 ', 2.11, 2.38, 2.14, 2.15, 2.75, 2.1, 2.14, 2.25, 2.1, 2.21, 3.11, 3.13, 3.14, 4, 10, '2024-05-02 12:52:21'),
(23, 41, 9, 3, 1, 1, 1, 2, 1, 1, 3, 46, 1, ' 3 ', ' 120 ', ' 144 ', ' 118 ', 2.11, 2.38, 2.14, 2.15, 2.75, 2.1, 2.14, 2.25, 2.1, 2.21, 3.11, 3.13, 3.14, 4, 10, '2024-05-03 11:34:15'),
(24, 41, 22, 9, 1, 1, 0, 4, 0, 1, 2, 43, 1, ' 4 ', ' 103 ', ' 133 ', ' 123 ', 2.21, 2.14, 2.08, 2.08, 3.5, 2.12, 2.13, 2.12, 2.11, 2.17, 3.08, 3.75, 3.17, 5, 7, '2024-05-03 11:36:55'),
(25, 41, 9, 3, 1, 1, 1, 2, 1, 1, 3, 46, 1, ' 3 ', ' 120 ', ' 144 ', ' 118 ', 2.11, 2.38, 2.14, 2.15, 2.75, 2.1, 2.14, 2.25, 2.1, 2.21, 3.11, 3.13, 3.14, 4, 10, '2024-05-03 11:51:42'),
(26, 41, 22, 9, 1, 1, 0, 4, 0, 1, 2, 43, 1, ' 4 ', ' 103 ', ' 133 ', ' 123 ', 2.21, 2.14, 2.08, 2.08, 3.5, 2.12, 2.13, 2.12, 2.11, 2.17, 3.08, 3.75, 3.17, 5, 7, '2024-05-03 11:52:56'),
(27, 41, 21, 2, 1, 1, 5, 3, 1, 1, 3, 26, 0, ' 2 ', ' 105 ', ' 119 ', ' 106 ', 2.08, 2.12, 2.12, 2.25, 2.12, 2.21, 2.12, 2.17, 2.17, 2.19, 3.75, 3.12, 3.12, 7, 11, '2024-05-03 11:57:19'),
(28, 41, 19, 1, 0, 1, 3, 2, 1, 1, 5, 35, 1, ' 2 ', ' 134 ', ' 117 ', ' 125 ', 2.12, 2.08, 2.12, 2.1, 2.09, 2.5, 2.75, 2.25, 2.5, 2.3, 3.1, 3.5, 3.1, 6, 8, '2024-05-03 12:00:27'),
(29, 41, 18, 7, 1, 0, 1, 2, 1, 1, 2, 41, 1, ' 4 ', ' 144 ', ' 108 ', ' 118 ', 2.14, 2.75, 2.09, 2.75, 2.17, 2.38, 3.5, 2.08, 2.14, 2.21, 3.3, 3.25, 3.09, 4, 7, '2024-05-03 12:00:43'),
(30, 41, 7, 4, 1, 1, 0, 4, 0, 0, 5, 33, 0, ' 2 ', ' 147 ', ' 142 ', ' 109 ', 2.25, 2.08, 2.09, 2.38, 2.11, 2.17, 2.15, 3.5, 2.21, 2.11, 3.25, 3.14, 3.14, 7, 8, '2024-05-03 12:05:17'),
(31, 41, 12, 6, 0, 1, 1, 0, 0, 0, 5, 33, 0, ' 2 ', ' 134 ', ' 142 ', ' 148 ', 2.12, 2.21, 3.5, 3.5, 2.08, 2.08, 2.08, 2.38, 2.5, 2.17, 3.38, 3.17, 3.15, 7, 7, '2024-05-03 12:07:18'),
(32, 41, 15, 4, 0, 0, 3, 5, 0, 0, 3, 45, 0, ' 2 ', ' 119 ', ' 102 ', ' 140 ', 2.3, 2.1, 2.11, 3.5, 2.08, 2.09, 2.38, 3.5, 2.17, 2.17, 3.12, 3.3, 4.5, 6, 11, '2024-05-03 12:07:34');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_42`
--

CREATE TABLE `yd_42` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_42`
--

INSERT INTO `yd_42` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 42, 5, 8, 0, 1, 1, 1, 0, 1, 3, 44, 1, ' 3 ', ' 100 ', ' 119 ', ' 105 ', 2.11, 2.38, 2.09, 2.1, 2.09, 2.08, 2.15, 2.14, 2.1, 2.08, 3.25, 3.14, 3.21, 6, 11, '2024-05-03 11:37:58'),
(2, 42, 5, 8, 0, 1, 1, 1, 0, 1, 3, 44, 1, ' 3 ', ' 100 ', ' 119 ', ' 105 ', 2.11, 2.38, 2.09, 2.1, 2.09, 2.08, 2.15, 2.14, 2.1, 2.08, 3.25, 3.14, 3.21, 6, 11, '2024-05-03 11:55:24'),
(3, 42, 10, 3, 1, 1, 3, 3, 1, 0, 1, 42, 1, ' 4 ', ' 144 ', ' 135 ', ' 146 ', 3.5, 3.5, 2.15, 2.3, 2.09, 3.5, 2.09, 2.1, 2.08, 2.75, 3.09, 3.38, 3.08, 7, 11, '2024-05-03 12:02:34'),
(4, 42, 1, 1, 0, 0, 3, 4, 1, 0, 5, 45, 1, ' 2 ', ' 130 ', ' 124 ', ' 142 ', 2.14, 2.12, 2.13, 2.08, 2.17, 2.21, 2.08, 2.14, 2.11, 3.5, 3.17, 3.13, 3.12, 6, 9, '2024-05-03 12:02:40'),
(5, 42, 16, 9, 1, 0, 3, 1, 0, 0, 3, 37, 1, ' 3 ', ' 144 ', ' 117 ', ' 102 ', 2.13, 2.12, 2.12, 2.19, 2.21, 2.09, 2.38, 2.08, 2.11, 2.21, 3.38, 3.3, 3.25, 7, 7, '2024-05-03 12:05:50'),
(6, 42, 18, 9, 1, 0, 1, 2, 0, 1, 1, 36, 0, ' 0 ', ' 140 ', ' 103 ', ' 134 ', 2.12, 2.3, 2.25, 2.38, 2.25, 2.13, 2.12, 2.19, 2.21, 2.75, 3.5, 3.21, 3.08, 7, 8, '2024-05-03 12:06:41'),
(7, 42, 17, 1, 1, 0, 4, 3, 1, 1, 3, 41, 0, ' 1 ', ' 146 ', ' 132 ', ' 140 ', 2.09, 2.3, 2.14, 2.11, 2.09, 2.12, 3.5, 2.3, 2.12, 2.38, 3.14, 3.19, 3.09, 3, 11, '2024-05-03 12:08:26'),
(8, 42, 21, 4, 0, 0, 1, 4, 0, 1, 5, 32, 1, ' 1 ', ' 113 ', ' 100 ', ' 123 ', 2.11, 2.5, 2.21, 2.19, 2.08, 2.09, 2.25, 2.3, 2.11, 2.1, 3.12, 3.13, 3.13, 3, 12, '2024-05-03 12:08:36'),
(9, 42, 1, 9, 1, 0, 4, 3, 0, 0, 2, 25, 0, ' 0 ', ' 145 ', ' 135 ', ' 139 ', 2.11, 2.1, 2.3, 2.12, 2.09, 2.09, 2.11, 2.15, 2.13, 2.09, 3.11, 3.25, 3.38, 5, 7, '2024-05-03 12:08:48');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_43`
--

CREATE TABLE `yd_43` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_43`
--

INSERT INTO `yd_43` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 43, 13, 1, 1, 1, 2, 5, 0, 1, 1, 40, 0, ' 2 ', ' 132 ', ' 104 ', ' 109 ', 2.13, 2.3, 2.38, 2.75, 2.09, 2.38, 3.5, 2.08, 2.11, 2.3, 3.19, 3.21, 3.15, 3, 12, '2024-05-02 09:56:26'),
(2, 43, 16, 3, 0, 0, 4, 1, 1, 0, 3, 46, 1, ' 3 ', ' 128 ', ' 113 ', ' 135 ', 2.15, 2.75, 2.19, 2.14, 2.11, 2.14, 2.13, 2.08, 2.09, 2.08, 3.17, 3.13, 3.21, 3, 10, '2024-05-02 09:56:50'),
(3, 43, 13, 2, 1, 0, 4, 1, 1, 1, 0, 43, 0, ' 1 ', ' 109 ', ' 123 ', ' 148 ', 2.75, 2.75, 2.21, 2.17, 2.21, 2.12, 2.15, 2.08, 2.11, 2.12, 3.75, 3.3, 3.19, 5, 11, '2024-05-02 09:58:37'),
(4, 43, 13, 1, 1, 1, 2, 5, 0, 1, 1, 40, 0, ' 2 ', ' 132 ', ' 104 ', ' 109 ', 2.13, 2.3, 2.38, 2.75, 2.09, 2.38, 3.5, 2.08, 2.11, 2.3, 3.19, 3.21, 3.15, 3, 12, '2024-05-02 10:11:59'),
(5, 43, 16, 3, 0, 0, 4, 1, 1, 0, 3, 46, 1, ' 3 ', ' 128 ', ' 113 ', ' 135 ', 2.15, 2.75, 2.19, 2.14, 2.11, 2.14, 2.13, 2.08, 2.09, 2.08, 3.17, 3.13, 3.21, 3, 10, '2024-05-02 10:12:23'),
(6, 43, 13, 1, 1, 1, 2, 5, 0, 1, 1, 40, 0, ' 2 ', ' 132 ', ' 104 ', ' 109 ', 2.13, 2.3, 2.38, 2.75, 2.09, 2.38, 3.5, 2.08, 2.11, 2.3, 3.19, 3.21, 3.15, 3, 12, '2024-05-02 10:29:00'),
(7, 43, 13, 1, 1, 1, 2, 5, 0, 1, 1, 40, 0, ' 2 ', ' 132 ', ' 104 ', ' 109 ', 2.13, 2.3, 2.38, 2.75, 2.09, 2.38, 3.5, 2.08, 2.11, 2.3, 3.19, 3.21, 3.15, 3, 12, '2024-05-02 11:50:48'),
(8, 43, 16, 3, 0, 0, 4, 1, 1, 0, 3, 46, 1, ' 3 ', ' 128 ', ' 113 ', ' 135 ', 2.15, 2.75, 2.19, 2.14, 2.11, 2.14, 2.13, 2.08, 2.09, 2.08, 3.17, 3.13, 3.21, 3, 10, '2024-05-02 11:51:13'),
(9, 43, 13, 1, 1, 1, 2, 5, 0, 1, 1, 40, 0, ' 2 ', ' 132 ', ' 104 ', ' 109 ', 2.13, 2.3, 2.38, 2.75, 2.09, 2.38, 3.5, 2.08, 2.11, 2.3, 3.19, 3.21, 3.15, 3, 12, '2024-05-02 12:09:21'),
(10, 43, 16, 3, 0, 0, 4, 1, 1, 0, 3, 46, 1, ' 3 ', ' 128 ', ' 113 ', ' 135 ', 2.15, 2.75, 2.19, 2.14, 2.11, 2.14, 2.13, 2.08, 2.09, 2.08, 3.17, 3.13, 3.21, 3, 10, '2024-05-02 12:09:46'),
(11, 43, 13, 2, 1, 0, 4, 1, 1, 1, 0, 43, 0, ' 1 ', ' 109 ', ' 123 ', ' 148 ', 2.75, 2.75, 2.21, 2.17, 2.21, 2.12, 2.15, 2.08, 2.11, 2.12, 3.75, 3.3, 3.19, 5, 11, '2024-05-02 12:11:33'),
(12, 43, 13, 1, 1, 1, 2, 5, 0, 1, 1, 40, 0, ' 2 ', ' 132 ', ' 104 ', ' 109 ', 2.13, 2.3, 2.38, 2.75, 2.09, 2.38, 3.5, 2.08, 2.11, 2.3, 3.19, 3.21, 3.15, 3, 12, '2024-05-02 12:38:17'),
(13, 43, 16, 3, 0, 0, 4, 1, 1, 0, 3, 46, 1, ' 3 ', ' 128 ', ' 113 ', ' 135 ', 2.15, 2.75, 2.19, 2.14, 2.11, 2.14, 2.13, 2.08, 2.09, 2.08, 3.17, 3.13, 3.21, 3, 10, '2024-05-02 12:38:42'),
(14, 43, 13, 1, 1, 1, 2, 5, 0, 1, 1, 40, 0, ' 2 ', ' 132 ', ' 104 ', ' 109 ', 2.13, 2.3, 2.38, 2.75, 2.09, 2.38, 3.5, 2.08, 2.11, 2.3, 3.19, 3.21, 3.15, 3, 12, '2024-05-03 11:34:47'),
(15, 43, 16, 3, 0, 0, 4, 1, 1, 0, 3, 46, 1, ' 3 ', ' 128 ', ' 113 ', ' 135 ', 2.15, 2.75, 2.19, 2.14, 2.11, 2.14, 2.13, 2.08, 2.09, 2.08, 3.17, 3.13, 3.21, 3, 10, '2024-05-03 11:36:34'),
(16, 43, 13, 2, 1, 0, 4, 1, 1, 1, 0, 43, 0, ' 1 ', ' 109 ', ' 123 ', ' 148 ', 2.75, 2.75, 2.21, 2.17, 2.21, 2.12, 2.15, 2.08, 2.11, 2.12, 3.75, 3.3, 3.19, 5, 11, '2024-05-03 11:37:42'),
(17, 43, 15, 1, 1, 1, 4, 0, 1, 0, 2, 41, 1, ' 0 ', ' 104 ', ' 111 ', ' 108 ', 2.19, 3.5, 2.08, 2.5, 2.11, 2.13, 2.19, 2.15, 2.5, 2.21, 3.21, 4.5, 3.11, 7, 9, '2024-05-03 11:38:05'),
(18, 43, 13, 1, 1, 1, 2, 5, 0, 1, 1, 40, 0, ' 2 ', ' 132 ', ' 104 ', ' 109 ', 2.13, 2.3, 2.38, 2.75, 2.09, 2.38, 3.5, 2.08, 2.11, 2.3, 3.19, 3.21, 3.15, 3, 12, '2024-05-03 11:52:09'),
(19, 43, 16, 3, 0, 0, 4, 1, 1, 0, 3, 46, 1, ' 3 ', ' 128 ', ' 113 ', ' 135 ', 2.15, 2.75, 2.19, 2.14, 2.11, 2.14, 2.13, 2.08, 2.09, 2.08, 3.17, 3.13, 3.21, 3, 10, '2024-05-03 11:52:34'),
(20, 43, 13, 2, 1, 0, 4, 1, 1, 1, 0, 43, 0, ' 1 ', ' 109 ', ' 123 ', ' 148 ', 2.75, 2.75, 2.21, 2.17, 2.21, 2.12, 2.15, 2.08, 2.11, 2.12, 3.75, 3.3, 3.19, 5, 11, '2024-05-03 11:54:21'),
(21, 43, 15, 1, 1, 1, 4, 0, 1, 0, 2, 41, 1, ' 0 ', ' 104 ', ' 111 ', ' 108 ', 2.19, 3.5, 2.08, 2.5, 2.11, 2.13, 2.19, 2.15, 2.5, 2.21, 3.21, 4.5, 3.11, 7, 9, '2024-05-03 11:55:35'),
(22, 43, 5, 2, 1, 0, 2, 0, 1, 1, 5, 43, 0, ' 3 ', ' 137 ', ' 114 ', ' 111 ', 2.5, 2.38, 2.17, 2.14, 2.3, 2.21, 2.09, 2.17, 2.5, 2.09, 3.08, 3.12, 3.08, 6, 10, '2024-05-03 11:57:36'),
(23, 43, 10, 9, 0, 1, 3, 5, 0, 1, 3, 44, 0, ' 4 ', ' 133 ', ' 119 ', ' 126 ', 2.17, 2.5, 2.11, 2.08, 2.14, 3.5, 2.11, 2.75, 2.75, 2.17, 3.08, 4.5, 3.25, 5, 12, '2024-05-03 11:58:29'),
(24, 43, 22, 3, 0, 0, 3, 1, 1, 0, 5, 38, 1, ' 0 ', ' 119 ', ' 132 ', ' 111 ', 2.14, 2.15, 2.12, 2.75, 2.21, 2.38, 2.11, 2.38, 2.08, 2.3, 3.19, 3.19, 3.19, 4, 10, '2024-05-03 11:59:17'),
(25, 43, 3, 5, 0, 0, 3, 4, 1, 1, 2, 42, 0, ' 0 ', ' 111 ', ' 107 ', ' 140 ', 2.15, 2.08, 2.13, 2.3, 2.75, 2.3, 2.12, 2.12, 2.1, 2.13, 3.08, 3.14, 3.08, 4, 10, '2024-05-03 12:00:00'),
(26, 43, 7, 0, 0, 1, 5, 3, 0, 0, 3, 38, 1, ' 4 ', ' 122 ', ' 119 ', ' 107 ', 2.15, 2.3, 2.09, 2.08, 2.11, 3.5, 2.17, 2.1, 2.17, 2.08, 3.09, 3.1, 3.11, 6, 10, '2024-05-03 12:01:06'),
(27, 43, 3, 4, 0, 0, 3, 0, 1, 1, 0, 27, 1, ' 1 ', ' 100 ', ' 104 ', ' 126 ', 2.25, 2.09, 3.5, 2.08, 2.75, 2.09, 2.08, 2.3, 2.3, 2.1, 3.3, 3.11, 3.12, 4, 10, '2024-05-03 12:04:36'),
(28, 43, 0, 7, 0, 1, 3, 3, 0, 1, 2, 39, 0, ' 2 ', ' 101 ', ' 113 ', ' 129 ', 2.08, 2.12, 2.08, 2.19, 3.5, 2.25, 2.13, 2.15, 2.15, 2.3, 3.09, 3.12, 3.75, 6, 12, '2024-05-03 12:06:02');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_44`
--

CREATE TABLE `yd_44` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_44`
--

INSERT INTO `yd_44` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 44, 1, 4, 1, 0, 1, 1, 1, 0, 2, 32, 0, ' 1 ', ' 147 ', ' 114 ', ' 145 ', 3.5, 2.75, 2.25, 2.25, 2.75, 2.75, 2.09, 2.17, 2.5, 2.08, 3.09, 3.11, 3.09, 5, 12, '2024-05-03 12:02:57'),
(2, 44, 7, 2, 1, 0, 5, 0, 0, 0, 4, 31, 1, ' 4 ', ' 148 ', ' 138 ', ' 131 ', 2.17, 2.08, 2.09, 2.3, 2.1, 2.09, 2.09, 2.14, 3.5, 2.09, 3.08, 3.09, 3.08, 6, 10, '2024-05-03 12:03:05'),
(3, 44, 7, 8, 1, 0, 3, 2, 1, 1, 5, 34, 0, ' 0 ', ' 112 ', ' 130 ', ' 137 ', 2.1, 3.5, 2.19, 2.14, 2.19, 2.09, 2.08, 2.1, 2.08, 2.14, 3.13, 3.13, 3.09, 6, 12, '2024-05-03 12:06:47');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_45`
--

CREATE TABLE `yd_45` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_45`
--

INSERT INTO `yd_45` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 45, 18, 7, 0, 0, 5, 1, 0, 1, 2, 45, 0, ' 4 ', ' 112 ', ' 126 ', ' 117 ', 2.14, 2.13, 2.14, 2.09, 2.14, 2.38, 2.3, 2.08, 2.1, 2.38, 3.3, 3.3, 3.5, 5, 9, '2024-05-02 09:56:48'),
(2, 45, 15, 8, 0, 1, 3, 5, 1, 0, 4, 37, 1, ' 2 ', ' 112 ', ' 131 ', ' 135 ', 2.38, 2.08, 2.15, 2.08, 2.1, 2.25, 2.08, 2.17, 2.38, 2.17, 3.08, 3.15, 3.13, 6, 9, '2024-05-02 09:58:27'),
(3, 45, 18, 7, 0, 0, 5, 1, 0, 1, 2, 45, 0, ' 4 ', ' 112 ', ' 126 ', ' 117 ', 2.14, 2.13, 2.14, 2.09, 2.14, 2.38, 2.3, 2.08, 2.1, 2.38, 3.3, 3.3, 3.5, 5, 9, '2024-05-02 10:12:21'),
(4, 45, 18, 7, 0, 0, 5, 1, 0, 1, 2, 45, 0, ' 4 ', ' 112 ', ' 126 ', ' 117 ', 2.14, 2.13, 2.14, 2.09, 2.14, 2.38, 2.3, 2.08, 2.1, 2.38, 3.3, 3.3, 3.5, 5, 9, '2024-05-02 11:51:11'),
(5, 45, 15, 8, 0, 1, 3, 5, 1, 0, 4, 37, 1, ' 2 ', ' 112 ', ' 131 ', ' 135 ', 2.38, 2.08, 2.15, 2.08, 2.1, 2.25, 2.08, 2.17, 2.38, 2.17, 3.08, 3.15, 3.13, 6, 9, '2024-05-02 11:52:50'),
(6, 45, 18, 7, 0, 0, 5, 1, 0, 1, 2, 45, 0, ' 4 ', ' 112 ', ' 126 ', ' 117 ', 2.14, 2.13, 2.14, 2.09, 2.14, 2.38, 2.3, 2.08, 2.1, 2.38, 3.3, 3.3, 3.5, 5, 9, '2024-05-02 12:09:44'),
(7, 45, 15, 8, 0, 1, 3, 5, 1, 0, 4, 37, 1, ' 2 ', ' 112 ', ' 131 ', ' 135 ', 2.38, 2.08, 2.15, 2.08, 2.1, 2.25, 2.08, 2.17, 2.38, 2.17, 3.08, 3.15, 3.13, 6, 9, '2024-05-02 12:11:22'),
(8, 45, 18, 7, 0, 0, 5, 1, 0, 1, 2, 45, 0, ' 4 ', ' 112 ', ' 126 ', ' 117 ', 2.14, 2.13, 2.14, 2.09, 2.14, 2.38, 2.3, 2.08, 2.1, 2.38, 3.3, 3.3, 3.5, 5, 9, '2024-05-02 12:38:40'),
(9, 45, 18, 7, 0, 0, 5, 1, 0, 1, 2, 45, 0, ' 4 ', ' 112 ', ' 126 ', ' 117 ', 2.14, 2.13, 2.14, 2.09, 2.14, 2.38, 2.3, 2.08, 2.1, 2.38, 3.3, 3.3, 3.5, 5, 9, '2024-05-03 11:36:33'),
(10, 45, 15, 8, 0, 1, 3, 5, 1, 0, 4, 37, 1, ' 2 ', ' 112 ', ' 131 ', ' 135 ', 2.38, 2.08, 2.15, 2.08, 2.1, 2.25, 2.08, 2.17, 2.38, 2.17, 3.08, 3.15, 3.13, 6, 9, '2024-05-03 11:37:39'),
(11, 45, 18, 7, 0, 0, 5, 1, 0, 1, 2, 45, 0, ' 4 ', ' 112 ', ' 126 ', ' 117 ', 2.14, 2.13, 2.14, 2.09, 2.14, 2.38, 2.3, 2.08, 2.1, 2.38, 3.3, 3.3, 3.5, 5, 9, '2024-05-03 11:52:32'),
(12, 45, 15, 8, 0, 1, 3, 5, 1, 0, 4, 37, 1, ' 2 ', ' 112 ', ' 131 ', ' 135 ', 2.38, 2.08, 2.15, 2.08, 2.1, 2.25, 2.08, 2.17, 2.38, 2.17, 3.08, 3.15, 3.13, 6, 9, '2024-05-03 11:54:10'),
(13, 45, 10, 2, 0, 1, 3, 2, 0, 1, 0, 46, 1, ' 2 ', ' 116 ', ' 138 ', ' 133 ', 2.21, 2.13, 2.08, 2.17, 2.12, 2.09, 2.75, 2.1, 2.12, 2.11, 3.19, 3.13, 3.17, 4, 11, '2024-05-03 11:57:26'),
(14, 45, 11, 1, 0, 1, 4, 5, 1, 0, 4, 42, 1, ' 3 ', ' 109 ', ' 111 ', ' 144 ', 2.15, 2.17, 2.13, 2.5, 2.15, 2.25, 2.09, 2.14, 2.5, 2.08, 3.25, 4.5, 3.38, 5, 8, '2024-05-03 12:02:30'),
(15, 45, 9, 0, 1, 1, 1, 2, 0, 1, 2, 26, 1, ' 3 ', ' 138 ', ' 108 ', ' 121 ', 2.14, 2.08, 2.09, 2.1, 2.17, 2.09, 2.5, 2.38, 2.14, 2.11, 3.21, 3.14, 3.09, 7, 7, '2024-05-03 12:03:17'),
(16, 45, 7, 1, 0, 0, 0, 1, 1, 0, 1, 42, 1, ' 4 ', ' 126 ', ' 119 ', ' 123 ', 2.08, 2.12, 2.17, 3.5, 2.3, 2.09, 2.09, 2.19, 2.09, 2.13, 3.3, 3.19, 3.14, 6, 10, '2024-05-03 12:04:27'),
(17, 45, 14, 0, 0, 0, 5, 1, 1, 0, 2, 27, 0, ' 3 ', ' 103 ', ' 119 ', ' 148 ', 2.14, 2.13, 2.38, 2.15, 2.14, 2.11, 3.5, 2.08, 2.19, 2.25, 3.25, 3.14, 3.17, 5, 12, '2024-05-03 12:05:23'),
(18, 45, 5, 2, 0, 0, 1, 3, 1, 0, 4, 28, 1, ' 1 ', ' 134 ', ' 144 ', ' 137 ', 2.17, 2.1, 2.38, 2.08, 2.5, 2.19, 2.1, 2.1, 2.75, 2.13, 3.14, 3.17, 3.14, 4, 7, '2024-05-03 12:07:16'),
(19, 45, 21, 9, 1, 1, 5, 1, 1, 0, 2, 41, 1, ' 1 ', ' 143 ', ' 138 ', ' 146 ', 2.11, 2.08, 2.38, 2.14, 2.3, 2.14, 2.38, 2.17, 2.12, 2.12, 3.09, 3.15, 3.1, 5, 8, '2024-05-03 12:08:28');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_46`
--

CREATE TABLE `yd_46` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_46`
--

INSERT INTO `yd_46` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 46, 24, 3, 0, 0, 2, 0, 0, 1, 1, 40, 1, ' 2 ', ' 142 ', ' 137 ', ' 103 ', 3.5, 2.21, 2.19, 2.25, 2.08, 2.21, 2.75, 2.21, 2.25, 2.09, 3.17, 3.14, 3.25, 6, 7, '2024-05-02 09:55:51'),
(2, 46, 23, 8, 1, 1, 4, 0, 0, 0, 3, 38, 0, ' 1 ', ' 147 ', ' 121 ', ' 128 ', 2.38, 2.12, 2.21, 2.17, 2.3, 2.17, 2.09, 2.12, 2.19, 2.12, 3.14, 3.08, 3.12, 5, 8, '2024-05-02 09:55:55'),
(3, 46, 14, 8, 0, 1, 1, 1, 0, 1, 2, 45, 0, ' 2 ', ' 116 ', ' 147 ', ' 146 ', 2.1, 2.17, 2.12, 2.75, 2.75, 2.3, 2.09, 2.75, 2.09, 2.13, 3.14, 3.5, 3.11, 5, 12, '2024-05-02 09:56:42'),
(4, 46, 24, 3, 0, 0, 2, 0, 0, 1, 1, 40, 1, ' 2 ', ' 142 ', ' 137 ', ' 103 ', 3.5, 2.21, 2.19, 2.25, 2.08, 2.21, 2.75, 2.21, 2.25, 2.09, 3.17, 3.14, 3.25, 6, 7, '2024-05-02 10:08:45'),
(5, 46, 23, 8, 1, 1, 4, 0, 0, 0, 3, 38, 0, ' 1 ', ' 147 ', ' 121 ', ' 128 ', 2.38, 2.12, 2.21, 2.17, 2.3, 2.17, 2.09, 2.12, 2.19, 2.12, 3.14, 3.08, 3.12, 5, 8, '2024-05-02 10:08:49'),
(6, 46, 24, 3, 0, 0, 2, 0, 0, 1, 1, 40, 1, ' 2 ', ' 142 ', ' 137 ', ' 103 ', 3.5, 2.21, 2.19, 2.25, 2.08, 2.21, 2.75, 2.21, 2.25, 2.09, 3.17, 3.14, 3.25, 6, 7, '2024-05-02 10:11:24'),
(7, 46, 23, 8, 1, 1, 4, 0, 0, 0, 3, 38, 0, ' 1 ', ' 147 ', ' 121 ', ' 128 ', 2.38, 2.12, 2.21, 2.17, 2.3, 2.17, 2.09, 2.12, 2.19, 2.12, 3.14, 3.08, 3.12, 5, 8, '2024-05-02 10:11:28'),
(8, 46, 14, 8, 0, 1, 1, 1, 0, 1, 2, 45, 0, ' 2 ', ' 116 ', ' 147 ', ' 146 ', 2.1, 2.17, 2.12, 2.75, 2.75, 2.3, 2.09, 2.75, 2.09, 2.13, 3.14, 3.5, 3.11, 5, 12, '2024-05-02 10:12:15'),
(9, 46, 24, 3, 0, 0, 2, 0, 0, 1, 1, 40, 1, ' 2 ', ' 142 ', ' 137 ', ' 103 ', 3.5, 2.21, 2.19, 2.25, 2.08, 2.21, 2.75, 2.21, 2.25, 2.09, 3.17, 3.14, 3.25, 6, 7, '2024-05-02 10:13:09'),
(10, 46, 23, 8, 1, 1, 4, 0, 0, 0, 3, 38, 0, ' 1 ', ' 147 ', ' 121 ', ' 128 ', 2.38, 2.12, 2.21, 2.17, 2.3, 2.17, 2.09, 2.12, 2.19, 2.12, 3.14, 3.08, 3.12, 5, 8, '2024-05-02 10:13:13'),
(11, 46, 24, 3, 0, 0, 2, 0, 0, 1, 1, 40, 1, ' 2 ', ' 142 ', ' 137 ', ' 103 ', 3.5, 2.21, 2.19, 2.25, 2.08, 2.21, 2.75, 2.21, 2.25, 2.09, 3.17, 3.14, 3.25, 6, 7, '2024-05-02 10:14:11'),
(12, 46, 23, 8, 1, 1, 4, 0, 0, 0, 3, 38, 0, ' 1 ', ' 147 ', ' 121 ', ' 128 ', 2.38, 2.12, 2.21, 2.17, 2.3, 2.17, 2.09, 2.12, 2.19, 2.12, 3.14, 3.08, 3.12, 5, 8, '2024-05-02 10:14:15'),
(13, 46, 24, 3, 0, 0, 2, 0, 0, 1, 1, 40, 1, ' 2 ', ' 142 ', ' 137 ', ' 103 ', 3.5, 2.21, 2.19, 2.25, 2.08, 2.21, 2.75, 2.21, 2.25, 2.09, 3.17, 3.14, 3.25, 6, 7, '2024-05-02 10:17:46'),
(14, 46, 23, 8, 1, 1, 4, 0, 0, 0, 3, 38, 0, ' 1 ', ' 147 ', ' 121 ', ' 128 ', 2.38, 2.12, 2.21, 2.17, 2.3, 2.17, 2.09, 2.12, 2.19, 2.12, 3.14, 3.08, 3.12, 5, 8, '2024-05-02 10:17:50'),
(15, 46, 24, 3, 0, 0, 2, 0, 0, 1, 1, 40, 1, ' 2 ', ' 142 ', ' 137 ', ' 103 ', 3.5, 2.21, 2.19, 2.25, 2.08, 2.21, 2.75, 2.21, 2.25, 2.09, 3.17, 3.14, 3.25, 6, 7, '2024-05-02 10:23:18'),
(16, 46, 23, 8, 1, 1, 4, 0, 0, 0, 3, 38, 0, ' 1 ', ' 147 ', ' 121 ', ' 128 ', 2.38, 2.12, 2.21, 2.17, 2.3, 2.17, 2.09, 2.12, 2.19, 2.12, 3.14, 3.08, 3.12, 5, 8, '2024-05-02 10:23:22'),
(17, 46, 24, 3, 0, 0, 2, 0, 0, 1, 1, 40, 1, ' 2 ', ' 142 ', ' 137 ', ' 103 ', 3.5, 2.21, 2.19, 2.25, 2.08, 2.21, 2.75, 2.21, 2.25, 2.09, 3.17, 3.14, 3.25, 6, 7, '2024-05-02 10:26:10'),
(18, 46, 23, 8, 1, 1, 4, 0, 0, 0, 3, 38, 0, ' 1 ', ' 147 ', ' 121 ', ' 128 ', 2.38, 2.12, 2.21, 2.17, 2.3, 2.17, 2.09, 2.12, 2.19, 2.12, 3.14, 3.08, 3.12, 5, 8, '2024-05-02 10:26:14'),
(19, 46, 24, 3, 0, 0, 2, 0, 0, 1, 1, 40, 1, ' 2 ', ' 142 ', ' 137 ', ' 103 ', 3.5, 2.21, 2.19, 2.25, 2.08, 2.21, 2.75, 2.21, 2.25, 2.09, 3.17, 3.14, 3.25, 6, 7, '2024-05-02 10:28:25'),
(20, 46, 23, 8, 1, 1, 4, 0, 0, 0, 3, 38, 0, ' 1 ', ' 147 ', ' 121 ', ' 128 ', 2.38, 2.12, 2.21, 2.17, 2.3, 2.17, 2.09, 2.12, 2.19, 2.12, 3.14, 3.08, 3.12, 5, 8, '2024-05-02 10:28:29'),
(21, 46, 24, 3, 0, 0, 2, 0, 0, 1, 1, 40, 1, ' 2 ', ' 142 ', ' 137 ', ' 103 ', 3.5, 2.21, 2.19, 2.25, 2.08, 2.21, 2.75, 2.21, 2.25, 2.09, 3.17, 3.14, 3.25, 6, 7, '2024-05-02 10:46:08'),
(22, 46, 23, 8, 1, 1, 4, 0, 0, 0, 3, 38, 0, ' 1 ', ' 147 ', ' 121 ', ' 128 ', 2.38, 2.12, 2.21, 2.17, 2.3, 2.17, 2.09, 2.12, 2.19, 2.12, 3.14, 3.08, 3.12, 5, 8, '2024-05-02 10:46:13'),
(23, 46, 24, 3, 0, 0, 2, 0, 0, 1, 1, 40, 1, ' 2 ', ' 142 ', ' 137 ', ' 103 ', 3.5, 2.21, 2.19, 2.25, 2.08, 2.21, 2.75, 2.21, 2.25, 2.09, 3.17, 3.14, 3.25, 6, 7, '2024-05-02 10:51:28'),
(24, 46, 23, 8, 1, 1, 4, 0, 0, 0, 3, 38, 0, ' 1 ', ' 147 ', ' 121 ', ' 128 ', 2.38, 2.12, 2.21, 2.17, 2.3, 2.17, 2.09, 2.12, 2.19, 2.12, 3.14, 3.08, 3.12, 5, 8, '2024-05-02 10:51:33'),
(25, 46, 23, 8, 1, 1, 4, 0, 0, 0, 3, 38, 0, ' 1 ', ' 147 ', ' 121 ', ' 128 ', 2.38, 2.12, 2.21, 2.17, 2.3, 2.17, 2.09, 2.12, 2.19, 2.12, 3.14, 3.08, 3.12, 5, 8, '2024-05-02 10:54:49'),
(26, 46, 24, 3, 0, 0, 2, 0, 0, 1, 1, 40, 1, ' 2 ', ' 142 ', ' 137 ', ' 103 ', 3.5, 2.21, 2.19, 2.25, 2.08, 2.21, 2.75, 2.21, 2.25, 2.09, 3.17, 3.14, 3.25, 6, 7, '2024-05-02 10:58:45'),
(27, 46, 23, 8, 1, 1, 4, 0, 0, 0, 3, 38, 0, ' 1 ', ' 147 ', ' 121 ', ' 128 ', 2.38, 2.12, 2.21, 2.17, 2.3, 2.17, 2.09, 2.12, 2.19, 2.12, 3.14, 3.08, 3.12, 5, 8, '2024-05-02 10:58:49'),
(28, 46, 24, 3, 0, 0, 2, 0, 0, 1, 1, 40, 1, ' 2 ', ' 142 ', ' 137 ', ' 103 ', 3.5, 2.21, 2.19, 2.25, 2.08, 2.21, 2.75, 2.21, 2.25, 2.09, 3.17, 3.14, 3.25, 6, 7, '2024-05-02 11:01:42'),
(29, 46, 24, 3, 0, 0, 2, 0, 0, 1, 1, 40, 1, ' 2 ', ' 142 ', ' 137 ', ' 103 ', 3.5, 2.21, 2.19, 2.25, 2.08, 2.21, 2.75, 2.21, 2.25, 2.09, 3.17, 3.14, 3.25, 6, 7, '2024-05-02 11:01:58'),
(30, 46, 23, 8, 1, 1, 4, 0, 0, 0, 3, 38, 0, ' 1 ', ' 147 ', ' 121 ', ' 128 ', 2.38, 2.12, 2.21, 2.17, 2.3, 2.17, 2.09, 2.12, 2.19, 2.12, 3.14, 3.08, 3.12, 5, 8, '2024-05-02 11:02:02'),
(31, 46, 24, 3, 0, 0, 2, 0, 0, 1, 1, 40, 1, ' 2 ', ' 142 ', ' 137 ', ' 103 ', 3.5, 2.21, 2.19, 2.25, 2.08, 2.21, 2.75, 2.21, 2.25, 2.09, 3.17, 3.14, 3.25, 6, 7, '2024-05-02 11:30:42'),
(32, 46, 23, 8, 1, 1, 4, 0, 0, 0, 3, 38, 0, ' 1 ', ' 147 ', ' 121 ', ' 128 ', 2.38, 2.12, 2.21, 2.17, 2.3, 2.17, 2.09, 2.12, 2.19, 2.12, 3.14, 3.08, 3.12, 5, 8, '2024-05-02 11:30:46'),
(33, 46, 24, 3, 0, 0, 2, 0, 0, 1, 1, 40, 1, ' 2 ', ' 142 ', ' 137 ', ' 103 ', 3.5, 2.21, 2.19, 2.25, 2.08, 2.21, 2.75, 2.21, 2.25, 2.09, 3.17, 3.14, 3.25, 6, 7, '2024-05-02 11:47:38'),
(34, 46, 23, 8, 1, 1, 4, 0, 0, 0, 3, 38, 0, ' 1 ', ' 147 ', ' 121 ', ' 128 ', 2.38, 2.12, 2.21, 2.17, 2.3, 2.17, 2.09, 2.12, 2.19, 2.12, 3.14, 3.08, 3.12, 5, 8, '2024-05-02 11:47:42'),
(35, 46, 24, 3, 0, 0, 2, 0, 0, 1, 1, 40, 1, ' 2 ', ' 142 ', ' 137 ', ' 103 ', 3.5, 2.21, 2.19, 2.25, 2.08, 2.21, 2.75, 2.21, 2.25, 2.09, 3.17, 3.14, 3.25, 6, 7, '2024-05-02 11:50:14'),
(36, 46, 23, 8, 1, 1, 4, 0, 0, 0, 3, 38, 0, ' 1 ', ' 147 ', ' 121 ', ' 128 ', 2.38, 2.12, 2.21, 2.17, 2.3, 2.17, 2.09, 2.12, 2.19, 2.12, 3.14, 3.08, 3.12, 5, 8, '2024-05-02 11:50:18'),
(37, 46, 14, 8, 0, 1, 1, 1, 0, 1, 2, 45, 0, ' 2 ', ' 116 ', ' 147 ', ' 146 ', 2.1, 2.17, 2.12, 2.75, 2.75, 2.3, 2.09, 2.75, 2.09, 2.13, 3.14, 3.5, 3.11, 5, 12, '2024-05-02 11:51:05'),
(38, 46, 24, 3, 0, 0, 2, 0, 0, 1, 1, 40, 1, ' 2 ', ' 142 ', ' 137 ', ' 103 ', 3.5, 2.21, 2.19, 2.25, 2.08, 2.21, 2.75, 2.21, 2.25, 2.09, 3.17, 3.14, 3.25, 6, 7, '2024-05-02 12:00:13'),
(39, 46, 23, 8, 1, 1, 4, 0, 0, 0, 3, 38, 0, ' 1 ', ' 147 ', ' 121 ', ' 128 ', 2.38, 2.12, 2.21, 2.17, 2.3, 2.17, 2.09, 2.12, 2.19, 2.12, 3.14, 3.08, 3.12, 5, 8, '2024-05-02 12:00:17'),
(40, 46, 24, 3, 0, 0, 2, 0, 0, 1, 1, 40, 1, ' 2 ', ' 142 ', ' 137 ', ' 103 ', 3.5, 2.21, 2.19, 2.25, 2.08, 2.21, 2.75, 2.21, 2.25, 2.09, 3.17, 3.14, 3.25, 6, 7, '2024-05-02 12:00:52'),
(41, 46, 23, 8, 1, 1, 4, 0, 0, 0, 3, 38, 0, ' 1 ', ' 147 ', ' 121 ', ' 128 ', 2.38, 2.12, 2.21, 2.17, 2.3, 2.17, 2.09, 2.12, 2.19, 2.12, 3.14, 3.08, 3.12, 5, 8, '2024-05-02 12:00:56'),
(42, 46, 24, 3, 0, 0, 2, 0, 0, 1, 1, 40, 1, ' 2 ', ' 142 ', ' 137 ', ' 103 ', 3.5, 2.21, 2.19, 2.25, 2.08, 2.21, 2.75, 2.21, 2.25, 2.09, 3.17, 3.14, 3.25, 6, 7, '2024-05-02 12:08:46'),
(43, 46, 23, 8, 1, 1, 4, 0, 0, 0, 3, 38, 0, ' 1 ', ' 147 ', ' 121 ', ' 128 ', 2.38, 2.12, 2.21, 2.17, 2.3, 2.17, 2.09, 2.12, 2.19, 2.12, 3.14, 3.08, 3.12, 5, 8, '2024-05-02 12:08:50'),
(44, 46, 14, 8, 0, 1, 1, 1, 0, 1, 2, 45, 0, ' 2 ', ' 116 ', ' 147 ', ' 146 ', 2.1, 2.17, 2.12, 2.75, 2.75, 2.3, 2.09, 2.75, 2.09, 2.13, 3.14, 3.5, 3.11, 5, 12, '2024-05-02 12:09:37'),
(45, 46, 23, 8, 1, 1, 4, 0, 0, 0, 3, 38, 0, ' 1 ', ' 147 ', ' 121 ', ' 128 ', 2.38, 2.12, 2.21, 2.17, 2.3, 2.17, 2.09, 2.12, 2.19, 2.12, 3.14, 3.08, 3.12, 5, 8, '2024-05-02 12:37:46'),
(46, 46, 14, 8, 0, 1, 1, 1, 0, 1, 2, 45, 0, ' 2 ', ' 116 ', ' 147 ', ' 146 ', 2.1, 2.17, 2.12, 2.75, 2.75, 2.3, 2.09, 2.75, 2.09, 2.13, 3.14, 3.5, 3.11, 5, 12, '2024-05-02 12:38:33'),
(47, 46, 24, 3, 0, 0, 2, 0, 0, 1, 1, 40, 1, ' 2 ', ' 142 ', ' 137 ', ' 103 ', 3.5, 2.21, 2.19, 2.25, 2.08, 2.21, 2.75, 2.21, 2.25, 2.09, 3.17, 3.14, 3.25, 6, 7, '2024-05-02 12:41:26'),
(48, 46, 23, 8, 1, 1, 4, 0, 0, 0, 3, 38, 0, ' 1 ', ' 147 ', ' 121 ', ' 128 ', 2.38, 2.12, 2.21, 2.17, 2.3, 2.17, 2.09, 2.12, 2.19, 2.12, 3.14, 3.08, 3.12, 5, 8, '2024-05-02 12:41:30'),
(49, 46, 24, 3, 0, 0, 2, 0, 0, 1, 1, 40, 1, ' 2 ', ' 142 ', ' 137 ', ' 103 ', 3.5, 2.21, 2.19, 2.25, 2.08, 2.21, 2.75, 2.21, 2.25, 2.09, 3.17, 3.14, 3.25, 6, 7, '2024-05-02 12:52:13'),
(50, 46, 23, 8, 1, 1, 4, 0, 0, 0, 3, 38, 0, ' 1 ', ' 147 ', ' 121 ', ' 128 ', 2.38, 2.12, 2.21, 2.17, 2.3, 2.17, 2.09, 2.12, 2.19, 2.12, 3.14, 3.08, 3.12, 5, 8, '2024-05-02 12:52:17'),
(51, 46, 24, 3, 0, 0, 2, 0, 0, 1, 1, 40, 1, ' 2 ', ' 142 ', ' 137 ', ' 103 ', 3.5, 2.21, 2.19, 2.25, 2.08, 2.21, 2.75, 2.21, 2.25, 2.09, 3.17, 3.14, 3.25, 6, 7, '2024-05-03 11:34:04'),
(52, 46, 23, 8, 1, 1, 4, 0, 0, 0, 3, 38, 0, ' 1 ', ' 147 ', ' 121 ', ' 128 ', 2.38, 2.12, 2.21, 2.17, 2.3, 2.17, 2.09, 2.12, 2.19, 2.12, 3.14, 3.08, 3.12, 5, 8, '2024-05-03 11:34:08'),
(53, 46, 14, 8, 0, 1, 1, 1, 0, 1, 2, 45, 0, ' 2 ', ' 116 ', ' 147 ', ' 146 ', 2.1, 2.17, 2.12, 2.75, 2.75, 2.3, 2.09, 2.75, 2.09, 2.13, 3.14, 3.5, 3.11, 5, 12, '2024-05-03 11:36:22'),
(54, 46, 10, 7, 0, 1, 5, 5, 0, 0, 2, 26, 0, ' 1 ', ' 138 ', ' 135 ', ' 115 ', 2.3, 2.3, 2.75, 2.09, 2.38, 3.5, 2.21, 2.19, 2.09, 2.75, 3.14, 3.11, 3.1, 7, 8, '2024-05-03 11:37:55'),
(55, 46, 24, 3, 0, 0, 2, 0, 0, 1, 1, 40, 1, ' 2 ', ' 142 ', ' 137 ', ' 103 ', 3.5, 2.21, 2.19, 2.25, 2.08, 2.21, 2.75, 2.21, 2.25, 2.09, 3.17, 3.14, 3.25, 6, 7, '2024-05-03 11:51:34'),
(56, 46, 23, 8, 1, 1, 4, 0, 0, 0, 3, 38, 0, ' 1 ', ' 147 ', ' 121 ', ' 128 ', 2.38, 2.12, 2.21, 2.17, 2.3, 2.17, 2.09, 2.12, 2.19, 2.12, 3.14, 3.08, 3.12, 5, 8, '2024-05-03 11:51:38'),
(57, 46, 14, 8, 0, 1, 1, 1, 0, 1, 2, 45, 0, ' 2 ', ' 116 ', ' 147 ', ' 146 ', 2.1, 2.17, 2.12, 2.75, 2.75, 2.3, 2.09, 2.75, 2.09, 2.13, 3.14, 3.5, 3.11, 5, 12, '2024-05-03 11:52:25'),
(58, 46, 10, 7, 0, 1, 5, 5, 0, 0, 2, 26, 0, ' 1 ', ' 138 ', ' 135 ', ' 115 ', 2.3, 2.3, 2.75, 2.09, 2.38, 3.5, 2.21, 2.19, 2.09, 2.75, 3.14, 3.11, 3.1, 7, 8, '2024-05-03 11:55:04'),
(59, 46, 16, 7, 0, 1, 1, 0, 0, 0, 2, 33, 1, ' 3 ', ' 101 ', ' 149 ', ' 137 ', 2.17, 2.08, 2.25, 2.25, 2.08, 2.09, 2.19, 2.09, 2.19, 2.1, 3.19, 3.3, 3.21, 4, 10, '2024-05-03 12:02:03'),
(60, 46, 2, 7, 1, 0, 1, 2, 1, 0, 2, 40, 1, ' 0 ', ' 129 ', ' 116 ', ' 107 ', 2.11, 2.3, 2.13, 2.75, 2.19, 2.19, 2.17, 2.25, 2.17, 2.1, 3.09, 3.1, 3.19, 3, 7, '2024-05-03 12:02:55'),
(61, 46, 8, 4, 0, 0, 3, 3, 0, 0, 2, 33, 0, ' 1 ', ' 136 ', ' 107 ', ' 105 ', 2.1, 2.13, 2.11, 2.14, 2.1, 2.08, 2.17, 2.08, 2.14, 2.08, 3.3, 3.5, 3.09, 7, 8, '2024-05-03 12:04:01'),
(62, 46, 19, 8, 0, 0, 3, 2, 0, 0, 5, 30, 0, ' 3 ', ' 120 ', ' 132 ', ' 148 ', 2.09, 2.08, 2.09, 2.21, 2.09, 2.12, 2.1, 2.15, 2.09, 2.5, 3.25, 3.19, 3.08, 7, 10, '2024-05-03 12:04:44'),
(63, 46, 7, 9, 0, 0, 3, 3, 0, 1, 1, 46, 0, ' 3 ', ' 104 ', ' 100 ', ' 102 ', 2.1, 2.25, 2.12, 2.13, 2.09, 2.11, 2.19, 2.1, 2.21, 2.15, 3.25, 3.15, 3.1, 7, 9, '2024-05-03 12:08:46');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_47`
--

CREATE TABLE `yd_47` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_47`
--

INSERT INTO `yd_47` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 47, 2, 7, 1, 1, 4, 3, 1, 0, 3, 38, 1, ' 1 ', ' 140 ', ' 140 ', ' 129 ', 2.25, 2.11, 2.19, 2.09, 2.14, 2.09, 2.19, 2.13, 2.13, 2.09, 3.13, 3.3, 3.38, 7, 11, '2024-05-02 09:55:57'),
(2, 47, 2, 7, 1, 1, 4, 3, 1, 0, 3, 38, 1, ' 1 ', ' 140 ', ' 140 ', ' 129 ', 2.25, 2.11, 2.19, 2.09, 2.14, 2.09, 2.19, 2.13, 2.13, 2.09, 3.13, 3.3, 3.38, 7, 11, '2024-05-02 10:08:51'),
(3, 47, 2, 7, 1, 1, 4, 3, 1, 0, 3, 38, 1, ' 1 ', ' 140 ', ' 140 ', ' 129 ', 2.25, 2.11, 2.19, 2.09, 2.14, 2.09, 2.19, 2.13, 2.13, 2.09, 3.13, 3.3, 3.38, 7, 11, '2024-05-02 10:11:30'),
(4, 47, 2, 7, 1, 1, 4, 3, 1, 0, 3, 38, 1, ' 1 ', ' 140 ', ' 140 ', ' 129 ', 2.25, 2.11, 2.19, 2.09, 2.14, 2.09, 2.19, 2.13, 2.13, 2.09, 3.13, 3.3, 3.38, 7, 11, '2024-05-02 10:13:15'),
(5, 47, 2, 7, 1, 1, 4, 3, 1, 0, 3, 38, 1, ' 1 ', ' 140 ', ' 140 ', ' 129 ', 2.25, 2.11, 2.19, 2.09, 2.14, 2.09, 2.19, 2.13, 2.13, 2.09, 3.13, 3.3, 3.38, 7, 11, '2024-05-02 10:14:17'),
(6, 47, 2, 7, 1, 1, 4, 3, 1, 0, 3, 38, 1, ' 1 ', ' 140 ', ' 140 ', ' 129 ', 2.25, 2.11, 2.19, 2.09, 2.14, 2.09, 2.19, 2.13, 2.13, 2.09, 3.13, 3.3, 3.38, 7, 11, '2024-05-02 10:17:52'),
(7, 47, 2, 7, 1, 1, 4, 3, 1, 0, 3, 38, 1, ' 1 ', ' 140 ', ' 140 ', ' 129 ', 2.25, 2.11, 2.19, 2.09, 2.14, 2.09, 2.19, 2.13, 2.13, 2.09, 3.13, 3.3, 3.38, 7, 11, '2024-05-02 10:23:24'),
(8, 47, 2, 7, 1, 1, 4, 3, 1, 0, 3, 38, 1, ' 1 ', ' 140 ', ' 140 ', ' 129 ', 2.25, 2.11, 2.19, 2.09, 2.14, 2.09, 2.19, 2.13, 2.13, 2.09, 3.13, 3.3, 3.38, 7, 11, '2024-05-02 10:26:16'),
(9, 47, 2, 7, 1, 1, 4, 3, 1, 0, 3, 38, 1, ' 1 ', ' 140 ', ' 140 ', ' 129 ', 2.25, 2.11, 2.19, 2.09, 2.14, 2.09, 2.19, 2.13, 2.13, 2.09, 3.13, 3.3, 3.38, 7, 11, '2024-05-02 10:28:31'),
(10, 47, 2, 7, 1, 1, 4, 3, 1, 0, 3, 38, 1, ' 1 ', ' 140 ', ' 140 ', ' 129 ', 2.25, 2.11, 2.19, 2.09, 2.14, 2.09, 2.19, 2.13, 2.13, 2.09, 3.13, 3.3, 3.38, 7, 11, '2024-05-02 10:46:15'),
(11, 47, 2, 7, 1, 1, 4, 3, 1, 0, 3, 38, 1, ' 1 ', ' 140 ', ' 140 ', ' 129 ', 2.25, 2.11, 2.19, 2.09, 2.14, 2.09, 2.19, 2.13, 2.13, 2.09, 3.13, 3.3, 3.38, 7, 11, '2024-05-02 10:51:35'),
(12, 47, 2, 7, 1, 1, 4, 3, 1, 0, 3, 38, 1, ' 1 ', ' 140 ', ' 140 ', ' 129 ', 2.25, 2.11, 2.19, 2.09, 2.14, 2.09, 2.19, 2.13, 2.13, 2.09, 3.13, 3.3, 3.38, 7, 11, '2024-05-02 10:54:51'),
(13, 47, 2, 7, 1, 1, 4, 3, 1, 0, 3, 38, 1, ' 1 ', ' 140 ', ' 140 ', ' 129 ', 2.25, 2.11, 2.19, 2.09, 2.14, 2.09, 2.19, 2.13, 2.13, 2.09, 3.13, 3.3, 3.38, 7, 11, '2024-05-02 10:58:51'),
(14, 47, 2, 7, 1, 1, 4, 3, 1, 0, 3, 38, 1, ' 1 ', ' 140 ', ' 140 ', ' 129 ', 2.25, 2.11, 2.19, 2.09, 2.14, 2.09, 2.19, 2.13, 2.13, 2.09, 3.13, 3.3, 3.38, 7, 11, '2024-05-02 11:47:44'),
(15, 47, 2, 7, 1, 1, 4, 3, 1, 0, 3, 38, 1, ' 1 ', ' 140 ', ' 140 ', ' 129 ', 2.25, 2.11, 2.19, 2.09, 2.14, 2.09, 2.19, 2.13, 2.13, 2.09, 3.13, 3.3, 3.38, 7, 11, '2024-05-02 11:50:20'),
(16, 47, 2, 7, 1, 1, 4, 3, 1, 0, 3, 38, 1, ' 1 ', ' 140 ', ' 140 ', ' 129 ', 2.25, 2.11, 2.19, 2.09, 2.14, 2.09, 2.19, 2.13, 2.13, 2.09, 3.13, 3.3, 3.38, 7, 11, '2024-05-02 12:00:19'),
(17, 47, 2, 7, 1, 1, 4, 3, 1, 0, 3, 38, 1, ' 1 ', ' 140 ', ' 140 ', ' 129 ', 2.25, 2.11, 2.19, 2.09, 2.14, 2.09, 2.19, 2.13, 2.13, 2.09, 3.13, 3.3, 3.38, 7, 11, '2024-05-02 12:00:58'),
(18, 47, 2, 7, 1, 1, 4, 3, 1, 0, 3, 38, 1, ' 1 ', ' 140 ', ' 140 ', ' 129 ', 2.25, 2.11, 2.19, 2.09, 2.14, 2.09, 2.19, 2.13, 2.13, 2.09, 3.13, 3.3, 3.38, 7, 11, '2024-05-02 12:08:52'),
(19, 47, 2, 7, 1, 1, 4, 3, 1, 0, 3, 38, 1, ' 1 ', ' 140 ', ' 140 ', ' 129 ', 2.25, 2.11, 2.19, 2.09, 2.14, 2.09, 2.19, 2.13, 2.13, 2.09, 3.13, 3.3, 3.38, 7, 11, '2024-05-02 12:37:48'),
(20, 47, 2, 7, 1, 1, 4, 3, 1, 0, 3, 38, 1, ' 1 ', ' 140 ', ' 140 ', ' 129 ', 2.25, 2.11, 2.19, 2.09, 2.14, 2.09, 2.19, 2.13, 2.13, 2.09, 3.13, 3.3, 3.38, 7, 11, '2024-05-02 12:52:19'),
(21, 47, 2, 7, 1, 1, 4, 3, 1, 0, 3, 38, 1, ' 1 ', ' 140 ', ' 140 ', ' 129 ', 2.25, 2.11, 2.19, 2.09, 2.14, 2.09, 2.19, 2.13, 2.13, 2.09, 3.13, 3.3, 3.38, 7, 11, '2024-05-03 11:34:13'),
(22, 47, 2, 7, 1, 1, 4, 3, 1, 0, 3, 38, 1, ' 1 ', ' 140 ', ' 140 ', ' 129 ', 2.25, 2.11, 2.19, 2.09, 2.14, 2.09, 2.19, 2.13, 2.13, 2.09, 3.13, 3.3, 3.38, 7, 11, '2024-05-03 11:51:40'),
(23, 47, 10, 6, 0, 1, 0, 2, 0, 1, 1, 46, 1, ' 4 ', ' 100 ', ' 119 ', ' 107 ', 2.17, 2.11, 2.75, 2.19, 2.1, 2.75, 2.25, 2.3, 2.08, 2.09, 3.08, 3.11, 4.5, 3, 12, '2024-05-03 11:55:45'),
(24, 47, 2, 3, 0, 0, 0, 4, 0, 0, 1, 32, 0, ' 4 ', ' 115 ', ' 119 ', ' 119 ', 2.3, 2.12, 2.75, 2.17, 2.08, 2.5, 2.12, 2.19, 2.13, 2.09, 3.19, 3.15, 4.5, 7, 7, '2024-05-03 11:57:24'),
(25, 47, 22, 6, 1, 0, 5, 5, 0, 0, 4, 38, 0, ' 4 ', ' 118 ', ' 133 ', ' 117 ', 2.14, 3.5, 3.5, 2.75, 2.17, 2.3, 2.75, 2.1, 2.5, 2.13, 3.12, 3.75, 3.15, 6, 8, '2024-05-03 12:01:57'),
(26, 47, 6, 9, 1, 0, 0, 4, 0, 0, 4, 27, 0, ' 1 ', ' 136 ', ' 138 ', ' 110 ', 2.08, 2.1, 2.5, 2.14, 2.08, 2.1, 2.5, 2.17, 2.12, 2.14, 3.15, 3.38, 3.09, 3, 10, '2024-05-03 12:02:09'),
(27, 47, 13, 8, 0, 1, 3, 0, 0, 1, 4, 38, 0, ' 2 ', ' 121 ', ' 125 ', ' 136 ', 2.3, 2.19, 2.21, 2.17, 3.5, 2.75, 2.19, 2.3, 2.11, 2.25, 3.1, 3.13, 3.1, 7, 12, '2024-05-03 12:06:22'),
(28, 47, 9, 0, 0, 1, 4, 4, 1, 0, 5, 48, 0, ' 4 ', ' 108 ', ' 136 ', ' 102 ', 2.09, 2.08, 2.38, 2.09, 2.1, 2.1, 2.09, 2.38, 2.13, 2.19, 3.25, 3.25, 3.08, 5, 8, '2024-05-03 12:07:08');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_48`
--

CREATE TABLE `yd_48` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_48`
--

INSERT INTO `yd_48` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 48, 9, 5, 1, 1, 2, 5, 0, 0, 5, 26, 0, ' 2 ', ' 134 ', ' 120 ', ' 146 ', 2.15, 2.09, 2.17, 3.5, 2.09, 2.75, 2.3, 2.75, 2.3, 2.14, 3.11, 3.08, 3.17, 6, 12, '2024-05-02 09:57:17'),
(2, 48, 13, 2, 1, 1, 1, 4, 0, 0, 1, 26, 0, ' 3 ', ' 147 ', ' 143 ', ' 103 ', 2.19, 2.14, 2.1, 2.38, 2.21, 2.38, 2.25, 2.1, 2.09, 2.75, 3.09, 3.75, 3.25, 5, 11, '2024-05-02 09:57:27'),
(3, 48, 9, 5, 1, 1, 2, 5, 0, 0, 5, 26, 0, ' 2 ', ' 134 ', ' 120 ', ' 146 ', 2.15, 2.09, 2.17, 3.5, 2.09, 2.75, 2.3, 2.75, 2.3, 2.14, 3.11, 3.08, 3.17, 6, 12, '2024-05-02 11:51:40'),
(4, 48, 13, 2, 1, 1, 1, 4, 0, 0, 1, 26, 0, ' 3 ', ' 147 ', ' 143 ', ' 103 ', 2.19, 2.14, 2.1, 2.38, 2.21, 2.38, 2.25, 2.1, 2.09, 2.75, 3.09, 3.75, 3.25, 5, 11, '2024-05-02 11:51:50'),
(5, 48, 9, 5, 1, 1, 2, 5, 0, 0, 5, 26, 0, ' 2 ', ' 134 ', ' 120 ', ' 146 ', 2.15, 2.09, 2.17, 3.5, 2.09, 2.75, 2.3, 2.75, 2.3, 2.14, 3.11, 3.08, 3.17, 6, 12, '2024-05-02 12:10:12'),
(6, 48, 13, 2, 1, 1, 1, 4, 0, 0, 1, 26, 0, ' 3 ', ' 147 ', ' 143 ', ' 103 ', 2.19, 2.14, 2.1, 2.38, 2.21, 2.38, 2.25, 2.1, 2.09, 2.75, 3.09, 3.75, 3.25, 5, 11, '2024-05-02 12:10:23'),
(7, 48, 9, 5, 1, 1, 2, 5, 0, 0, 5, 26, 0, ' 2 ', ' 134 ', ' 120 ', ' 146 ', 2.15, 2.09, 2.17, 3.5, 2.09, 2.75, 2.3, 2.75, 2.3, 2.14, 3.11, 3.08, 3.17, 6, 12, '2024-05-02 12:39:08'),
(8, 48, 13, 2, 1, 1, 1, 4, 0, 0, 1, 26, 0, ' 3 ', ' 147 ', ' 143 ', ' 103 ', 2.19, 2.14, 2.1, 2.38, 2.21, 2.38, 2.25, 2.1, 2.09, 2.75, 3.09, 3.75, 3.25, 5, 11, '2024-05-02 12:39:19'),
(9, 48, 9, 5, 1, 1, 2, 5, 0, 0, 5, 26, 0, ' 2 ', ' 134 ', ' 120 ', ' 146 ', 2.15, 2.09, 2.17, 3.5, 2.09, 2.75, 2.3, 2.75, 2.3, 2.14, 3.11, 3.08, 3.17, 6, 12, '2024-05-03 11:37:00'),
(10, 48, 13, 2, 1, 1, 1, 4, 0, 0, 1, 26, 0, ' 3 ', ' 147 ', ' 143 ', ' 103 ', 2.19, 2.14, 2.1, 2.38, 2.21, 2.38, 2.25, 2.1, 2.09, 2.75, 3.09, 3.75, 3.25, 5, 11, '2024-05-03 11:37:08'),
(11, 48, 9, 5, 1, 1, 2, 5, 0, 0, 5, 26, 0, ' 2 ', ' 134 ', ' 120 ', ' 146 ', 2.15, 2.09, 2.17, 3.5, 2.09, 2.75, 2.3, 2.75, 2.3, 2.14, 3.11, 3.08, 3.17, 6, 12, '2024-05-03 11:53:00'),
(12, 48, 13, 2, 1, 1, 1, 4, 0, 0, 1, 26, 0, ' 3 ', ' 147 ', ' 143 ', ' 103 ', 2.19, 2.14, 2.1, 2.38, 2.21, 2.38, 2.25, 2.1, 2.09, 2.75, 3.09, 3.75, 3.25, 5, 11, '2024-05-03 11:53:11'),
(13, 48, 1, 0, 1, 1, 2, 5, 0, 0, 5, 25, 1, ' 4 ', ' 125 ', ' 113 ', ' 106 ', 2.38, 2.75, 2.17, 2.08, 2.08, 2.1, 2.08, 2.09, 2.75, 2.11, 3.17, 3.09, 3.09, 7, 10, '2024-05-03 11:56:24'),
(14, 48, 3, 3, 1, 0, 1, 0, 1, 0, 3, 30, 1, ' 1 ', ' 121 ', ' 136 ', ' 146 ', 2.15, 2.17, 2.13, 2.08, 2.09, 2.19, 2.25, 2.75, 2.08, 3.5, 3.08, 3.17, 3.38, 7, 9, '2024-05-03 11:56:59'),
(15, 48, 14, 1, 1, 1, 4, 5, 1, 0, 2, 27, 1, ' 1 ', ' 145 ', ' 131 ', ' 148 ', 2.13, 2.19, 2.1, 2.12, 2.21, 2.12, 2.1, 2.14, 2.5, 2.21, 3.12, 3.5, 3.14, 7, 12, '2024-05-03 11:59:06'),
(16, 48, 13, 4, 1, 1, 1, 3, 1, 0, 4, 35, 0, ' 2 ', ' 108 ', ' 119 ', ' 123 ', 3.5, 2.5, 2.08, 2.1, 2.21, 2.09, 2.09, 2.08, 2.15, 2.09, 3.25, 3.3, 4.5, 3, 8, '2024-05-03 12:03:01'),
(17, 48, 8, 7, 0, 0, 4, 5, 0, 0, 0, 32, 0, ' 0 ', ' 139 ', ' 140 ', ' 120 ', 2.13, 2.13, 2.17, 2.21, 2.08, 2.1, 2.21, 2.11, 2.5, 2.15, 3.13, 3.1, 3.19, 7, 8, '2024-05-03 12:06:29'),
(18, 48, 8, 1, 1, 1, 4, 0, 1, 1, 4, 48, 1, ' 1 ', ' 124 ', ' 119 ', ' 103 ', 2.17, 2.09, 2.08, 2.15, 2.3, 2.19, 2.11, 2.13, 2.19, 2.21, 3.15, 3.25, 3.11, 7, 11, '2024-05-03 12:06:53'),
(19, 48, 2, 2, 0, 0, 1, 0, 1, 1, 4, 47, 0, ' 4 ', ' 122 ', ' 108 ', ' 105 ', 2.14, 2.21, 2.11, 2.3, 2.19, 2.1, 2.38, 2.12, 2.1, 2.38, 3.1, 3.08, 3.25, 3, 12, '2024-05-03 12:07:14'),
(20, 48, 13, 2, 0, 0, 0, 2, 0, 1, 2, 27, 0, ' 3 ', ' 121 ', ' 146 ', ' 141 ', 2.25, 2.08, 2.13, 2.5, 2.13, 3.5, 2.38, 2.09, 2.13, 2.12, 3.25, 3.13, 3.19, 4, 11, '2024-05-03 12:08:40');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_49`
--

CREATE TABLE `yd_49` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_49`
--

INSERT INTO `yd_49` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 49, 21, 9, 1, 1, 0, 5, 0, 1, 2, 36, 0, ' 2 ', ' 123 ', ' 143 ', ' 135 ', 2.12, 2.5, 3.5, 2.1, 2.13, 2.17, 2.25, 2.19, 2.21, 2.09, 3.09, 3.09, 3.12, 5, 12, '2024-05-02 09:56:57'),
(2, 49, 21, 9, 1, 1, 0, 5, 0, 1, 2, 36, 0, ' 2 ', ' 123 ', ' 143 ', ' 135 ', 2.12, 2.5, 3.5, 2.1, 2.13, 2.17, 2.25, 2.19, 2.21, 2.09, 3.09, 3.09, 3.12, 5, 12, '2024-05-02 10:12:30'),
(3, 49, 21, 9, 1, 1, 0, 5, 0, 1, 2, 36, 0, ' 2 ', ' 123 ', ' 143 ', ' 135 ', 2.12, 2.5, 3.5, 2.1, 2.13, 2.17, 2.25, 2.19, 2.21, 2.09, 3.09, 3.09, 3.12, 5, 12, '2024-05-02 11:51:19'),
(4, 49, 21, 9, 1, 1, 0, 5, 0, 1, 2, 36, 0, ' 2 ', ' 123 ', ' 143 ', ' 135 ', 2.12, 2.5, 3.5, 2.1, 2.13, 2.17, 2.25, 2.19, 2.21, 2.09, 3.09, 3.09, 3.12, 5, 12, '2024-05-02 12:09:52'),
(5, 49, 21, 9, 1, 1, 0, 5, 0, 1, 2, 36, 0, ' 2 ', ' 123 ', ' 143 ', ' 135 ', 2.12, 2.5, 3.5, 2.1, 2.13, 2.17, 2.25, 2.19, 2.21, 2.09, 3.09, 3.09, 3.12, 5, 12, '2024-05-02 12:38:48'),
(6, 49, 21, 9, 1, 1, 0, 5, 0, 1, 2, 36, 0, ' 2 ', ' 123 ', ' 143 ', ' 135 ', 2.12, 2.5, 3.5, 2.1, 2.13, 2.17, 2.25, 2.19, 2.21, 2.09, 3.09, 3.09, 3.12, 5, 12, '2024-05-03 11:36:43'),
(7, 49, 12, 4, 0, 0, 2, 2, 1, 1, 0, 43, 1, ' 4 ', ' 128 ', ' 100 ', ' 120 ', 2.09, 2.15, 2.09, 2.1, 2.1, 2.08, 2.75, 2.15, 2.09, 2.14, 4.5, 4.5, 3.12, 7, 9, '2024-05-03 11:37:56'),
(8, 49, 21, 9, 1, 1, 0, 5, 0, 1, 2, 36, 0, ' 2 ', ' 123 ', ' 143 ', ' 135 ', 2.12, 2.5, 3.5, 2.1, 2.13, 2.17, 2.25, 2.19, 2.21, 2.09, 3.09, 3.09, 3.12, 5, 12, '2024-05-03 11:52:40'),
(9, 49, 12, 4, 0, 0, 2, 2, 1, 1, 0, 43, 1, ' 4 ', ' 128 ', ' 100 ', ' 120 ', 2.09, 2.15, 2.09, 2.1, 2.1, 2.08, 2.75, 2.15, 2.09, 2.14, 4.5, 4.5, 3.12, 7, 9, '2024-05-03 11:55:08'),
(10, 49, 12, 6, 0, 1, 3, 1, 0, 1, 1, 47, 1, ' 3 ', ' 132 ', ' 143 ', ' 106 ', 2.09, 2.13, 2.15, 2.38, 2.5, 2.38, 3.5, 2.25, 2.17, 2.08, 3.13, 3.09, 3.3, 7, 12, '2024-05-03 11:56:32'),
(11, 49, 24, 5, 0, 0, 3, 2, 0, 0, 0, 29, 0, ' 1 ', ' 129 ', ' 130 ', ' 109 ', 2.19, 2.08, 2.14, 2.09, 2.38, 2.11, 2.08, 2.25, 2.3, 2.12, 3.3, 3.09, 3.15, 4, 7, '2024-05-03 11:56:34'),
(12, 49, 13, 9, 1, 1, 0, 5, 0, 0, 5, 34, 1, ' 1 ', ' 112 ', ' 106 ', ' 143 ', 2.17, 2.09, 2.38, 2.3, 2.12, 2.14, 2.09, 2.08, 2.19, 2.3, 3.12, 3.14, 4.5, 7, 8, '2024-05-03 12:01:47'),
(13, 49, 15, 7, 1, 1, 1, 5, 1, 0, 0, 43, 1, ' 3 ', ' 115 ', ' 124 ', ' 118 ', 3.5, 2.19, 2.38, 2.14, 2.5, 2.21, 2.11, 2.12, 2.13, 2.09, 3.08, 3.11, 3.12, 3, 10, '2024-05-03 12:03:56');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_50`
--

CREATE TABLE `yd_50` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_50`
--

INSERT INTO `yd_50` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 50, 18, 8, 1, 0, 5, 0, 0, 0, 2, 35, 1, ' 3 ', ' 115 ', ' 111 ', ' 102 ', 2.17, 2.08, 2.38, 2.09, 2.19, 2.14, 2.08, 2.13, 2.21, 2.15, 3.25, 4.5, 3.25, 3, 8, '2024-05-02 09:56:17'),
(2, 50, 23, 5, 1, 0, 4, 3, 1, 1, 2, 35, 0, ' 0 ', ' 142 ', ' 124 ', ' 141 ', 2.15, 2.09, 2.09, 2.15, 2.09, 2.14, 2.75, 2.13, 2.15, 2.3, 3.12, 3.08, 3.19, 3, 8, '2024-05-02 09:57:50'),
(3, 50, 18, 8, 1, 0, 5, 0, 0, 0, 2, 35, 1, ' 3 ', ' 115 ', ' 111 ', ' 102 ', 2.17, 2.08, 2.38, 2.09, 2.19, 2.14, 2.08, 2.13, 2.21, 2.15, 3.25, 4.5, 3.25, 3, 8, '2024-05-02 10:11:51'),
(4, 50, 18, 8, 1, 0, 5, 0, 0, 0, 2, 35, 1, ' 3 ', ' 115 ', ' 111 ', ' 102 ', 2.17, 2.08, 2.38, 2.09, 2.19, 2.14, 2.08, 2.13, 2.21, 2.15, 3.25, 4.5, 3.25, 3, 8, '2024-05-02 10:13:36'),
(5, 50, 18, 8, 1, 0, 5, 0, 0, 0, 2, 35, 1, ' 3 ', ' 115 ', ' 111 ', ' 102 ', 2.17, 2.08, 2.38, 2.09, 2.19, 2.14, 2.08, 2.13, 2.21, 2.15, 3.25, 4.5, 3.25, 3, 8, '2024-05-02 10:23:45'),
(6, 50, 18, 8, 1, 0, 5, 0, 0, 0, 2, 35, 1, ' 3 ', ' 115 ', ' 111 ', ' 102 ', 2.17, 2.08, 2.38, 2.09, 2.19, 2.14, 2.08, 2.13, 2.21, 2.15, 3.25, 4.5, 3.25, 3, 8, '2024-05-02 10:26:37'),
(7, 50, 18, 8, 1, 0, 5, 0, 0, 0, 2, 35, 1, ' 3 ', ' 115 ', ' 111 ', ' 102 ', 2.17, 2.08, 2.38, 2.09, 2.19, 2.14, 2.08, 2.13, 2.21, 2.15, 3.25, 4.5, 3.25, 3, 8, '2024-05-02 10:28:52'),
(8, 50, 18, 8, 1, 0, 5, 0, 0, 0, 2, 35, 1, ' 3 ', ' 115 ', ' 111 ', ' 102 ', 2.17, 2.08, 2.38, 2.09, 2.19, 2.14, 2.08, 2.13, 2.21, 2.15, 3.25, 4.5, 3.25, 3, 8, '2024-05-02 11:50:40'),
(9, 50, 23, 5, 1, 0, 4, 3, 1, 1, 2, 35, 0, ' 0 ', ' 142 ', ' 124 ', ' 141 ', 2.15, 2.09, 2.09, 2.15, 2.09, 2.14, 2.75, 2.13, 2.15, 2.3, 3.12, 3.08, 3.19, 3, 8, '2024-05-02 11:52:13'),
(10, 50, 18, 8, 1, 0, 5, 0, 0, 0, 2, 35, 1, ' 3 ', ' 115 ', ' 111 ', ' 102 ', 2.17, 2.08, 2.38, 2.09, 2.19, 2.14, 2.08, 2.13, 2.21, 2.15, 3.25, 4.5, 3.25, 3, 8, '2024-05-02 12:09:13'),
(11, 50, 23, 5, 1, 0, 4, 3, 1, 1, 2, 35, 0, ' 0 ', ' 142 ', ' 124 ', ' 141 ', 2.15, 2.09, 2.09, 2.15, 2.09, 2.14, 2.75, 2.13, 2.15, 2.3, 3.12, 3.08, 3.19, 3, 8, '2024-05-02 12:10:45'),
(12, 50, 18, 8, 1, 0, 5, 0, 0, 0, 2, 35, 1, ' 3 ', ' 115 ', ' 111 ', ' 102 ', 2.17, 2.08, 2.38, 2.09, 2.19, 2.14, 2.08, 2.13, 2.21, 2.15, 3.25, 4.5, 3.25, 3, 8, '2024-05-02 12:38:09'),
(13, 50, 23, 5, 1, 0, 4, 3, 1, 1, 2, 35, 0, ' 0 ', ' 142 ', ' 124 ', ' 141 ', 2.15, 2.09, 2.09, 2.15, 2.09, 2.14, 2.75, 2.13, 2.15, 2.3, 3.12, 3.08, 3.19, 3, 8, '2024-05-02 12:39:41'),
(14, 50, 18, 8, 1, 0, 5, 0, 0, 0, 2, 35, 1, ' 3 ', ' 115 ', ' 111 ', ' 102 ', 2.17, 2.08, 2.38, 2.09, 2.19, 2.14, 2.08, 2.13, 2.21, 2.15, 3.25, 4.5, 3.25, 3, 8, '2024-05-03 11:34:38'),
(15, 50, 23, 5, 1, 0, 4, 3, 1, 1, 2, 35, 0, ' 0 ', ' 142 ', ' 124 ', ' 141 ', 2.15, 2.09, 2.09, 2.15, 2.09, 2.14, 2.75, 2.13, 2.15, 2.3, 3.12, 3.08, 3.19, 3, 8, '2024-05-03 11:37:17'),
(16, 50, 18, 8, 1, 0, 5, 0, 0, 0, 2, 35, 1, ' 3 ', ' 115 ', ' 111 ', ' 102 ', 2.17, 2.08, 2.38, 2.09, 2.19, 2.14, 2.08, 2.13, 2.21, 2.15, 3.25, 4.5, 3.25, 3, 8, '2024-05-03 11:52:01'),
(17, 50, 23, 5, 1, 0, 4, 3, 1, 1, 2, 35, 0, ' 0 ', ' 142 ', ' 124 ', ' 141 ', 2.15, 2.09, 2.09, 2.15, 2.09, 2.14, 2.75, 2.13, 2.15, 2.3, 3.12, 3.08, 3.19, 3, 8, '2024-05-03 11:53:33'),
(18, 50, 12, 0, 0, 0, 1, 3, 0, 0, 3, 26, 1, ' 4 ', ' 107 ', ' 122 ', ' 126 ', 2.21, 2.12, 2.12, 2.21, 2.5, 2.11, 2.09, 2.38, 2.11, 2.11, 3.1, 3.09, 3.15, 5, 7, '2024-05-03 11:56:07'),
(19, 50, 22, 4, 1, 0, 4, 4, 0, 0, 0, 41, 0, ' 4 ', ' 124 ', ' 128 ', ' 144 ', 2.25, 2.09, 2.13, 2.08, 2.38, 2.25, 2.1, 2.08, 2.1, 3.5, 3.09, 3.19, 3.75, 4, 10, '2024-05-03 11:56:10'),
(20, 50, 20, 4, 1, 0, 4, 2, 0, 1, 2, 28, 1, ' 2 ', ' 128 ', ' 116 ', ' 110 ', 2.21, 2.08, 2.15, 2.19, 2.25, 2.21, 2.3, 2.19, 2.15, 2.15, 3.09, 3.1, 3.15, 5, 8, '2024-05-03 11:56:42'),
(21, 50, 22, 8, 0, 0, 0, 3, 0, 1, 5, 40, 1, ' 1 ', ' 103 ', ' 122 ', ' 115 ', 2.5, 2.13, 2.75, 2.38, 2.08, 2.17, 3.5, 2.25, 2.12, 2.1, 3.08, 3.12, 3.12, 5, 10, '2024-05-03 11:57:52'),
(22, 50, 18, 7, 0, 0, 4, 1, 1, 0, 4, 34, 0, ' 4 ', ' 148 ', ' 142 ', ' 126 ', 2.09, 3.5, 2.09, 2.17, 2.09, 2.17, 2.3, 2.38, 2.21, 2.09, 4.5, 3.21, 3.21, 7, 11, '2024-05-03 11:58:13'),
(23, 50, 16, 1, 0, 0, 1, 0, 1, 0, 3, 39, 1, ' 4 ', ' 149 ', ' 112 ', ' 135 ', 2.17, 2.25, 2.19, 2.09, 2.08, 2.19, 2.25, 2.75, 2.11, 2.25, 3.09, 3.08, 4.5, 4, 10, '2024-05-03 11:58:40'),
(24, 50, 3, 8, 0, 0, 5, 0, 0, 0, 0, 35, 0, ' 1 ', ' 114 ', ' 139 ', ' 140 ', 2.19, 2.08, 2.11, 2.21, 2.38, 2.38, 2.38, 2.12, 2.14, 2.17, 3.19, 3.14, 4.5, 7, 7, '2024-05-03 11:59:13'),
(25, 50, 8, 1, 1, 1, 0, 3, 1, 0, 0, 39, 1, ' 4 ', ' 131 ', ' 137 ', ' 113 ', 2.5, 2.09, 2.5, 2.15, 2.38, 2.19, 2.3, 2.14, 2.25, 2.21, 3.5, 3.3, 3.09, 3, 8, '2024-05-03 11:59:27'),
(26, 50, 6, 2, 0, 0, 3, 2, 1, 0, 2, 37, 0, ' 4 ', ' 140 ', ' 141 ', ' 144 ', 2.08, 2.09, 2.09, 2.13, 2.09, 3.5, 2.15, 2.09, 2.17, 2.3, 3.15, 3.21, 3.1, 5, 7, '2024-05-03 12:05:54'),
(27, 50, 22, 9, 0, 0, 2, 4, 0, 0, 3, 38, 0, ' 1 ', ' 144 ', ' 105 ', ' 147 ', 2.75, 2.09, 3.5, 2.17, 2.09, 2.1, 2.08, 2.08, 2.5, 2.09, 3.3, 3.25, 3.13, 7, 7, '2024-05-03 12:07:06');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_51`
--

CREATE TABLE `yd_51` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_51`
--

INSERT INTO `yd_51` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 51, 3, 1, 0, 1, 5, 3, 0, 0, 5, 25, 1, ' 0 ', ' 131 ', ' 143 ', ' 146 ', 2.08, 2.08, 2.19, 2.08, 2.38, 2.15, 2.25, 2.14, 2.1, 2.17, 3.14, 3.38, 3.11, 7, 8, '2024-05-02 09:56:40'),
(2, 51, 11, 0, 1, 1, 4, 0, 1, 1, 0, 27, 1, ' 3 ', ' 125 ', ' 139 ', ' 122 ', 2.11, 2.21, 3.5, 2.14, 2.25, 3.5, 2.08, 2.3, 2.15, 2.08, 3.17, 4.5, 3.08, 5, 11, '2024-05-02 09:56:54'),
(3, 51, 8, 9, 1, 1, 4, 3, 1, 0, 3, 28, 1, ' 1 ', ' 134 ', ' 119 ', ' 142 ', 2.17, 2.08, 2.1, 2.12, 2.09, 2.38, 2.11, 2.13, 2.1, 2.17, 3.13, 3.08, 3.08, 6, 8, '2024-05-02 09:57:05'),
(4, 51, 12, 0, 0, 0, 1, 0, 1, 1, 5, 38, 1, ' 3 ', ' 132 ', ' 117 ', ' 102 ', 2.5, 2.11, 2.19, 2.19, 2.3, 2.25, 3.5, 2.12, 2.09, 2.08, 3.11, 3.38, 3.15, 5, 10, '2024-05-02 09:57:52'),
(5, 51, 6, 0, 1, 1, 2, 3, 1, 0, 2, 36, 0, ' 0 ', ' 137 ', ' 148 ', ' 132 ', 2.08, 2.13, 2.3, 2.17, 2.14, 2.08, 2.11, 2.21, 2.13, 2.11, 3.21, 3.75, 3.19, 5, 12, '2024-05-02 09:58:31'),
(6, 51, 3, 1, 0, 1, 5, 3, 0, 0, 5, 25, 1, ' 0 ', ' 131 ', ' 143 ', ' 146 ', 2.08, 2.08, 2.19, 2.08, 2.38, 2.15, 2.25, 2.14, 2.1, 2.17, 3.14, 3.38, 3.11, 7, 8, '2024-05-02 10:12:13'),
(7, 51, 11, 0, 1, 1, 4, 0, 1, 1, 0, 27, 1, ' 3 ', ' 125 ', ' 139 ', ' 122 ', 2.11, 2.21, 3.5, 2.14, 2.25, 3.5, 2.08, 2.3, 2.15, 2.08, 3.17, 4.5, 3.08, 5, 11, '2024-05-02 10:12:28'),
(8, 51, 3, 1, 0, 1, 5, 3, 0, 0, 5, 25, 1, ' 0 ', ' 131 ', ' 143 ', ' 146 ', 2.08, 2.08, 2.19, 2.08, 2.38, 2.15, 2.25, 2.14, 2.1, 2.17, 3.14, 3.38, 3.11, 7, 8, '2024-05-02 11:51:03'),
(9, 51, 11, 0, 1, 1, 4, 0, 1, 1, 0, 27, 1, ' 3 ', ' 125 ', ' 139 ', ' 122 ', 2.11, 2.21, 3.5, 2.14, 2.25, 3.5, 2.08, 2.3, 2.15, 2.08, 3.17, 4.5, 3.08, 5, 11, '2024-05-02 11:51:17'),
(10, 51, 8, 9, 1, 1, 4, 3, 1, 0, 3, 28, 1, ' 1 ', ' 134 ', ' 119 ', ' 142 ', 2.17, 2.08, 2.1, 2.12, 2.09, 2.38, 2.11, 2.13, 2.1, 2.17, 3.13, 3.08, 3.08, 6, 8, '2024-05-02 11:51:28'),
(11, 51, 12, 0, 0, 0, 1, 0, 1, 1, 5, 38, 1, ' 3 ', ' 132 ', ' 117 ', ' 102 ', 2.5, 2.11, 2.19, 2.19, 2.3, 2.25, 3.5, 2.12, 2.09, 2.08, 3.11, 3.38, 3.15, 5, 10, '2024-05-02 11:52:15'),
(12, 51, 6, 0, 1, 1, 2, 3, 1, 0, 2, 36, 0, ' 0 ', ' 137 ', ' 148 ', ' 132 ', 2.08, 2.13, 2.3, 2.17, 2.14, 2.08, 2.11, 2.21, 2.13, 2.11, 3.21, 3.75, 3.19, 5, 12, '2024-05-02 11:52:54'),
(13, 51, 3, 1, 0, 1, 5, 3, 0, 0, 5, 25, 1, ' 0 ', ' 131 ', ' 143 ', ' 146 ', 2.08, 2.08, 2.19, 2.08, 2.38, 2.15, 2.25, 2.14, 2.1, 2.17, 3.14, 3.38, 3.11, 7, 8, '2024-05-02 12:09:35'),
(14, 51, 11, 0, 1, 1, 4, 0, 1, 1, 0, 27, 1, ' 3 ', ' 125 ', ' 139 ', ' 122 ', 2.11, 2.21, 3.5, 2.14, 2.25, 3.5, 2.08, 2.3, 2.15, 2.08, 3.17, 4.5, 3.08, 5, 11, '2024-05-02 12:09:50'),
(15, 51, 8, 9, 1, 1, 4, 3, 1, 0, 3, 28, 1, ' 1 ', ' 134 ', ' 119 ', ' 142 ', 2.17, 2.08, 2.1, 2.12, 2.09, 2.38, 2.11, 2.13, 2.1, 2.17, 3.13, 3.08, 3.08, 6, 8, '2024-05-02 12:10:00'),
(16, 51, 12, 0, 0, 0, 1, 0, 1, 1, 5, 38, 1, ' 3 ', ' 132 ', ' 117 ', ' 102 ', 2.5, 2.11, 2.19, 2.19, 2.3, 2.25, 3.5, 2.12, 2.09, 2.08, 3.11, 3.38, 3.15, 5, 10, '2024-05-02 12:10:47'),
(17, 51, 6, 0, 1, 1, 2, 3, 1, 0, 2, 36, 0, ' 0 ', ' 137 ', ' 148 ', ' 132 ', 2.08, 2.13, 2.3, 2.17, 2.14, 2.08, 2.11, 2.21, 2.13, 2.11, 3.21, 3.75, 3.19, 5, 12, '2024-05-02 12:11:26'),
(18, 51, 3, 1, 0, 1, 5, 3, 0, 0, 5, 25, 1, ' 0 ', ' 131 ', ' 143 ', ' 146 ', 2.08, 2.08, 2.19, 2.08, 2.38, 2.15, 2.25, 2.14, 2.1, 2.17, 3.14, 3.38, 3.11, 7, 8, '2024-05-02 12:38:31'),
(19, 51, 11, 0, 1, 1, 4, 0, 1, 1, 0, 27, 1, ' 3 ', ' 125 ', ' 139 ', ' 122 ', 2.11, 2.21, 3.5, 2.14, 2.25, 3.5, 2.08, 2.3, 2.15, 2.08, 3.17, 4.5, 3.08, 5, 11, '2024-05-02 12:38:46'),
(20, 51, 8, 9, 1, 1, 4, 3, 1, 0, 3, 28, 1, ' 1 ', ' 134 ', ' 119 ', ' 142 ', 2.17, 2.08, 2.1, 2.12, 2.09, 2.38, 2.11, 2.13, 2.1, 2.17, 3.13, 3.08, 3.08, 6, 8, '2024-05-02 12:38:56'),
(21, 51, 3, 1, 0, 1, 5, 3, 0, 0, 5, 25, 1, ' 0 ', ' 131 ', ' 143 ', ' 146 ', 2.08, 2.08, 2.19, 2.08, 2.38, 2.15, 2.25, 2.14, 2.1, 2.17, 3.14, 3.38, 3.11, 7, 8, '2024-05-03 11:36:13'),
(22, 51, 11, 0, 1, 1, 4, 0, 1, 1, 0, 27, 1, ' 3 ', ' 125 ', ' 139 ', ' 122 ', 2.11, 2.21, 3.5, 2.14, 2.25, 3.5, 2.08, 2.3, 2.15, 2.08, 3.17, 4.5, 3.08, 5, 11, '2024-05-03 11:36:41'),
(23, 51, 8, 9, 1, 1, 4, 3, 1, 0, 3, 28, 1, ' 1 ', ' 134 ', ' 119 ', ' 142 ', 2.17, 2.08, 2.1, 2.12, 2.09, 2.38, 2.11, 2.13, 2.1, 2.17, 3.13, 3.08, 3.08, 6, 8, '2024-05-03 11:36:51'),
(24, 51, 12, 0, 0, 0, 1, 0, 1, 1, 5, 38, 1, ' 3 ', ' 132 ', ' 117 ', ' 102 ', 2.5, 2.11, 2.19, 2.19, 2.3, 2.25, 3.5, 2.12, 2.09, 2.08, 3.11, 3.38, 3.15, 5, 10, '2024-05-03 11:37:18'),
(25, 51, 6, 0, 1, 1, 2, 3, 1, 0, 2, 36, 0, ' 0 ', ' 137 ', ' 148 ', ' 132 ', 2.08, 2.13, 2.3, 2.17, 2.14, 2.08, 2.11, 2.21, 2.13, 2.11, 3.21, 3.75, 3.19, 5, 12, '2024-05-03 11:37:40'),
(26, 51, 13, 9, 1, 1, 0, 5, 1, 1, 2, 48, 0, ' 4 ', ' 112 ', ' 118 ', ' 118 ', 2.75, 2.11, 2.08, 2.17, 2.09, 2.13, 2.1, 2.13, 2.12, 2.08, 3.14, 3.5, 3.38, 3, 12, '2024-05-03 11:38:01'),
(27, 51, 3, 1, 0, 1, 5, 3, 0, 0, 5, 25, 1, ' 0 ', ' 131 ', ' 143 ', ' 146 ', 2.08, 2.08, 2.19, 2.08, 2.38, 2.15, 2.25, 2.14, 2.1, 2.17, 3.14, 3.38, 3.11, 7, 8, '2024-05-03 11:52:23'),
(28, 51, 11, 0, 1, 1, 4, 0, 1, 1, 0, 27, 1, ' 3 ', ' 125 ', ' 139 ', ' 122 ', 2.11, 2.21, 3.5, 2.14, 2.25, 3.5, 2.08, 2.3, 2.15, 2.08, 3.17, 4.5, 3.08, 5, 11, '2024-05-03 11:52:38'),
(29, 51, 8, 9, 1, 1, 4, 3, 1, 0, 3, 28, 1, ' 1 ', ' 134 ', ' 119 ', ' 142 ', 2.17, 2.08, 2.1, 2.12, 2.09, 2.38, 2.11, 2.13, 2.1, 2.17, 3.13, 3.08, 3.08, 6, 8, '2024-05-03 11:52:48'),
(30, 51, 12, 0, 0, 0, 1, 0, 1, 1, 5, 38, 1, ' 3 ', ' 132 ', ' 117 ', ' 102 ', 2.5, 2.11, 2.19, 2.19, 2.3, 2.25, 3.5, 2.12, 2.09, 2.08, 3.11, 3.38, 3.15, 5, 10, '2024-05-03 11:53:35'),
(31, 51, 6, 0, 1, 1, 2, 3, 1, 0, 2, 36, 0, ' 0 ', ' 137 ', ' 148 ', ' 132 ', 2.08, 2.13, 2.3, 2.17, 2.14, 2.08, 2.11, 2.21, 2.13, 2.11, 3.21, 3.75, 3.19, 5, 12, '2024-05-03 11:54:14'),
(32, 51, 13, 9, 1, 1, 0, 5, 1, 1, 2, 48, 0, ' 4 ', ' 112 ', ' 118 ', ' 118 ', 2.75, 2.11, 2.08, 2.17, 2.09, 2.13, 2.1, 2.13, 2.12, 2.08, 3.14, 3.5, 3.38, 3, 12, '2024-05-03 11:55:30'),
(33, 51, 5, 6, 1, 0, 3, 2, 0, 1, 3, 41, 0, ' 2 ', ' 132 ', ' 122 ', ' 106 ', 2.12, 2.13, 2.11, 2.14, 2.13, 2.08, 2.75, 2.17, 2.38, 2.09, 3.08, 3.5, 3.13, 4, 12, '2024-05-03 11:56:36'),
(34, 51, 10, 5, 1, 1, 4, 3, 0, 0, 2, 26, 0, ' 4 ', ' 106 ', ' 117 ', ' 135 ', 2.15, 2.15, 3.5, 2.15, 2.75, 2.08, 2.5, 2.13, 2.14, 2.17, 3.38, 3.17, 3.5, 5, 9, '2024-05-03 12:01:35'),
(35, 51, 5, 1, 0, 1, 4, 3, 1, 1, 5, 47, 0, ' 4 ', ' 122 ', ' 115 ', ' 111 ', 2.14, 2.11, 3.5, 2.11, 2.3, 2.08, 2.3, 2.21, 2.11, 2.5, 3.3, 3.21, 3.15, 5, 11, '2024-05-03 12:01:45'),
(36, 51, 11, 1, 0, 0, 0, 4, 1, 0, 1, 37, 1, ' 1 ', ' 111 ', ' 104 ', ' 102 ', 2.12, 2.13, 2.13, 2.09, 2.11, 2.14, 2.17, 2.09, 2.08, 2.75, 3.09, 3.17, 3.5, 4, 11, '2024-05-03 12:01:49'),
(37, 51, 15, 2, 1, 1, 0, 5, 1, 0, 3, 41, 0, ' 1 ', ' 125 ', ' 100 ', ' 100 ', 2.15, 2.15, 2.17, 2.13, 2.75, 2.11, 2.5, 2.12, 2.38, 2.15, 3.3, 3.12, 3.25, 4, 8, '2024-05-03 12:04:50'),
(38, 51, 2, 3, 0, 1, 1, 0, 0, 1, 2, 40, 1, ' 2 ', ' 107 ', ' 122 ', ' 145 ', 2.3, 2.75, 2.19, 2.09, 2.1, 3.5, 2.75, 2.09, 3.5, 2.17, 4.5, 4.5, 3.19, 4, 9, '2024-05-03 12:06:08'),
(39, 51, 4, 1, 1, 1, 5, 3, 0, 1, 5, 39, 1, ' 4 ', ' 103 ', ' 102 ', ' 115 ', 2.1, 2.38, 2.15, 2.11, 2.08, 2.11, 2.21, 2.15, 2.19, 2.12, 3.09, 3.08, 3.38, 4, 11, '2024-05-03 12:07:10');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_52`
--

CREATE TABLE `yd_52` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_52`
--

INSERT INTO `yd_52` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 52, 0, 7, 0, 0, 1, 4, 1, 1, 4, 32, 1, ' 2 ', ' 144 ', ' 107 ', ' 115 ', 2.12, 2.15, 2.09, 2.38, 2.5, 2.3, 2.08, 3.5, 2.08, 2.75, 3.09, 3.09, 3.5, 3, 10, '2024-05-02 09:59:00'),
(2, 52, 0, 7, 0, 0, 1, 4, 1, 1, 4, 32, 1, ' 2 ', ' 144 ', ' 107 ', ' 115 ', 2.12, 2.15, 2.09, 2.38, 2.5, 2.3, 2.08, 3.5, 2.08, 2.75, 3.09, 3.09, 3.5, 3, 10, '2024-05-03 11:37:47'),
(3, 52, 16, 1, 1, 0, 2, 4, 0, 1, 0, 37, 0, ' 1 ', ' 100 ', ' 119 ', ' 137 ', 2.08, 2.1, 2.25, 2.13, 2.21, 2.11, 2.08, 2.1, 2.17, 2.13, 3.38, 3.09, 3.5, 5, 9, '2024-05-03 11:38:11'),
(4, 52, 0, 7, 0, 0, 1, 4, 1, 1, 4, 32, 1, ' 2 ', ' 144 ', ' 107 ', ' 115 ', 2.12, 2.15, 2.09, 2.38, 2.5, 2.3, 2.08, 3.5, 2.08, 2.75, 3.09, 3.09, 3.5, 3, 10, '2024-05-03 11:54:43'),
(5, 52, 16, 1, 1, 0, 2, 4, 0, 1, 0, 37, 0, ' 1 ', ' 100 ', ' 119 ', ' 137 ', 2.08, 2.1, 2.25, 2.13, 2.21, 2.11, 2.08, 2.1, 2.17, 2.13, 3.38, 3.09, 3.5, 5, 9, '2024-05-03 11:55:41'),
(6, 52, 9, 5, 1, 0, 3, 4, 1, 1, 2, 42, 0, ' 3 ', ' 115 ', ' 143 ', ' 114 ', 2.1, 2.12, 2.08, 2.09, 2.08, 2.09, 2.12, 2.08, 2.11, 2.21, 3.15, 3.09, 3.17, 4, 7, '2024-05-03 11:55:51'),
(7, 52, 9, 2, 1, 1, 1, 4, 1, 0, 1, 40, 1, ' 0 ', ' 124 ', ' 133 ', ' 111 ', 2.5, 2.21, 2.12, 2.08, 2.08, 2.1, 2.19, 2.75, 2.09, 2.17, 3.08, 3.17, 3.11, 7, 11, '2024-05-03 11:58:09'),
(8, 52, 6, 3, 1, 0, 2, 3, 1, 1, 1, 27, 0, ' 4 ', ' 105 ', ' 146 ', ' 116 ', 2.75, 2.25, 2.19, 2.09, 2.75, 2.5, 2.09, 2.5, 2.38, 2.08, 3.75, 3.09, 3.11, 6, 11, '2024-05-03 11:58:25'),
(9, 52, 16, 6, 1, 1, 5, 5, 1, 1, 2, 30, 1, ' 2 ', ' 127 ', ' 100 ', ' 126 ', 2.08, 2.17, 2.09, 2.25, 2.13, 2.09, 2.21, 2.5, 2.08, 2.17, 3.5, 3.38, 3.12, 7, 10, '2024-05-03 12:00:31'),
(10, 52, 22, 8, 0, 0, 5, 4, 1, 0, 1, 33, 1, ' 1 ', ' 147 ', ' 135 ', ' 147 ', 2.3, 2.09, 2.25, 2.15, 3.5, 2.19, 2.13, 2.21, 2.19, 2.3, 3.11, 3.15, 3.13, 4, 12, '2024-05-03 12:04:07'),
(11, 52, 6, 0, 0, 0, 3, 3, 1, 1, 5, 29, 1, ' 1 ', ' 135 ', ' 148 ', ' 139 ', 2.14, 2.19, 2.1, 2.19, 2.08, 2.15, 2.5, 2.38, 2.1, 2.13, 3.3, 3.38, 3.17, 6, 8, '2024-05-03 12:04:33');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_53`
--

CREATE TABLE `yd_53` (
  `ID` int(11) NOT NULL,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_53`
--

INSERT INTO `yd_53` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(1, 53, 12, 4, 1, 1, 4, 2, 1, 0, 4, 33, 0, ' 1 ', ' 130 ', ' 115 ', ' 120 ', 2.09, 2.21, 2.3, 2.13, 2.19, 2.12, 2.19, 2.08, 2.09, 2.1, 3.17, 3.09, 3.19, 6, 12, '2024-05-02 09:58:46'),
(2, 53, 12, 4, 1, 1, 4, 2, 1, 0, 4, 33, 0, ' 1 ', ' 130 ', ' 115 ', ' 120 ', 2.09, 2.21, 2.3, 2.13, 2.19, 2.12, 2.19, 2.08, 2.09, 2.1, 3.17, 3.09, 3.19, 6, 12, '2024-05-02 12:11:41'),
(3, 53, 12, 4, 1, 1, 4, 2, 1, 0, 4, 33, 0, ' 1 ', ' 130 ', ' 115 ', ' 120 ', 2.09, 2.21, 2.3, 2.13, 2.19, 2.12, 2.19, 2.08, 2.09, 2.1, 3.17, 3.09, 3.19, 6, 12, '2024-05-03 11:37:44'),
(4, 53, 12, 4, 1, 1, 4, 2, 1, 0, 4, 33, 0, ' 1 ', ' 130 ', ' 115 ', ' 120 ', 2.09, 2.21, 2.3, 2.13, 2.19, 2.12, 2.19, 2.08, 2.09, 2.1, 3.17, 3.09, 3.19, 6, 12, '2024-05-03 11:54:29'),
(5, 53, 18, 0, 1, 1, 4, 5, 1, 0, 5, 46, 0, ' 2 ', ' 132 ', ' 146 ', ' 133 ', 3.5, 2.3, 2.11, 2.5, 2.09, 2.14, 3.5, 2.09, 2.15, 2.14, 3.15, 3.15, 3.12, 7, 7, '2024-05-03 11:58:05'),
(6, 53, 8, 4, 0, 1, 4, 1, 1, 1, 5, 41, 0, ' 2 ', ' 143 ', ' 108 ', ' 114 ', 2.19, 2.11, 2.08, 2.09, 2.25, 2.15, 2.09, 2.08, 2.11, 2.12, 3.1, 3.14, 3.08, 4, 8, '2024-05-03 12:03:52');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_54`
--

CREATE TABLE `yd_54` (
  `ID` int(11) NOT NULL DEFAULT 0,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_54`
--

INSERT INTO `yd_54` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(0, 54, 23, 4, 0, 1, 3, 3, 1, 0, 2, 39, 1, ' 3 ', ' 104 ', ' 100 ', ' 100 ', 2.11, 2.14, 2.09, 2.09, 2.38, 2.19, 2.19, 2.08, 2.15, 2.09, 3.09, 3.15, 3.13, 3, 10, '2024-05-02 09:56:03'),
(0, 54, 9, 1, 1, 0, 5, 4, 1, 1, 1, 31, 1, ' 1 ', ' 124 ', ' 135 ', ' 131 ', 2.1, 2.19, 2.1, 2.3, 2.25, 2.13, 2.12, 2.5, 2.08, 2.38, 3.5, 3.08, 3.14, 5, 12, '2024-05-02 09:56:36'),
(0, 54, 20, 8, 0, 1, 1, 1, 0, 0, 5, 41, 1, ' 4 ', ' 105 ', ' 122 ', ' 113 ', 2.38, 2.14, 2.3, 2.21, 2.11, 3.5, 2.11, 2.19, 2.5, 2.09, 3.25, 4.5, 4.5, 3, 7, '2024-05-02 09:57:03'),
(0, 54, 14, 7, 1, 1, 1, 4, 1, 1, 0, 49, 0, ' 4 ', ' 137 ', ' 132 ', ' 124 ', 2.09, 2.1, 2.09, 2.09, 2.19, 2.14, 2.13, 2.17, 2.25, 2.14, 3.38, 3.19, 3.09, 4, 8, '2024-05-02 09:57:58'),
(0, 54, 23, 4, 0, 1, 3, 3, 1, 0, 2, 39, 1, ' 3 ', ' 104 ', ' 100 ', ' 100 ', 2.11, 2.14, 2.09, 2.09, 2.38, 2.19, 2.19, 2.08, 2.15, 2.09, 3.09, 3.15, 3.13, 3, 10, '2024-05-02 10:08:58'),
(0, 54, 23, 4, 0, 1, 3, 3, 1, 0, 2, 39, 1, ' 3 ', ' 104 ', ' 100 ', ' 100 ', 2.11, 2.14, 2.09, 2.09, 2.38, 2.19, 2.19, 2.08, 2.15, 2.09, 3.09, 3.15, 3.13, 3, 10, '2024-05-02 10:11:36'),
(0, 54, 9, 1, 1, 0, 5, 4, 1, 1, 1, 31, 1, ' 1 ', ' 124 ', ' 135 ', ' 131 ', 2.1, 2.19, 2.1, 2.3, 2.25, 2.13, 2.12, 2.5, 2.08, 2.38, 3.5, 3.08, 3.14, 5, 12, '2024-05-02 10:12:09'),
(0, 54, 23, 4, 0, 1, 3, 3, 1, 0, 2, 39, 1, ' 3 ', ' 104 ', ' 100 ', ' 100 ', 2.11, 2.14, 2.09, 2.09, 2.38, 2.19, 2.19, 2.08, 2.15, 2.09, 3.09, 3.15, 3.13, 3, 10, '2024-05-02 10:13:21'),
(0, 54, 23, 4, 0, 1, 3, 3, 1, 0, 2, 39, 1, ' 3 ', ' 104 ', ' 100 ', ' 100 ', 2.11, 2.14, 2.09, 2.09, 2.38, 2.19, 2.19, 2.08, 2.15, 2.09, 3.09, 3.15, 3.13, 3, 10, '2024-05-02 10:14:23'),
(0, 54, 23, 4, 0, 1, 3, 3, 1, 0, 2, 39, 1, ' 3 ', ' 104 ', ' 100 ', ' 100 ', 2.11, 2.14, 2.09, 2.09, 2.38, 2.19, 2.19, 2.08, 2.15, 2.09, 3.09, 3.15, 3.13, 3, 10, '2024-05-02 10:17:58'),
(0, 54, 23, 4, 0, 1, 3, 3, 1, 0, 2, 39, 1, ' 3 ', ' 104 ', ' 100 ', ' 100 ', 2.11, 2.14, 2.09, 2.09, 2.38, 2.19, 2.19, 2.08, 2.15, 2.09, 3.09, 3.15, 3.13, 3, 10, '2024-05-02 10:23:31'),
(0, 54, 23, 4, 0, 1, 3, 3, 1, 0, 2, 39, 1, ' 3 ', ' 104 ', ' 100 ', ' 100 ', 2.11, 2.14, 2.09, 2.09, 2.38, 2.19, 2.19, 2.08, 2.15, 2.09, 3.09, 3.15, 3.13, 3, 10, '2024-05-02 10:26:23'),
(0, 54, 23, 4, 0, 1, 3, 3, 1, 0, 2, 39, 1, ' 3 ', ' 104 ', ' 100 ', ' 100 ', 2.11, 2.14, 2.09, 2.09, 2.38, 2.19, 2.19, 2.08, 2.15, 2.09, 3.09, 3.15, 3.13, 3, 10, '2024-05-02 10:28:37'),
(0, 54, 23, 4, 0, 1, 3, 3, 1, 0, 2, 39, 1, ' 3 ', ' 104 ', ' 100 ', ' 100 ', 2.11, 2.14, 2.09, 2.09, 2.38, 2.19, 2.19, 2.08, 2.15, 2.09, 3.09, 3.15, 3.13, 3, 10, '2024-05-02 11:50:26'),
(0, 54, 9, 1, 1, 0, 5, 4, 1, 1, 1, 31, 1, ' 1 ', ' 124 ', ' 135 ', ' 131 ', 2.1, 2.19, 2.1, 2.3, 2.25, 2.13, 2.12, 2.5, 2.08, 2.38, 3.5, 3.08, 3.14, 5, 12, '2024-05-02 11:50:59'),
(0, 54, 20, 8, 0, 1, 1, 1, 0, 0, 5, 41, 1, ' 4 ', ' 105 ', ' 122 ', ' 113 ', 2.38, 2.14, 2.3, 2.21, 2.11, 3.5, 2.11, 2.19, 2.5, 2.09, 3.25, 4.5, 4.5, 3, 7, '2024-05-02 11:51:26'),
(0, 54, 14, 7, 1, 1, 1, 4, 1, 1, 0, 49, 0, ' 4 ', ' 137 ', ' 132 ', ' 124 ', 2.09, 2.1, 2.09, 2.09, 2.19, 2.14, 2.13, 2.17, 2.25, 2.14, 3.38, 3.19, 3.09, 4, 8, '2024-05-02 11:52:21'),
(0, 54, 23, 4, 0, 1, 3, 3, 1, 0, 2, 39, 1, ' 3 ', ' 104 ', ' 100 ', ' 100 ', 2.11, 2.14, 2.09, 2.09, 2.38, 2.19, 2.19, 2.08, 2.15, 2.09, 3.09, 3.15, 3.13, 3, 10, '2024-05-02 12:01:05'),
(0, 54, 23, 4, 0, 1, 3, 3, 1, 0, 2, 39, 1, ' 3 ', ' 104 ', ' 100 ', ' 100 ', 2.11, 2.14, 2.09, 2.09, 2.38, 2.19, 2.19, 2.08, 2.15, 2.09, 3.09, 3.15, 3.13, 3, 10, '2024-05-02 12:08:58'),
(0, 54, 9, 1, 1, 0, 5, 4, 1, 1, 1, 31, 1, ' 1 ', ' 124 ', ' 135 ', ' 131 ', 2.1, 2.19, 2.1, 2.3, 2.25, 2.13, 2.12, 2.5, 2.08, 2.38, 3.5, 3.08, 3.14, 5, 12, '2024-05-02 12:09:31'),
(0, 54, 20, 8, 0, 1, 1, 1, 0, 0, 5, 41, 1, ' 4 ', ' 105 ', ' 122 ', ' 113 ', 2.38, 2.14, 2.3, 2.21, 2.11, 3.5, 2.11, 2.19, 2.5, 2.09, 3.25, 4.5, 4.5, 3, 7, '2024-05-02 12:09:58'),
(0, 54, 14, 7, 1, 1, 1, 4, 1, 1, 0, 49, 0, ' 4 ', ' 137 ', ' 132 ', ' 124 ', 2.09, 2.1, 2.09, 2.09, 2.19, 2.14, 2.13, 2.17, 2.25, 2.14, 3.38, 3.19, 3.09, 4, 8, '2024-05-02 12:10:53'),
(0, 54, 23, 4, 0, 1, 3, 3, 1, 0, 2, 39, 1, ' 3 ', ' 104 ', ' 100 ', ' 100 ', 2.11, 2.14, 2.09, 2.09, 2.38, 2.19, 2.19, 2.08, 2.15, 2.09, 3.09, 3.15, 3.13, 3, 10, '2024-05-02 12:37:54'),
(0, 54, 9, 1, 1, 0, 5, 4, 1, 1, 1, 31, 1, ' 1 ', ' 124 ', ' 135 ', ' 131 ', 2.1, 2.19, 2.1, 2.3, 2.25, 2.13, 2.12, 2.5, 2.08, 2.38, 3.5, 3.08, 3.14, 5, 12, '2024-05-02 12:38:27'),
(0, 54, 20, 8, 0, 1, 1, 1, 0, 0, 5, 41, 1, ' 4 ', ' 105 ', ' 122 ', ' 113 ', 2.38, 2.14, 2.3, 2.21, 2.11, 3.5, 2.11, 2.19, 2.5, 2.09, 3.25, 4.5, 4.5, 3, 7, '2024-05-02 12:38:54'),
(0, 54, 23, 4, 0, 1, 3, 3, 1, 0, 2, 39, 1, ' 3 ', ' 104 ', ' 100 ', ' 100 ', 2.11, 2.14, 2.09, 2.09, 2.38, 2.19, 2.19, 2.08, 2.15, 2.09, 3.09, 3.15, 3.13, 3, 10, '2024-05-02 12:52:25'),
(0, 54, 23, 4, 0, 1, 3, 3, 1, 0, 2, 39, 1, ' 3 ', ' 104 ', ' 100 ', ' 100 ', 2.11, 2.14, 2.09, 2.09, 2.38, 2.19, 2.19, 2.08, 2.15, 2.09, 3.09, 3.15, 3.13, 3, 10, '2024-05-03 11:34:20'),
(0, 54, 9, 1, 1, 0, 5, 4, 1, 1, 1, 31, 1, ' 1 ', ' 124 ', ' 135 ', ' 131 ', 2.1, 2.19, 2.1, 2.3, 2.25, 2.13, 2.12, 2.5, 2.08, 2.38, 3.5, 3.08, 3.14, 5, 12, '2024-05-03 11:36:04'),
(0, 54, 20, 8, 0, 1, 1, 1, 0, 0, 5, 41, 1, ' 4 ', ' 105 ', ' 122 ', ' 113 ', 2.38, 2.14, 2.3, 2.21, 2.11, 3.5, 2.11, 2.19, 2.5, 2.09, 3.25, 4.5, 4.5, 3, 7, '2024-05-03 11:36:50'),
(0, 54, 14, 7, 1, 1, 1, 4, 1, 1, 0, 49, 0, ' 4 ', ' 137 ', ' 132 ', ' 124 ', 2.09, 2.1, 2.09, 2.09, 2.19, 2.14, 2.13, 2.17, 2.25, 2.14, 3.38, 3.19, 3.09, 4, 8, '2024-05-03 11:37:19'),
(0, 54, 7, 8, 1, 1, 5, 3, 0, 0, 4, 25, 1, ' 0 ', ' 116 ', ' 145 ', ' 115 ', 2.21, 2.25, 2.13, 2.5, 2.09, 2.19, 2.12, 2.08, 2.21, 2.08, 3.3, 3.3, 3.19, 6, 10, '2024-05-03 11:37:58'),
(0, 54, 23, 4, 0, 1, 3, 3, 1, 0, 2, 39, 1, ' 3 ', ' 104 ', ' 100 ', ' 100 ', 2.11, 2.14, 2.09, 2.09, 2.38, 2.19, 2.19, 2.08, 2.15, 2.09, 3.09, 3.15, 3.13, 3, 10, '2024-05-03 11:51:46'),
(0, 54, 9, 1, 1, 0, 5, 4, 1, 1, 1, 31, 1, ' 1 ', ' 124 ', ' 135 ', ' 131 ', 2.1, 2.19, 2.1, 2.3, 2.25, 2.13, 2.12, 2.5, 2.08, 2.38, 3.5, 3.08, 3.14, 5, 12, '2024-05-03 11:52:19'),
(0, 54, 20, 8, 0, 1, 1, 1, 0, 0, 5, 41, 1, ' 4 ', ' 105 ', ' 122 ', ' 113 ', 2.38, 2.14, 2.3, 2.21, 2.11, 3.5, 2.11, 2.19, 2.5, 2.09, 3.25, 4.5, 4.5, 3, 7, '2024-05-03 11:52:46'),
(0, 54, 14, 7, 1, 1, 1, 4, 1, 1, 0, 49, 0, ' 4 ', ' 137 ', ' 132 ', ' 124 ', 2.09, 2.1, 2.09, 2.09, 2.19, 2.14, 2.13, 2.17, 2.25, 2.14, 3.38, 3.19, 3.09, 4, 8, '2024-05-03 11:53:41'),
(0, 54, 7, 8, 1, 1, 5, 3, 0, 0, 4, 25, 1, ' 0 ', ' 116 ', ' 145 ', ' 115 ', 2.21, 2.25, 2.13, 2.5, 2.09, 2.19, 2.12, 2.08, 2.21, 2.08, 3.3, 3.3, 3.19, 6, 10, '2024-05-03 11:55:22'),
(0, 54, 21, 1, 1, 0, 5, 5, 1, 1, 1, 31, 1, ' 1 ', ' 120 ', ' 111 ', ' 110 ', 2.17, 2.38, 2.08, 2.08, 2.09, 3.5, 2.08, 2.13, 2.14, 2.5, 3.1, 3.1, 3.13, 4, 11, '2024-05-03 11:55:49'),
(0, 54, 6, 0, 0, 1, 3, 5, 1, 0, 4, 43, 0, ' 3 ', ' 116 ', ' 104 ', ' 123 ', 2.08, 2.09, 2.09, 2.08, 2.5, 2.08, 2.13, 2.21, 2.3, 2.17, 3.08, 3.17, 3.09, 5, 10, '2024-05-03 11:58:07'),
(0, 54, 1, 5, 0, 0, 0, 2, 1, 0, 5, 39, 1, ' 3 ', ' 103 ', ' 104 ', ' 123 ', 2.09, 2.1, 2.08, 2.08, 2.08, 2.5, 2.1, 2.12, 3.5, 2.12, 3.3, 3.5, 3.75, 4, 9, '2024-05-03 12:01:55'),
(0, 54, 12, 5, 0, 1, 5, 0, 1, 1, 3, 27, 1, ' 1 ', ' 147 ', ' 140 ', ' 123 ', 2.19, 2.09, 2.12, 2.08, 2.12, 2.08, 2.09, 2.09, 2.12, 2.14, 3.75, 3.15, 3.3, 5, 9, '2024-05-03 12:04:23'),
(0, 54, 9, 0, 1, 0, 5, 5, 0, 1, 4, 46, 1, ' 0 ', ' 127 ', ' 125 ', ' 117 ', 2.14, 2.08, 2.3, 2.19, 2.25, 2.19, 2.21, 2.38, 2.08, 2.09, 3.12, 3.17, 3.21, 4, 12, '2024-05-03 12:05:06'),
(0, 54, 4, 2, 1, 1, 1, 4, 0, 0, 5, 30, 1, ' 2 ', ' 138 ', ' 121 ', ' 123 ', 2.08, 2.08, 2.08, 2.15, 2.08, 2.25, 2.15, 3.5, 2.09, 2.25, 3.38, 3.38, 3.12, 6, 7, '2024-05-03 12:06:37');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_55`
--

CREATE TABLE `yd_55` (
  `ID` int(11) NOT NULL DEFAULT 0,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_55`
--

INSERT INTO `yd_55` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(0, 55, 7, 6, 1, 1, 0, 1, 1, 0, 0, 45, 1, ' 0 ', ' 107 ', ' 129 ', ' 101 ', 2.11, 2.13, 2.25, 2.09, 2.75, 2.17, 2.14, 2.75, 2.17, 2.5, 3.25, 3.75, 3.09, 4, 11, '2024-05-02 09:57:46'),
(0, 55, 18, 2, 1, 0, 2, 4, 0, 0, 2, 34, 1, ' 1 ', ' 109 ', ' 111 ', ' 128 ', 2.21, 2.08, 2.1, 3.5, 2.08, 2.1, 2.3, 2.13, 2.38, 2.5, 3.3, 3.17, 3.09, 5, 9, '2024-05-02 09:58:56'),
(0, 55, 7, 6, 1, 1, 0, 1, 1, 0, 0, 45, 1, ' 0 ', ' 107 ', ' 129 ', ' 101 ', 2.11, 2.13, 2.25, 2.09, 2.75, 2.17, 2.14, 2.75, 2.17, 2.5, 3.25, 3.75, 3.09, 4, 11, '2024-05-02 11:52:09'),
(0, 55, 7, 6, 1, 1, 0, 1, 1, 0, 0, 45, 1, ' 0 ', ' 107 ', ' 129 ', ' 101 ', 2.11, 2.13, 2.25, 2.09, 2.75, 2.17, 2.14, 2.75, 2.17, 2.5, 3.25, 3.75, 3.09, 4, 11, '2024-05-02 12:10:41'),
(0, 55, 18, 2, 1, 0, 2, 4, 0, 0, 2, 34, 1, ' 1 ', ' 109 ', ' 111 ', ' 128 ', 2.21, 2.08, 2.1, 3.5, 2.08, 2.1, 2.3, 2.13, 2.38, 2.5, 3.3, 3.17, 3.09, 5, 9, '2024-05-02 12:11:51'),
(0, 55, 7, 6, 1, 1, 0, 1, 1, 0, 0, 45, 1, ' 0 ', ' 107 ', ' 129 ', ' 101 ', 2.11, 2.13, 2.25, 2.09, 2.75, 2.17, 2.14, 2.75, 2.17, 2.5, 3.25, 3.75, 3.09, 4, 11, '2024-05-02 12:39:37'),
(0, 55, 7, 6, 1, 1, 0, 1, 1, 0, 0, 45, 1, ' 0 ', ' 107 ', ' 129 ', ' 101 ', 2.11, 2.13, 2.25, 2.09, 2.75, 2.17, 2.14, 2.75, 2.17, 2.5, 3.25, 3.75, 3.09, 4, 11, '2024-05-03 11:37:16'),
(0, 55, 18, 2, 1, 0, 2, 4, 0, 0, 2, 34, 1, ' 1 ', ' 109 ', ' 111 ', ' 128 ', 2.21, 2.08, 2.1, 3.5, 2.08, 2.1, 2.3, 2.13, 2.38, 2.5, 3.3, 3.17, 3.09, 5, 9, '2024-05-03 11:37:46'),
(0, 55, 18, 7, 1, 1, 3, 3, 1, 1, 5, 41, 1, ' 4 ', ' 114 ', ' 149 ', ' 110 ', 3.5, 2.08, 2.19, 2.09, 2.3, 2.12, 2.3, 2.1, 2.25, 2.19, 3.08, 3.19, 3.5, 5, 12, '2024-05-03 11:37:56'),
(0, 55, 7, 6, 1, 1, 0, 1, 1, 0, 0, 45, 1, ' 0 ', ' 107 ', ' 129 ', ' 101 ', 2.11, 2.13, 2.25, 2.09, 2.75, 2.17, 2.14, 2.75, 2.17, 2.5, 3.25, 3.75, 3.09, 4, 11, '2024-05-03 11:53:29'),
(0, 55, 18, 2, 1, 0, 2, 4, 0, 0, 2, 34, 1, ' 1 ', ' 109 ', ' 111 ', ' 128 ', 2.21, 2.08, 2.1, 3.5, 2.08, 2.1, 2.3, 2.13, 2.38, 2.5, 3.3, 3.17, 3.09, 5, 9, '2024-05-03 11:54:39'),
(0, 55, 18, 7, 1, 1, 3, 3, 1, 1, 5, 41, 1, ' 4 ', ' 114 ', ' 149 ', ' 110 ', 3.5, 2.08, 2.19, 2.09, 2.3, 2.12, 2.3, 2.1, 2.25, 2.19, 3.08, 3.19, 3.5, 5, 12, '2024-05-03 11:55:10'),
(0, 55, 4, 4, 0, 0, 5, 2, 0, 1, 5, 45, 1, ' 2 ', ' 114 ', ' 119 ', ' 139 ', 2.15, 2.14, 2.1, 2.08, 2.11, 2.12, 2.09, 2.1, 2.09, 2.25, 3.12, 3.11, 3.75, 7, 7, '2024-05-03 11:56:30'),
(0, 55, 18, 0, 0, 1, 4, 5, 0, 1, 0, 39, 0, ' 3 ', ' 117 ', ' 114 ', ' 132 ', 2.3, 2.75, 2.38, 2.75, 2.3, 2.14, 2.14, 2.08, 2.5, 2.09, 3.11, 3.75, 3.09, 3, 7, '2024-05-03 11:58:50'),
(0, 55, 3, 3, 1, 1, 1, 1, 0, 0, 0, 33, 0, ' 4 ', ' 125 ', ' 103 ', ' 107 ', 2.19, 2.11, 2.17, 2.17, 2.1, 2.25, 2.12, 2.14, 3.5, 2.13, 3.17, 3.38, 3.08, 5, 12, '2024-05-03 11:59:39'),
(0, 55, 11, 0, 0, 1, 2, 0, 0, 1, 0, 49, 1, ' 0 ', ' 129 ', ' 134 ', ' 147 ', 2.38, 2.38, 2.12, 2.19, 2.21, 2.25, 2.3, 2.19, 2.13, 2.38, 3.08, 3.21, 3.1, 3, 10, '2024-05-03 11:59:50'),
(0, 55, 9, 4, 1, 1, 5, 2, 1, 1, 5, 44, 0, ' 3 ', ' 100 ', ' 134 ', ' 140 ', 2.11, 2.3, 2.25, 2.21, 2.09, 2.12, 2.17, 2.75, 2.1, 2.1, 3.1, 3.75, 3.19, 4, 10, '2024-05-03 12:03:58'),
(0, 55, 23, 3, 0, 0, 2, 1, 0, 0, 0, 34, 1, ' 2 ', ' 129 ', ' 129 ', ' 133 ', 2.13, 2.09, 2.09, 2.08, 2.19, 2.75, 2.17, 2.38, 2.21, 2.38, 3.09, 3.08, 3.09, 3, 8, '2024-05-03 12:05:48'),
(0, 55, 3, 3, 1, 1, 4, 2, 1, 1, 1, 43, 0, ' 2 ', ' 116 ', ' 142 ', ' 120 ', 2.08, 2.75, 2.15, 2.38, 2.12, 2.25, 2.13, 2.08, 3.5, 2.11, 3.17, 3.17, 3.21, 6, 11, '2024-05-03 12:07:20');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_56`
--

CREATE TABLE `yd_56` (
  `ID` int(11) NOT NULL DEFAULT 0,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_56`
--

INSERT INTO `yd_56` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(0, 56, 6, 1, 0, 0, 0, 0, 0, 1, 0, 49, 0, ' 3 ', ' 112 ', ' 123 ', ' 126 ', 2.08, 2.11, 2.5, 2.5, 2.08, 2.09, 2.21, 2.21, 2.09, 2.14, 3.1, 3.08, 4.5, 5, 8, '2024-05-03 11:57:13'),
(0, 56, 23, 1, 1, 0, 1, 1, 0, 0, 0, 37, 1, ' 2 ', ' 105 ', ' 148 ', ' 127 ', 2.19, 2.1, 2.38, 2.1, 2.21, 2.19, 2.09, 2.38, 2.3, 2.1, 3.09, 3.11, 3.11, 4, 8, '2024-05-03 11:57:15'),
(0, 56, 18, 3, 1, 1, 0, 4, 1, 1, 5, 31, 0, ' 2 ', ' 134 ', ' 134 ', ' 139 ', 2.08, 2.12, 2.11, 2.09, 2.13, 2.15, 2.75, 2.13, 2.11, 2.12, 3.5, 3.25, 3.09, 7, 10, '2024-05-03 11:57:54'),
(0, 56, 14, 0, 0, 1, 3, 1, 0, 1, 4, 27, 0, ' 2 ', ' 101 ', ' 135 ', ' 133 ', 2.14, 2.14, 2.15, 2.3, 2.19, 2.11, 2.19, 2.09, 2.09, 3.5, 3.08, 3.1, 3.14, 5, 11, '2024-05-03 11:58:15'),
(0, 56, 15, 5, 1, 0, 3, 5, 1, 1, 0, 33, 0, ' 4 ', ' 141 ', ' 124 ', ' 108 ', 3.5, 2.21, 2.3, 2.12, 2.09, 2.19, 2.12, 2.13, 2.09, 2.38, 3.08, 3.09, 4.5, 4, 11, '2024-05-03 12:01:02'),
(0, 56, 10, 7, 0, 0, 1, 3, 1, 1, 0, 29, 1, ' 3 ', ' 123 ', ' 129 ', ' 104 ', 2.09, 2.08, 2.75, 2.19, 2.19, 2.1, 2.15, 2.15, 2.19, 2.38, 3.25, 3.13, 3.19, 6, 8, '2024-05-03 12:03:30'),
(0, 56, 7, 8, 1, 0, 1, 2, 1, 0, 1, 41, 1, ' 4 ', ' 133 ', ' 125 ', ' 102 ', 2.25, 2.08, 2.08, 2.1, 2.5, 2.25, 2.08, 2.08, 2.09, 2.08, 3.3, 3.08, 3.14, 7, 9, '2024-05-03 12:04:03'),
(0, 56, 9, 6, 0, 0, 2, 0, 0, 1, 4, 34, 0, ' 0 ', ' 125 ', ' 114 ', ' 107 ', 2.17, 2.09, 2.09, 2.25, 2.15, 2.21, 2.5, 2.09, 2.08, 2.5, 3.09, 3.12, 3.08, 4, 10, '2024-05-03 12:06:35'),
(0, 56, 22, 3, 0, 0, 4, 2, 0, 1, 4, 42, 0, ' 3 ', ' 129 ', ' 143 ', ' 101 ', 2.14, 2.21, 2.3, 2.08, 2.38, 3.5, 2.09, 2.14, 2.75, 2.19, 3.5, 3.38, 3.12, 3, 8, '2024-05-03 12:06:59');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_57`
--

CREATE TABLE `yd_57` (
  `ID` int(11) NOT NULL DEFAULT 0,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_57`
--

INSERT INTO `yd_57` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(0, 57, 15, 7, 0, 1, 1, 2, 0, 1, 1, 49, 1, ' 2 ', ' 124 ', ' 134 ', ' 133 ', 2.12, 2.25, 2.15, 2.75, 2.09, 2.75, 2.14, 2.21, 2.12, 2.25, 3.11, 3.38, 3.15, 4, 10, '2024-05-02 09:56:46'),
(0, 57, 15, 7, 0, 1, 1, 2, 0, 1, 1, 49, 1, ' 2 ', ' 124 ', ' 134 ', ' 133 ', 2.12, 2.25, 2.15, 2.75, 2.09, 2.75, 2.14, 2.21, 2.12, 2.25, 3.11, 3.38, 3.15, 4, 10, '2024-05-02 10:12:19'),
(0, 57, 15, 7, 0, 1, 1, 2, 0, 1, 1, 49, 1, ' 2 ', ' 124 ', ' 134 ', ' 133 ', 2.12, 2.25, 2.15, 2.75, 2.09, 2.75, 2.14, 2.21, 2.12, 2.25, 3.11, 3.38, 3.15, 4, 10, '2024-05-02 11:51:09'),
(0, 57, 15, 7, 0, 1, 1, 2, 0, 1, 1, 49, 1, ' 2 ', ' 124 ', ' 134 ', ' 133 ', 2.12, 2.25, 2.15, 2.75, 2.09, 2.75, 2.14, 2.21, 2.12, 2.25, 3.11, 3.38, 3.15, 4, 10, '2024-05-02 12:09:41'),
(0, 57, 15, 7, 0, 1, 1, 2, 0, 1, 1, 49, 1, ' 2 ', ' 124 ', ' 134 ', ' 133 ', 2.12, 2.25, 2.15, 2.75, 2.09, 2.75, 2.14, 2.21, 2.12, 2.25, 3.11, 3.38, 3.15, 4, 10, '2024-05-02 12:38:37'),
(0, 57, 15, 7, 0, 1, 1, 2, 0, 1, 1, 49, 1, ' 2 ', ' 124 ', ' 134 ', ' 133 ', 2.12, 2.25, 2.15, 2.75, 2.09, 2.75, 2.14, 2.21, 2.12, 2.25, 3.11, 3.38, 3.15, 4, 10, '2024-05-03 11:36:25'),
(0, 57, 13, 9, 1, 0, 1, 2, 0, 1, 0, 34, 1, ' 0 ', ' 149 ', ' 104 ', ' 125 ', 2.12, 2.21, 2.12, 2.25, 2.21, 2.38, 2.08, 2.14, 2.21, 2.09, 3.09, 3.09, 3.21, 6, 12, '2024-05-03 11:37:57'),
(0, 57, 15, 7, 0, 1, 1, 2, 0, 1, 1, 49, 1, ' 2 ', ' 124 ', ' 134 ', ' 133 ', 2.12, 2.25, 2.15, 2.75, 2.09, 2.75, 2.14, 2.21, 2.12, 2.25, 3.11, 3.38, 3.15, 4, 10, '2024-05-03 11:52:29'),
(0, 57, 13, 9, 1, 0, 1, 2, 0, 1, 0, 34, 1, ' 0 ', ' 149 ', ' 104 ', ' 125 ', 2.12, 2.21, 2.12, 2.25, 2.21, 2.38, 2.08, 2.14, 2.21, 2.09, 3.09, 3.09, 3.21, 6, 12, '2024-05-03 11:55:12'),
(0, 57, 3, 4, 0, 1, 2, 2, 0, 1, 3, 42, 0, ' 4 ', ' 145 ', ' 129 ', ' 149 ', 2.3, 2.1, 2.15, 2.17, 2.38, 2.14, 3.5, 2.15, 3.5, 2.75, 3.38, 3.15, 3.14, 5, 7, '2024-05-03 11:58:03'),
(0, 57, 24, 6, 0, 1, 3, 5, 1, 0, 3, 42, 1, ' 4 ', ' 109 ', ' 138 ', ' 143 ', 2.38, 2.21, 2.09, 2.09, 2.25, 2.19, 2.1, 2.5, 2.5, 2.15, 3.13, 3.14, 3.11, 6, 9, '2024-05-03 11:58:19'),
(0, 57, 15, 9, 0, 1, 0, 4, 0, 1, 0, 49, 1, ' 3 ', ' 101 ', ' 134 ', ' 133 ', 2.25, 2.11, 2.1, 3.5, 2.09, 2.09, 2.75, 2.17, 2.19, 2.25, 3.08, 3.19, 3.38, 5, 10, '2024-05-03 12:03:03'),
(0, 57, 12, 7, 0, 1, 4, 2, 1, 1, 2, 40, 0, ' 1 ', ' 142 ', ' 128 ', ' 118 ', 2.13, 2.09, 2.15, 2.13, 2.12, 2.08, 2.1, 2.08, 2.17, 2.09, 3.38, 3.13, 3.19, 7, 9, '2024-05-03 12:03:42'),
(0, 57, 15, 4, 0, 0, 5, 4, 0, 1, 1, 33, 0, ' 4 ', ' 135 ', ' 130 ', ' 117 ', 2.25, 2.08, 2.13, 3.5, 2.38, 2.21, 2.13, 2.5, 3.5, 2.15, 3.75, 3.09, 3.38, 4, 7, '2024-05-03 12:05:41'),
(0, 57, 3, 1, 0, 1, 3, 2, 0, 1, 1, 29, 1, ' 4 ', ' 147 ', ' 100 ', ' 116 ', 3.5, 2.38, 2.08, 2.13, 2.08, 2.25, 2.21, 2.5, 2.1, 2.15, 3.3, 3.5, 3.11, 3, 10, '2024-05-03 12:06:04');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_58`
--

CREATE TABLE `yd_58` (
  `ID` int(11) NOT NULL DEFAULT 0,
  `YD` int(11) NOT NULL,
  `YD_Info` int(11) NOT NULL,
  `Package_Num` int(11) NOT NULL,
  `RightTurn` int(11) NOT NULL,
  `LeftTurn` int(11) NOT NULL,
  `NumOfControl` int(11) NOT NULL,
  `NumOfTurn` int(11) NOT NULL,
  `Kurbel` int(11) NOT NULL,
  `SOBS3AP` int(11) NOT NULL,
  `SOBS_Lost_Of_Control` int(11) NOT NULL,
  `Temperature` int(11) NOT NULL,
  `BlokKontakt` int(11) NOT NULL,
  `Block_Contact_N` varchar(100) DEFAULT NULL,
  `U_AB` varchar(100) DEFAULT NULL,
  `U_BC` varchar(100) DEFAULT NULL,
  `U_AC` varchar(100) DEFAULT NULL,
  `CurrentValue1` float NOT NULL,
  `CurrentValue2` float NOT NULL,
  `CurrentValue3` float NOT NULL,
  `CurrentValue4` float NOT NULL,
  `CurrentValue5` float NOT NULL,
  `CurrentValue6` float NOT NULL,
  `CurrentValue7` float NOT NULL,
  `CurrentValue8` float NOT NULL,
  `CurrentValue9` float NOT NULL,
  `CurrentValue10` float NOT NULL,
  `Current_Accident_A` float NOT NULL,
  `Current_Accident_B` float NOT NULL,
  `Current_Accident_C` float NOT NULL,
  `Conversion_Period` float NOT NULL,
  `V_of_Device` float NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_58`
--

INSERT INTO `yd_58` (`ID`, `YD`, `YD_Info`, `Package_Num`, `RightTurn`, `LeftTurn`, `NumOfControl`, `NumOfTurn`, `Kurbel`, `SOBS3AP`, `SOBS_Lost_Of_Control`, `Temperature`, `BlokKontakt`, `Block_Contact_N`, `U_AB`, `U_BC`, `U_AC`, `CurrentValue1`, `CurrentValue2`, `CurrentValue3`, `CurrentValue4`, `CurrentValue5`, `CurrentValue6`, `CurrentValue7`, `CurrentValue8`, `CurrentValue9`, `CurrentValue10`, `Current_Accident_A`, `Current_Accident_B`, `Current_Accident_C`, `Conversion_Period`, `V_of_Device`, `Timestamp`) VALUES
(0, 58, 12, 8, 0, 0, 4, 5, 1, 1, 2, 45, 1, ' 2 ', ' 132 ', ' 111 ', ' 128 ', 2.08, 2.21, 2.08, 2.38, 2.08, 2.19, 2.13, 2.13, 3.5, 2.1, 3.17, 3.5, 3.75, 7, 10, '2024-05-02 09:57:11'),
(0, 58, 11, 2, 0, 0, 4, 2, 1, 1, 3, 30, 1, ' 1 ', ' 109 ', ' 123 ', ' 115 ', 2.25, 2.11, 2.1, 2.17, 2.11, 2.21, 2.25, 2.08, 2.14, 2.38, 3.09, 3.1, 3.12, 6, 7, '2024-05-02 09:58:48'),
(0, 58, 12, 8, 0, 0, 4, 5, 1, 1, 2, 45, 1, ' 2 ', ' 132 ', ' 111 ', ' 128 ', 2.08, 2.21, 2.08, 2.38, 2.08, 2.19, 2.13, 2.13, 3.5, 2.1, 3.17, 3.5, 3.75, 7, 10, '2024-05-02 11:51:34'),
(0, 58, 12, 8, 0, 0, 4, 5, 1, 1, 2, 45, 1, ' 2 ', ' 132 ', ' 111 ', ' 128 ', 2.08, 2.21, 2.08, 2.38, 2.08, 2.19, 2.13, 2.13, 3.5, 2.1, 3.17, 3.5, 3.75, 7, 10, '2024-05-02 12:10:06'),
(0, 58, 11, 2, 0, 0, 4, 2, 1, 1, 3, 30, 1, ' 1 ', ' 109 ', ' 123 ', ' 115 ', 2.25, 2.11, 2.1, 2.17, 2.11, 2.21, 2.25, 2.08, 2.14, 2.38, 3.09, 3.1, 3.12, 6, 7, '2024-05-02 12:11:43'),
(0, 58, 12, 8, 0, 0, 4, 5, 1, 1, 2, 45, 1, ' 2 ', ' 132 ', ' 111 ', ' 128 ', 2.08, 2.21, 2.08, 2.38, 2.08, 2.19, 2.13, 2.13, 3.5, 2.1, 3.17, 3.5, 3.75, 7, 10, '2024-05-02 12:39:02'),
(0, 58, 12, 8, 0, 0, 4, 5, 1, 1, 2, 45, 1, ' 2 ', ' 132 ', ' 111 ', ' 128 ', 2.08, 2.21, 2.08, 2.38, 2.08, 2.19, 2.13, 2.13, 3.5, 2.1, 3.17, 3.5, 3.75, 7, 10, '2024-05-03 11:36:54'),
(0, 58, 11, 2, 0, 0, 4, 2, 1, 1, 3, 30, 1, ' 1 ', ' 109 ', ' 123 ', ' 115 ', 2.25, 2.11, 2.1, 2.17, 2.11, 2.21, 2.25, 2.08, 2.14, 2.38, 3.09, 3.1, 3.12, 6, 7, '2024-05-03 11:37:44'),
(0, 58, 12, 8, 0, 0, 4, 5, 1, 1, 2, 45, 1, ' 2 ', ' 132 ', ' 111 ', ' 128 ', 2.08, 2.21, 2.08, 2.38, 2.08, 2.19, 2.13, 2.13, 3.5, 2.1, 3.17, 3.5, 3.75, 7, 10, '2024-05-03 11:52:54'),
(0, 58, 11, 2, 0, 0, 4, 2, 1, 1, 3, 30, 1, ' 1 ', ' 109 ', ' 123 ', ' 115 ', 2.25, 2.11, 2.1, 2.17, 2.11, 2.21, 2.25, 2.08, 2.14, 2.38, 3.09, 3.1, 3.12, 6, 7, '2024-05-03 11:54:31'),
(0, 58, 20, 7, 1, 0, 4, 5, 1, 0, 3, 35, 0, ' 3 ', ' 130 ', ' 124 ', ' 113 ', 2.3, 2.19, 2.13, 2.75, 2.5, 2.21, 2.3, 2.11, 2.08, 2.15, 3.75, 3.08, 3.11, 3, 12, '2024-05-03 11:56:20'),
(0, 58, 0, 4, 0, 1, 5, 5, 0, 0, 5, 47, 0, ' 1 ', ' 117 ', ' 148 ', ' 103 ', 2.12, 2.08, 3.5, 2.09, 2.11, 2.14, 3.5, 2.5, 2.25, 2.09, 3.3, 3.75, 3.11, 5, 12, '2024-05-03 11:58:38'),
(0, 58, 7, 8, 0, 1, 2, 2, 0, 1, 0, 48, 1, ' 4 ', ' 110 ', ' 105 ', ' 100 ', 3.5, 2.3, 2.21, 2.08, 2.12, 2.75, 2.75, 2.3, 2.75, 2.5, 3.09, 3.15, 3.09, 5, 9, '2024-05-03 11:58:54'),
(0, 58, 1, 9, 0, 1, 1, 3, 1, 1, 4, 46, 0, ' 2 ', ' 108 ', ' 127 ', ' 137 ', 2.75, 2.25, 2.09, 2.13, 2.75, 3.5, 2.08, 2.1, 3.5, 2.1, 3.09, 3.08, 3.09, 4, 7, '2024-05-03 12:00:49'),
(0, 58, 12, 8, 0, 0, 0, 2, 1, 1, 5, 25, 1, ' 0 ', ' 136 ', ' 107 ', ' 142 ', 2.5, 2.09, 3.5, 2.75, 2.17, 2.08, 2.15, 2.12, 2.1, 2.21, 3.09, 3.12, 3.08, 5, 7, '2024-05-03 12:01:00'),
(0, 58, 19, 3, 1, 0, 4, 3, 1, 1, 3, 43, 0, ' 3 ', ' 106 ', ' 127 ', ' 120 ', 2.21, 2.13, 2.15, 2.5, 2.09, 3.5, 2.5, 2.3, 2.11, 2.12, 3.08, 3.09, 3.75, 5, 8, '2024-05-03 12:01:24'),
(0, 58, 22, 1, 1, 1, 3, 3, 0, 0, 3, 46, 1, ' 0 ', ' 129 ', ' 120 ', ' 146 ', 2.09, 2.12, 2.08, 2.09, 2.25, 2.25, 2.3, 2.09, 2.19, 2.38, 3.09, 3.21, 3.21, 6, 8, '2024-05-03 12:03:34'),
(0, 58, 14, 0, 1, 0, 0, 0, 0, 1, 1, 37, 0, ' 3 ', ' 122 ', ' 142 ', ' 119 ', 2.15, 2.08, 2.5, 2.17, 2.25, 2.11, 2.25, 2.12, 2.11, 2.3, 3.38, 3.17, 3.38, 7, 9, '2024-05-03 12:04:42'),
(0, 58, 22, 2, 0, 1, 2, 4, 0, 1, 3, 37, 1, ' 3 ', ' 136 ', ' 115 ', ' 120 ', 2.25, 2.13, 2.3, 2.75, 2.13, 2.25, 2.3, 2.13, 2.08, 2.25, 3.19, 3.5, 3.14, 7, 7, '2024-05-03 12:05:19'),
(0, 58, 9, 5, 0, 1, 0, 1, 1, 0, 1, 48, 0, ' 1 ', ' 128 ', ' 107 ', ' 148 ', 2.19, 2.19, 2.25, 2.19, 2.38, 2.12, 2.75, 2.14, 2.75, 2.25, 3.08, 3.17, 3.21, 7, 12, '2024-05-03 12:05:45'),
(0, 58, 5, 8, 0, 1, 2, 2, 0, 1, 0, 29, 0, ' 2 ', ' 145 ', ' 133 ', ' 120 ', 2.15, 2.3, 2.38, 2.09, 2.75, 2.3, 2.11, 2.08, 2.14, 3.5, 4.5, 3.13, 3.12, 7, 12, '2024-05-03 12:07:02');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `yd_1`
--
ALTER TABLE `yd_1`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_2`
--
ALTER TABLE `yd_2`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_3`
--
ALTER TABLE `yd_3`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_4`
--
ALTER TABLE `yd_4`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_5`
--
ALTER TABLE `yd_5`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_6`
--
ALTER TABLE `yd_6`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_7`
--
ALTER TABLE `yd_7`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_8`
--
ALTER TABLE `yd_8`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_9`
--
ALTER TABLE `yd_9`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_10`
--
ALTER TABLE `yd_10`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_11`
--
ALTER TABLE `yd_11`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_12`
--
ALTER TABLE `yd_12`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_13`
--
ALTER TABLE `yd_13`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_14`
--
ALTER TABLE `yd_14`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_15`
--
ALTER TABLE `yd_15`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_16`
--
ALTER TABLE `yd_16`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_17`
--
ALTER TABLE `yd_17`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_18`
--
ALTER TABLE `yd_18`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_19`
--
ALTER TABLE `yd_19`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_20`
--
ALTER TABLE `yd_20`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_21`
--
ALTER TABLE `yd_21`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_22`
--
ALTER TABLE `yd_22`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_23`
--
ALTER TABLE `yd_23`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_24`
--
ALTER TABLE `yd_24`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_25`
--
ALTER TABLE `yd_25`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_26`
--
ALTER TABLE `yd_26`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_27`
--
ALTER TABLE `yd_27`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_28`
--
ALTER TABLE `yd_28`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_29`
--
ALTER TABLE `yd_29`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_30`
--
ALTER TABLE `yd_30`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_31`
--
ALTER TABLE `yd_31`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_32`
--
ALTER TABLE `yd_32`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_33`
--
ALTER TABLE `yd_33`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_34`
--
ALTER TABLE `yd_34`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_35`
--
ALTER TABLE `yd_35`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_36`
--
ALTER TABLE `yd_36`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_37`
--
ALTER TABLE `yd_37`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_38`
--
ALTER TABLE `yd_38`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_39`
--
ALTER TABLE `yd_39`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_40`
--
ALTER TABLE `yd_40`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_41`
--
ALTER TABLE `yd_41`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_42`
--
ALTER TABLE `yd_42`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_43`
--
ALTER TABLE `yd_43`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_44`
--
ALTER TABLE `yd_44`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_45`
--
ALTER TABLE `yd_45`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_46`
--
ALTER TABLE `yd_46`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_47`
--
ALTER TABLE `yd_47`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_48`
--
ALTER TABLE `yd_48`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_49`
--
ALTER TABLE `yd_49`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_50`
--
ALTER TABLE `yd_50`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_51`
--
ALTER TABLE `yd_51`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_52`
--
ALTER TABLE `yd_52`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_53`
--
ALTER TABLE `yd_53`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `yd_1`
--
ALTER TABLE `yd_1`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT для таблицы `yd_2`
--
ALTER TABLE `yd_2`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT для таблицы `yd_3`
--
ALTER TABLE `yd_3`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT для таблицы `yd_4`
--
ALTER TABLE `yd_4`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `yd_5`
--
ALTER TABLE `yd_5`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT для таблицы `yd_6`
--
ALTER TABLE `yd_6`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `yd_7`
--
ALTER TABLE `yd_7`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT для таблицы `yd_8`
--
ALTER TABLE `yd_8`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT для таблицы `yd_9`
--
ALTER TABLE `yd_9`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT для таблицы `yd_10`
--
ALTER TABLE `yd_10`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT для таблицы `yd_11`
--
ALTER TABLE `yd_11`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `yd_12`
--
ALTER TABLE `yd_12`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT для таблицы `yd_13`
--
ALTER TABLE `yd_13`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT для таблицы `yd_14`
--
ALTER TABLE `yd_14`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT для таблицы `yd_15`
--
ALTER TABLE `yd_15`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT для таблицы `yd_16`
--
ALTER TABLE `yd_16`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT для таблицы `yd_17`
--
ALTER TABLE `yd_17`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT для таблицы `yd_18`
--
ALTER TABLE `yd_18`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT для таблицы `yd_19`
--
ALTER TABLE `yd_19`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `yd_20`
--
ALTER TABLE `yd_20`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT для таблицы `yd_21`
--
ALTER TABLE `yd_21`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT для таблицы `yd_22`
--
ALTER TABLE `yd_22`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT для таблицы `yd_23`
--
ALTER TABLE `yd_23`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT для таблицы `yd_24`
--
ALTER TABLE `yd_24`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT для таблицы `yd_25`
--
ALTER TABLE `yd_25`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT для таблицы `yd_26`
--
ALTER TABLE `yd_26`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT для таблицы `yd_27`
--
ALTER TABLE `yd_27`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT для таблицы `yd_28`
--
ALTER TABLE `yd_28`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT для таблицы `yd_29`
--
ALTER TABLE `yd_29`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT для таблицы `yd_30`
--
ALTER TABLE `yd_30`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT для таблицы `yd_31`
--
ALTER TABLE `yd_31`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT для таблицы `yd_32`
--
ALTER TABLE `yd_32`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT для таблицы `yd_33`
--
ALTER TABLE `yd_33`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `yd_34`
--
ALTER TABLE `yd_34`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT для таблицы `yd_35`
--
ALTER TABLE `yd_35`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT для таблицы `yd_36`
--
ALTER TABLE `yd_36`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT для таблицы `yd_37`
--
ALTER TABLE `yd_37`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT для таблицы `yd_38`
--
ALTER TABLE `yd_38`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT для таблицы `yd_39`
--
ALTER TABLE `yd_39`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT для таблицы `yd_40`
--
ALTER TABLE `yd_40`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT для таблицы `yd_41`
--
ALTER TABLE `yd_41`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT для таблицы `yd_42`
--
ALTER TABLE `yd_42`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT для таблицы `yd_43`
--
ALTER TABLE `yd_43`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT для таблицы `yd_44`
--
ALTER TABLE `yd_44`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `yd_45`
--
ALTER TABLE `yd_45`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT для таблицы `yd_46`
--
ALTER TABLE `yd_46`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT для таблицы `yd_47`
--
ALTER TABLE `yd_47`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT для таблицы `yd_48`
--
ALTER TABLE `yd_48`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT для таблицы `yd_49`
--
ALTER TABLE `yd_49`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT для таблицы `yd_50`
--
ALTER TABLE `yd_50`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT для таблицы `yd_51`
--
ALTER TABLE `yd_51`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT для таблицы `yd_52`
--
ALTER TABLE `yd_52`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT для таблицы `yd_53`
--
ALTER TABLE `yd_53`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
