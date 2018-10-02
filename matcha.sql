-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Хост: localhost:3306
-- Время создания: Окт 02 2018 г., 10:00
-- Версия сервера: 5.7.23
-- Версия PHP: 7.0.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `matcha`
--

-- --------------------------------------------------------

--
-- Структура таблицы `interests`
--

CREATE TABLE `interests` (
  `id` int(11) DEFAULT NULL,
  `interest` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `interests`
--

INSERT INTO `interests` (`id`, `interest`) VALUES
(1, 'geek'),
(2, 'travelling'),
(3, 'reading'),
(4, 'workout'),
(5, 'sports'),
(6, 'fishing'),
(7, 'rap'),
(8, 'rock'),
(9, 'pop'),
(10, 'art'),
(11, 'piercing'),
(12, 'comics'),
(13, 'programming'),
(14, 'tattoos'),
(15, 'videogames'),
(16, 'history'),
(17, 'medicine'),
(18, 'movies'),
(19, 'foreign_languages'),
(20, 'photography'),
(21, 'handmade'),
(22, 'dancing'),
(23, 'chess'),
(24, 'fashion'),
(25, 'board_games'),
(26, 'horse_riding'),
(27, 'running'),
(28, 'football'),
(29, 'baseball'),
(30, 'basketball'),
(31, 'skateboarding'),
(32, 'birdwatching'),
(33, 'hiking'),
(34, 'biking'),
(35, 'cooking'),
(36, 'cosplay');

-- --------------------------------------------------------

--
-- Структура таблицы `messages`
--

CREATE TABLE `messages` (
  `sender_id` int(11) DEFAULT NULL,
  `recipient_id` int(11) DEFAULT NULL,
  `message` text CHARACTER SET utf8mb4,
  `msg_sent` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `messages`
--

INSERT INTO `messages` (`sender_id`, `recipient_id`, `message`, `msg_sent`) VALUES
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 13:52:47'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 14:42:00'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 14:44:10'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 14:45:10'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 14:45:24'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 14:52:40'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 14:54:33'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 14:55:15'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 14:56:01'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 14:56:10'),
(1, 2, 'alert(\"dfd\");', '2018-10-01 14:56:30'),
(1, 2, 'alert(\"dfd\");', '2018-10-01 14:57:56'),
(1, 2, 'alert(\"dfd\");', '2018-10-01 14:58:06'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 15:01:42'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 15:05:10'),
(1, 2, '\\<script\\>alert(\"dfd\");\\<\\/script\\>', '2018-10-01 15:12:40'),
(1, 2, '<script>alert(\"dfd\");\\</script\\>', '2018-10-01 15:13:02'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 15:20:05'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 15:21:25'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 15:25:13'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 15:28:59'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 15:29:21'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 15:29:38'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 15:30:48'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 15:31:23'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 15:32:29'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 15:39:44'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 15:41:08'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 15:46:08'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 15:47:27'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 15:50:43'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 15:51:39'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 15:56:20'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 15:57:35'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 15:59:29'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 16:01:22'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 16:13:39'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 16:14:42'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 16:15:40'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 16:25:14'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 16:25:50'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 16:27:25'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 16:29:04'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 18:39:52'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 18:40:42'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 18:42:18'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 18:54:51'),
(1, 2, '<script>alert(\"dfd\");</script>', '2018-10-01 18:56:47'),
(2, 1, '<script>alert(\"dfd\");</script>', '2018-10-01 18:59:35'),
(1, 2, 'yo', '2018-10-01 19:07:10'),
(1, 2, 'yo yo yo', '2018-10-01 19:07:20'),
(1, 2, 'pam pam', '2018-10-02 13:02:19'),
(1, 2, 'pararam', '2018-10-02 13:02:40'),
(1, 2, '🎎', '2018-10-02 13:06:06'),
(1, 2, 'some fish for my sweetheart🎏', '2018-10-02 13:06:45'),
(1, 2, '😍', '2018-10-02 13:07:33'),
(1, 2, '😘', '2018-10-02 13:07:36'),
(1, 2, '❤️', '2018-10-02 13:07:39'),
(1, 2, '😘', '2018-10-02 13:08:47'),
(1, 2, '🎏', '2018-10-02 13:11:20'),
(1, 2, '🎎', '2018-10-02 13:11:23'),
(1, 2, '😘', '2018-10-02 13:11:26'),
(1, 2, 'yo', '2018-10-02 13:20:07'),
(1, 2, '🎎', '2018-10-02 13:21:07'),
(1, 2, '🎎', '2018-10-02 13:21:12'),
(1, 2, '🎏', '2018-10-02 13:21:27'),
(1, 2, '🎏', '2018-10-02 13:21:31'),
(1, 2, 'yoyo😘', '2018-10-02 13:23:44'),
(1, 2, 'pew', '2018-10-02 13:24:49'),
(1, 2, '❤️', '2018-10-02 13:24:54'),
(1, 2, 'pew🎏', '2018-10-02 13:25:01'),
(1, 2, '🌰ororoor', '2018-10-02 13:25:18'),
(1, 2, 'hey', '2018-10-02 15:40:01'),
(1, 2, '😘', '2018-10-02 15:40:55'),
(1, 2, '❤️', '2018-10-02 15:41:02'),
(1, 2, 'love❤️', '2018-10-02 15:41:08'),
(1, 2, 'yp', '2018-10-02 15:42:55'),
(1, 2, 'pew', '2018-10-02 15:47:03'),
(1, 2, 'pom pom', '2018-10-02 15:47:23'),
(1, 2, 'sad to see you go', '2018-10-02 15:48:01'),
(1, 2, 'don\'t wait', '2018-10-02 15:52:45'),
(1, 2, 'aaaaa', '2018-10-02 15:53:16'),
(1, 2, 'but she could try', '2018-10-02 15:55:19'),
(1, 2, 'yesterday', '2018-10-02 16:06:52'),
(1, 2, 'prprprp', '2018-10-02 16:07:55'),
(1, 2, 'papap', '2018-10-02 16:11:18'),
(1, 2, 'eeeeeee', '2018-10-02 16:11:41'),
(1, 2, 'what would you do', '2018-10-02 16:12:29'),
(1, 2, 'what would you do', '2018-10-02 16:31:47'),
(1, 2, 'fade out', '2018-10-02 16:33:49'),
(1, 2, 'keep breathig', '2018-10-02 16:36:13'),
(1, 2, 'today we escape', '2018-10-02 16:37:32'),
(1, 2, 'we hope', '2018-10-02 16:38:07'),
(1, 2, 'we hope', '2018-10-02 16:38:36'),
(1, 2, 'make you more alone', '2018-10-02 16:39:24'),
(1, 2, 'pam', '2018-10-02 16:40:19'),
(1, 2, 'pam', '2018-10-02 16:40:49'),
(1, 2, '😍', '2018-10-02 16:45:10'),
(1, 2, 'i promise🎏', '2018-10-02 16:46:06'),
(1, 2, 'fffff🌰', '2018-10-02 16:46:20'),
(1, 2, '🎏set me on fire😍', '2018-10-02 16:58:20'),
(1, 2, ': 🎏set me on fire😍', '2018-10-02 16:58:25'),
(1, 2, ': 🎏set me on fire😍: 🎏set me on fire😍: 🎏set me on fire😍: 🎏set me on fire😍 🎏set me on fire😍', '2018-10-02 16:58:36'),
(1, 2, 'there\'s a morning after', '2018-10-02 18:24:49'),
(2, 1, 'i just wanted you to know', '2018-10-02 18:25:01');

-- --------------------------------------------------------

--
-- Структура таблицы `notifications`
--

CREATE TABLE `notifications` (
  `user_id` int(11) DEFAULT NULL,
  `message` tinyint(1) DEFAULT '1',
  `new_like` tinyint(1) DEFAULT '1',
  `unlike` tinyint(1) DEFAULT '1',
  `profile_check` tinyint(1) DEFAULT '1',
  `mutual_like` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `notifications`
--

INSERT INTO `notifications` (`user_id`, `message`, `new_like`, `unlike`, `profile_check`, `mutual_like`) VALUES
(1, 0, 0, 0, 0, 0),
(2, 0, 0, 0, 0, 0),
(3, 1, 1, 1, 1, 1),
(4, 1, 1, 1, 1, 1),
(5, 1, 1, 1, 1, 1),
(6, 1, 1, 1, 1, 1),
(7, 1, 1, 1, 1, 1),
(8, 1, 1, 1, 1, 1),
(9, 1, 1, 1, 1, 1),
(10, 1, 1, 1, 1, 1),
(11, 1, 1, 1, 1, 1),
(12, 1, 1, 1, 1, 1),
(13, 1, 1, 1, 1, 1),
(14, 1, 1, 1, 1, 1),
(15, 1, 1, 1, 1, 1),
(16, 1, 1, 1, 1, 1),
(17, 1, 1, 1, 1, 1),
(18, 1, 1, 1, 1, 1),
(19, 1, 1, 1, 1, 1),
(20, 1, 1, 1, 1, 1),
(21, 1, 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `notification_box`
--

CREATE TABLE `notification_box` (
  `current_user_id` int(11) DEFAULT NULL,
  `other_user_id` int(11) DEFAULT NULL,
  `message` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `notification_box`
--

INSERT INTO `notification_box` (`current_user_id`, `other_user_id`, `message`) VALUES
(18, 7, 'froos checked your profile'),
(11, 3, 'gwash checked your profile'),
(19, 3, 'gwash checked your profile'),
(19, 3, 'gwash liked your page'),
(19, 3, 'gwash checked your profile'),
(14, 3, 'gwash checked your profile'),
(5, 3, 'gwash checked your profile'),
(15, 3, 'gwash checked your profile'),
(6, 3, 'gwash checked your profile'),
(6, 3, 'gwash checked your profile'),
(6, 3, 'gwash checked your profile'),
(6, 3, 'gwash checked your profile'),
(6, 3, 'gwash checked your profile'),
(6, 3, 'gwash checked your profile'),
(6, 3, 'gwash checked your profile'),
(17, 3, 'gwash checked your profile'),
(12, 3, 'gwash checked your profile'),
(9, 3, 'gwash checked your profile'),
(18, 3, 'gwash checked your profile'),
(15, 1, 'ksena checked your profile'),
(19, 1, 'ksena checked your profile'),
(10, 1, 'ksena checked your profile'),
(3, 1, 'ksena checked your profile');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `verify` tinyint(1) DEFAULT '0',
  `login` datetime DEFAULT NULL,
  `logout` datetime DEFAULT NULL,
  `fame_rating` double DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `username`, `name`, `last_name`, `email`, `password`, `verify`, `login`, `logout`, `fame_rating`) VALUES
(1, 'ksena', 'Kseniya', 'Vilna', 'semkaway@gmail.com', '$5$rounds=535000$a8boLRDhnKNgY.la$CXWOptfz/5.oI4CO03rgwcIWVYz1vFMGHwawOYNK1gC', 1, '2018-10-02 19:55:58', NULL, 0.67),
(2, 'devon', 'Alex', 'Murchik', 'kseniiavilna@gmail.com', '$5$rounds=535000$mXH0bhG3cPaewBmD$zyiqjF7SctBjpbaZrl.6OyJxc5Y6FOXGP/JNRB7YTxC', 1, '2018-10-02 18:23:48', NULL, 1),
(3, 'gwash', 'George', 'Washington', 'test@test.ua', '$5$rounds=535000$kBMZXx7G1ufgNeKO$PGT9csSJBhClNDyDKekEOOM7qRMoPBxsMglwpMltmv/', 1, '2018-09-28 10:23:22', '2018-09-28 12:37:47', 0.5),
(4, 'wwilson', 'Woodrow', 'Wilson', 'test0@test.ua', '$5$rounds=535000$.VzqeeMwVwDw4Fe6$PBoh9CJfNIu.LcdBBHLrZcX88fuFjUCJ2cHpo9Er7/6', 1, '2018-09-22 10:15:06', '2018-09-22 10:20:12', 0),
(5, 'tjeff', 'Thomas', 'Jefferson', 'test1@test.ua', '$5$rounds=535000$Hudr2C6O.tr.btjT$57J5AofkOQMpsYzIXjen.c81ED4JiXCeczuYC0cZkO9', 1, '2018-09-22 10:20:51', '2018-09-22 10:23:33', 0),
(6, 'alinc', 'Abraham', 'Lincoln', 'test2@test.ua', '$5$rounds=535000$yYCKsphXnLmPvBLb$Seq0MqoZg2Op5srAocIlu7NOE9U4RkMW6Z6DtqJDAPD', 1, '2018-09-22 10:32:35', '2018-09-22 10:32:38', 0),
(7, 'froos', 'Franklin', 'Roosevelt', 'test3@test.ua', '$5$rounds=535000$PnY7cd8gzcdmVjyp$9xwjz8rXlffAGhPu5z2IJjQF0yRUhlccROXs3UHx6dC', 1, '2018-09-27 18:32:33', '2018-09-27 18:33:53', 0.33),
(8, 'jkenn', 'John', 'Kennedy', 'test4@test.ua', '$5$rounds=535000$uDDbrQN1HlSJAeO7$rF1UL/HQOBlmgqnHuo83uFPLCs1rqjOtru98T16Zrs4', 1, '2018-09-22 11:16:02', '2018-09-22 11:23:47', 0),
(9, 'rnixon', 'Richard', 'Nixon', 'test5@test.ua', '$5$rounds=535000$52cqShnZl.Hn3iLy$X675OLgyntdo6EjUDYVXTz1ML8rHxbgSvVuzecGas7C', 1, '2018-09-22 11:23:59', '2018-09-22 11:28:15', 0),
(10, 'ajolie', 'Angelina', 'Jolie', 'test6@test.ua', '$5$rounds=535000$O376vu16gw1tSqve$li4yKie87G3AqzbfEV4Ve5Do6vTir4RSeEXk7LldFl0', 1, '2018-09-26 12:59:19', '2018-09-26 13:04:45', 0),
(11, 'ahathaway', 'Anne', 'Hathaway', 'test7@test.ua', '$5$rounds=535000$prVKuo52PUI59tiy$TBTj3Y5FboNk2gY2X18w92v385ze6BzPOYaXgj5KFt1', 1, '2018-09-22 11:35:52', '2018-09-22 11:36:06', 0),
(12, 'estone', 'Emma', 'Stone', 'test8@test.ua', '$5$rounds=535000$.mcuL4IKkkAqv0IK$dEQBmaW7SdF.bKv7QmmEDcNf6SqIzRikCu6ZSII40j1', 1, '2018-09-22 11:36:19', '2018-09-22 11:38:34', 0),
(13, 'gkelly', 'Grace', 'Kelly', 'test9@test.ua', '$5$rounds=535000$gcHyE2IIGrrHysLd$dp/ebspvAOLOd5xcY7gFtQCsmihIFbwZj2wByRJfoB6', 1, '2018-09-22 11:38:46', '2018-09-22 11:42:42', 0),
(14, 'jlaw', 'Jennifer', 'Lawrence', 'test10@test.ua', '$5$rounds=535000$tlpt5/oAxtpBiV0K$.t4IraowQE16.t4itrQH68tlXEpv14Q7KXmxOCv3H2B', 1, '2018-09-22 11:45:51', '2018-09-22 11:45:54', 0),
(15, 'mmonroe', 'Marilyn', 'Monroe', 'test11@test.ua', '$5$rounds=535000$elr22UZNmUDE1x4g$LuMRFC1nQT6p.d3kBKb75buX02TMPhoAXnexxuPPzZ1', 1, '2018-09-24 14:46:03', '2018-09-24 14:46:33', 0),
(16, 'mkunis', 'Mila', 'Kunis', 'test12@test.ua', '$5$rounds=535000$o68JFTQcpIU3UNlG$wBD0JeAGdwCbZqxCM79FgiYAyQ76USQPlYHS3t5fmXD', 1, '2018-09-22 11:54:58', '2018-09-22 11:58:07', 0),
(17, 'mstreep', 'Meryl', 'Streep', 'test13@test.ua', '$5$rounds=535000$migEUbYiR5Lxn.or$n43n4/LblZC9JjaU2sZtJlCa5CbrZY698i5/.UjpGe3', 1, '2018-09-22 11:58:20', '2018-09-22 12:00:16', 0),
(18, 'nportman', 'Natalie', 'Portman', 'test14@test.ua', '$5$rounds=535000$oElPfedrxZiZnj6D$SfklCspbCW.6Ik9uWj1t3K92R61Iq4HRsbCw5QQR2c3', 1, '2018-09-22 12:00:28', '2018-09-22 12:04:03', 0),
(19, 'nkidman', 'Nicole', 'Kidman', 'test15@test.ua', '$5$rounds=535000$uWp.Zsg7ivCkPUeG$z0HRVh0vXts130F8g3qpj2Pw/oVc26bqAEnHZveJj77', 1, '2018-09-22 12:04:15', '2018-09-22 12:06:04', 0.5),
(20, 'sjoh', 'Scarlett', 'Johansson', 'test16@test.ua', '$5$rounds=535000$9a2yzrtrdX53Yw/9$MiK1D06YS8vekP9Vh92bsLvKmyILF.qxVeb/JEjj624', 1, '2018-09-22 12:58:36', '2018-09-22 13:14:05', 0),
(21, 'msmith', 'Matt', 'Smith', 'test17@test.ua', '$5$rounds=535000$.uSJKJccpuYcUwwi$pFxITUomjWMkDcwqlfOj/aZ7Ke26Hsj5Iw5x2QoEHcA', 1, '2018-09-22 12:13:28', '2018-09-22 12:44:34', 0),
(22, 'thanks', 'Tom', 'Hanks', 't0@mail.za', '$5$rounds=535000$njWTbgIVyGG/nPjY$ERM/ZK4/ITojKlDhM4aZDT9pD77LpelwAQyu0/SVVA5', 1, NULL, NULL, 0),
(23, 'rdeniro', 'Robert', 'Niro', 't1@mail.za', '$5$rounds=535000$60naPhOW9ENAIGb4$eno4ZAeGHrcjgNT/hKgfaIp8bQclBnUyfve2oR154u.', 1, NULL, NULL, 0),
(24, 'ghackman', 'Gene', 'Hackman', 't2@mail.za', '$5$rounds=535000$gE8I5Fp/GZgSRld3$bedjElz2nChQTDeLgSGIKUSXZJYPtZyTcksNsYHCVf2', 1, NULL, NULL, 0),
(25, 'rduvall', 'Robert', 'Duvall', 't3@mail.za', '$5$rounds=535000$vzzsF1ztN4tpFzni$HasZqABt/3duJU1xu8ZMChAQPEAD.E6TxRX2rAzwTW/', 1, NULL, NULL, 0),
(26, 'jnichol', 'Jack', 'Nicholson', 't4@mail.za', '$5$rounds=535000$zNkGjdYOPU/Mpgt1$Pz0bkN4MDo1EW9uyNvOtdHzzyAqEs.exCQMiVYMjsk5', 1, NULL, NULL, 0),
(27, 'dhoffman', 'Dustin', 'Hoffman', 't5@mail.za', '$5$rounds=535000$c6pxJkALbaZli4Pw$ZzcFPUoyfODs6E0v135ViPUoHV0aVtg/3Ke5WpcCUI2', 1, NULL, NULL, 0),
(28, 'alpachino', 'Al', 'Pacino', 't6@mail.za', '$5$rounds=535000$pz72py1QZwIVrzXV$PeQPjtg9xPQ/9ev2Yeagvl3UHQxbY11ZNQcn29nvrB7', 1, NULL, NULL, 0),
(29, 'mfreeman', 'Morgan', 'Freeman', 't7@mail.za', '$5$rounds=535000$vNKYYMcSDgKFMSL1$Tg6yvp5yQrKLv7.DdF8bpaUhd5lQoDcISnx74ehUtm8', 1, NULL, NULL, 0),
(30, 'ceast', 'Clint', 'Eastwood', 't8@mail.za', '$5$rounds=535000$zlwhoaH4gM/MAAU7$H0aQigQ737gplU3RauGF0PNjitQmovrUDpUgsr/d2FA', 1, NULL, NULL, 0),
(31, 'kspacey', 'Kevin', 'Spacey', 't9@mail.za', '$5$rounds=535000$.SjTTj3palWSb0HL$H9F922UCoKsgQGEChe9h4NvZAVcuj/ig0PmG1XUdHN9', 1, NULL, NULL, 0),
(32, 'hford', 'Harrison', 'Ford', 't10@mail.za', '$5$rounds=535000$vt7ITSbGF.4MTiVI$hTvuMGzlh8LiBxDcegeHYhLaR.NedTZDeigq/OFhjP/', 1, NULL, NULL, 0),
(33, 'sjackson', 'Samuel', 'Jackson', 't11@mail.za', '$5$rounds=535000$MLfw7zLCrlj91r.I$xc7S1OSMpslll/kk3jZGSBaK6EsdxMCh/ihTFCLiCO9', 1, NULL, NULL, 0),
(34, 'cwalken', 'Christopher', 'Walken', 't12@mail.za', '$5$rounds=535000$y2Ekl1EAd/Dz9/XE$8UhlVrJLCc0LjFrVWbMeO7IC8j9B2Z4WCW4EEnPgpfD', 1, NULL, NULL, 0),
(35, 'bmurray', 'Bill', 'Murray', 't13@mail.za', '$5$rounds=535000$9GMp0olCv3G/8x.I$CaGqF6brWrr/72Raxx0AuxH29HFVcSxnaD4lx.0iLv4', 1, NULL, NULL, 0),
(36, 'tjohnes', 'Tommy', 'Jones', 't14@mail.za', '$5$rounds=535000$sWpvjFYSFe9oTuXW$gHa1twbmAGo9029YssqEKnvS.jjy19AhXVaqIkaglX0', 1, NULL, NULL, 0),
(37, 'enorton', 'Edward', 'Norton', 't15@mail.za', '$5$rounds=535000$VubOhiBHj/g.ntM3$bQcQamkfFPaOtjg0heWx0hkTlQ1MtzO8OkC3nF/NnV0', 1, NULL, NULL, 0),
(38, 'mmcc', 'Matthew', 'McConaughey', 't16@mail.za', '$5$rounds=535000$mpjR94g7glOA/qf1$rmSG2pt5ne2e59pbyfWriLVIqyS1.9Q6q9fheA8DXg6', 1, NULL, NULL, 0),
(39, 'eharr', 'Ed', 'Harris', 't17@mail.za', '$5$rounds=535000$P3uf4FhCiveBjEaC$VPyprAK6KX.zpm1OKU2PG10B2RHfFxWqPAEUh2.HuW6', 1, NULL, NULL, 0),
(40, 'ldicaprio', 'Leonardo', 'DiCaprio', 't18@mail.za', '$5$rounds=535000$bqxHluE/xPr.JVQ2$NJ25/bTOe5bhNhj82ZHBhhjP00qWLsGsgBfqXNCPhL8', 1, NULL, NULL, 0),
(41, 'wharrel', 'Woody', 'Harrelson', 't19@mail.za', '$5$rounds=535000$iY63vMD9IEee1/Sg$HobNl.LRDfEuKbflJBceQYuIblg5Kfwo4RQwycxXXu3', 1, NULL, NULL, 0),
(42, 'jphoenix', 'Joaquin', 'Phoenix', 't20@mail.za', '$5$rounds=535000$L7WTIC6Oc8DK2l6g$nog7egdqaihsL9T2vek5I6K.74OrEX/2X1lBeVOK5S.', 1, NULL, NULL, 0),
(43, 'kbacon', 'Kevin', 'Bacon', 't21@mail.za', '$5$rounds=535000$bK.Dw5sVyAzHAzyO$xl3WsIaATCYn7kyh1g2JkKxt7j233m7e7KTkVHoWdY8', 1, NULL, NULL, 0),
(44, 'mgibson', 'Mel', 'Gibson', 't22@mail.za', '$5$rounds=535000$yXIJxkQClAydhzem$WUlRP95U6gkj0aebzOmkZm4v37/rxk3.jAok3BsiAO5', 1, NULL, NULL, 0),
(45, 'rdowney', 'Robert', 'Downey', 't23@mail.za', '$5$rounds=535000$VoBy3c7/eYcVw3Yp$g5VSAPaIJxL5GhUdBmkSvyihizZFa0v8h6iP15sikG9', 1, NULL, NULL, 0),
(46, 'dwash', 'Denzel', 'Washington', 't24@mail.za', '$5$rounds=535000$x0cqlBlaoDdrJyK/$njnRkTK6fhTJVmGQUp24wk4.VSmQIr7Oe8LW6M5jgy9', 1, NULL, NULL, 0),
(47, 'jdepp', 'Johnny', 'Depp', 't25@mail.za', '$5$rounds=535000$nU/q6.ZcLAk.DxZj$NSyPW82KJc.PK1VNEGcO4EzKFsM4s0CCKOO68MmcDrD', 1, NULL, NULL, 0),
(48, 'bpitt', 'Brad', 'Pitt', 't26@mail.za', '$5$rounds=535000$pPZk5JhiQY2F4q5j$IUyFPH96PWwv8C0NzfMJ0V8w1vq/yNwt9QND9uxNKSA', 1, NULL, NULL, 0),
(49, 'mdamon', 'Matt', 'Damon', 't27@mail.za', '$5$rounds=535000$ae4aIAuG3Rl.gtId$fU6lWLx9XwCdjiqOwBOrXatuztA5J7xLx0bHU20au79', 1, NULL, NULL, 0),
(50, 'pdink', 'Peter', 'Dinklage', 't28@mail.za', '$5$rounds=535000$xlYdSZqRr/Or1HPg$7SPVTO4v8iwH8PMt.B5XALdeHGp0Qjx9WzhassNX2dA', 1, NULL, NULL, 0),
(51, 'vmort', 'Viggo', 'Mortensen', 't29@mail.za', '$5$rounds=535000$L.iW6R5rjnArebYy$15FGXBOG1xLLL2IpcQ1U0kJ8JSAZVjGfe6T5S/.0Zz2', 1, NULL, NULL, 0),
(52, 'krussell', 'Kurt', 'Russell', 't30@mail.za', '$5$rounds=535000$WVGCMpq2cX1SfiAK$bWptaJ8CnAjyI19mirREl/FB.yEGDDWD7/P2VBIbwn.', 1, NULL, NULL, 0),
(53, 'sbuschemi', 'Steve', 'Buscemi', 't31@mail.za', '$5$rounds=535000$0O7RqRm3lXdnbML0$Wp/bSrhiXyA1FHbf260dJvJ45oNbKv.xo.7QBnSpCK5', 1, NULL, NULL, 0),
(54, 'mkeaton', 'Michael', 'Keaton', 't32@mail.za', '$5$rounds=535000$.SMGWjkCufMd22pO$mBbTN3M7dNAKY.ceGmWP4nxoqHm0nO2r.S557hIcD.1', 1, NULL, NULL, 0),
(55, 'dcheadle', 'Don', 'Cheadle', 't33@mail.za', '$5$rounds=535000$H8blAKJLROoVGMOZ$Przwa4yQO7.iWkm6ibXcwIYzNK69frkwM/UGcjuKc55', 1, NULL, NULL, 0),
(56, 'jgyllen', 'Jake', 'Gyllenhaal', 't34@mail.za', '$5$rounds=535000$NsmqmcaPFMGmxZ8w$65Xqt1LYQaq1Vhb6dSfvxs1PZOAKNUswp5Wowvc28s7', 1, NULL, NULL, 0),
(57, 'wmacy', 'William', 'Macy', 't35@mail.za', '$5$rounds=535000$22mBYHJIgl3V8VKS$3IYrtcj.13JmEYt56CgMoOsoghmYI1GvrDE/wetsBU5', 1, NULL, NULL, 0),
(58, 'bcooper', 'Bradley', 'Cooper', 't36@mail.za', '$5$rounds=535000$Dn3JwV9PpZU91GLH$WwSKGQNX60d5cMuzpMitc08TJwMiVT1hgwh5TSQ/he5', 1, NULL, NULL, 0),
(59, 'bcranston', 'Bryan', 'Cranston', 't37@mail.za', '$5$rounds=535000$V9d/pD5ySsW3lBvy$pszbk.L8S2O0ChQlskZDFhq.PjoKR/LSiLaM2mKt.eA', 1, NULL, NULL, 0),
(60, 'spenn', 'Sean', 'Penn', 't38@mail.za', '$5$rounds=535000$taZTXdBnW1oqNr8w$hZlRfP50byJlzgXYX21qfoVhZNhgW/X6ZOcVDofWiSA', 1, NULL, NULL, 0),
(61, 'wsmith', 'Will', 'Smith', 't39@mail.za', '$5$rounds=535000$EYuKCy/RtGy.tMiz$YYUd8/zjHWJ5YmiPpeY1n7Ng1vkugCEMo.VK5ROTQK5', 1, NULL, NULL, 0),
(62, 'kcostner', 'Kevin', 'Costner', 't40@mail.za', '$5$rounds=535000$ENYO8yURxE2eah5h$jaPL/.3ef4Gvex0xVEAtU/pkGX4qZdJRprWvdGfbES1', 1, NULL, NULL, 0),
(63, 'jjones', 'James', 'Jones', 't41@mail.za', '$5$rounds=535000$ThB.uElXsxJJrR9E$9./L2JIuiZvFYtKLU6K1vqgoFt48Dh89RRIhGWD.0G7', 1, NULL, NULL, 0),
(64, 'bwillis', 'Bruce', 'Willis', 't42@mail.za', '$5$rounds=535000$2dcsaaCvjE9UIMwe$WHoyRt/9fKrrH7PfK9HhN.A5xaVYNFhnH3WGzb6rceA', 1, NULL, NULL, 0),
(65, 'gclooney', 'George', 'Clooney', 't43@mail.za', '$5$rounds=535000$77ifd.vrOfTU1d0C$XMrYQiJSZhXcx4nlh/9fmn9V7Se4rhPVRABjraid3n.', 1, NULL, NULL, 0),
(66, 'rredford', 'Robert', 'Redford', 't44@mail.za', '$5$rounds=535000$K4zlsY4/HCojzCFX$DQUvxa2RpDzTlFU6bpao0AMmHyqqVzyQtTOjZFytBl9', 1, NULL, NULL, 0),
(67, 'rliota', 'Ray', 'Liotta', 't45@mail.za', '$5$rounds=535000$ddPmJwTKjZnrWJki$uh2QGdyxe1L6wXrp2ThY7IkaHnraQ.pxmtN9eNigmHA', 1, NULL, NULL, 0),
(68, 'mdoug', 'Michael', 'Douglas', 't46@mail.za', '$5$rounds=535000$RIxL0.VL1fMgkpQ2$GkLF17D5OaoO8RIv5riYCzExmO/tG9LadlWjri34ojB', 1, NULL, NULL, 0),
(69, 'tcruise', 'Tom', 'Cruise', 't47@mail.za', '$5$rounds=535000$U/FSTdoM.yefjk3O$J6IvgtZx0AzuvmSz79ra84Hs0/fWgwTUZSdEWnZRu82', 1, NULL, NULL, 0),
(70, 'jcaan', 'James', 'Caan', 't48@mail.za', '$5$rounds=535000$GP5qfp2bCzbT86EB$RM3lMqNE02eZLQLxlFkvrHZ6cIyrCjZ59E1ndBE0Ab1', 1, NULL, NULL, 0),
(71, 'pgiam', 'Paul', 'Giamatti', 't49@mail.za', '$5$rounds=535000$GT2lY8XcDtu//n7o$YmITuZ7ycZzg.ZoWEfe00SGT6vTOwY.OWencZwet.U1', 1, NULL, NULL, 0),
(72, 'hkeit', 'Harvey', 'Keitel', 't50@mail.za', '$5$rounds=535000$J.NWJL/TecUQfup/$hk0bAW9go463coV8O/XmRSRinp8ik8fMAZwqlH5h3S0', 1, NULL, NULL, 0),
(73, 'mantwood', 'Margaret', 'Atwood', 'te0@mail.za', '$5$rounds=535000$8RAaLi6WiRuHrzPW$enrCoHTnHgkPz6PooQq/2YAKbLWMCOGqUdvZKLVi6gA', 1, NULL, NULL, 0),
(74, 'nwoof', 'Naomi', 'Woolf', 'te1@mail.za', '$5$rounds=535000$vmHd.AbH8ukY14e2$WZq2wQu8FaKETLMcQXIWJyhjvkYcoornU61pHvote9/', 1, NULL, NULL, 0),
(75, 'cadichie', 'Chimamanda', 'Adichie', 'te2@mail.za', '$5$rounds=535000$qnz5cjIZzqIeN.r6$lv.JgAH9fYT8.L.3fqCvj25A8h7pgpwPjAk2qoTdLV6', 1, NULL, NULL, 0),
(76, 'cmoran', 'Caitlin', 'Moran', 'te3@mail.za', '$5$rounds=535000$5ohCspyRH/Lj/QaE$SfVG8AD9Q5MORs.Y6b5U6jFt6JZnssR2Nz6a0IbNcHB', 1, NULL, NULL, 0),
(77, 'awalker', 'Alice', 'Walker', 'te4@mail.za', '$5$rounds=535000$lT0QBXGgN8Zm1wK4$fUFk4jgQ18Wo4JlYo7onu0S4VkvsWcrob02UOjUVIk.', 1, NULL, NULL, 0),
(78, 'mangelou', 'Maya', 'Angelou', 'te5@mail.za', '$5$rounds=535000$HQ5SHbLDkCWc9hqK$9LTRiWa1bBxUKZzySm07s/gU4sBXQ//3LhiZLCea0A/', 1, NULL, NULL, 0),
(79, 'hclinton', 'Hillary', 'Clinton', 'te6@mail.za', '$5$rounds=535000$Ql.UzG3Ek5Eg7X3S$/.nsI4x317YrYqshLkfYNF4XjYfcY539nfj40Xi1MW8', 1, NULL, NULL, 0),
(80, 'arich', 'Adrienne', 'Rich', 'te7@mail.za', '$5$rounds=535000$RjBaO8JTh4O3ZA1r$QT27qIG6RlTXzjPNV0oHEun7sWQSFV5RUe/0gWc2c/3', 1, NULL, NULL, 0),
(81, 'abechdel', 'Alison', 'Bechdel', 'te8@mail.za', '$5$rounds=535000$lZhj/U8KbxCt7BV5$W/ULHZdZ.WbBVaCwNPr8AYfYBbXtKWswLBjss8Zv4zC', 1, NULL, NULL, 0),
(82, 'ahemp', 'Amy', 'Hempel', 'te9@mail.za', '$5$rounds=535000$wkBkTXPpFh7n5qe.$p9QTQVMbgDXiNeQJRWwDmuMM6QpnDkvnlS4dzPOXys3', 1, NULL, NULL, 0),
(83, 'clispec', 'Clarice', 'Lispector', 'te10@mail.za', '$5$rounds=535000$XnvnWXYfejoTtu7b$JQQ8x60QYO1VgqUDr1ovBPL5r0rEs29YxPU5gzEVGtA', 1, NULL, NULL, 0),
(84, 'dtartt', 'Donna', 'Tartt', 'te11@mail.za', '$5$rounds=535000$NcWZZ7GzaMFX0j2J$wrOIdn.fje6ayNQEJwenREwiXNCYb9mC2JDFHWCzq68', 1, NULL, NULL, 0),
(85, 'edant', 'Edwidge', 'Danticat', 'te12@mail.za', '$5$rounds=535000$tmrPjsrRZ.QFpvff$l4jIMwB3bsmdedxwhYmSd270wAwUnZRsXmyIzUasaR0', 1, NULL, NULL, 0),
(86, 'ekolbert', 'Elizabeth', 'Kolbert', 'te13@mail.za', '$5$rounds=535000$e.6VNgL4rPCwqVyP$rzKSxNcxtiWnafKPrgeg.1/VW8xJbLBNRdyY8l1jlD.', 1, NULL, NULL, 0),
(87, 'geliot', 'George', 'Eliot', 'te14@mail.za', '$5$rounds=535000$xPJSf8JwCSYIw7HH$BgaOdxKrH77yuuEApWrQ.ixjb9XFG.DMl/Bbrplia28', 1, NULL, NULL, 0),
(88, 'iwilk', 'Isabel', 'Wilkerson', 'te15@mail.za', '$5$rounds=535000$NjLISfpC.ov7k13V$CTpGPwxBl6wAvDYCy2DPtdnUwPMAY4JLh2xqZNSMQJ3', 1, NULL, NULL, 0),
(89, 'jjacobs', 'Jane', 'Jacobs', 'te16@mail.za', '$5$rounds=535000$96RKjZeQ1q..ypCY$OLU2ewjZ0xWilXCpx4vNXLciYC/XyO27VwpVRSXjiz/', 1, NULL, NULL, 0),
(90, 'jdidion', 'Joan', 'Didion', 'te17@mail.za', '$5$rounds=535000$owjpffWKu0HBSzQl$XTX5IJO17TmXwnUgRYZsIewOI0NoHj.2UoDfkjPJjX2', 1, NULL, NULL, 0),
(91, 'karmst', 'Karen', 'Armstrong', 'te18@mail.za', '$5$rounds=535000$MH.yg/cLJooEZFOL$DOM1mhGCo82hCe9BWm9vwXYYRR5rZtV7v8lObmPb2yB', 1, NULL, NULL, 0),
(92, 'lshriver', 'Lionel', 'Shriver', 'te19@mail.za', '$5$rounds=535000$UM5nplQM683AATkD$rI31MJSwaE2C.sa46uiR0Yv0IXkEfa8PnYvtEaRNbB6', 1, NULL, NULL, 0),
(93, 'lerdrich', 'Louise', 'Erdrich', 'te20@mail.za', '$5$rounds=535000$fg62kpivYtqivWgB$l41KKRjUGM1rQxiPdgUCPaqVGEhT5In59PpT3hh4tQ1', 1, NULL, NULL, 0),
(94, 'ldavis', 'Lydia', 'Davis', 'te21@mail.za', '$5$rounds=535000$1rAUjjdp69A0dU8J$0COpOXKZ8YAIKt9yKef6D7kTuYob8g1QTYgV.i27of.', 1, NULL, NULL, 0),
(95, 'matwood', 'Margaret', 'Atwood', 'te22@mail.za', '$5$rounds=535000$iN5MUwY93Oq7PVu4$m3nsGqP45pmT4us.TUGQNAgHDhYEddWgae3oRUjrLK4', 1, NULL, NULL, 0),
(96, 'mshelly', 'Mary', 'Shelley', 'te23@mail.za', '$5$rounds=535000$ETr4z0E0HRoSoNNu$UlDHFCay58bAB7WTRymIqHCUl6T7xOg7b8fY91etFl2', 1, NULL, NULL, 0),
(97, 'phigh', 'Patricia', 'Highsmith', 'te24@mail.za', '$5$rounds=535000$XS5XWrgDHvEBAbev$Vokp2nNSIcH8wd2CGChW/Lo2XREOnbc7FQuo93tfrUD', 1, NULL, NULL, 0),
(98, 'rsoln', 'Rebecca', 'Solnit', 'te25@mail.za', '$5$rounds=535000$wHHEt9jxrxHosUnc$dcfKOx8Bmet8HgxNUVeZ.BEXRtA.iCv8Ce.cUusUwK9', 1, NULL, NULL, 0),
(99, 'sson', 'Susan', 'Sontag', 'te26@mail.za', '$5$rounds=535000$BAwIYXYkxvij9kAE$3kzT2FAM/deOcL9t6D038o6DpPFbNOc4I7nllsTNNh1', 1, NULL, NULL, 0),
(100, 'tmorr', 'Toni', 'Morrison', 'te27@mail.za', '$5$rounds=535000$0.r1uIWumxKoF9nj$13I9oQ1R6znMn/BailKGOGYvu/7KrwaqX9aw4KSrAYD', 1, NULL, NULL, 0),
(101, 'vluic', 'Valeria', 'Luiselli', 'te28@mail.za', '$5$rounds=535000$CRHaJwbYLiNLpUdh$E8bKF10dxhAf6llMoUwt7mKZkkzpKj/qk7orpaV/aU.', 1, NULL, NULL, 0),
(102, 'vwoolf', 'Virginia', 'Woolf', 'te29@mail.za', '$5$rounds=535000$Hw33lK7EqQ1LcNB2$Z3J/Fam4fqxw6k09Y3ieNkRE2/9Ro9NZFjzPotVN1Q3', 1, NULL, NULL, 0),
(103, 'wszym', 'Wislawa', 'Szymborska', 'te30@mail.za', '$5$rounds=535000$cNaLRVzTYTOKEbzH$kuQteDH/WvsOCNqynKvWWXqXu2iRAqNegS6LLVvMMK0', 1, NULL, NULL, 0),
(104, 'dles', 'Doris', 'Lessing', 'te31@mail.za', '$5$rounds=535000$z8Yo84PPUhNFWiPr$cVJOhcQfpQTBP4Va6v474pub2rgwA48RU5aJzjx/Ca.', 1, NULL, NULL, 0),
(105, 'uguin', 'Ursula', 'Guin', 'te32@mail.za', '$5$rounds=535000$HJ8u4R0mnOj89p.t$VGv7GZNbXrHXWH2YCi.WRvxfF3GwrCDjpQ4pri0HeP5', 1, NULL, NULL, 0),
(106, 'zsmith', 'Zadie', 'Smith', 'te33@mail.za', '$5$rounds=535000$reGJ3KQRI.WUKl6m$U0YQsEvRRFj0PCm19lg6ONPflBopI8/HdPq2rxg6Mc0', 1, NULL, NULL, 0),
(107, 'eferr', 'Elena', 'Ferrante', 'te34@mail.za', '$5$rounds=535000$JmITtAc.BgcQ1jh6$NygUfnOhrjycB7kJ.NsdI26T4a.3BdU5E15j48ZsXPB', 1, NULL, NULL, 0),
(108, 'acart', 'Angela', 'Carter', 'te35@mail.za', '$5$rounds=535000$ZF1U5DMUpbrEozUN$m1LmI.9ZRNO.HqPhJrM.lIbH0e8h7MjKPKB1NDTYAr/', 1, NULL, NULL, 0),
(109, 'ecatt', 'Eleanor', 'Catton', 'te36@mail.za', '$5$rounds=535000$qY0ibkmnqPPLFNL3$9Qk2wfGYOsDA./U0e3AEW7jK94MnPDhOnRwgV3j/Vn6', 1, NULL, NULL, 0),
(110, 'edono', 'Emma', 'Donoghue', 'te37@mail.za', '$5$rounds=535000$TGyIMQCjOEQ8XZH5$QDzdcBXWHb2tMW2hs4oGp/RJrOwR5lFOLv/dwAqZDL6', 1, NULL, NULL, 0),
(111, 'egilbert', 'Elizabeth', 'Gilbert', 'te38@mail.za', '$5$rounds=535000$7aA..SNEJcHwsJzr$x/aRx6bHME8mZA.rGmL8XySn4qGG5ngmctcgs1BqQA7', 1, NULL, NULL, 0),
(112, 'sheti', 'Sheila', 'Heti', 'te39@mail.za', '$5$rounds=535000$z5SG7S9e2rydYRxB$8KAOvAR9X1pXFDBcDvxniwhS0WOYCQ89Rz1Jn.pTRMC', 1, NULL, NULL, 0),
(113, 'gflynn', 'Gillian', 'Flynn', 'te40@mail.za', '$5$rounds=535000$Gdsow2fHJekkbxsE$j0k0Ki937fcvP3YhSHzcLcIYQUDDzMNqbKh0wmSsph/', 1, NULL, NULL, 0),
(114, 'eholt', 'Elliott', 'Holt', 'te41@mail.za', '$5$rounds=535000$boQ9fdLorCsFFJmF$oSp8.IifA9FFR.D3LdpYXvxyO2bekoXoMmiTs11nGk5', 1, NULL, NULL, 0),
(115, 'rkush', 'Rachel', 'Kushner', 'te42@mail.za', '$5$rounds=535000$f7Stbn291h/HwdBI$ARR7Mr6ACwp2mtTtJYzURZRgrqFT2VFwQ3j2fayjrf9', 1, NULL, NULL, 0),
(116, 'cmessud', 'Claire', 'Messud', 'te43@mail.za', '$5$rounds=535000$G/rdlzsjRnYubvq6$CZjIqio/pAp25SHblMJnK6K8fOHc9PseL3IiwRmJZx1', 1, NULL, NULL, 0),
(117, 'lmoore', 'Lorrie', 'Moore', 'te44@mail.za', '$5$rounds=535000$ffNHYYxt8DLRdMmo$iVrOiJybZulJg.BgWjZZjfStei1iiHSiGDBPRkCDo58', 1, NULL, NULL, 0),
(118, 'amunro', 'Alice', 'Munro', 'te45@mail.za', '$5$rounds=535000$O/gJ7aGhvAsdWY7y$HGosSqxJcMyvVW..nDwvjllI2fGAN82wRijn0GPDY48', 1, NULL, NULL, 0),
(119, 'tselasi', 'Taiye', 'Selasi', 'te46@mail.za', '$5$rounds=535000$sH1ilUdrbDTESd10$Xy.rkHX6.3VE2kENX0VQqnzeO1B.Ub9bnwq/yYemte.', 1, NULL, NULL, 0),
(120, 'cstrayed', 'Cheryl', 'Strayed', 'te47@mail.za', '$5$rounds=535000$.qBsu2p3Ty0vUsqC$HbAqNnQhEy/gbfp381Y9X.FPdz5sZNKQNqmKMQtT818', 1, NULL, NULL, 0),
(121, 'csulliv', 'Courtney', 'Sullivan', 'te48@mail.za', '$5$rounds=535000$/y1O5Sy4F55i1qJj$F.kzfk8rmQCTvh20t/b3y73I378y1oeuIaZm8894AD9', 1, NULL, NULL, 0),
(122, 'atan', 'Amy', 'Tan', 'te49@mail.za', '$5$rounds=535000$frO5ro8gUEOZq0Ni$rI.RUPsmDruAIpixrkE35onLQ3.Ua8WP.WCYSX2DcwD', 1, NULL, NULL, 0),
(123, 'mwrinkle', 'Margaret', 'Wrinkle', 'te50@mail.za', '$5$rounds=535000$TVCxr1HXvo5ha08f$RwjMxX1Ll.9cqc7zC00rXFWQ2DZC49JovwYB0rr.6Y4', 1, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `users_appearance`
--

CREATE TABLE `users_appearance` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `height` varchar(255) DEFAULT 'Unknown',
  `body_type` varchar(255) DEFAULT 'Unknown',
  `hair_color` varchar(255) DEFAULT 'Unknown',
  `eye_color` varchar(255) DEFAULT 'Unknown',
  `hair_type` varchar(255) DEFAULT 'Unknown'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users_appearance`
--

INSERT INTO `users_appearance` (`id`, `user_id`, `height`, `body_type`, `hair_color`, `eye_color`, `hair_type`) VALUES
(1, 1, '154cm', 'Skinny', 'Brown', 'Grey', 'Shoulder length'),
(2, 2, '180cm', 'A few extra kilos', 'Blond', 'Grey', 'Shoulder length'),
(3, 3, '176cm', 'Athletic', 'Brown', 'Hazel', 'Very short'),
(4, 4, '178cm', 'Average', 'Red', 'Blue', 'Very short'),
(5, 5, '168cm', 'Muscular', 'Black', 'Green', 'Shaved'),
(6, 6, '184cm', 'Athletic', 'Brown', 'Green', 'Very short'),
(7, 7, '174cm', 'Athletic', 'Black', 'Hazel', 'Very short'),
(8, 8, '172cm', 'Athletic', 'Brown', 'Brown', 'Very short'),
(9, 9, '182cm', 'A few extra kilos', 'Black', 'Green', 'Shoulder length'),
(10, 10, '158cm', 'Curvy', 'Black', 'Hazel', 'Long'),
(11, 11, '172cm', 'Skinny', 'Black', 'Green', 'Long'),
(12, 12, '170cm', 'Athletic', 'Red', 'Green', 'Shoulder length'),
(13, 13, '160cm', 'Curvy', 'Blond', 'Green', 'Shoulder length'),
(14, 14, '164cm', 'Athletic', 'Brown', 'Hazel', 'Long'),
(15, 15, '164cm', 'Curvy', 'Blond', 'Blue', 'Shoulder length'),
(16, 16, '172cm', 'Average', 'Red', 'Green', 'Very short'),
(17, 17, '166cm', 'Average', 'Blond', 'Green', 'Shoulder length'),
(18, 18, '162cm', 'A few extra kilos', 'Blond', 'Hazel', 'Long'),
(19, 19, '164cm', 'Athletic', 'Blond', 'Hazel', 'Shoulder length'),
(20, 20, '166cm', 'Average', 'Red', 'Grey', 'Long'),
(21, 21, '184cm', 'Athletic', 'Brown', 'Blue', 'Very short');

-- --------------------------------------------------------

--
-- Структура таблицы `users_background`
--

CREATE TABLE `users_background` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `education` varchar(255) DEFAULT 'Unknown',
  `employment` varchar(255) DEFAULT 'Unknown',
  `occupation` varchar(255) DEFAULT 'Unknown',
  `languages` varchar(255) DEFAULT 'Unknown'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users_background`
--

INSERT INTO `users_background` (`id`, `user_id`, `education`, `employment`, `occupation`, `languages`) VALUES
(1, 1, 'High shcool', 'Student', 'IT', 'English, Russian, Ukrainian'),
(2, 2, 'High shcool', 'Self-employed', 'Other', 'English, Russian, Ukrainian'),
(3, 3, 'Bachelors', 'Employed', 'Architecture', 'English'),
(4, 4, 'Colledge', 'Employed', 'Consultant', 'English'),
(5, 5, 'Colledge', 'Self-employed', 'Engineering', 'English'),
(6, 6, 'Masters', 'Employed', 'Finance', 'English, Russian'),
(7, 7, 'Bachelors', 'Self-employed', 'Artistic/Creative/Design', 'English'),
(8, 8, 'Colledge', 'Self-employed', 'Tourism', 'English'),
(9, 9, 'Colledge', 'Self-employed', 'Scientist', 'English'),
(10, 10, 'Bachelors', 'Volunteer', 'Charity', 'English'),
(11, 11, 'Masters', 'Employed', 'Executive', 'English'),
(12, 12, 'Masters', 'Employed', 'Artistic/Creative/Design', 'English'),
(13, 13, 'Colledge', 'Employed', 'Architecture', 'English'),
(14, 14, 'Bachelors', 'Retired', 'Legal', 'English'),
(15, 15, 'Colledge', 'Other', 'Marketing', 'English'),
(16, 16, 'Masters', 'Employed', 'Finance', 'English'),
(17, 17, 'Colledge', 'Self-employed', 'Legal', 'English'),
(18, 18, 'Bachelors', 'Employed', 'Consultant', 'English, Russian'),
(19, 19, 'Bachelors', 'Self-employed', 'Artistic/Creative/Design', 'English'),
(20, 20, 'Bachelors', 'Volunteer', 'Political/Government', 'English, French'),
(21, 21, 'Masters', 'Employed', 'Finance', 'English');

-- --------------------------------------------------------

--
-- Структура таблицы `users_basic_info`
--

CREATE TABLE `users_basic_info` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `gender` varchar(255) DEFAULT 'Unknown',
  `bday_day` int(2) DEFAULT '1',
  `bday_month` int(2) DEFAULT '1',
  `bday_year` int(4) DEFAULT '1990',
  `age` int(3) NOT NULL DEFAULT '28',
  `target_gender` varchar(255) DEFAULT 'Both',
  `target_min_age` int(11) DEFAULT '20',
  `target_max_age` int(11) DEFAULT '50'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users_basic_info`
--

INSERT INTO `users_basic_info` (`id`, `user_id`, `gender`, `bday_day`, `bday_month`, `bday_year`, `age`, `target_gender`, `target_min_age`, `target_max_age`) VALUES
(1, 1, 'Woman', 27, 10, 1997, 20, 'Men', 20, 23),
(2, 2, 'Man', 22, 2, 1998, 20, 'Women', 20, 27),
(3, 3, 'Man', 31, 1, 1981, 37, 'Women', 22, 36),
(4, 4, 'Man', 1, 1, 1989, 29, 'Both', 25, 30),
(5, 5, 'Man', 1, 1, 1996, 22, 'Women', 22, 28),
(6, 6, 'Man', 1, 1, 1988, 30, 'Men', 25, 34),
(7, 7, 'Man', 1, 1, 1996, 22, 'Women', 21, 26),
(8, 8, 'Man', 1, 1, 1986, 32, 'Both', 30, 35),
(9, 9, 'Man', 1, 1, 1993, 25, 'Women', 27, 32),
(10, 10, 'Woman', 1, 1, 1990, 28, 'Both', 20, 30),
(11, 11, 'Woman', 1, 1, 1989, 29, 'Men', 21, 32),
(12, 12, 'Woman', 1, 1, 1993, 25, 'Men', 24, 30),
(13, 13, 'Woman', 1, 1, 1987, 31, 'Men', 29, 35),
(14, 14, 'Woman', 1, 1, 1991, 27, 'Men', 23, 26),
(15, 15, 'Woman', 1, 1, 1986, 32, 'Men', 30, 40),
(16, 16, 'Woman', 1, 1, 1986, 32, 'Men', 29, 36),
(17, 17, 'Woman', 1, 1, 1985, 33, 'Men', 31, 42),
(18, 18, 'Woman', 1, 1, 1992, 26, 'Men', 24, 34),
(19, 19, 'Woman', 1, 1, 1996, 22, 'Men', 20, 25),
(20, 20, 'Woman', 1, 1, 1993, 25, 'Men', 20, 25),
(21, 21, 'Man', 1, 1, 1991, 27, 'Women', 20, 26);

-- --------------------------------------------------------

--
-- Структура таблицы `users_blocked`
--

CREATE TABLE `users_blocked` (
  `user_id` int(11) DEFAULT NULL,
  `blocked_by_user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users_blocked`
--

INSERT INTO `users_blocked` (`user_id`, `blocked_by_user_id`) VALUES
(6, 3),
(17, 3),
(12, 3),
(9, 3),
(18, 3),
(10, 3);

-- --------------------------------------------------------

--
-- Структура таблицы `users_description`
--

CREATE TABLE `users_description` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `about_me` varchar(8000) DEFAULT 'There is nothing interesting about me',
  `about_target` varchar(8000) DEFAULT 'I have no idea of who I am looking for'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users_description`
--

INSERT INTO `users_description` (`id`, `user_id`, `about_me`, `about_target`) VALUES
(1, 1, 'Oslo is the economic and governmental centre of Norway. The city is also a hub of Norwegian trade, banking, industry and shipping. It is an important centre for maritime industries and maritime trade in Europe. The city is home to many companies within the maritime sector, some of which are among the world\'s largest shipping companies, shipbrokers and maritime insurance brokers. Oslo is a pilot city of the Council of Europe and the European Commission intercultural cities programme.', 'Oslo is the economic and governmental centre of Norway. The city is also a hub of Norwegian trade, banking, industry and shipping. It is an important centre for maritime industries and maritime trade in Europe. The city is home to many companies within the maritime sector, some of which are among the world\'s largest shipping companies, shipbrokers and maritime insurance brokers. Oslo is a pilot city of the Council of Europe and the European Commission intercultural cities programme.'),
(2, 2, 'Stockholm[a] is the capital of Sweden and the most populous city in the Nordic countries;[9][b] 952,058 people live in the municipality,[10] approximately 1.5 million in the urban area,[5] and 2.3 million in the metropolitan area.[11] The city stretches across fourteen islands where Lake Mälaren flows into the Baltic Sea. Just outside the city and along the coast is the island chain of the Stockholm archipelago. The area has been settled since the Stone Age, in the 6th millennium BC, and was founded as a city in 1252 by Swedish statesman Birger Jarl. It is also the capital of Stockholm County. Stockholm is the only capital in the world with a national urban park.[12]', 'Oslo is the economic and governmental centre of Norway. The city is also a hub of Norwegian trade, banking, industry and shipping. It is an important centre for maritime industries and maritime trade in Europe. The city is home to many companies within the maritime sector, some of which are among the world\'s largest shipping companies, shipbrokers and maritime insurance brokers. Oslo is a pilot city of the Council of Europe and the European Commission intercultural cities programme.'),
(3, 3, 'Stockholm[a] is the capital of Sweden and the most populous city in the Nordic countries;[9][b] 952,058 people live in the municipality,[10] approximately 1.5 million in the urban area,[5] and 2.3 million in the metropolitan area.[11] The city stretches across fourteen islands where Lake Mälaren flows into the Baltic Sea. Just outside the city and along the coast is the island chain of the Stockholm archipelago. The area has been settled since the Stone Age, in the 6th millennium BC, and was founded as a city in 1252 by Swedish statesman Birger Jarl. It is also the capital of Stockholm County. Stockholm is the only capital in the world with a national urban park.[12]', 'Oslo is the economic and governmental centre of Norway. The city is also a hub of Norwegian trade, banking, industry and shipping. It is an important centre for maritime industries and maritime trade in Europe. The city is home to many companies within the maritime sector, some of which are among the world\'s largest shipping companies, shipbrokers and maritime insurance brokers. Oslo is a pilot city of the Council of Europe and the European Commission intercultural cities programme.'),
(4, 4, 'Stockholm[a] is the capital of Sweden and the most populous city in the Nordic countries;[9][b] 952,058 people live in the municipality,[10] approximately 1.5 million in the urban area,[5] and 2.3 million in the metropolitan area.[11] The city stretches across fourteen islands where Lake Mälaren flows into the Baltic Sea. Just outside the city and along the coast is the island chain of the Stockholm archipelago. The area has been settled since the Stone Age, in the 6th millennium BC, and was founded as a city in 1252 by Swedish statesman Birger Jarl. It is also the capital of Stockholm County. Stockholm is the only capital in the world with a national urban park.[12]', 'Oslo is the economic and governmental centre of Norway. The city is also a hub of Norwegian trade, banking, industry and shipping. It is an important centre for maritime industries and maritime trade in Europe. The city is home to many companies within the maritime sector, some of which are among the world\'s largest shipping companies, shipbrokers and maritime insurance brokers. Oslo is a pilot city of the Council of Europe and the European Commission intercultural cities programme.'),
(5, 5, 'Stockholm[a] is the capital of Sweden and the most populous city in the Nordic countries;[9][b] 952,058 people live in the municipality,[10] approximately 1.5 million in the urban area,[5] and 2.3 million in the metropolitan area.[11] The city stretches across fourteen islands where Lake Mälaren flows into the Baltic Sea. Just outside the city and along the coast is the island chain of the Stockholm archipelago. The area has been settled since the Stone Age, in the 6th millennium BC, and was founded as a city in 1252 by Swedish statesman Birger Jarl. It is also the capital of Stockholm County. Stockholm is the only capital in the world with a national urban park.[12]', 'Oslo is the economic and governmental centre of Norway. The city is also a hub of Norwegian trade, banking, industry and shipping. It is an important centre for maritime industries and maritime trade in Europe. The city is home to many companies within the maritime sector, some of which are among the world\'s largest shipping companies, shipbrokers and maritime insurance brokers. Oslo is a pilot city of the Council of Europe and the European Commission intercultural cities programme.'),
(6, 6, 'Stockholm[a] is the capital of Sweden and the most populous city in the Nordic countries;[9][b] 952,058 people live in the municipality,[10] approximately 1.5 million in the urban area,[5] and 2.3 million in the metropolitan area.[11] The city stretches across fourteen islands where Lake Mälaren flows into the Baltic Sea. Just outside the city and along the coast is the island chain of the Stockholm archipelago. The area has been settled since the Stone Age, in the 6th millennium BC, and was founded as a city in 1252 by Swedish statesman Birger Jarl. It is also the capital of Stockholm County. Stockholm is the only capital in the world with a national urban park.[12]', 'Oslo is the economic and governmental centre of Norway. The city is also a hub of Norwegian trade, banking, industry and shipping. It is an important centre for maritime industries and maritime trade in Europe. The city is home to many companies within the maritime sector, some of which are among the world\'s largest shipping companies, shipbrokers and maritime insurance brokers. Oslo is a pilot city of the Council of Europe and the European Commission intercultural cities programme.'),
(7, 7, 'Stockholm[a] is the capital of Sweden and the most populous city in the Nordic countries;[9][b] 952,058 people live in the municipality,[10] approximately 1.5 million in the urban area,[5] and 2.3 million in the metropolitan area.[11] The city stretches across fourteen islands where Lake Mälaren flows into the Baltic Sea. Just outside the city and along the coast is the island chain of the Stockholm archipelago. The area has been settled since the Stone Age, in the 6th millennium BC, and was founded as a city in 1252 by Swedish statesman Birger Jarl. It is also the capital of Stockholm County. Stockholm is the only capital in the world with a national urban park.[12]', 'Oslo is the economic and governmental centre of Norway. The city is also a hub of Norwegian trade, banking, industry and shipping. It is an important centre for maritime industries and maritime trade in Europe. The city is home to many companies within the maritime sector, some of which are among the world\'s largest shipping companies, shipbrokers and maritime insurance brokers. Oslo is a pilot city of the Council of Europe and the European Commission intercultural cities programme.'),
(8, 8, 'Stockholm[a] is the capital of Sweden and the most populous city in the Nordic countries;[9][b] 952,058 people live in the municipality,[10] approximately 1.5 million in the urban area,[5] and 2.3 million in the metropolitan area.[11] The city stretches across fourteen islands where Lake Mälaren flows into the Baltic Sea. Just outside the city and along the coast is the island chain of the Stockholm archipelago. The area has been settled since the Stone Age, in the 6th millennium BC, and was founded as a city in 1252 by Swedish statesman Birger Jarl. It is also the capital of Stockholm County. Stockholm is the only capital in the world with a national urban park.[12]', 'Oslo is the economic and governmental centre of Norway. The city is also a hub of Norwegian trade, banking, industry and shipping. It is an important centre for maritime industries and maritime trade in Europe. The city is home to many companies within the maritime sector, some of which are among the world\'s largest shipping companies, shipbrokers and maritime insurance brokers. Oslo is a pilot city of the Council of Europe and the European Commission intercultural cities programme.'),
(9, 9, 'Stockholm[a] is the capital of Sweden and the most populous city in the Nordic countries;[9][b] 952,058 people live in the municipality,[10] approximately 1.5 million in the urban area,[5] and 2.3 million in the metropolitan area.[11] The city stretches across fourteen islands where Lake Mälaren flows into the Baltic Sea. Just outside the city and along the coast is the island chain of the Stockholm archipelago. The area has been settled since the Stone Age, in the 6th millennium BC, and was founded as a city in 1252 by Swedish statesman Birger Jarl. It is also the capital of Stockholm County. Stockholm is the only capital in the world with a national urban park.[12]', 'Oslo is the economic and governmental centre of Norway. The city is also a hub of Norwegian trade, banking, industry and shipping. It is an important centre for maritime industries and maritime trade in Europe. The city is home to many companies within the maritime sector, some of which are among the world\'s largest shipping companies, shipbrokers and maritime insurance brokers. Oslo is a pilot city of the Council of Europe and the European Commission intercultural cities programme.'),
(10, 10, 'Stockholm[a] is the capital of Sweden and the most populous city in the Nordic countries;[9][b] 952,058 people live in the municipality,[10] approximately 1.5 million in the urban area,[5] and 2.3 million in the metropolitan area.[11] The city stretches across fourteen islands where Lake Mälaren flows into the Baltic Sea. Just outside the city and along the coast is the island chain of the Stockholm archipelago. The area has been settled since the Stone Age, in the 6th millennium BC, and was founded as a city in 1252 by Swedish statesman Birger Jarl. It is also the capital of Stockholm County. Stockholm is the only capital in the world with a national urban park.[12]', 'Oslo is the economic and governmental centre of Norway. The city is also a hub of Norwegian trade, banking, industry and shipping. It is an important centre for maritime industries and maritime trade in Europe. The city is home to many companies within the maritime sector, some of which are among the world\'s largest shipping companies, shipbrokers and maritime insurance brokers. Oslo is a pilot city of the Council of Europe and the European Commission intercultural cities programme.'),
(11, 11, 'Stockholm[a] is the capital of Sweden and the most populous city in the Nordic countries;[9][b] 952,058 people live in the municipality,[10] approximately 1.5 million in the urban area,[5] and 2.3 million in the metropolitan area.[11] The city stretches across fourteen islands where Lake Mälaren flows into the Baltic Sea. Just outside the city and along the coast is the island chain of the Stockholm archipelago. The area has been settled since the Stone Age, in the 6th millennium BC, and was founded as a city in 1252 by Swedish statesman Birger Jarl. It is also the capital of Stockholm County. Stockholm is the only capital in the world with a national urban park.[12]', 'Oslo is the economic and governmental centre of Norway. The city is also a hub of Norwegian trade, banking, industry and shipping. It is an important centre for maritime industries and maritime trade in Europe. The city is home to many companies within the maritime sector, some of which are among the world\'s largest shipping companies, shipbrokers and maritime insurance brokers. Oslo is a pilot city of the Council of Europe and the European Commission intercultural cities programme.'),
(12, 12, 'Stockholm[a] is the capital of Sweden and the most populous city in the Nordic countries;[9][b] 952,058 people live in the municipality,[10] approximately 1.5 million in the urban area,[5] and 2.3 million in the metropolitan area.[11] The city stretches across fourteen islands where Lake Mälaren flows into the Baltic Sea. Just outside the city and along the coast is the island chain of the Stockholm archipelago. The area has been settled since the Stone Age, in the 6th millennium BC, and was founded as a city in 1252 by Swedish statesman Birger Jarl. It is also the capital of Stockholm County. Stockholm is the only capital in the world with a national urban park.[12]', 'Oslo is the economic and governmental centre of Norway. The city is also a hub of Norwegian trade, banking, industry and shipping. It is an important centre for maritime industries and maritime trade in Europe. The city is home to many companies within the maritime sector, some of which are among the world\'s largest shipping companies, shipbrokers and maritime insurance brokers. Oslo is a pilot city of the Council of Europe and the European Commission intercultural cities programme.'),
(13, 13, 'Stockholm[a] is the capital of Sweden and the most populous city in the Nordic countries;[9][b] 952,058 people live in the municipality,[10] approximately 1.5 million in the urban area,[5] and 2.3 million in the metropolitan area.[11] The city stretches across fourteen islands where Lake Mälaren flows into the Baltic Sea. Just outside the city and along the coast is the island chain of the Stockholm archipelago. The area has been settled since the Stone Age, in the 6th millennium BC, and was founded as a city in 1252 by Swedish statesman Birger Jarl. It is also the capital of Stockholm County. Stockholm is the only capital in the world with a national urban park.[12]', 'Oslo is the economic and governmental centre of Norway. The city is also a hub of Norwegian trade, banking, industry and shipping. It is an important centre for maritime industries and maritime trade in Europe. The city is home to many companies within the maritime sector, some of which are among the world\'s largest shipping companies, shipbrokers and maritime insurance brokers. Oslo is a pilot city of the Council of Europe and the European Commission intercultural cities programme.'),
(14, 14, 'Stockholm[a] is the capital of Sweden and the most populous city in the Nordic countries;[9][b] 952,058 people live in the municipality,[10] approximately 1.5 million in the urban area,[5] and 2.3 million in the metropolitan area.[11] The city stretches across fourteen islands where Lake Mälaren flows into the Baltic Sea. Just outside the city and along the coast is the island chain of the Stockholm archipelago. The area has been settled since the Stone Age, in the 6th millennium BC, and was founded as a city in 1252 by Swedish statesman Birger Jarl. It is also the capital of Stockholm County. Stockholm is the only capital in the world with a national urban park.[12]', 'Oslo is the economic and governmental centre of Norway. The city is also a hub of Norwegian trade, banking, industry and shipping. It is an important centre for maritime industries and maritime trade in Europe. The city is home to many companies within the maritime sector, some of which are among the world\'s largest shipping companies, shipbrokers and maritime insurance brokers. Oslo is a pilot city of the Council of Europe and the European Commission intercultural cities programme.'),
(15, 15, 'Stockholm[a] is the capital of Sweden and the most populous city in the Nordic countries;[9][b] 952,058 people live in the municipality,[10] approximately 1.5 million in the urban area,[5] and 2.3 million in the metropolitan area.[11] The city stretches across fourteen islands where Lake Mälaren flows into the Baltic Sea. Just outside the city and along the coast is the island chain of the Stockholm archipelago. The area has been settled since the Stone Age, in the 6th millennium BC, and was founded as a city in 1252 by Swedish statesman Birger Jarl. It is also the capital of Stockholm County. Stockholm is the only capital in the world with a national urban park.[12]', 'Oslo is the economic and governmental centre of Norway. The city is also a hub of Norwegian trade, banking, industry and shipping. It is an important centre for maritime industries and maritime trade in Europe. The city is home to many companies within the maritime sector, some of which are among the world\'s largest shipping companies, shipbrokers and maritime insurance brokers. Oslo is a pilot city of the Council of Europe and the European Commission intercultural cities programme.'),
(16, 16, 'Stockholm[a] is the capital of Sweden and the most populous city in the Nordic countries;[9][b] 952,058 people live in the municipality,[10] approximately 1.5 million in the urban area,[5] and 2.3 million in the metropolitan area.[11] The city stretches across fourteen islands where Lake Mälaren flows into the Baltic Sea. Just outside the city and along the coast is the island chain of the Stockholm archipelago. The area has been settled since the Stone Age, in the 6th millennium BC, and was founded as a city in 1252 by Swedish statesman Birger Jarl. It is also the capital of Stockholm County. Stockholm is the only capital in the world with a national urban park.[12]', 'Oslo is the economic and governmental centre of Norway. The city is also a hub of Norwegian trade, banking, industry and shipping. It is an important centre for maritime industries and maritime trade in Europe. The city is home to many companies within the maritime sector, some of which are among the world\'s largest shipping companies, shipbrokers and maritime insurance brokers. Oslo is a pilot city of the Council of Europe and the European Commission intercultural cities programme.'),
(17, 17, 'Stockholm[a] is the capital of Sweden and the most populous city in the Nordic countries;[9][b] 952,058 people live in the municipality,[10] approximately 1.5 million in the urban area,[5] and 2.3 million in the metropolitan area.[11] The city stretches across fourteen islands where Lake Mälaren flows into the Baltic Sea. Just outside the city and along the coast is the island chain of the Stockholm archipelago. The area has been settled since the Stone Age, in the 6th millennium BC, and was founded as a city in 1252 by Swedish statesman Birger Jarl. It is also the capital of Stockholm County. Stockholm is the only capital in the world with a national urban park.[12]', 'Oslo is the economic and governmental centre of Norway. The city is also a hub of Norwegian trade, banking, industry and shipping. It is an important centre for maritime industries and maritime trade in Europe. The city is home to many companies within the maritime sector, some of which are among the world\'s largest shipping companies, shipbrokers and maritime insurance brokers. Oslo is a pilot city of the Council of Europe and the European Commission intercultural cities programme.'),
(18, 18, 'Stockholm[a] is the capital of Sweden and the most populous city in the Nordic countries;[9][b] 952,058 people live in the municipality,[10] approximately 1.5 million in the urban area,[5] and 2.3 million in the metropolitan area.[11] The city stretches across fourteen islands where Lake Mälaren flows into the Baltic Sea. Just outside the city and along the coast is the island chain of the Stockholm archipelago. The area has been settled since the Stone Age, in the 6th millennium BC, and was founded as a city in 1252 by Swedish statesman Birger Jarl. It is also the capital of Stockholm County. Stockholm is the only capital in the world with a national urban park.[12]', 'Oslo is the economic and governmental centre of Norway. The city is also a hub of Norwegian trade, banking, industry and shipping. It is an important centre for maritime industries and maritime trade in Europe. The city is home to many companies within the maritime sector, some of which are among the world\'s largest shipping companies, shipbrokers and maritime insurance brokers. Oslo is a pilot city of the Council of Europe and the European Commission intercultural cities programme.'),
(19, 19, 'Stockholm[a] is the capital of Sweden and the most populous city in the Nordic countries;[9][b] 952,058 people live in the municipality,[10] approximately 1.5 million in the urban area,[5] and 2.3 million in the metropolitan area.[11] The city stretches across fourteen islands where Lake Mälaren flows into the Baltic Sea. Just outside the city and along the coast is the island chain of the Stockholm archipelago. The area has been settled since the Stone Age, in the 6th millennium BC, and was founded as a city in 1252 by Swedish statesman Birger Jarl. It is also the capital of Stockholm County. Stockholm is the only capital in the world with a national urban park.[12]', 'Oslo is the economic and governmental centre of Norway. The city is also a hub of Norwegian trade, banking, industry and shipping. It is an important centre for maritime industries and maritime trade in Europe. The city is home to many companies within the maritime sector, some of which are among the world\'s largest shipping companies, shipbrokers and maritime insurance brokers. Oslo is a pilot city of the Council of Europe and the European Commission intercultural cities programme.'),
(20, 20, 'Stockholm[a] is the capital of Sweden and the most populous city in the Nordic countries;[9][b] 952,058 people live in the municipality,[10] approximately 1.5 million in the urban area,[5] and 2.3 million in the metropolitan area.[11] The city stretches across fourteen islands where Lake Mälaren flows into the Baltic Sea. Just outside the city and along the coast is the island chain of the Stockholm archipelago. The area has been settled since the Stone Age, in the 6th millennium BC, and was founded as a city in 1252 by Swedish statesman Birger Jarl. It is also the capital of Stockholm County. Stockholm is the only capital in the world with a national urban park.[12]', 'Oslo is the economic and governmental centre of Norway. The city is also a hub of Norwegian trade, banking, industry and shipping. It is an important centre for maritime industries and maritime trade in Europe. The city is home to many companies within the maritime sector, some of which are among the world\'s largest shipping companies, shipbrokers and maritime insurance brokers. Oslo is a pilot city of the Council of Europe and the European Commission intercultural cities programme.'),
(21, 21, 'Stockholm[a] is the capital of Sweden and the most populous city in the Nordic countries;[9][b] 952,058 people live in the municipality,[10] approximately 1.5 million in the urban area,[5] and 2.3 million in the metropolitan area.[11] The city stretches across fourteen islands where Lake Mälaren flows into the Baltic Sea. Just outside the city and along the coast is the island chain of the Stockholm archipelago. The area has been settled since the Stone Age, in the 6th millennium BC, and was founded as a city in 1252 by Swedish statesman Birger Jarl. It is also the capital of Stockholm County. Stockholm is the only capital in the world with a national urban park.[12]', 'Oslo is the economic and governmental centre of Norway. The city is also a hub of Norwegian trade, banking, industry and shipping. It is an important centre for maritime industries and maritime trade in Europe. The city is home to many companies within the maritime sector, some of which are among the world\'s largest shipping companies, shipbrokers and maritime insurance brokers. Oslo is a pilot city of the Council of Europe and the European Commission intercultural cities programme.');

-- --------------------------------------------------------

--
-- Структура таблицы `users_files_upload`
--

CREATE TABLE `users_files_upload` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `upload_pic` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users_files_upload`
--

INSERT INTO `users_files_upload` (`id`, `user_id`, `upload_pic`) VALUES
(9, 1, 'static/uploads/ksena/awesome_pics/1_F_ttuYWPAVBGSMyHlX9l9A.jpeg'),
(10, 1, 'static/uploads/ksena/awesome_pics/1.-Men-Wearing-Glass.jpg'),
(11, 1, 'static/uploads/ksena/awesome_pics/3bcb6ce79c6278f5b2ad132fc130c436.jpg');

-- --------------------------------------------------------

--
-- Структура таблицы `users_interests`
--

CREATE TABLE `users_interests` (
  `user_id` int(11) DEFAULT NULL,
  `interest_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users_interests`
--

INSERT INTO `users_interests` (`user_id`, `interest_id`) VALUES
(1, 20),
(1, 19),
(1, 35),
(2, 2),
(2, 3),
(2, 15),
(2, 18),
(2, 33),
(4, 20),
(4, 11),
(4, 8),
(4, 15),
(4, 27),
(4, 33),
(5, 4),
(5, 7),
(5, 28),
(5, 30),
(5, 27),
(6, 16),
(6, 13),
(6, 10),
(6, 18),
(6, 33),
(6, 36),
(6, 35),
(7, 26),
(7, 35),
(7, 11),
(7, 8),
(7, 5),
(7, 2),
(8, 5),
(8, 8),
(8, 15),
(8, 18),
(8, 3),
(8, 2),
(8, 33),
(9, 2),
(9, 4),
(9, 10),
(9, 16),
(9, 19),
(9, 22),
(10, 4),
(10, 10),
(10, 16),
(10, 17),
(10, 20),
(10, 33),
(11, 2),
(11, 3),
(11, 18),
(11, 30),
(11, 33),
(11, 35),
(12, 11),
(12, 15),
(12, 18),
(12, 36),
(12, 25),
(12, 2),
(13, 3),
(13, 12),
(13, 18),
(13, 10),
(13, 25),
(14, 3),
(14, 6),
(14, 34),
(14, 35),
(15, 24),
(15, 27),
(15, 10),
(15, 16),
(15, 25),
(15, 35),
(15, 2),
(16, 11),
(16, 8),
(16, 14),
(16, 3),
(16, 12),
(17, 10),
(17, 19),
(17, 34),
(17, 33),
(17, 3),
(18, 36),
(18, 35),
(18, 29),
(18, 5),
(18, 2),
(19, 8),
(19, 3),
(19, 2),
(19, 10),
(19, 19),
(19, 22),
(20, 5),
(20, 10),
(20, 12),
(20, 18),
(20, 36),
(20, 33),
(20, 34),
(21, 2),
(21, 5),
(21, 11),
(21, 15),
(21, 12),
(21, 18),
(3, 20),
(3, 23),
(3, 8),
(3, 2),
(1, 34),
(1, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `users_lifestyle`
--

CREATE TABLE `users_lifestyle` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `relationship_status` varchar(255) DEFAULT 'Unknown',
  `children` varchar(255) DEFAULT 'Unknown',
  `would_like_children` varchar(255) DEFAULT 'Unknown',
  `diet` varchar(255) DEFAULT 'Unknown',
  `drinking` varchar(255) DEFAULT 'Unknown',
  `smoking` varchar(255) DEFAULT 'Unknown'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users_lifestyle`
--

INSERT INTO `users_lifestyle` (`id`, `user_id`, `relationship_status`, `children`, `would_like_children`, `diet`, `drinking`, `smoking`) VALUES
(1, 1, 'Single', 'None', 'No', 'Vegan', 'Social drinking', 'Occasionally'),
(2, 2, 'Single', 'None', 'No', 'Home cooking', 'Social drinking', 'Ex-smoker'),
(3, 3, 'Divorced', 'None', 'Yes', 'Healthy', 'Rarely', 'Moderate'),
(4, 4, 'It\'s complicated', 'One', 'No', 'Fast food', 'Social drinking', 'Heavily'),
(5, 5, 'Single', 'None', 'Yes', 'Only organic', 'Rarely', 'Occasionally'),
(6, 6, 'Widowed', 'None', 'Yes', 'Fast food', 'Rarely', 'Occasionally'),
(7, 7, 'Single', 'None', 'Yes', 'Only organic', 'Don\'t drink', 'Occasionally'),
(8, 8, 'Divorced', 'One', 'Yes', 'Only organic', 'Rarely', 'Ex-smoker'),
(9, 9, 'Single', 'One', 'No', 'Home cooking', 'Social drinking', 'Ex-smoker'),
(10, 10, 'Single', 'None', 'Don\'t know yet', 'Vegetarian', 'Don\'t drink', 'Occasionally'),
(11, 11, 'Divorced', 'Two', 'No', 'Fast food', 'Social drinking', 'Trying to give up'),
(12, 12, 'Single', 'None', 'Yes', 'Only organic', 'Rarely', 'Occasionally'),
(13, 13, 'Single', 'One', 'Don\'t know yet', 'Home cooking', 'Social drinking', 'Pipe'),
(14, 14, 'Widowed', 'None', 'Yes', 'Home cooking', 'Rarely', 'Moderate'),
(15, 15, 'It\'s complicated', 'None', 'Yes', 'Healthy', 'Rarely', 'Moderate'),
(16, 16, 'Single', 'One', 'Yes', 'Fast food', 'Social drinking', 'Occasionally'),
(17, 17, 'Single', 'Two', 'No', 'Home cooking', 'Don\'t drink', 'Moderate'),
(18, 18, 'Widowed', 'One', 'Yes', 'Vegetarian', 'Don\'t drink', 'Don\'t smoke'),
(19, 19, 'Single', 'None', 'Yes', 'Healthy', 'Social drinking', 'Moderate'),
(20, 20, 'Married', 'Two', 'No', 'Fast food', 'Rarely', 'Don\'t smoke'),
(21, 21, 'Single', 'None', 'No', 'Vegetarian', 'Rarely', 'Occasionally');

-- --------------------------------------------------------

--
-- Структура таблицы `users_likes`
--

CREATE TABLE `users_likes` (
  `user_id` int(11) DEFAULT NULL,
  `like_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users_likes`
--

INSERT INTO `users_likes` (`user_id`, `like_id`) VALUES
(1, 2),
(7, 20),
(20, 7),
(19, 3),
(1, 3),
(3, 1),
(2, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `users_location`
--

CREATE TABLE `users_location` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `country` varchar(100) DEFAULT 'Unknown',
  `city` varchar(100) DEFAULT 'Unknown',
  `district` varchar(100) DEFAULT 'Unknown',
  `user_country` varchar(100) DEFAULT 'Unknown',
  `user_city` varchar(100) DEFAULT 'Unknown',
  `user_district` varchar(100) DEFAULT 'Unknown',
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `backup_lat` double DEFAULT NULL,
  `backup_lon` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users_location`
--

INSERT INTO `users_location` (`id`, `user_id`, `country`, `city`, `district`, `user_country`, `user_city`, `user_district`, `latitude`, `longitude`, `backup_lat`, `backup_lon`) VALUES
(1, 1, 'Ukraine', 'Kyiv', 'Сирець', 'Ukraine', 'Kyiv', 'none', 50.468431599999995, 30.4518626, 50.4333, 30.5167),
(2, 2, 'Ukraine', 'Kyiv', 'Lukyanivka', 'Unknown', 'Unknown', 'Unknown', 50.464208899999996, 30.466489, 50.4333, 30.5167),
(3, 3, 'Ukraine', 'Kyiv', 'Lukyanivka', 'Ukraine', 'Boryspil', 'none', 50.464208899999996, 30.466489, 50.4333, 30.5167),
(4, 4, 'Ukraine', 'Kyiv', 'Lukyanivka', 'Unknown', 'Unknown', 'Unknown', 50.400527, 30.524926, 50.4333, 30.5167),
(5, 5, 'Ukraine', 'Kyiv', 'Lukyanivka', 'Unknown', 'Unknown', 'Unknown', 50.40729, 30.513409, 50.4333, 30.5167),
(6, 6, 'Ukraine', 'Kyiv', 'Lukyanivka', 'Unknown', 'Unknown', 'Unknown', 50.418829, 30.466489, 50.4333, 30.5167),
(7, 7, 'Ukraine', 'Unknown', 'Old Kyiv', 'Ukraine', 'Bucha', 'none', 50.5485813, 30.522682, 50.4547, 30.5238),
(8, 8, 'Ukraine', 'Kyiv', 'Lukyanivka', 'Unknown', 'Unknown', 'Unknown', 50.49762, 30.517547, 50.4333, 30.5167),
(9, 9, 'Ukraine', 'Kyiv', 'Lukyanivka', 'Unknown', 'Unknown', 'Unknown', 50.51378, 30.438236, 50.4333, 30.5167),
(10, 10, 'Ukraine', 'Kyiv', 'Lukyanivka', 'Unknown', 'Unknown', 'Unknown', 50.506107, 30.610297, 50.4333, 30.5167),
(11, 11, 'Ukraine', 'Kyiv', 'Lukyanivka', 'Unknown', 'Unknown', 'Unknown', 50.36956, 30.835945, 50.4333, 30.5167),
(12, 12, 'Ukraine', 'Kyiv', 'Lukyanivka', 'Unknown', 'Unknown', 'Unknown', 50.412944, 30.665627, 50.4333, 30.5167),
(13, 13, 'Ukraine', 'Kyiv', 'Lukyanivka', 'Unknown', 'Unknown', 'Unknown', 50.397462, 30.626054, 50.4333, 30.5167),
(14, 14, 'Ukraine', 'Kyiv', 'Lukyanivka', 'Unknown', 'Unknown', 'Unknown', 50.451275, 30.466489, 50.4333, 30.5167),
(15, 15, 'Ukraine', 'Unknown', 'none', 'Ukraine', 'Brovary', 'none', 50.5111168, 30.535418, 50.4333, 30.5167),
(16, 16, 'Ukraine', 'Kyiv', 'Lukyanivka', 'Unknown', 'Unknown', 'Unknown', 50.444717, 30.510098, 50.4333, 30.5167),
(17, 17, 'Ukraine', 'Kyiv', 'Lukyanivka', 'Unknown', 'Unknown', 'Unknown', 50.450618, 30.445893, 50.4333, 30.5167),
(18, 18, 'Ukraine', 'Kyiv', 'Lukyanivka', 'Unknown', 'Unknown', 'Unknown', 50.475041, 30.466489, 50.4333, 30.5167),
(19, 19, 'Ukraine', 'Kyiv', 'none', 'Unknown', 'Unknown', 'Unknown', 50.463083, 30.434479, 50.4333, 30.5167),
(20, 20, 'Ukraine', 'Kyiv', 'Lukyanivka', 'Unknown', 'Unknown', 'Unknown', 50.505612, 30.49613, 50.4333, 30.5167),
(21, 21, 'Ukraine', 'Kyiv', 'Lukyanivka', 'Unknown', 'Unknown', 'Unknown', 50.464208899999996, 30.466489, 50.4333, 30.5167);

-- --------------------------------------------------------

--
-- Структура таблицы `users_pictures`
--

CREATE TABLE `users_pictures` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `profile_pic` varchar(255) DEFAULT 'static/img/default_profile.jpg'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users_pictures`
--

INSERT INTO `users_pictures` (`id`, `user_id`, `profile_pic`) VALUES
(1, 1, 'static/uploads/ksena/profile_pic/cropped_pic1.jpeg'),
(2, 2, 'static/uploads/devon/profile_pic/cropped_14c0cb0a-3989-476e-9711-ad9b731b1ede.jpeg'),
(3, 3, 'static/uploads/gwash/profile_pic/cropped_1_F_ttuYWPAVBGSMyHlX9l9A.jpeg'),
(4, 4, 'static/uploads/wwilson/profile_pic/cropped_Harry-Ginger-1.jpg'),
(5, 5, 'static/uploads/tjeff/profile_pic/cropped_bw_sad__focus_man_portrait_by_femiradu-d5yly0f.jpg'),
(6, 6, 'static/uploads/alinc/profile_pic/cropped_1030-beard-1.jpeg'),
(7, 7, 'static/uploads/froos/profile_pic/cropped_Vincent-Binant-Man-Portrait.jpg'),
(8, 8, 'static/uploads/jkenn/profile_pic/cropped_1.-Men-Wearing-Glass.jpg'),
(9, 9, 'static/uploads/rnixon/profile_pic/cropped_936ae832cf6e5e3a47479f2d045724a7.jpg'),
(10, 10, 'static/img/default_profile.jpg'),
(11, 11, 'static/uploads/ahathaway/profile_pic/cropped_shutterstock_471284129-1500x1000.jpg'),
(12, 12, 'static/uploads/estone/profile_pic/cropped_redheads-brian-dowling-3.jpg'),
(13, 13, 'static/uploads/gkelly/profile_pic/cropped_inspired-2016-03-blonde-woman-reading-smart-main.jpg'),
(14, 14, 'static/uploads/jlaw/profile_pic/cropped_Screen_Shot_2017_11_17_at_12.30.10_AM.0.png'),
(15, 15, 'static/uploads/mmonroe/profile_pic/cropped_1454963436-loni-marilyn.jpg'),
(16, 16, 'static/uploads/mkunis/profile_pic/cropped_maxresdefault_1.jpg'),
(17, 17, 'static/uploads/mstreep/profile_pic/cropped_IMG_3652.JPG'),
(18, 18, 'static/uploads/nportman/profile_pic/cropped_14911-a-beautiful-young-woman-in-business-attire-pv.jpg'),
(19, 19, 'static/uploads/nkidman/profile_pic/cropped_person-girl-woman-female-young-food-610585-pxhere.com_.jpg'),
(20, 20, 'static/uploads/sjoh/profile_pic/cropped_Syprem-Word-Printed-Fitness-Tank-Top-Women-Yoga-Vest-Workout-Clothes-Light-weight-Loose-Sleeveless-Cute-1.jpg'),
(21, 21, 'static/uploads/msmith/profile_pic/cropped_beard-styles-for-men-1170x693.jpg');

-- --------------------------------------------------------

--
-- Структура таблицы `users_visits`
--

CREATE TABLE `users_visits` (
  `user_id` int(11) DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users_visits`
--

INSERT INTO `users_visits` (`user_id`, `visit_id`, `visit_time`) VALUES
(2, 1, '2018-09-21 12:20:03'),
(1, 2, '2018-09-21 12:20:22'),
(2, 1, '2018-09-21 12:25:19'),
(2, 1, '2018-09-21 12:26:12'),
(2, 1, '2018-09-21 12:26:23'),
(2, 1, '2018-09-21 12:26:41'),
(2, 1, '2018-09-21 12:28:07'),
(2, 1, '2018-09-21 12:28:28'),
(2, 1, '2018-09-21 12:31:07'),
(2, 1, '2018-09-21 12:57:36'),
(2, 1, '2018-09-21 12:59:19'),
(2, 1, '2018-09-21 13:00:05'),
(2, 1, '2018-09-21 13:00:14'),
(2, 1, '2018-09-21 13:00:41'),
(2, 1, '2018-09-21 13:02:06'),
(2, 1, '2018-09-21 13:03:15'),
(2, 1, '2018-09-21 13:03:17'),
(2, 1, '2018-09-21 13:04:06'),
(2, 1, '2018-09-21 13:04:11'),
(2, 1, '2018-09-21 13:04:14'),
(2, 1, '2018-09-21 13:04:16'),
(2, 1, '2018-09-21 13:04:20'),
(2, 1, '2018-09-21 13:04:24'),
(2, 1, '2018-09-21 13:04:50'),
(2, 1, '2018-09-21 13:04:55'),
(2, 1, '2018-09-21 13:05:06'),
(2, 1, '2018-09-21 13:05:09'),
(2, 1, '2018-09-21 13:05:48'),
(2, 1, '2018-09-21 13:06:33'),
(2, 1, '2018-09-21 13:06:37'),
(2, 1, '2018-09-21 13:06:52'),
(2, 1, '2018-09-21 13:09:22'),
(2, 1, '2018-09-21 13:09:29'),
(2, 1, '2018-09-21 13:10:21'),
(2, 1, '2018-09-21 13:10:29'),
(2, 1, '2018-09-21 13:10:46'),
(2, 1, '2018-09-21 13:16:52'),
(2, 1, '2018-09-21 13:16:57'),
(2, 1, '2018-09-21 13:17:11'),
(2, 1, '2018-09-21 13:17:23'),
(2, 1, '2018-09-21 13:17:25'),
(2, 1, '2018-09-21 13:17:31'),
(2, 1, '2018-09-21 13:17:33'),
(2, 1, '2018-09-21 13:18:52'),
(2, 1, '2018-09-21 13:19:04'),
(2, 1, '2018-09-21 13:19:15'),
(2, 1, '2018-09-21 13:19:26'),
(2, 1, '2018-09-21 13:19:28'),
(2, 1, '2018-09-21 13:21:23'),
(2, 1, '2018-09-21 13:21:47'),
(2, 1, '2018-09-21 13:21:54'),
(2, 1, '2018-09-21 13:21:57'),
(2, 1, '2018-09-21 13:22:31'),
(2, 1, '2018-09-21 13:22:38'),
(2, 1, '2018-09-21 13:32:29'),
(2, 1, '2018-09-21 13:32:40'),
(2, 1, '2018-09-21 13:33:04'),
(2, 1, '2018-09-21 13:33:15'),
(2, 1, '2018-09-21 13:33:44'),
(2, 1, '2018-09-21 13:33:54'),
(2, 1, '2018-09-21 13:35:10'),
(2, 1, '2018-09-21 13:35:58'),
(2, 1, '2018-09-21 13:36:11'),
(2, 1, '2018-09-21 13:37:33'),
(2, 1, '2018-09-21 13:37:35'),
(2, 1, '2018-09-21 13:37:43'),
(2, 1, '2018-09-21 13:38:42'),
(2, 1, '2018-09-21 13:38:47'),
(2, 1, '2018-09-21 14:15:40'),
(2, 1, '2018-09-21 14:16:12'),
(2, 1, '2018-09-21 14:23:44'),
(2, 1, '2018-09-21 14:23:52'),
(2, 1, '2018-09-21 14:23:54'),
(2, 1, '2018-09-21 14:23:57'),
(2, 1, '2018-09-21 14:24:04'),
(2, 1, '2018-09-21 14:24:06'),
(2, 1, '2018-09-21 14:24:09'),
(2, 1, '2018-09-21 14:24:11'),
(2, 1, '2018-09-21 14:24:13'),
(2, 1, '2018-09-21 14:24:14'),
(2, 1, '2018-09-21 14:24:17'),
(2, 1, '2018-09-21 14:24:19'),
(2, 1, '2018-09-21 14:24:40'),
(2, 1, '2018-09-21 14:25:00'),
(2, 1, '2018-09-21 14:25:02'),
(2, 1, '2018-09-21 14:25:03'),
(2, 1, '2018-09-21 14:25:05'),
(2, 1, '2018-09-21 14:25:06'),
(2, 1, '2018-09-21 14:25:07'),
(2, 1, '2018-09-21 14:25:08'),
(2, 1, '2018-09-21 14:25:12'),
(2, 1, '2018-09-21 14:25:14'),
(2, 1, '2018-09-21 14:25:18'),
(2, 1, '2018-09-21 14:25:19'),
(2, 1, '2018-09-21 14:25:21'),
(2, 1, '2018-09-21 14:25:23'),
(2, 1, '2018-09-21 14:25:36'),
(2, 1, '2018-09-21 14:25:38'),
(2, 1, '2018-09-21 14:26:58'),
(2, 1, '2018-09-21 14:27:22'),
(2, 1, '2018-09-21 14:27:27'),
(2, 1, '2018-09-21 14:28:04'),
(2, 1, '2018-09-21 14:28:35'),
(2, 1, '2018-09-21 14:51:12'),
(2, 1, '2018-09-21 14:58:22'),
(2, 1, '2018-09-21 14:59:14'),
(2, 1, '2018-09-21 15:00:34'),
(2, 1, '2018-09-21 15:01:40'),
(2, 1, '2018-09-21 15:01:44'),
(2, 1, '2018-09-21 15:01:47'),
(2, 1, '2018-09-21 15:01:49'),
(2, 1, '2018-09-21 15:01:51'),
(2, 1, '2018-09-21 15:01:57'),
(2, 1, '2018-09-21 15:02:56'),
(2, 1, '2018-09-21 15:03:05'),
(2, 1, '2018-09-21 15:03:07'),
(2, 1, '2018-09-21 15:03:09'),
(2, 1, '2018-09-21 15:03:10'),
(2, 1, '2018-09-21 15:03:29'),
(2, 1, '2018-09-21 15:03:43'),
(2, 1, '2018-09-21 15:13:03'),
(2, 1, '2018-09-21 15:13:25'),
(2, 1, '2018-09-21 15:13:28'),
(2, 1, '2018-09-21 15:13:30'),
(2, 1, '2018-09-21 15:13:32'),
(2, 1, '2018-09-21 15:13:39'),
(2, 1, '2018-09-21 15:13:41'),
(2, 1, '2018-09-21 15:13:43'),
(2, 1, '2018-09-21 15:13:44'),
(2, 1, '2018-09-21 15:13:45'),
(2, 1, '2018-09-21 15:13:46'),
(2, 1, '2018-09-21 15:13:46'),
(2, 1, '2018-09-21 15:13:47'),
(2, 1, '2018-09-21 15:13:48'),
(2, 1, '2018-09-21 15:13:49'),
(2, 1, '2018-09-21 15:13:51'),
(2, 1, '2018-09-21 15:13:53'),
(2, 1, '2018-09-21 15:13:55'),
(2, 1, '2018-09-21 15:13:57'),
(2, 1, '2018-09-21 15:37:19'),
(2, 1, '2018-09-21 15:37:58'),
(2, 1, '2018-09-21 15:38:02'),
(2, 1, '2018-09-21 15:38:05'),
(2, 1, '2018-09-21 15:38:08'),
(2, 1, '2018-09-21 15:38:10'),
(2, 1, '2018-09-21 15:38:14'),
(2, 1, '2018-09-21 15:38:18'),
(2, 1, '2018-09-21 15:38:40'),
(2, 1, '2018-09-21 15:38:45'),
(2, 1, '2018-09-21 15:38:47'),
(2, 1, '2018-09-21 15:38:59'),
(2, 1, '2018-09-21 15:39:01'),
(2, 1, '2018-09-21 15:39:04'),
(2, 1, '2018-09-21 15:39:06'),
(2, 1, '2018-09-21 15:39:09'),
(2, 1, '2018-09-21 15:39:46'),
(2, 1, '2018-09-21 15:40:09'),
(2, 1, '2018-09-21 15:40:10'),
(2, 1, '2018-09-21 15:40:12'),
(2, 1, '2018-09-21 15:40:14'),
(2, 1, '2018-09-21 15:40:17'),
(2, 1, '2018-09-21 15:40:18'),
(2, 1, '2018-09-21 15:40:20'),
(2, 1, '2018-09-21 15:40:23'),
(2, 1, '2018-09-21 15:40:25'),
(2, 1, '2018-09-21 15:40:28'),
(2, 1, '2018-09-21 15:40:29'),
(2, 1, '2018-09-21 15:40:30'),
(2, 1, '2018-09-21 15:40:31'),
(2, 1, '2018-09-21 15:40:32'),
(2, 1, '2018-09-21 15:41:25'),
(2, 1, '2018-09-21 15:41:34'),
(2, 1, '2018-09-21 15:41:39'),
(2, 1, '2018-09-21 15:41:40'),
(2, 1, '2018-09-21 15:42:30'),
(2, 1, '2018-09-21 15:42:40'),
(2, 1, '2018-09-21 15:43:14'),
(2, 1, '2018-09-21 15:43:30'),
(2, 1, '2018-09-21 15:44:11'),
(2, 1, '2018-09-21 15:44:13'),
(2, 1, '2018-09-21 15:44:59'),
(1, 2, '2018-09-21 15:45:06'),
(1, 2, '2018-09-22 10:05:53'),
(1, 2, '2018-09-22 10:06:51'),
(1, 2, '2018-09-22 10:09:23'),
(7, 8, '2018-09-22 11:16:06'),
(1, 2, '2018-09-22 12:46:57'),
(1, 7, '2018-09-22 12:47:39'),
(7, 1, '2018-09-22 12:50:26'),
(7, 1, '2018-09-22 12:50:36'),
(2, 1, '2018-09-22 12:50:58'),
(2, 1, '2018-09-22 12:51:21'),
(1, 2, '2018-09-22 12:53:42'),
(1, 2, '2018-09-22 12:53:57'),
(2, 1, '2018-09-22 12:54:11'),
(1, 7, '2018-09-22 12:55:13'),
(1, 7, '2018-09-22 12:57:41'),
(7, 1, '2018-09-22 12:57:53'),
(2, 1, '2018-09-22 12:57:59'),
(2, 1, '2018-09-22 12:58:05'),
(7, 20, '2018-09-22 12:58:41'),
(20, 7, '2018-09-22 12:58:56'),
(7, 20, '2018-09-22 12:59:05'),
(2, 1, '2018-09-22 13:13:29'),
(18, 7, '2018-09-22 13:13:34'),
(7, 1, '2018-09-22 13:38:59'),
(2, 1, '2018-09-22 13:39:01'),
(7, 1, '2018-09-22 16:21:54'),
(7, 1, '2018-09-22 16:21:57'),
(7, 1, '2018-09-22 16:22:03'),
(7, 1, '2018-09-22 16:22:07'),
(7, 1, '2018-09-22 16:23:17'),
(11, 3, '2018-09-22 16:39:15'),
(15, 3, '2018-09-22 16:48:25'),
(19, 3, '2018-09-25 12:14:15'),
(19, 3, '2018-09-25 12:14:20'),
(14, 3, '2018-09-25 18:36:50'),
(5, 3, '2018-09-26 09:57:55'),
(15, 3, '2018-09-26 10:51:07'),
(6, 3, '2018-09-26 11:22:56'),
(6, 3, '2018-09-26 11:29:48'),
(6, 3, '2018-09-26 11:30:09'),
(6, 3, '2018-09-26 11:31:07'),
(6, 3, '2018-09-26 11:32:14'),
(6, 3, '2018-09-26 11:38:02'),
(6, 3, '2018-09-26 11:40:54'),
(17, 3, '2018-09-26 11:59:38'),
(12, 3, '2018-09-26 11:59:49'),
(9, 3, '2018-09-26 12:07:03'),
(18, 3, '2018-09-26 12:13:15'),
(3, 10, '2018-09-26 12:20:30'),
(3, 10, '2018-09-26 12:21:44'),
(10, 3, '2018-09-26 12:22:01'),
(10, 3, '2018-09-26 12:22:13'),
(3, 10, '2018-09-26 12:22:55'),
(3, 10, '2018-09-26 12:23:49'),
(3, 10, '2018-09-26 12:23:57'),
(10, 3, '2018-09-26 12:24:00'),
(10, 3, '2018-09-26 12:24:13'),
(3, 10, '2018-09-26 12:24:16'),
(3, 10, '2018-09-26 12:24:59'),
(3, 10, '2018-09-26 12:25:39'),
(3, 10, '2018-09-26 12:25:45'),
(3, 10, '2018-09-26 12:26:31'),
(3, 10, '2018-09-26 12:26:34'),
(3, 10, '2018-09-26 12:26:38'),
(3, 10, '2018-09-26 12:27:19'),
(3, 10, '2018-09-26 12:28:19'),
(3, 10, '2018-09-26 12:28:25'),
(3, 10, '2018-09-26 12:28:51'),
(3, 10, '2018-09-26 12:29:02'),
(3, 10, '2018-09-26 12:30:27'),
(3, 10, '2018-09-26 12:31:02'),
(3, 10, '2018-09-26 12:31:04'),
(3, 10, '2018-09-26 12:31:07'),
(3, 10, '2018-09-26 12:31:22'),
(3, 10, '2018-09-26 12:31:26'),
(3, 10, '2018-09-26 12:31:28'),
(3, 1, '2018-09-26 12:33:43'),
(3, 10, '2018-09-26 12:40:25'),
(3, 10, '2018-09-26 12:40:36'),
(3, 10, '2018-09-26 12:40:42'),
(3, 10, '2018-09-26 12:52:10'),
(3, 10, '2018-09-26 12:52:21'),
(3, 1, '2018-09-26 12:54:19'),
(1, 3, '2018-09-26 12:54:25'),
(10, 3, '2018-09-26 13:01:29'),
(10, 3, '2018-09-26 13:02:11'),
(1, 3, '2018-09-26 13:04:30'),
(3, 1, '2018-09-26 13:04:59'),
(1, 3, '2018-09-26 13:05:04'),
(3, 1, '2018-09-26 13:23:15'),
(1, 3, '2018-09-26 13:34:53'),
(3, 1, '2018-09-26 13:35:02'),
(3, 1, '2018-09-26 13:35:20'),
(2, 1, '2018-09-27 12:09:08'),
(2, 1, '2018-09-27 12:10:05'),
(15, 1, '2018-09-27 18:23:17'),
(19, 1, '2018-09-27 18:23:28'),
(2, 1, '2018-09-27 18:23:34'),
(2, 1, '2018-09-27 19:05:19'),
(3, 1, '2018-09-28 09:20:17'),
(3, 1, '2018-09-28 10:00:23'),
(3, 1, '2018-09-28 10:00:34'),
(3, 1, '2018-09-28 10:03:37'),
(3, 1, '2018-09-28 10:04:24'),
(3, 1, '2018-09-28 10:04:41'),
(3, 1, '2018-09-28 10:04:51'),
(3, 1, '2018-09-28 10:06:15'),
(3, 1, '2018-09-28 10:06:28'),
(3, 1, '2018-09-28 10:07:07'),
(3, 1, '2018-09-28 10:07:18'),
(3, 1, '2018-09-28 10:08:30'),
(3, 1, '2018-09-28 10:08:42'),
(3, 1, '2018-09-28 10:12:06'),
(3, 1, '2018-09-28 10:12:18'),
(3, 1, '2018-09-28 10:12:41'),
(3, 1, '2018-09-28 10:12:44'),
(3, 1, '2018-09-28 10:15:32'),
(3, 1, '2018-09-28 10:16:02'),
(3, 1, '2018-09-28 10:16:20'),
(3, 1, '2018-09-28 10:17:33'),
(3, 1, '2018-09-28 10:17:52'),
(3, 1, '2018-09-28 10:18:08'),
(1, 3, '2018-09-28 10:18:12'),
(1, 3, '2018-09-28 10:18:24'),
(3, 1, '2018-09-28 10:23:27'),
(3, 1, '2018-09-28 10:24:51'),
(1, 3, '2018-09-28 10:24:53'),
(3, 1, '2018-09-28 10:24:59'),
(1, 3, '2018-09-28 10:25:02'),
(1, 3, '2018-09-28 10:25:13'),
(3, 1, '2018-09-28 10:25:15'),
(3, 1, '2018-09-28 10:25:28'),
(1, 3, '2018-09-28 10:25:39'),
(1, 3, '2018-09-28 10:30:38'),
(3, 1, '2018-09-28 10:30:47'),
(2, 1, '2018-09-28 11:44:18'),
(10, 1, '2018-09-28 15:25:53'),
(3, 1, '2018-10-01 11:56:42'),
(2, 1, '2018-10-01 12:01:22'),
(2, 1, '2018-10-01 20:43:20'),
(2, 1, '2018-10-02 13:48:33'),
(2, 1, '2018-10-02 17:31:47'),
(2, 1, '2018-10-02 17:32:05'),
(2, 1, '2018-10-02 17:32:19'),
(2, 1, '2018-10-02 17:32:59'),
(2, 1, '2018-10-02 17:35:02'),
(2, 1, '2018-10-02 17:35:17'),
(2, 1, '2018-10-02 17:37:24'),
(2, 1, '2018-10-02 17:37:39'),
(2, 1, '2018-10-02 17:38:21'),
(2, 1, '2018-10-02 17:38:38'),
(2, 1, '2018-10-02 17:38:43'),
(2, 1, '2018-10-02 17:39:50'),
(2, 1, '2018-10-02 17:40:41'),
(2, 1, '2018-10-02 17:41:02'),
(2, 1, '2018-10-02 17:42:00'),
(2, 1, '2018-10-02 17:42:10'),
(2, 1, '2018-10-02 17:43:22'),
(2, 1, '2018-10-02 17:43:33'),
(2, 1, '2018-10-02 17:43:40'),
(2, 1, '2018-10-02 17:44:15'),
(2, 1, '2018-10-02 17:46:29'),
(2, 1, '2018-10-02 17:46:33'),
(2, 1, '2018-10-02 17:48:11'),
(2, 1, '2018-10-02 17:48:42'),
(2, 1, '2018-10-02 17:49:38'),
(2, 1, '2018-10-02 17:55:33'),
(2, 1, '2018-10-02 17:56:27'),
(2, 1, '2018-10-02 17:56:57'),
(2, 1, '2018-10-02 17:58:14'),
(2, 1, '2018-10-02 17:58:23'),
(2, 1, '2018-10-02 17:59:21'),
(2, 1, '2018-10-02 17:59:28'),
(2, 1, '2018-10-02 17:59:49'),
(2, 1, '2018-10-02 18:00:20'),
(2, 1, '2018-10-02 18:00:42'),
(2, 1, '2018-10-02 18:00:45'),
(2, 1, '2018-10-02 18:22:26'),
(2, 1, '2018-10-02 18:22:53'),
(2, 1, '2018-10-02 18:24:17'),
(1, 2, '2018-10-02 18:24:27');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users_appearance`
--
ALTER TABLE `users_appearance`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users_background`
--
ALTER TABLE `users_background`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users_basic_info`
--
ALTER TABLE `users_basic_info`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users_description`
--
ALTER TABLE `users_description`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users_files_upload`
--
ALTER TABLE `users_files_upload`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users_lifestyle`
--
ALTER TABLE `users_lifestyle`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users_location`
--
ALTER TABLE `users_location`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users_pictures`
--
ALTER TABLE `users_pictures`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=124;

--
-- AUTO_INCREMENT для таблицы `users_appearance`
--
ALTER TABLE `users_appearance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT для таблицы `users_background`
--
ALTER TABLE `users_background`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT для таблицы `users_basic_info`
--
ALTER TABLE `users_basic_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT для таблицы `users_description`
--
ALTER TABLE `users_description`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT для таблицы `users_files_upload`
--
ALTER TABLE `users_files_upload`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT для таблицы `users_lifestyle`
--
ALTER TABLE `users_lifestyle`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT для таблицы `users_location`
--
ALTER TABLE `users_location`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT для таблицы `users_pictures`
--
ALTER TABLE `users_pictures`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
