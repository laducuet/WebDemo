-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 13, 2023 at 07:42 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shop_team9`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddNewAdmin` (IN `fName` VARCHAR(20), IN `lName` VARCHAR(20), IN `userName` VARCHAR(20), IN `email` VARCHAR(70), IN `password` VARCHAR(100))   INSERT INTO `admin` (`ID`, `fName`, `lName`, `userName`, `email`, `password`) VALUES (NULL, fName, lName, userName, email, password)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteFromCartItem` (IN `cartIDD` INT(11), IN `itemIDD` INT(11))   DELETE FROM cartitem WHERE cartitem.cartId = cartIDD AND cartitem.itemId = itemIDD$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllCategories` ()   BEGIN
SELECT * FROM category;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllChildCategories` ()   BEGIN
SELECT * FROM childcategory;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllImages` ()   BEGIN
SELECT *  FROM itemimage;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllitems` ()   BEGIN
SELECT *  FROM item ORDER by quantity DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getBuyerWithUserName` (IN `UserNameee` VARCHAR(20))   SELECT * FROM buyer where userName = UserNameee$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getItemCartWithItemIdandBuyerId` (IN `buyerID` INT(11), IN `itemIDD` INT(11))   SELECT cartitem.cartId , cartitem.itemId
                                                                                                                            from buyer,cartitem,cart,item
                                                                                                                            WHERE buyer.cartId = cart.cartId and cartitem.cartId=cart.cartId and buyer.ID=buyerID and cartitem.itemId = item.itemId and item.itemId=itemIDD$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getItemsByCertainCategory` (IN `catName` VARCHAR(30))   BEGIN
SELECT * FROM item as e WHERE e.categoryId in (SELECT b.categoryId from category as b WHERE categoryName = catName) ORDER BY quantity DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getItemsByCertainChildCategory` (IN `childcatName` VARCHAR(30))   BEGIN
SELECT * FROM item as e WHERE e.childcategoryId in (SELECT b.childcategoryId from childcategory as b WHERE childcategoryName = childcatName) ORDER BY quantity DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getSellerWithUserName` (IN `UserNameee` VARCHAR(20))   SELECT * FROM seller where userName = UserNameee$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertNewOrder` (IN `cartIdd` INT(11), IN `OrderPricee` DOUBLE, IN `qty` INT(11), IN `buyerIdd` INT(11), IN `itemIdd` INT(11))   INSERT INTO orders (cartId,orderPrice,quantity,buyerId,itemId)  VALUES (cartIdd,OrderPricee,qty,buyerIdd,itemIdd)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `searchForItemsByKeyword` (IN `KeyWord` VARCHAR(255))   SELECT * FROM item WHERE title LIKE KeyWord UNION SELECT * FROM item WHERE description LIKE KeyWord ORDER by quantity DESC$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `ID` int(11) NOT NULL,
  `fName` varchar(20) DEFAULT NULL,
  `lName` varchar(20) DEFAULT NULL,
  `userName` varchar(20) NOT NULL,
  `email` varchar(70) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`ID`, `fName`, `lName`, `userName`, `email`, `password`) VALUES
(1, 'NguyenTu', 'Trung', 'admin', 'admin@gmail.com', '4cb7a9e4b9acfd6d97a5aa9c1b83c3947a29c53f'),
(2, 'Le Anh', 'Duc', 'Mainadmin', 'aa@gmail.com', '42f5b40bcb35224d56ba4f05ffc69085fb817b92');

-- --------------------------------------------------------

--
-- Table structure for table `bill`
--

CREATE TABLE `bill` (
  `ID` int(11) NOT NULL,
  `numberOfItems` int(11) NOT NULL DEFAULT 0,
  `orderTotal` int(11) NOT NULL DEFAULT 0,
  `cartId` int(11) NOT NULL,
  `firstname` varchar(300) DEFAULT NULL,
  `lastname` varchar(300) DEFAULT NULL,
  `isShip` tinyint(1) NOT NULL DEFAULT 0,
  `companyname` varchar(300) DEFAULT NULL,
  `address` varchar(300) DEFAULT NULL,
  `optional` varchar(300) DEFAULT NULL,
  `city` varchar(300) DEFAULT NULL,
  `country` varchar(300) DEFAULT NULL,
  `postcode` varchar(300) DEFAULT NULL,
  `email` varchar(300) DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bill`
--

