-- phpMyAdmin SQL Dump
-- version 3.5.8.2
-- http://www.phpmyadmin.net
--
-- Počítač: md14.wedos.net:3306
-- Vygenerováno: Sob 09. čen 2018, 13:42
-- Verze serveru: 10.1.32-MariaDB
-- Verze PHP: 5.4.23

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Databáze: `d183248_chill`
--

-- --------------------------------------------------------

--
-- Struktura tabulky `places`
--

CREATE TABLE IF NOT EXISTS `places` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nazev` varchar(40) COLLATE utf8_bin NOT NULL,
  `sirka` varchar(20) COLLATE utf8_bin NOT NULL,
  `delka` float NOT NULL,
  `popis` text COLLATE utf8_bin NOT NULL,
  `overeno` tinyint(1) NOT NULL DEFAULT '0',
  `WiFi` tinyint(1) NOT NULL DEFAULT '0',
  `USB` tinyint(1) NOT NULL DEFAULT '0',
  `inout` enum('in','out') COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=13 ;

--
-- Vypisuji data pro tabulku `places`
--

INSERT INTO `places` (`id`, `nazev`, `sirka`, `delka`, `popis`, `overeno`, `WiFi`, `USB`, `inout`) VALUES
(1, 'Lavička - Kongresové centrum Praha', '50.0896', 14.4146, '', 1, 1, 1, 'in'),
(3, 'Mořský svět', '50.1056', 14.4317, '', 1, 1, 0, 'in'),
(4, 'GOJA Music Hall', '50.108', 14.4317, '', 1, 0, 0, 'in'),
(5, 'Výstaviště Praha Holešovice', '50.1065', 14.4299, '', 1, 1, 0, 'in'),
(6, 'Bohemia Bagel', '50.102865', 14.4326, '', 0, 0, 0, 'in'),
(7, 'Happy Noodles', '50.100101', 14.4253, '', 1, 0, 0, 'in'),
(8, 'Ouky Douky Coffee', '50.100277', 14.4348, '', 1, 1, 0, 'in'),
(9, 'Workout park Stromovka', '50.109412', 14.4177, '', 0, 0, 0, 'out'),
(10, 'Paralelní Polis', '50.103345', 14.4177, '', 1, 1, 1, 'in'),
(11, 'Stejkárna Holešovice', '50.102556', 14.4365, '', 0, 0, 0, 'in'),
(12, 'Sušírna', '50.102643', 14.4352, '', 0, 0, 0, 'in');

-- --------------------------------------------------------

--
-- Struktura tabulky `places_tag_rel`
--

CREATE TABLE IF NOT EXISTS `places_tag_rel` (
  `id` int(11) NOT NULL,
  `id_tag` int(11) NOT NULL,
  KEY `id` (`id`),
  KEY `id_2` (`id`),
  KEY `id_tag` (`id_tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Vypisuji data pro tabulku `places_tag_rel`
--

INSERT INTO `places_tag_rel` (`id`, `id_tag`) VALUES
(3, 10),
(3, 12),
(3, 13),
(4, 10),
(5, 10),
(5, 9),
(6, 1),
(6, 7),
(7, 1),
(7, 2),
(8, 6),
(8, 1),
(8, 3),
(9, 4),
(9, 5),
(9, 13),
(10, 6),
(10, 3),
(11, 1),
(11, 7),
(12, 1),
(12, 2),
(12, 7);

-- --------------------------------------------------------

--
-- Struktura tabulky `tags`
--

