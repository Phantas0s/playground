--
-- Database: `jsdd_ch15`
--

-- --------------------------------------------------------

--
-- Table structure for table `bids`
--

CREATE TABLE `bids` (
  `bidId` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `itemId` INT(10) UNSIGNED NOT NULL,
  `userId` MEDIUMINT(8) UNSIGNED NOT NULL,
  `bid` DECIMAL(7,2) UNSIGNED NOT NULL,
  `dateSubmitted` TIMESTAMP NOT NULL,
  PRIMARY KEY (`bidId`),
  KEY `itemId` (`itemId`),
  KEY `userId` (`userId`)
);

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `itemId` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `item` VARCHAR(100) NOT NULL,
  `description` TINYTEXT,
  `openingPrice` DECIMAL(7,2) UNSIGNED NOT NULL,
  `finalPrice` DECIMAL(7,2) DEFAULT NULL,
  `dateOpened` timestamp NOT NULL,
  `dateClosed` datetime NOT NULL,
  PRIMARY KEY (`itemId`)
);

INSERT INTO `items` (`item`, `description`, `openingPrice`, `dateOpened`, `dateClosed`) VALUES ('This is the item.', 'This is the description.', 1.25, UTC_TIMESTAMP(), '2012-07-05 13:01:00');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userId` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(40) NOT NULL,
  `userpass` CHAR(40) NOT NULL,
  `timezone` VARCHAR(100) NOT NULL,
  `dateCreated` TIMESTAMP NOT NULL,
  PRIMARY KEY (`userId`),
  UNIQUE KEY `username` (`username`),
  KEY `login` (`username`,`userpass`)
);

INSERT INTO `users` (`username`, `userpass`, `timezone`, `dateCreated`) VALUES ('testing', SHA1('securepass'), 'America/New_York', UTC_TIMESTAMP());