INSERT INTO `bill` (`ID`, `numberOfItems`, `orderTotal`, `cartId`, `firstname`, `lastname`, `isShip`, `companyname`, `address`, `optional`, `city`, `country`, `postcode`, `email`, `phone`, `notes`) VALUES
(1, 0, 88, 1, 'Le Anh', 'Duc', 0, 'aaa', 'a', 'aaa', 'q', 'Vietnam', 'AA', 'aa@gmail.com', '223456', '2345'),
(2, 0, 88, 1, 'Le Anh', 'Duc', 1, 'dfehs', 'aaaaaa', 'ádfgfdg', 'qetyuikjhg', 'Vietnam', 'AA', 'aa@gmail.com', '23456', '12356'),
(3, 0, 264, 1, 'Le Anh', 'Duc', 0, 'aaaaaaa', 'a', 'jhhjutyhj', 'q', 'Vietnam', 'AA', 'aa@gmail.com', '123456u', 'jhfyndf'),
(4, 0, 88, 1, 'Le Anh', 'Duc', 1, 'Lan2', 'lan2', 'jkhjhjuy', 'q', 'Vietnam', 'AA', 'aa@gmail.com', '2567', '2346sdf'),
(5, 0, 88, 1, 'Le Anh', 'Duc', 1, 'AAaaaa', 'a', 'hftn', 'q', 'Vietnam', 'AA', 'aa@gmail.com', '123456', 'drgdrg');

-- --------------------------------------------------------

--
-- Table structure for table `buyer`
--

