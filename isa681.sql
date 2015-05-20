-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: May 06, 2015 at 11:04 PM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `isa681`
--

-- --------------------------------------------------------

--
-- Table structure for table `correctwords`
--

CREATE TABLE IF NOT EXISTS `correctwords` (
  `Id` int(255) NOT NULL AUTO_INCREMENT,
  `correctword` text NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=128 ;

--
-- Dumping data for table `correctwords`
--

INSERT INTO `correctwords` (`Id`, `correctword`) VALUES
(18, 'Elephant'),
(19, 'Lephant'),
(20, 'Lmphant'),
(21, 'mlphant'),
(22, 'Sumar'),
(23, 'Aumar'),
(24, 'Numar'),
(25, 'Rumar'),
(26, 'Pumar'),
(27, 'Dumar'),
(28, 'Zumar'),
(29, 'Omar'),
(30, 'Bumar'),
(31, 'Xumar'),
(32, 'Jumar'),
(33, 'Fumar'),
(34, 'Yumar'),
(35, 'Uumar'),
(36, 'Tumar'),
(37, 'Aman'),
(38, 'Amar'),
(39, 'Juman'),
(40, 'Junam'),
(41, 'Junm'),
(42, 'Umar'),
(43, 'Imar'),
(44, 'Imaru'),
(45, 'Amar'),
(46, 'Amar'),
(47, 'Amanu'),
(48, 'Ama'),
(49, 'Amaa'),
(50, 'Amaaa'),
(51, 'Amaaaa'),
(52, 'Ruma'),
(53, 'Rumaa'),
(54, 'Rumaaa'),
(55, 'Rumaaaa'),
(56, 'Rumaaaaa'),
(57, 'Rumaaaaaa'),
(58, 'Duma'),
(59, 'Dum'),
(60, 'Bumaa'),
(61, 'Vumar'),
(62, 'Vmar'),
(63, 'Vmarr'),
(64, 'Vmarrr'),
(65, 'Vmarrrr'),
(66, 'Vmarrrrr'),
(67, 'Vmarrrrrr'),
(68, 'Cumar'),
(69, 'Cumar'),
(70, 'Cumarr'),
(71, 'Cumarrr'),
(72, 'Cumarrrr'),
(73, 'Cumarrrrr'),
(74, 'Cumarrrrrr'),
(75, 'Cumarrrrrrr'),
(76, 'Cumarrrrrrrr'),
(77, 'Yumarr'),
(78, 'Vumarr'),
(79, 'Fumarr'),
(80, 'Xumarr'),
(81, 'Harsh'),
(82, 'Harshh'),
(83, 'Tumarr'),
(84, 'Kumar'),
(85, 'Kumarr'),
(86, 'Kumarrr'),
(87, 'Kumarrrr'),
(88, 'Krup'),
(89, 'Mumar'),
(90, 'Mumarr'),
(91, 'Mrp'),
(92, 'Pumarr'),
(93, 'Prup'),
(94, 'Xumarr'),
(95, 'Xu'),
(96, 'Qumar'),
(97, 'Qpar'),
(98, 'Qtar'),
(99, 'Qma'),
(100, 'Quma'),
(101, 'Dumarr'),
(102, 'Gumar'),
(103, 'Loomba'),
(104, 'Vindo'),
(105, 'Vindoo'),
(106, 'Vind'),
(107, 'Omarr'),
(108, 'Omarrr'),
(109, 'Omarrrr'),
(110, 'Omarrrrrr'),
(111, 'Omarrrrr'),
(112, 'Omarrrrrrr'),
(113, 'Omarrrrrrrr'),
(114, 'Omarrrrrrrrr'),
(115, 'Omarrrrrrrrrr'),
(116, 'Fl'),
(117, 'Flm'),
(118, 'Dumarr'),
(119, 'Dumarrr'),
(120, 'Dumarrrr'),
(121, 'Cumar'),
(122, 'Cat'),
(123, 'Quiet'),
(124, 'Quiett'),
(125, 'Gupta'),
(126, 'Guptaji'),
(127, 'Guptajik');

-- --------------------------------------------------------

--
-- Table structure for table `gamedata`
--

CREATE TABLE IF NOT EXISTS `gamedata` (
  `Game_Id` int(100) NOT NULL,
  `WordList` text NOT NULL,
  `currentID` int(20) NOT NULL,
  PRIMARY KEY (`Game_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stopgame`
--

CREATE TABLE IF NOT EXISTS `stopgame` (
  `Game_Id` int(20) NOT NULL,
  `S_Time` timestamp NOT NULL,
  PRIMARY KEY (`Game_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `userinfo`
--

CREATE TABLE IF NOT EXISTS `userinfo` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `FirstPlayer_Id` int(11) NOT NULL,
  `SecondPlayer_Id` int(11) DEFAULT NULL,
  `Status` text NOT NULL,
  `Moves` text NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=136 ;

--
-- Dumping data for table `userinfo`
--

INSERT INTO `userinfo` (`Id`, `FirstPlayer_Id`, `SecondPlayer_Id`, `Status`, `Moves`) VALUES
(134, 22, 23, 'Compeleted&22', 'Letter : G&harsh loomba : Gupta&sushma loomba : Guptaji&harsh loomba : Guptajik'),
(135, 22, 23, 'Compeleted&22', 'Letter : A&harsh loomba : Aumar&sushma loomba : Aman&harsh loomba : Amaa');

-- --------------------------------------------------------

--
-- Table structure for table `userpoints`
--

CREATE TABLE IF NOT EXISTS `userpoints` (
  `User_Id` int(50) NOT NULL,
  `score` int(50) NOT NULL,
  `Status` text NOT NULL,
  PRIMARY KEY (`User_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `userpoints`
--

INSERT INTO `userpoints` (`User_Id`, `score`, `Status`) VALUES
(23, 10, 'A');

-- --------------------------------------------------------

--
-- Table structure for table `usersrecord`
--

CREATE TABLE IF NOT EXISTS `usersrecord` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` text NOT NULL,
  `email_ID` varchar(100) NOT NULL,
  `contact_no` varchar(20) NOT NULL,
  `paswd` varchar(128) NOT NULL,
  `salted_paswd` varchar(128) NOT NULL,
  `Log_In` tinyint(1) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=30 ;

--
-- Dumping data for table `usersrecord`
--

INSERT INTO `usersrecord` (`Id`, `user_name`, `email_ID`, `contact_no`, `paswd`, `salted_paswd`, `Log_In`) VALUES
(22, 'harsh loomba', 'hloomba@gmu.edu', '(415) 696 0034', '-5d3fd60eb46f2aa3eb49749f672f73cfb0ece430fd5db76', '146a34e55829d7fb4ca6b4a8328a4bf85daab31d785e0d12365192358a2c54f7', 1),
(23, 'sushma loomba', 'su@gmu.edu', '(415) 696 0034', '3afb0967c56d9abf761583e9e49b434cfa7fcb6c0942fbe0', '-49b2eda5e623d73c7f4bb2ab815eee74a52fd60b13602f174e0810f3037beb63', 1),
(24, 'sumar loomba', 's@gmu.edu', '(415) 696 0034', '370084d99daa0f1034105e2618bf8e12f08c5f811a54be9e', '5e6e237e8345b76a33e99b3ccff9cff968835b953d8542d093c13a6e6347b47d', 1),
(25, 'Vinod loomba', 'v@gmu.edu', '(415) 696 0034', '-291f88bf0470ccb8b4b05d53a0a734212dde478a22df343f', '-15c7132bb0bf56024e604c751e2a08f883d20c871bd83f5791e197086aa33a37', 0),
(26, 'Harsh lom', 'hloomba@gmil.com', '(209) 100-7689', '750f4a1343a71237ce745c7355a19e0dfd8f78e043ec76b0', '-3e601027def62e979c5fe0899589e9fb2cd0c4088a2391103089835abbabd9e', 0),
(27, 'Hlfl lo', 'hl@gmu.edu', '(415) 696-0034', '107780fe7465105e098ff51b0a4beb3b7ac03d766c3e8a35', '-45d1e6f5a8d0cf93cbe421cec5d691faebc129fb9e3243ada99b50a80c1e5e30', 0),
(28, 'Har loomba', 'hloom@gmu.edu', '(415) 696-0034', '4f9b6035639ce00dae51d73601503b3b5ddcb7bb26d29b90', '-39f36beee4a4a7d9694542d01676f8935e0199fce9284249fc2185179e50f7d8', 0),
(29, 'Sumar loo', 'saq@gmu.edu', '(415) 696-0034', '4ce499af93429addaeab729b159567e3c3f5abdba131354b', '4772e55a1f7cd13a731f82bff2eab27965dc48270a52cab56dfce62d09dc0246', 0);

-- --------------------------------------------------------

--
-- Table structure for table `winstatistics`
--

CREATE TABLE IF NOT EXISTS `winstatistics` (
  `Id` int(20) NOT NULL,
  `Win_score` int(20) NOT NULL,
  `Loss_score` int(20) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `winstatistics`
--

INSERT INTO `winstatistics` (`Id`, `Win_score`, `Loss_score`) VALUES
(22, 7, 0),
(23, 0, 1),
(24, 0, 0),
(25, 0, 0),
(26, 0, 0),
(27, 0, 0),
(28, 0, 0),
(29, 0, 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
