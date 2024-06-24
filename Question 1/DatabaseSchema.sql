CREATE TABLE `Hotels` (
  `hotel_id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `address` varchar(255),
  `city` varchar(100),
  `state` varchar(100),
  `country` varchar(100),
  `zip` varchar(20),
  `phone` varchar(20),
  `email` varchar(100),
  `num_available_rooms` int
);

CREATE TABLE `Rooms` (
  `room_id` int PRIMARY KEY AUTO_INCREMENT,
  `hotel_id` int,
  `room_number` varchar(10),
  `room_type_id` int,
  `price_per_night` decimal(10,2),
  `availability` boolean DEFAULT true
);

CREATE TABLE `RoomTypes` (
  `room_type_id` int PRIMARY KEY AUTO_INCREMENT,
  `room_type_name` varchar(50),
  `description` text
);

CREATE TABLE `RoomAmenities` (
  `amenity_id` int PRIMARY KEY AUTO_INCREMENT,
  `roomId` int,
  `amenity_name` varchar(100)
);

CREATE TABLE `HotelAmenities` (
  `amenity_id` int PRIMARY KEY AUTO_INCREMENT,
  `hotel_id` int,
  `amenity_name` varchar(100)
);

CREATE TABLE `Guests` (
  `guest_id` int PRIMARY KEY AUTO_INCREMENT,
  `first_name` varchar(100),
  `last_name` varchar(100),
  `email` varchar(100) UNIQUE,
  `phone` varchar(20),
  `address` varchar(255),
  `city` varchar(100),
  `state` varchar(100),
  `country` varchar(100),
  `zip` varchar(20)
);

CREATE TABLE `Reservations` (
  `reservation_id` int PRIMARY KEY AUTO_INCREMENT,
  `guest_id` int,
  `hotel_id` int,
  `room_id` int,
  `checkin_date` date,
  `checkout_date` date,
  `total_price` decimal(10,2),
  `reservation_date` timestamp DEFAULT (current_timestamp),
  `status` varchar(50) DEFAULT 'Booked'
);

CREATE TABLE `Payments` (
  `payment_id` int PRIMARY KEY AUTO_INCREMENT,
  `reservation_id` int,
  `payment_date` timestamp DEFAULT (current_timestamp),
  `amount` decimal(10,2),
  `payment_method` varchar(50),
  `status` varchar(50) DEFAULT 'Completed'
);

CREATE TABLE `Cancellations` (
  `cancellation_id` int PRIMARY KEY AUTO_INCREMENT,
  `reservation_id` int,
  `cancellation_date` timestamp DEFAULT (current_timestamp),
  `refund_amount` decimal(10,2),
  `reason` text
);

CREATE TABLE `HotelReviews` (
  `review_id` int PRIMARY KEY AUTO_INCREMENT,
  `hotel_id` int,
  `guest_id` int,
  `review_date` timestamp DEFAULT (current_timestamp),
  `rating` int COMMENT 'Rating from 0 to 100',
  `comment` text
);

CREATE TABLE `Users` (
  `user_id` int PRIMARY KEY AUTO_INCREMENT,
  `username` varchar(50) UNIQUE NOT NULL,
  `email` varchar(100) UNIQUE NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `salt` varchar(255) NOT NULL,
  `role_id` int,
  `created_at` timestamp DEFAULT (current_timestamp),
  `updated_at` timestamp
);

CREATE TABLE `Roles` (
  `role_id` int PRIMARY KEY AUTO_INCREMENT,
  `role_name` varchar(50) UNIQUE NOT NULL,
  `description` text
);

CREATE TABLE `Permissions` (
  `permission_id` int PRIMARY KEY AUTO_INCREMENT,
  `permission_name` varchar(50) UNIQUE NOT NULL,
  `description` text
);

CREATE TABLE `RolePermissions` (
  `rolepermission_id` int PRIMARY KEY AUTO_INCREMENT,
  `role_id` int,
  `permission_id` int
);

ALTER TABLE `Rooms` ADD FOREIGN KEY (`hotel_id`) REFERENCES `Hotels` (`hotel_id`);

ALTER TABLE `Rooms` ADD FOREIGN KEY (`room_type_id`) REFERENCES `RoomTypes` (`room_type_id`);

ALTER TABLE `RoomAmenities` ADD FOREIGN KEY (`roomId`) REFERENCES `Rooms` (`room_id`);

ALTER TABLE `HotelAmenities` ADD FOREIGN KEY (`hotel_id`) REFERENCES `Hotels` (`hotel_id`);

ALTER TABLE `Reservations` ADD FOREIGN KEY (`guest_id`) REFERENCES `Guests` (`guest_id`);

ALTER TABLE `Reservations` ADD FOREIGN KEY (`hotel_id`) REFERENCES `Hotels` (`hotel_id`);

ALTER TABLE `Reservations` ADD FOREIGN KEY (`room_id`) REFERENCES `Rooms` (`room_id`);

ALTER TABLE `Payments` ADD FOREIGN KEY (`reservation_id`) REFERENCES `Reservations` (`reservation_id`);

ALTER TABLE `Cancellations` ADD FOREIGN KEY (`reservation_id`) REFERENCES `Reservations` (`reservation_id`);

ALTER TABLE `HotelReviews` ADD FOREIGN KEY (`hotel_id`) REFERENCES `Hotels` (`hotel_id`);

ALTER TABLE `HotelReviews` ADD FOREIGN KEY (`guest_id`) REFERENCES `Guests` (`guest_id`);

ALTER TABLE `Users` ADD FOREIGN KEY (`role_id`) REFERENCES `Roles` (`role_id`);

ALTER TABLE `RolePermissions` ADD FOREIGN KEY (`role_id`) REFERENCES `Roles` (`role_id`);

ALTER TABLE `RolePermissions` ADD FOREIGN KEY (`permission_id`) REFERENCES `Permissions` (`permission_id`);
