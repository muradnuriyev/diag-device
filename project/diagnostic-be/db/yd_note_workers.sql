-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: db
-- Время создания: Июн 12 2024 г., 12:43
-- Версия сервера: 8.4.0
-- Версия PHP: 8.2.19

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
-- Структура таблицы `yd_iq3journal`
--

CREATE TABLE `yd_iq3journal` (
  `ID` int NOT NULL,
  `FullName` varchar(255) NOT NULL,
  `Sahe` varchar(255) NOT NULL,
  `Note` varchar(255) NOT NULL,
  `TexProsQrafikBend` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `yd_iq3journal`
--

INSERT INTO `yd_iq3journal` (`ID`, `FullName`, `Sahe`, `Note`, `TexProsQrafikBend`, `timestamp`) VALUES
(1, 'Murad Nuriyev', 'IMB-4(Qx)', 'test', '9.2', '2024-06-12 12:40:02'),
(2, 'Murad Nuriyev', 'IMB-4(Qx)', 'test 2', '9.2', '2024-06-12 12:41:58'),
(3, 'Murad Nuriyev', 'IMB-4(Qx)', 'test 3', '9.2', '2024-06-12 12:42:34');

-- --------------------------------------------------------

--
-- Структура таблицы `yd_note_workers`
--

CREATE TABLE `yd_note_workers` (
  `ID` int NOT NULL,
  `Sahe` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `FullName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
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
(16, 'IMB-4(Qx)', 'İxtiyar Hüseynli ', 'test', '2024-05-17 07:37:06'),
(17, 'IMB-4(Qx)', 'Murad Nuriyev', 'dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd', '2024-06-11 07:47:13'),
(18, 'IMB-4(Qx)', 'Murad Nuriyev', 'HDFSJASBFIUABDICABCYAWYIBCACY BE BFYEB YEB YEB YBE YCBECYBEYBCYEBCY BEY CBEB CEYCB YCBEYCB EYB CY BCYEB CYEBC YEBCY BEYC BEYC BY BYCB E', '2024-06-11 07:55:07'),
(19, 'IMB-4(Qx)', 'Murad Nuriyev', 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', '2024-06-11 07:55:32');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `yd_iq3journal`
--
ALTER TABLE `yd_iq3journal`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `yd_note_workers`
--
ALTER TABLE `yd_note_workers`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `yd_iq3journal`
--
ALTER TABLE `yd_iq3journal`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `yd_note_workers`
--
ALTER TABLE `yd_note_workers`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
