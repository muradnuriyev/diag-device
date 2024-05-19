-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Хост: localhost:3306
-- Время создания: Май 19 2024 г., 16:53
-- Версия сервера: 8.0.36-0ubuntu0.22.04.1
-- Версия PHP: 8.1.2-1ubuntu2.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `yd_note_workers`
--

-- --------------------------------------------------------

--
-- Структура таблицы `yd_note_workers`
--

USE `yd_note_workers`;

CREATE TABLE `yd_note_workers` (
  `ID` int NOT NULL,
  `Sahe` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `FullName` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `Note` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yd_note_workers`
--

INSERT INTO `yd_note_workers` (`ID`, `Sahe`, `FullName`, `Note`, `timestamp`) VALUES
(4, 'IMB-4(Qx)', 'Murad Nuriyev', 'sasasasa', '2024-05-15 05:52:44'),
(5, 'IMB-4(Qx)', 'Murad Nuriyev', 'sasasasa', '2024-05-15 05:54:20'),
(6, 'IMB-4(Qx)', 'Murad Nuriyev', 'test', '2024-05-15 05:56:44'),
(7, 'IMB-4(Qx)', 'Murad Nuriyev', 'test', '2024-05-15 05:57:39'),
(8, 'IMB-4(Qx)', 'Murad Nuriyev', 'salam', '2024-05-15 05:57:52'),
(9, 'test', 'Test Test', 'test note', '2024-05-15 05:59:36'),
(10, 'test', 'Test Test', 'texniki baxish kecirilib', '2024-05-15 07:18:35'),
(11, 'IMB-4(Qx)', 'Murad Nuriyev', 'test', '2024-05-16 04:59:25'),
(12, 'IMB-4(Qx)', 'Murad Nuriyev', 'test1', '2024-05-16 05:02:15'),
(13, 'IMB-4(Qx)', 'Murad Nuriyev', 'test', '2024-05-16 06:48:15'),
(14, 'IMB-4(Qx)', 'Murad Nuriyev', '123', '2024-05-16 12:27:45'),
(15, 'IMB-4(Qx)', 'Murad Nuriyev', 'nhtjytjct g g ', '2024-05-17 04:42:51'),
(16, 'IMB-4(Qx)', 'İxtiyar Hüseynli ', 'test', '2024-05-17 07:37:06');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `yd_note_workers`
--
ALTER TABLE `yd_note_workers`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `yd_note_workers`
--
ALTER TABLE `yd_note_workers`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
