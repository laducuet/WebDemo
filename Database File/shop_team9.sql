-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 13, 2023 at 02:42 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dawrhashop`
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`ID`, `fName`, `lName`, `userName`, `email`, `password`) VALUES
(1, 'NguyenTu', 'Trung', 'admin', 'admin@gmail.com', '4cb7a9e4b9acfd6d97a5aa9c1b83c3947a29c53f');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cartId` int(11) NOT NULL,
  `itemCount` int(11) NOT NULL,
  `payment` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cartitem`
--

CREATE TABLE `cartitem` (
  `cartId` int(11) NOT NULL,
  `itemId` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `categoryId` int(11) NOT NULL,
  `categoryName` varchar(30) NOT NULL,
  `categoryDescription` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `childcategory`
--

INSERT INTO `childcategory` (`childcategoryId`, `childcategoryName`, `categoryId`, `childcategoryDescription`, `totalItems`) VALUES
(11, 'ACC THƯỜNG', 10, 'accthuong', 1),
(12, 'ACC RANDOM', 10, 'accrandom', 0),
(13, 'ACC VIP', 10, 'accvip', 0),
(14, 'HP', 11, 'hp', 10),
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
(31, 'LG', 12, 'lg', 0);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `itemimage`
--

CREATE TABLE `itemimage` (
  `itemId` int(11) NOT NULL,
  `image` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mobileadmin`
--

CREATE TABLE `mobileadmin` (
  `adminId` int(11) NOT NULL,
  `phone` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mobileadmin`
--

INSERT INTO `mobileadmin` (`adminId`, `phone`) VALUES
(1, '0355287940');

-- --------------------------------------------------------

--
-- Table structure for table `mobilebuyer`
--

CREATE TABLE `mobilebuyer` (
  `buyerId` int(11) NOT NULL,
  `phone` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mobileseller`
--

CREATE TABLE `mobileseller` (
  `sellerId` int(11) NOT NULL,
  `phoneNo` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE `notification` (
  `id` int(11) NOT NULL,
  `message` varchar(300) NOT NULL,
  `date` date NOT NULL DEFAULT curdate(),
  `seen` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `bill`
--
ALTER TABLE `bill`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `buyer`
--
ALTER TABLE `buyer`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cartId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `categoryId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `childcategory`
--
ALTER TABLE `childcategory`
  MODIFY `childcategoryId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `item`
--
ALTER TABLE `item`
  MODIFY `itemId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `notification`
--
ALTER TABLE `notification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `orderId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `seller`
--
ALTER TABLE `seller`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

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