CREATE TABLE `buyer` (
  `ID` int(11) NOT NULL,
  `userName` varchar(20) NOT NULL,
  `password` varchar(50) NOT NULL,
  `joinDate` date NOT NULL DEFAULT curdate(),
  `email` varchar(70) NOT NULL,
  `fName` varchar(20) NOT NULL,
  `lName` varchar(20) NOT NULL,
  `cartId` int(11) NOT NULL,
  `likes` int(11) NOT NULL DEFAULT 0,
  `disLikes` int(11) NOT NULL DEFAULT 0,
  `transactions` int(11) NOT NULL DEFAULT 0,
  `Amount` int(11) NOT NULL DEFAULT 100000
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `buyer`
--

INSERT INTO `buyer` (`ID`, `userName`, `password`, `joinDate`, `email`, `fName`, `lName`, `cartId`, `likes`, `disLikes`, `transactions`, `Amount`) VALUES
(1, 'ducqcb', '482de74ca32ccb636bd1fba8ae4ce85c206db3a9', '2023-05-13', 'aa@gmail.com', 'Le Anh', 'Duc', 1, 6, 0, 5, 99557);

--
-- Triggers `buyer`
--
DELIMITER $$
CREATE TRIGGER `deleteNotificationafterBuyerDeletion` BEFORE DELETE ON `buyer` FOR EACH ROW DELETE FROM notification WHERE notification.id in (SELECT notificationId  from  buyernotification,buyer WHERE buyer.ID = buyernotification.ownerID)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `buyernotification`
--

CREATE TABLE `buyernotification` (
  `notificationId` int(11) NOT NULL,
  `sellerId` int(11) NOT NULL,
  `ownerID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `buyernotification`
--

INSERT INTO `buyernotification` (`notificationId`, `sellerId`, `ownerID`) VALUES
(4, 1, 1),
(5, 1, 1),
(6, 1, 1),
(9, 1, 1),
(10, 1, 1),
(12, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cartId` int(11) NOT NULL,
  `itemCount` int(11) NOT NULL,
  `payment` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`cartId`, `itemCount`, `payment`) VALUES
(1, 5, 616);

-- --------------------------------------------------------

--
-- Table structure for table `cartitem`
--

CREATE TABLE `cartitem` (
  `cartId` int(11) NOT NULL,
  `itemId` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `categoryId` int(11) NOT NULL,
  `categoryName` varchar(30) NOT NULL,
  `categoryDescription` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`categoryId`, `categoryName`, `categoryDescription`) VALUES
(10, 'GAME', ''),
(11, 'LAPTOP', ''),
(12, 'SMARTPHONE', ''),
(14, 'SHOES', ''),
(15, 'TV', ''),
(19, 'SPORTS', ''),
(20, 'TOYS', ''),
(21, 'BOOKS', ''),
(22, 'WATCH', '');

--
-- Triggers `category`
--
DELIMITER $$
CREATE TRIGGER `updateCat` BEFORE DELETE ON `category` FOR EACH ROW UPDATE childcategory as e SET e.categoryId = 1 WHERE e.categoryId in (SELECT c.categoryId from category as c WHERE c.categoryId =OLD.categoryId)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `childcategory`
--

CREATE TABLE `childcategory` (
  `childcategoryId` int(11) NOT NULL,
  `childcategoryName` varchar(30) NOT NULL,
  `categoryId` int(11) DEFAULT 1,
  `childcategoryDescription` varchar(300) NOT NULL,
  `totalItems` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `childcategory`
--

INSERT INTO `childcategory` (`childcategoryId`, `childcategoryName`, `categoryId`, `childcategoryDescription`, `totalItems`) VALUES
(14, 'HP', 11, 'hp', 0),
(15, 'DELL', 11, 'dell', 0),
(16, 'ACER', 11, 'acer', 0),
(17, 'ASUS', 11, 'asus', 0),
(18, 'APPLE', 11, 'apple', 0),
(19, 'LG', 11, 'lg', 0),
(20, 'MSI', 11, 'msi', 0),
(21, 'SAMSUNG', 11, 'samsung', 0),
(22, 'HUAWEI', 11, 'huawei', 0),
(23, 'APPLE', 12, 'apple', 0),
(24, 'SAMSUNG', 12, 'samsung', 0),
(25, 'HUAWEI', 12, 'huawei', 0),
(26, 'OPPO', 12, 'oppo', 0),
(27, 'MI', 12, 'mi', 0),
(28, 'REALME', 12, 'realme', 0),
(29, 'VIVO', 12, 'vivo', 0),
(30, 'PHILIPS', 12, 'philips', 0),
(31, 'LG', 12, 'lg', 0),
(32, 'PES MOBILE', 10, 'pes mobile', 0),
(33, 'ARENA OF VALOR', 10, 'arena of valor', 0),
(34, 'FIFA ONLINE', 10, 'fifa online', 0),
(35, 'LEAGUE OF LEGENDS', 10, 'league of legends', 0),
(36, 'PUBG MOBILE', 10, 'pubg mobile', 0),
(37, 'NGOC RONG ONLINE', 10, 'ngoc rong online', 0),
(38, 'STEAM', 10, 'steam', 0),
(39, 'VALORANT', 10, 'valorant', 0),
(40, 'GUNNY', 10, 'gunny', 0),
(41, 'LG', 15, 'lg', 0),
(42, 'SONY', 15, 'sony', 0),
(43, 'SAMSUNG', 15, 'samsung', 0),
(44, 'MI', 15, 'mi', 0),
(45, 'PANASONIC', 15, 'panasonic', 0),
(46, 'PHILIPS', 15, 'philips', 0),
(47, 'SHARP', 15, 'sharp', 0),
(48, 'TCL', 15, 'tcl', 0),
(49, 'ASANZO', 15, 'asanzo', 0),
(50, 'NIKES', 14, 'nikes', 0),
(51, 'ADIDAS', 14, 'adidas', 0),
(52, 'NEW BALANCE', 14, 'new balance', 0),
(53, 'ASICS', 14, 'asics', 0),
(54, 'PUMA', 14, 'puma', 0),
(55, 'SKECHERS', 14, 'skechers', 0),
(56, 'FILA', 14, 'fila', 0),
(57, 'BATA', 14, 'bata', 0),
(58, 'BURBERRY', 14, 'burberry', 0),
(59, 'ROSSIGNOL', 19, 'rossignol', 0),
(60, 'HEAD', 19, 'head', 0),
(61, 'SALOMON', 19, 'salomon', 0),
(62, 'WILSON SPORTING GOODS', 19, 'wilson sporting goods', 0),
(63, 'BLIZZARD - TECNICA', 19, 'blizzard - tecnica', 0),
(64, 'FISCHER SPORTS', 19, 'fischer sports', 0),
(65, 'ATOMIC', 19, 'atomic', 0),
(66, 'BALOLAT', 19, 'babolat', 0),
(67, 'UHLSPORT', 19, 'uhlsport', 0);

--
-- Triggers `childcategory`
--
DELIMITER $$
CREATE TRIGGER `updateChildCat` BEFORE DELETE ON `childcategory` FOR EACH ROW UPDATE item as e SET e.childcategoryId = 1 WHERE e.childcategoryId in (SELECT c.childcategoryId from childcategory as c WHERE c.childcategoryId =OLD.childcategoryId)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE `item` (
  `itemId` int(11) NOT NULL,
  `title` varchar(20) NOT NULL,
  `description` varchar(300) NOT NULL,
  `information` text DEFAULT NULL,
  `price` double NOT NULL,
  `quantity` int(11) NOT NULL,
  `addDate` date NOT NULL DEFAULT curdate(),
  `isDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `isSaled` tinyint(1) NOT NULL DEFAULT 0,
  `childcategoryId` int(11) DEFAULT 1,
  `sellerId` int(11) NOT NULL,
  `startDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `discount` int(11) DEFAULT NULL,
  `homeNumber` int(11) NOT NULL,
  `street` varchar(50) NOT NULL,
  `city` varchar(30) NOT NULL,
  `country` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `itemimage`
--

CREATE TABLE `itemimage` (
  `itemId` int(11) NOT NULL,
  `image` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `mobileadmin`
--

CREATE TABLE `mobileadmin` (
  `adminId` int(11) NOT NULL,
  `phone` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `mobileadmin`
--

INSERT INTO `mobileadmin` (`adminId`, `phone`) VALUES
(1, '0355287940'),
(2, '0123456789');

-- --------------------------------------------------------

--
-- Table structure for table `mobilebuyer`
--

CREATE TABLE `mobilebuyer` (
  `buyerId` int(11) NOT NULL,
  `phone` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `mobilebuyer`
--

INSERT INTO `mobilebuyer` (`buyerId`, `phone`) VALUES
(1, '1234567654');

-- --------------------------------------------------------

--
-- Table structure for table `mobileseller`
--

CREATE TABLE `mobileseller` (
  `sellerId` int(11) NOT NULL,
  `phoneNo` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `mobileseller`
--

INSERT INTO `mobileseller` (`sellerId`, `phoneNo`) VALUES
(1, '34567898765');

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE `notification` (
  `id` int(11) NOT NULL,
  `message` varchar(300) NOT NULL,
  `date` date NOT NULL DEFAULT curdate(),
  `seen` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `notification`
--

INSERT INTO `notification` (`id`, `message`, `date`, `seen`) VALUES
(1, 'Hello Nguyen Tu Trung, Le Anh Duc ordered your item: MS1, Quantity: 1, Price: 89, at 2023-05-13', '2023-05-13', 1),
(2, 'Hello Nguyen Tu Trung, Le Anh Duc ordered your item: MS1, Quantity: 1, Price: 89, at 2023-05-13', '2023-05-13', 1),
(3, 'Hello Nguyen Tu Trung, Le Anh Duc ordered your item: ACC1, Quantity: 1, Price: 89, at 2023-05-13', '2023-05-13', 1),
(4, 'Hello ducqcb regarding your order for ACC1, quantity: 1, price: 89 ,at address 12 HN HN we want to inform you that it has been accepted\n you can communicate with the seller through 34567898765', '2023-05-13', 1),
(5, 'Hello ducqcb regarding your order for MS1, quantity: 1, price: 89 ,at address 1 HN HN we want to inform you that it has been accepted\n you can communicate with the seller through 34567898765', '2023-05-13', 1),
(6, 'Hello ducqcb regarding your order for MS1, quantity: 1, price: 89 ,at address 1 HN HN we want to inform you that it has been accepted\n you can communicate with the seller through 34567898765', '2023-05-13', 1),
(7, 'Hello Nguyen Tu Trung, Le Anh Duc ordered your item: MS1, Quantity: 3, Price: 264, at 2023-05-13', '2023-05-13', 1),
(8, 'Hello Nguyen Tu Trung, Le Anh Duc ordered your item: MS1, Quantity: 1, Price: 88, at 2023-05-13', '2023-05-13', 1),
(9, 'Hello ducqcb regarding your order for MS1, quantity: 3, price: 264 ,at address 1 HN HN we want to inform you that it has been declined\n you can communicate with the seller through 34567898765', '2023-05-13', 1),
(10, 'Hello ducqcb regarding your order for MS1, quantity: 1, price: 88 ,at address 1 HN HN we want to inform you that it has been accepted\n you can communicate with the seller through 34567898765', '2023-05-13', 1),
(11, 'Hello Nguyen Tu Trung, Le Anh Duc ordered your item: MS1, Quantity: 1, Price: 88, at 2023-05-13', '2023-05-13', 1),
(12, 'Hello ducqcb regarding your order for MS1, quantity: 1, price: 88 ,at address 1 HN HN we want to inform you that it has been accepted\n you can communicate with the seller through 34567898765', '2023-05-13', 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `orderId` int(11) NOT NULL,
  `cartId` int(11) NOT NULL DEFAULT 0,
  `orderPrice` double NOT NULL,
  `quantity` int(11) NOT NULL,
  `orderDate` date NOT NULL DEFAULT curdate(),
  `buyerId` int(11) NOT NULL,
  `itemId` int(11) DEFAULT NULL,
  `status` int(1) NOT NULL DEFAULT 0,
  `isShip` tinyint(1) NOT NULL DEFAULT 0,
  `billId` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`orderId`, `cartId`, `orderPrice`, `quantity`, `orderDate`, `buyerId`, `itemId`, `status`, `isShip`, `billId`) VALUES
(1, 1, 89, 1, '2023-05-13', 1, NULL, 1, 0, 1),
(2, 1, 89, 1, '2023-05-13', 1, NULL, 1, 1, 2),
(3, 1, 89, 1, '2023-05-13', 1, NULL, 1, 0, 0),
(4, 1, 264, 3, '2023-05-13', 1, NULL, 2, 0, 3),
(5, 1, 88, 1, '2023-05-13', 1, NULL, 1, 1, 4),
(6, 1, 88, 1, '2023-05-13', 1, NULL, 1, 1, 5);

-- --------------------------------------------------------

--
-- Table structure for table `seller`
--

CREATE TABLE `seller` (
  `ID` int(11) NOT NULL,
  `userName` varchar(20) NOT NULL,
  `password` varchar(50) NOT NULL,
  `joinDate` date NOT NULL DEFAULT curdate(),
  `email` varchar(70) NOT NULL,
  `fName` varchar(20) NOT NULL,
  `lName` varchar(20) NOT NULL,
  `likes` int(11) NOT NULL DEFAULT 0,
  `disLikes` int(11) NOT NULL DEFAULT 0,
  `transactions` int(11) NOT NULL DEFAULT 0,
  `Amount` int(11) NOT NULL DEFAULT 100000
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `seller`
--

INSERT INTO `seller` (`ID`, `userName`, `password`, `joinDate`, `email`, `fName`, `lName`, `likes`, `disLikes`, `transactions`, `Amount`) VALUES
(1, 'trunguet', '28b743abc9e2c0c37c410ca23460f3cde0fc52cd', '2023-05-13', 'aa1@gmail.com', 'Nguyen Tu', 'Trung', 1, 0, 5, 100443);

--
-- Triggers `seller`
--
DELIMITER $$
CREATE TRIGGER `deleteNotificationafterSellerDeletion` BEFORE DELETE ON `seller` FOR EACH ROW DELETE FROM notification WHERE notification.id in (SELECT notificationId  from  sellernotifications,seller WHERE seller.ID = sellernotifications.ownerID)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sellernotifications`
--

CREATE TABLE `sellernotifications` (
  `notificationId` int(11) NOT NULL,
  `buyerId` int(11) NOT NULL,
  `ownerID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sellernotifications`
--

INSERT INTO `sellernotifications` (`notificationId`, `buyerId`, `ownerID`) VALUES
(1, 1, 1),
(2, 1, 1),
(3, 1, 1),
(7, 1, 1),
(8, 1, 1),
(11, 1, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `userName` (`userName`) USING BTREE,
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `bill`
--
ALTER TABLE `bill`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `buyer`
--
ALTER TABLE `buyer`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `userName` (`userName`) USING BTREE,
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `cartId` (`cartId`);

--
-- Indexes for table `buyernotification`
--
ALTER TABLE `buyernotification`
  ADD PRIMARY KEY (`notificationId`,`sellerId`,`ownerID`),
  ADD KEY `selllll` (`sellerId`),
  ADD KEY `buyeeee` (`ownerID`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cartId`);

--
-- Indexes for table `cartitem`
--
ALTER TABLE `cartitem`
  ADD PRIMARY KEY (`cartId`,`itemId`),
  ADD KEY `itemIdcartitem` (`itemId`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`categoryId`);

--
-- Indexes for table `childcategory`
--
ALTER TABLE `childcategory`
  ADD PRIMARY KEY (`childcategoryId`);

--
-- Indexes for table `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`itemId`),
  ADD UNIQUE KEY `homeNumber` (`homeNumber`,`street`,`city`,`country`,`itemId`) USING BTREE,
  ADD UNIQUE KEY `startDate` (`startDate`,`endDate`,`discount`,`itemId`) USING BTREE,
  ADD KEY `sellerIdItem` (`sellerId`);

--
-- Indexes for table `itemimage`
--
ALTER TABLE `itemimage`
  ADD PRIMARY KEY (`itemId`,`image`);

--
-- Indexes for table `mobileadmin`
--
ALTER TABLE `mobileadmin`
  ADD PRIMARY KEY (`adminId`,`phone`);

--
-- Indexes for table `mobilebuyer`
--
ALTER TABLE `mobilebuyer`
  ADD PRIMARY KEY (`buyerId`,`phone`);

--
-- Indexes for table `mobileseller`
--
ALTER TABLE `mobileseller`
  ADD PRIMARY KEY (`sellerId`,`phoneNo`);

--
-- Indexes for table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`orderId`),
  ADD KEY `buyerIdorder` (`buyerId`),
  ADD KEY `itemIdForOrder` (`itemId`);

--
-- Indexes for table `seller`
--
ALTER TABLE `seller`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `userName` (`userName`) USING BTREE,
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `sellernotifications`
--
ALTER TABLE `sellernotifications`
  ADD PRIMARY KEY (`notificationId`,`buyerId`,`ownerID`),
  ADD KEY `bu` (`buyerId`),
  ADD KEY `sel` (`ownerID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `bill`
--
ALTER TABLE `bill`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `buyer`
--
ALTER TABLE `buyer`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cartId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `categoryId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `childcategory`
--
ALTER TABLE `childcategory`
  MODIFY `childcategoryId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT for table `item`
--
ALTER TABLE `item`
  MODIFY `itemId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `notification`
--
ALTER TABLE `notification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `orderId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `seller`
--
ALTER TABLE `seller`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `buyer`
--
ALTER TABLE `buyer`
  ADD CONSTRAINT `cardId` FOREIGN KEY (`cartId`) REFERENCES `cart` (`cartId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `buyernotification`
--
ALTER TABLE `buyernotification`
  ADD CONSTRAINT `buyeeee` FOREIGN KEY (`ownerID`) REFERENCES `buyer` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `notiii` FOREIGN KEY (`notificationId`) REFERENCES `notification` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `selllll` FOREIGN KEY (`sellerId`) REFERENCES `seller` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `cartitem`
--
ALTER TABLE `cartitem`
  ADD CONSTRAINT `cartIDforcartitem` FOREIGN KEY (`cartId`) REFERENCES `cart` (`cartId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `itemIdcartitem` FOREIGN KEY (`itemId`) REFERENCES `item` (`itemId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `item`
--
ALTER TABLE `item`
  ADD CONSTRAINT `sellerIdItem` FOREIGN KEY (`sellerId`) REFERENCES `seller` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `itemimage`
--
ALTER TABLE `itemimage`
  ADD CONSTRAINT `itemIdForImage` FOREIGN KEY (`itemId`) REFERENCES `item` (`itemId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `mobileadmin`
--
ALTER TABLE `mobileadmin`
  ADD CONSTRAINT `mobileAdminId` FOREIGN KEY (`adminId`) REFERENCES `admin` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `mobilebuyer`
--
ALTER TABLE `mobilebuyer`
  ADD CONSTRAINT `buyerId` FOREIGN KEY (`buyerId`) REFERENCES `buyer` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `mobileseller`
--
ALTER TABLE `mobileseller`
  ADD CONSTRAINT `sellerId` FOREIGN KEY (`sellerId`) REFERENCES `seller` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `buyerIdorder` FOREIGN KEY (`buyerId`) REFERENCES `buyer` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `itemIdForOrder` FOREIGN KEY (`itemId`) REFERENCES `item` (`itemId`) ON DELETE SET NULL ON UPDATE NO ACTION;

--
-- Constraints for table `sellernotifications`
--
ALTER TABLE `sellernotifications`
  ADD CONSTRAINT `bu` FOREIGN KEY (`buyerId`) REFERENCES `buyer` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `noti` FOREIGN KEY (`notificationId`) REFERENCES `notification` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sel` FOREIGN KEY (`ownerID`) REFERENCES `seller` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
