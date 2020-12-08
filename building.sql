-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 08, 2020 at 03:04 PM
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
-- Database: `building`
--

-- --------------------------------------------------------

--
-- Table structure for table `бонусные_карты`
--

CREATE TABLE `бонусные_карты` (
  `Код_карты` int(11) NOT NULL,
  `Дата_начала` date NOT NULL,
  `Дата_окончания` date NOT NULL,
  `Бонусы` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `бонусные_карты`
--

INSERT INTO `бонусные_карты` (`Код_карты`, `Дата_начала`, `Дата_окончания`, `Бонусы`) VALUES
(1, '2018-03-05', '2020-03-05', 221),
(2, '2019-01-01', '2021-01-01', 92),
(3, '2017-11-03', '2020-11-03', 192),
(4, '2018-01-01', '2021-01-01', 453),
(5, '2019-03-05', '2021-03-05', 0),
(6, '2019-07-14', '2023-07-14', 23);

-- --------------------------------------------------------

--
-- Table structure for table `бригады`
--

CREATE TABLE `бригады` (
  `Код_бригады` int(11) NOT NULL,
  `Наименование` varchar(50) NOT NULL,
  `Код_бригадира` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `бригады`
--

INSERT INTO `бригады` (`Код_бригады`, `Наименование`, `Код_бригадира`) VALUES
(1, 'Витязь', 1),
(2, 'Молния', 6),
(3, 'Богатырь', 3);

-- --------------------------------------------------------

--
-- Table structure for table `должности`
--

CREATE TABLE `должности` (
  `Код_должности` int(11) NOT NULL,
  `Наименование` varchar(50) NOT NULL,
  `Описание` varchar(150) NOT NULL,
  `Зарплата` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `должности`
--

INSERT INTO `должности` (`Код_должности`, `Наименование`, `Описание`, `Зарплата`) VALUES
(1, 'Электрик', 'Выполняет работу с электрикой', 50000),
(2, 'Системный администратор', 'Обеспечивает работу компьютерной техники', 20000),
(3, 'Оператор Call-центра', 'Обслуживает поступающие звонки', 20000),
(4, 'Маляр', 'Выполняет малярные работы', 15000),
(5, 'Руководитель', 'Руководит процессом компании', 70000),
(6, 'Разнорабочий', 'Выполняет работы различного рода', 30000);

-- --------------------------------------------------------

--
-- Table structure for table `заказы`
--

CREATE TABLE `заказы` (
  `Код_заказа` int(11) NOT NULL,
  `Код_клиента` int(11) NOT NULL,
  `Код_услуги` int(11) NOT NULL,
  `Код_сотрудника` int(11) NOT NULL,
  `Адрес` varchar(100) NOT NULL,
  `Количество` int(11) NOT NULL,
  `Дата_начала` date NOT NULL,
  `Дата_окончания` date NOT NULL,
  `Стоимость` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `заказы`
--

INSERT INTO `заказы` (`Код_заказа`, `Код_клиента`, `Код_услуги`, `Код_сотрудника`, `Адрес`, `Количество`, `Дата_начала`, `Дата_окончания`, `Стоимость`) VALUES
(1, 3, 11, 1, 'ул.Борисова д.3', 4, '2019-12-30', '2019-12-30', 1200),
(2, 4, 2, 2, 'ул.Жидилова д.27', 20, '2020-01-06', '2020-01-06', 3000),
(3, 6, 7, 2, 'ул.Лебедя д.22', 2, '2020-03-01', '2020-03-01', 2500),
(4, 5, 3, 3, 'Очаковцев д.7', 4, '2018-03-05', '2018-03-05', 1200),
(5, 11, 11, 4, 'Ул.Очаковцев д.56', 5, '2018-01-07', '2018-01-07', 5400);

-- --------------------------------------------------------

--
-- Table structure for table `клиенты`
--

CREATE TABLE `клиенты` (
  `Код_клиента` int(11) NOT NULL,
  `Фамилия` varchar(30) NOT NULL,
  `Имя` varchar(30) NOT NULL,
  `Отчество` varchar(30) NOT NULL,
  `Дата_рождения` date NOT NULL,
  `Пол` char(1) NOT NULL,
  `Телефон` varchar(12) NOT NULL,
  `Код_карты` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `клиенты`
--

INSERT INTO `клиенты` (`Код_клиента`, `Фамилия`, `Имя`, `Отчество`, `Дата_рождения`, `Пол`, `Телефон`, `Код_карты`) VALUES
(3, 'Сергеев', 'Никита', 'Алексеевич', '1994-04-12', 'м', '+7978123321', 1),
(4, 'Иванов', 'Пётр', 'Борисович', '1992-01-01', 'м', '+79781975434', NULL),
(5, 'Риденко', 'Геннадий', 'Павлович', '1993-01-05', 'м', '+79788864323', 2),
(6, 'Иванова', 'Маргарита ', 'Павловна', '1993-03-04', 'ж', '+79788492251', NULL),
(7, 'Подкорытова', 'Ирина', 'Павловна', '1999-03-04', 'ж', '+79781975434', 1),
(9, 'Михайлюк', 'Ирина', 'Вадимовна', '1995-01-09', 'ж', '+7978123321', 4),
(11, 'Бопп', 'Игорь', 'Семенович', '1984-02-10', 'м', '+79788492251', 6),
(13, 'Жорин', 'Пётр', 'Васильевич', '1989-03-09', 'м', '+7978123321', 5);

-- --------------------------------------------------------

--
-- Table structure for table `сотрудники`
--

CREATE TABLE `сотрудники` (
  `Код_сотрудника` int(11) NOT NULL,
  `Фамилия` varchar(30) NOT NULL,
  `Имя` varchar(30) NOT NULL,
  `Отчество` varchar(30) NOT NULL,
  `Пол` char(1) NOT NULL,
  `Телефон` varchar(12) NOT NULL,
  `Адрес` varchar(100) NOT NULL,
  `Дата_найма` date NOT NULL,
  `Дата_рождения` date NOT NULL,
  `Код_должности` int(11) NOT NULL,
  `Код_бригады` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `сотрудники`
--

INSERT INTO `сотрудники` (`Код_сотрудника`, `Фамилия`, `Имя`, `Отчество`, `Пол`, `Телефон`, `Адрес`, `Дата_найма`, `Дата_рождения`, `Код_должности`, `Код_бригады`) VALUES
(1, 'Волосовец', 'Владислав', 'Витальевич', 'м', '+7978123321', 'ул.Шевченко д.46', '2019-09-01', '2001-08-14', 2, 3),
(2, 'Бородин ', 'Родион', 'Владиславович', 'м', '+79781975434', 'пр.Острякова д.30', '2018-11-03', '1989-03-09', 5, 3),
(3, 'Семёнова ', 'Алла', 'Анатольевна', 'ж', '+79788864323', 'ул.Мичурина д.15', '2018-11-03', '1992-12-09', 3, 1),
(6, 'Петров', 'Иван', 'Васильевич', 'м', '+79788492251', 'ул.Шевченко д.7', '2019-03-11', '1989-06-11', 6, 2),
(11, 'Редекоп', 'Андрей', 'Викторович', 'м', '+7978123321', 'ул.Хрюкина', '2019-01-08', '1994-04-06', 1, 1),
(12, 'Дементьев', 'Игорь', 'Алексеевич', 'м', '+79781975434', 'ул.Ленина д.6', '2019-10-05', '1994-04-12', 3, 2);

-- --------------------------------------------------------

--
-- Table structure for table `специализация`
--

CREATE TABLE `специализация` (
  `Код_сотрудника` int(11) NOT NULL,
  `Код_услуги` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `специализация`
--

INSERT INTO `специализация` (`Код_сотрудника`, `Код_услуги`) VALUES
(2, 1),
(3, 1),
(1, 2),
(6, 2),
(12, 3),
(2, 7),
(6, 7),
(12, 7),
(1, 11),
(11, 11);

-- --------------------------------------------------------

--
-- Table structure for table `услуги`
--

CREATE TABLE `услуги` (
  `Код_услуги` int(11) NOT NULL,
  `Наименование` varchar(50) NOT NULL,
  `Ед_измерения` varchar(20) NOT NULL,
  `Стоимость` int(11) NOT NULL,
  `Описание` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `услуги`
--

INSERT INTO `услуги` (`Код_услуги`, `Наименование`, `Ед_измерения`, `Стоимость`, `Описание`) VALUES
(1, 'Поклейка обоев', 'м2', 210, 'Поклейка обоев в жилых помещениях'),
(2, 'Установка светильников', 'шт', 400, 'Установка светильников и люстр в жилых помещениях'),
(3, 'Укладка ламината', 'м2', 180, 'Установка ламинированного покрытия в помещениях'),
(7, 'Демонтаж ламината', 'м2', 70, 'Демонтаж ламината'),
(11, 'Установка выключателей', 'шт', 259, 'Установка и демонтаж выключателей');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `бонусные_карты`
--
ALTER TABLE `бонусные_карты`
  ADD PRIMARY KEY (`Код_карты`);

--
-- Indexes for table `бригады`
--
ALTER TABLE `бригады`
  ADD PRIMARY KEY (`Код_бригады`),
  ADD KEY `FK_Team_Worker` (`Код_бригадира`);

--
-- Indexes for table `должности`
--
ALTER TABLE `должности`
  ADD PRIMARY KEY (`Код_должности`);

--
-- Indexes for table `заказы`
--
ALTER TABLE `заказы`
  ADD PRIMARY KEY (`Код_заказа`),
  ADD KEY `FK_Order_Client` (`Код_клиента`),
  ADD KEY `FK_Order_Service` (`Код_услуги`);

--
-- Indexes for table `клиенты`
--
ALTER TABLE `клиенты`
  ADD PRIMARY KEY (`Код_клиента`),
  ADD KEY `FK_Client_Card` (`Код_карты`);

--
-- Indexes for table `сотрудники`
--
ALTER TABLE `сотрудники`
  ADD PRIMARY KEY (`Код_сотрудника`),
  ADD KEY `FK_Worker_Position` (`Код_должности`),
  ADD KEY `FK_Worker_Team` (`Код_бригады`);

--
-- Indexes for table `специализация`
--
ALTER TABLE `специализация`
  ADD PRIMARY KEY (`Код_сотрудника`,`Код_услуги`),
  ADD KEY `Код_услуги` (`Код_услуги`);

--
-- Indexes for table `услуги`
--
ALTER TABLE `услуги`
  ADD PRIMARY KEY (`Код_услуги`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `бонусные_карты`
--
ALTER TABLE `бонусные_карты`
  MODIFY `Код_карты` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `бригады`
--
ALTER TABLE `бригады`
  MODIFY `Код_бригады` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `должности`
--
ALTER TABLE `должности`
  MODIFY `Код_должности` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `заказы`
--
ALTER TABLE `заказы`
  MODIFY `Код_заказа` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `клиенты`
--
ALTER TABLE `клиенты`
  MODIFY `Код_клиента` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `сотрудники`
--
ALTER TABLE `сотрудники`
  MODIFY `Код_сотрудника` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `услуги`
--
ALTER TABLE `услуги`
  MODIFY `Код_услуги` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `бригады`
--
ALTER TABLE `бригады`
  ADD CONSTRAINT `FK_Team_Worker` FOREIGN KEY (`Код_бригадира`) REFERENCES `сотрудники` (`Код_сотрудника`) ON UPDATE CASCADE;

--
-- Constraints for table `заказы`
--
ALTER TABLE `заказы`
  ADD CONSTRAINT `FK_Order_Client` FOREIGN KEY (`Код_клиента`) REFERENCES `клиенты` (`Код_клиента`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Order_Service` FOREIGN KEY (`Код_услуги`) REFERENCES `услуги` (`Код_услуги`) ON UPDATE CASCADE;

--
-- Constraints for table `клиенты`
--
ALTER TABLE `клиенты`
  ADD CONSTRAINT `FK_Client_Card` FOREIGN KEY (`Код_карты`) REFERENCES `бонусные_карты` (`Код_карты`) ON UPDATE CASCADE;

--
-- Constraints for table `сотрудники`
--
ALTER TABLE `сотрудники`
  ADD CONSTRAINT `FK_Worker_Position` FOREIGN KEY (`Код_должности`) REFERENCES `должности` (`Код_должности`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Worker_Team` FOREIGN KEY (`Код_бригады`) REFERENCES `бригады` (`Код_бригады`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `специализация`
--
ALTER TABLE `специализация`
  ADD CONSTRAINT ` FK_Specialization_Service` FOREIGN KEY (`Код_услуги`) REFERENCES `услуги` (`Код_услуги`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Specialization_Worker` FOREIGN KEY (`Код_сотрудника`) REFERENCES `сотрудники` (`Код_сотрудника`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
