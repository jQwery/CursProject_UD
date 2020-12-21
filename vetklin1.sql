-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 21, 2020 at 01:05 PM
-- Server version: 5.7.24
-- PHP Version: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vetklin1`
--

-- --------------------------------------------------------

--
-- Table structure for table `должности`
--

CREATE TABLE `должности` (
  `Код_должности` int(11) NOT NULL,
  `Название` varchar(50) NOT NULL,
  `Описание` varchar(150) NOT NULL,
  `З/П` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `должности`
--

INSERT INTO `должности` (`Код_должности`, `Название`, `Описание`, `З/П`) VALUES
(1, 'Глав-врач', 'Главный врач в ветклинике, ответственный за все дела, касающиеся здоровья питомцев', 50000),
(2, 'Мед.сестра', 'Всегда помогает врачу, состоит в его команде. На операциях сама присутствовать не может. Может выполнять простые процедуры.', 20000),
(3, 'Санитар', 'Занимается вопросами стерильности всех приборов и поверхностей в кабинете, при необходимости приносит все необходимое в палату', 15000),
(4, 'Дежурный врач', 'Врач, который работает посменно, следит за общим состоянием питомцев, при необходимости может резко внести коррективы в план лечения', 40000),
(5, 'Стажер', 'Только учится и набирается опыта, опираться на него нельзя', 5000),
(6, 'Дежурная мед-сестра', 'Дежурит совместно с дежурным врачем', 20000);

-- --------------------------------------------------------

--
-- Table structure for table `команды_врачей`
--

CREATE TABLE `команды_врачей` (
  `Код_команды` int(11) NOT NULL,
  `Название` varchar(50) NOT NULL,
  `Код_врача` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `команды_врачей`
--

INSERT INTO `команды_врачей` (`Код_команды`, `Название`, `Код_врача`) VALUES
(1, 'Дневная', 1),
(2, 'Дежурная', 4);

-- --------------------------------------------------------

--
-- Table structure for table `питомцы`
--

CREATE TABLE `питомцы` (
  `Код_питомца` int(11) NOT NULL,
  `Порода` varchar(30) NOT NULL,
  `Кличка` varchar(30) NOT NULL,
  `Возраст` varchar(30) NOT NULL,
  `Пол` char(1) NOT NULL,
  `Фамилия_хозяина` varchar(15) NOT NULL,
  `Имя_хозяина` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `питомцы`
--

INSERT INTO `питомцы` (`Код_питомца`, `Порода`, `Кличка`, `Возраст`, `Пол`, `Фамилия_хозяина`, `Имя_хозяина`) VALUES
(1, 'Бобер', 'Бони', '1мес.', 'м', 'Волосовец', 'Даниил'),
(2, 'Кошка', 'Кнопка', '4 года', 'ж', 'Игорев', 'Денис'),
(3, 'Собака', 'Босс', '3 месяца', 'м', 'Акулов', 'Александр'),
(4, 'Попугай', 'Кеша', '2 месяца', 'м', 'Ахрипов', 'Вадим'),
(6, 'Хомяк', 'Хрю', '4 месяца', 'м', 'Иванов', 'Виктор'),
(7, 'Собака', 'Жук', '2 года', 'м', 'Игорева', 'Люся'),
(99, 'Собака', 'Фас', '2 месяца', 'ж', 'Варина', 'Наташа');

-- --------------------------------------------------------

--
-- Table structure for table `сотрудники_клиники`
--

CREATE TABLE `сотрудники_клиники` (
  `Код_врача` int(11) NOT NULL,
  `Фамилия` varchar(30) NOT NULL,
  `Имя` varchar(30) NOT NULL,
  `Отчество` varchar(30) NOT NULL,
  `Пол` char(1) NOT NULL,
  `Телефон` varchar(12) NOT NULL,
  `Адрес` varchar(100) NOT NULL,
  `Дата_приема` date NOT NULL,
  `Дата_рождения` date NOT NULL,
  `Код_должности` int(11) NOT NULL,
  `Код_команды` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `сотрудники_клиники`
--

INSERT INTO `сотрудники_клиники` (`Код_врача`, `Фамилия`, `Имя`, `Отчество`, `Пол`, `Телефон`, `Адрес`, `Дата_приема`, `Дата_рождения`, `Код_должности`, `Код_команды`) VALUES
(1, 'Иванов', 'Виктор', 'Степанович', 'м', '+7978123321', 'Ульянова 16', '2020-12-01', '1994-04-12', 1, 1),
(2, 'Маринина', 'Виталина', 'Олеговна', 'ж', '+79788492251', 'Степаняна 8', '2020-11-21', '1989-03-09', 2, 1),
(3, 'Казаков', 'Арсен', 'Велиевич', 'м', '+79788864323', 'Хохлова 23', '2020-11-25', '1994-04-06', 3, 1),
(4, 'Петров', 'Пётр', 'Васильевич', 'м', '+79781975434', 'Иванова 54', '2020-11-25', '1992-12-09', 4, 2),
(5, 'Семёнова ', 'Алла', 'Павловна', 'ж', '+7978123321', 'Вокаренко 55', '2020-11-01', '1989-06-11', 6, 2),
(6, 'Бородин ', 'Родион', 'Владиславович', 'м', '+79781233244', 'Шевченко 46', '2020-12-25', '2001-05-14', 5, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `специализация_врачей`
--

CREATE TABLE `специализация_врачей` (
  `Код_врача` int(11) NOT NULL,
  `Код_услуги` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `специализация_врачей`
--

INSERT INTO `специализация_врачей` (`Код_врача`, `Код_услуги`) VALUES
(1, 1),
(4, 1),
(1, 2),
(4, 2),
(1, 3),
(2, 3),
(4, 3),
(5, 3),
(1, 4),
(2, 4),
(2, 5),
(5, 5),
(1, 6);

-- --------------------------------------------------------

--
-- Table structure for table `список_услуг`
--

CREATE TABLE `список_услуг` (
  `Код_услуги` int(11) NOT NULL,
  `Наименование` varchar(50) NOT NULL,
  `Стоимость` int(10) NOT NULL,
  `Длительность` int(10) NOT NULL,
  `Описание` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `список_услуг`
--

INSERT INTO `список_услуг` (`Код_услуги`, `Наименование`, `Стоимость`, `Длительность`, `Описание`) VALUES
(1, 'Стрижка', 3000, 100, 'Стрижка на любой вкус'),
(2, 'Срочная операция', 5000, 200, 'Срочное операционное вмешательство'),
(3, 'Прививка', 500, 10, 'Прививание от всего'),
(4, 'Вывод блох', 700, 50, 'Вывод всех маленьких тварей'),
(5, 'Удаление когтей', 1200, 200, 'ПОд наркозом удаляем ноготки'),
(6, 'Улучшение сдоровья', 4000, 300, 'Набор процедур для повышения всех показателей здоровья');

-- --------------------------------------------------------

--
-- Table structure for table `текущие_услуги`
--

CREATE TABLE `текущие_услуги` (
  `Код_текущей_услуги` int(11) NOT NULL,
  `Код_птомца` int(11) NOT NULL,
  `Код_услуги` int(11) NOT NULL,
  `Код_команды` int(11) NOT NULL,
  `Кабинет` varchar(100) NOT NULL,
  `Дата_сеанса` date NOT NULL,
  `Длительность` varchar(5) NOT NULL,
  `Стоимость` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `текущие_услуги`
--

INSERT INTO `текущие_услуги` (`Код_текущей_услуги`, `Код_птомца`, `Код_услуги`, `Код_команды`, `Кабинет`, `Дата_сеанса`, `Длительность`, `Стоимость`) VALUES
(1, 2, 4, 1, '34', '2020-12-20', '1 час', 1200),
(2, 1, 3, 2, '22', '2020-12-20', '10 м.', 400),
(3, 3, 1, 1, '34', '2020-12-22', '2 час', 3000),
(4, 4, 2, 2, '11', '2020-12-20', '1 час', 1000),
(5, 99, 6, 2, '34', '2020-12-21', '5 час', 5000),
(6, 6, 3, 1, '22', '2020-12-21', '10 м.', 210);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `должности`
--
ALTER TABLE `должности`
  ADD PRIMARY KEY (`Код_должности`);

--
-- Indexes for table `команды_врачей`
--
ALTER TABLE `команды_врачей`
  ADD PRIMARY KEY (`Код_команды`),
  ADD KEY `FK_Team_Worker` (`Код_врача`);

--
-- Indexes for table `питомцы`
--
ALTER TABLE `питомцы`
  ADD PRIMARY KEY (`Код_питомца`);

--
-- Indexes for table `сотрудники_клиники`
--
ALTER TABLE `сотрудники_клиники`
  ADD PRIMARY KEY (`Код_врача`),
  ADD KEY `FK_Worker_Position` (`Код_должности`),
  ADD KEY `FK_Worker_Team` (`Код_команды`);

--
-- Indexes for table `специализация_врачей`
--
ALTER TABLE `специализация_врачей`
  ADD PRIMARY KEY (`Код_врача`,`Код_услуги`),
  ADD KEY `Код_услуги` (`Код_услуги`);

--
-- Indexes for table `список_услуг`
--
ALTER TABLE `список_услуг`
  ADD PRIMARY KEY (`Код_услуги`);

--
-- Indexes for table `текущие_услуги`
--
ALTER TABLE `текущие_услуги`
  ADD PRIMARY KEY (`Код_текущей_услуги`),
  ADD KEY `FK_Order_Client` (`Код_птомца`),
  ADD KEY `FK_Order_Service` (`Код_услуги`),
  ADD KEY `FK_Order_Team` (`Код_команды`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `должности`
--
ALTER TABLE `должности`
  MODIFY `Код_должности` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `команды_врачей`
--
ALTER TABLE `команды_врачей`
  MODIFY `Код_команды` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `питомцы`
--
ALTER TABLE `питомцы`
  MODIFY `Код_питомца` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `сотрудники_клиники`
--
ALTER TABLE `сотрудники_клиники`
  MODIFY `Код_врача` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `список_услуг`
--
ALTER TABLE `список_услуг`
  MODIFY `Код_услуги` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `текущие_услуги`
--
ALTER TABLE `текущие_услуги`
  MODIFY `Код_текущей_услуги` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `команды_врачей`
--
ALTER TABLE `команды_врачей`
  ADD CONSTRAINT `FK_Team_Worker` FOREIGN KEY (`Код_врача`) REFERENCES `сотрудники_клиники` (`Код_врача`) ON UPDATE CASCADE;

--
-- Constraints for table `сотрудники_клиники`
--
ALTER TABLE `сотрудники_клиники`
  ADD CONSTRAINT `FK_Worker_Position` FOREIGN KEY (`Код_должности`) REFERENCES `должности` (`Код_должности`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Worker_Team` FOREIGN KEY (`Код_команды`) REFERENCES `команды_врачей` (`Код_команды`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `специализация_врачей`
--
ALTER TABLE `специализация_врачей`
  ADD CONSTRAINT ` FK_Specialization_Service` FOREIGN KEY (`Код_услуги`) REFERENCES `список_услуг` (`Код_услуги`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Specialization_Worker` FOREIGN KEY (`Код_врача`) REFERENCES `сотрудники_клиники` (`Код_врача`) ON UPDATE CASCADE;

--
-- Constraints for table `текущие_услуги`
--
ALTER TABLE `текущие_услуги`
  ADD CONSTRAINT `FK_Order_Client` FOREIGN KEY (`Код_птомца`) REFERENCES `питомцы` (`Код_питомца`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Order_Service` FOREIGN KEY (`Код_услуги`) REFERENCES `список_услуг` (`Код_услуги`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Order_Team` FOREIGN KEY (`Код_команды`) REFERENCES `команды_врачей` (`Код_команды`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