CREATE TABLE IF NOT EXISTS `tags` (
  `id_tag` int(11) NOT NULL AUTO_INCREMENT,
  `jmeno_tag` varchar(50) CHARACTER SET utf8 COLLATE utf8_czech_ci NOT NULL,
  PRIMARY KEY (`id_tag`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=14 ;

--
-- Vypisuji data pro tabulku `tags`
--

INSERT INTO `tags` (`id_tag`, `jmeno_tag`) VALUES
(1, 'food'),
(2, 'sushi'),
(3, 'pub'),
(4, 'sport'),
(5, 'fitness'),
(6, 'caffee'),
(7, 'restaurant'),
(8, 'church'),
(9, 'architecture'),
(10, 'museum'),
(11, 'theatre'),
(12, 'kids'),
(13, 'nature');

-- --------------------------------------------------------

--
-- Struktura tabulky `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `jmeno` varchar(32) CHARACTER SET utf8 COLLATE utf8_czech_ci NOT NULL,
  `heslo` varchar(64) CHARACTER SET utf8 COLLATE utf8_czech_ci NOT NULL,
  `cas_registrace` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=3 ;

--
-- Vypisuji data pro tabulku `user`
--

INSERT INTO `user` (`id`, `jmeno`, `heslo`, `cas_registrace`) VALUES
(2, 'kuba', 'derp', '2018-06-08 15:54:58');

-- --------------------------------------------------------

--
-- Struktura tabulky `wether`
--

CREATE TABLE IF NOT EXISTS `wether` (
  `id` int(11) NOT NULL,
  `name` varchar(30) COLLATE utf8_czech_ci NOT NULL,
  `lat` int(11) NOT NULL,
  `lon` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

--
-- Vypisuji data pro tabulku `wether`
--

INSERT INTO `wether` (`id`, `name`, `lat`, `lon`) VALUES
(603, '0', 51, 15),
(502, '0', 51, 14),
(788, '0', 50, 16),
(789, '0', 50, 13),
(518, '0', 50, 14),
(446, '0', 50, 14),
(693, '0', 49, 16),
(438, '0', 50, 13),
(730, '0', 50, 17),
(541, '0', 49, 14),
(659, '0', 50, 16),
(790, '0', 50, 15),
(433, '0', 51, 14),
(643, '0', 51, 16),
(567, '0', 50, 15),
(698, '0', 49, 16),
(683, '0', 50, 16),
(414, '0', 50, 13),
(774, '0', 49, 18),
(723, '0', 49, 17),
(519, '0', 50, 15),
(692, '0', 49, 16),
(457, '0', 49, 14),
(509, '0', 51, 14),
(787, '0', 50, 19),
(766, '0', 50, 18),
(679, '0', 50, 16),
(782, '0', 50, 18),
(791, '0', 51, 16),
(652, '0', 50, 16),
(628, '0', 50, 15),
(636, '0', 49, 15),
(520, '0', 50, 15),
(464, '0', 50, 14),
(406, '0', 50, 12),
(538, '0', 49, 14),
(710, '0', 50, 17),
(487, '0', 50, 14),
(624, '0', 50, 15),
(423, '0', 50, 13),
(603, 'Liberec-letiste', 51, 15),
(502, 'Usti n.Labem', 51, 14),
(788, 'Polom', 50, 16),
(789, 'Plzen-Mikulka', 50, 13),
(518, 'Praha-Ruzyne', 50, 14),
(446, 'Plzen-Bolevec', 50, 14),
(693, 'Dukovany', 49, 16),
(438, 'Tusimice', 50, 13),
(730, 'Serak', 50, 17),
(541, 'Ceske Budejovice', 49, 14),
(659, 'Pribyslav', 50, 16),
(790, 'Kosetice', 50, 15),
(433, 'Kopisty', 51, 14),
(643, 'Pec p.Snezkou', 51, 16),
(567, 'Praha-Kbely', 50, 15),
(698, 'Kucharovice', 49, 16),
(683, 'Svratouch', 50, 16),
(414, 'Karlovy Vary', 50, 13),
(774, 'Holesov-letiste', 49, 18),
(723, 'Brno-Turany', 49, 17),
(519, 'Praha-Karlov', 50, 15),
(692, 'Namest n.Oslavou', 49, 16),
(457, 'Churanov', 49, 14),
(509, 'Doksany', 51, 14),
(787, 'Lysa Hora', 50, 19),
(766, 'Cervena u Libave', 50, 18),
(679, 'Usti n.Orlici', 50, 16),
(782, 'Ostrava-Mosnov', 50, 18),
(791, 'Snezka', 51, 16),
(652, 'Pardubice', 50, 16),
(628, 'Kramolin-Kosetice', 50, 15),
(636, 'Kostelni Myslova', 49, 15),
(520, 'Praha-Libus', 50, 15),
(464, 'Milesovka', 50, 14),
(406, 'Cheb', 50, 12),
(538, 'Temelin', 49, 14),
(710, 'Luka', 50, 17),
(487, 'Kocelovice', 50, 14),
(624, 'Caslav', 50, 15),
(423, 'Primda', 50, 13);

--
-- Omezení pro exportované tabulky
--

--
-- Omezení pro tabulku `places_tag_rel`
--
ALTER TABLE `places_tag_rel`
  ADD CONSTRAINT `places_tag_rel_ibfk_1` FOREIGN KEY (`id`) REFERENCES `places` (`id`),
  ADD CONSTRAINT `places_tag_rel_ibfk_2` FOREIGN KEY (`id_tag`) REFERENCES `tags` (`id_tag`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
