-- CreateTable
CREATE TABLE `Account` (
    `id` BINARY(16) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NULL,
    `password` VARCHAR(191) NOT NULL,
    `role` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Account_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Role` (
    `name` VARCHAR(191) NOT NULL DEFAULT 'customer',

    PRIMARY KEY (`name`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Customer` (
    `account_id` BINARY(16) NOT NULL,
    `gender` VARCHAR(191) NOT NULL,
    `born_date` DATETIME(3) NOT NULL,
    `phone` VARCHAR(191) NOT NULL,
    `avatar` VARCHAR(191) NULL,

    PRIMARY KEY (`account_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Admin` (
    `account_id` BINARY(16) NOT NULL,

    PRIMARY KEY (`account_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `LaptopModel` (
    `id` BINARY(16) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `brand` VARCHAR(191) NOT NULL,
    `cpu` VARCHAR(191) NOT NULL,
    `ram` VARCHAR(191) NOT NULL,
    `storage` VARCHAR(191) NOT NULL,
    `display` VARCHAR(191) NOT NULL,
    `color` ENUM('Red', 'Blue', 'Green', 'Black', 'White', 'Silver', 'Gold') NOT NULL,
    `price` DECIMAL(10, 2) NOT NULL,
    `description` VARCHAR(191) NULL,

    INDEX `LaptopModel_cpu_idx`(`cpu`),
    INDEX `LaptopModel_ram_idx`(`ram`),
    INDEX `LaptopModel_brand_idx`(`brand`),
    INDEX `LaptopModel_cpu_ram_idx`(`cpu`, `ram`),
    INDEX `LaptopModel_cpu_ram_brand_idx`(`cpu`, `ram`, `brand`),
    INDEX `LaptopModel_cpu_ram_brand_price_idx`(`cpu`, `ram`, `brand`, `price`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `LaptopOnSale` (
    `laptop_model_id` BINARY(16) NOT NULL,
    `sale_id` BINARY(16) NOT NULL,

    PRIMARY KEY (`laptop_model_id`, `sale_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Sale` (
    `id` BINARY(16) NOT NULL,
    `event_description` VARCHAR(191) NULL,
    `start_at` DATETIME(3) NOT NULL,
    `end_at` DATETIME(3) NOT NULL,
    `discount` DOUBLE NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Laptop` (
    `mac_id` BINARY(16) NOT NULL,
    `MFG` DATETIME(3) NOT NULL,
    `model_id` BINARY(16) NOT NULL,
    `status` ENUM('Available', 'SoldOut', 'Maintenance') NOT NULL DEFAULT 'Available',

    INDEX `Laptop_status_idx`(`status`),
    INDEX `Laptop_model_id_idx`(`model_id`),
    PRIMARY KEY (`mac_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Order` (
    `id` BINARY(16) NOT NULL,
    `customer_id` BINARY(16) NOT NULL,
    `status` ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') NOT NULL DEFAULT 'Pending',
    `address` VARCHAR(191) NOT NULL,
    `date_create` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `Order_customer_id_idx`(`customer_id`),
    INDEX `Order_status_idx`(`status`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `OrderDetail` (
    `id` BINARY(16) NOT NULL,
    `order_id` BINARY(16) NOT NULL,
    `laptop_model_id` BINARY(16) NOT NULL,
    `quantity` INTEGER NOT NULL,
    `price` DECIMAL(10, 2) NOT NULL,

    INDEX `OrderDetail_order_id_idx`(`order_id`),
    INDEX `OrderDetail_laptop_model_id_idx`(`laptop_model_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Payment` (
    `id` BINARY(16) NOT NULL,
    `customer_id` BINARY(16) NOT NULL,
    `order_id` BINARY(16) NOT NULL,
    `type` ENUM('VNPay', 'Momo', 'ZaloPay', 'CashOnDelivery') NOT NULL,
    `status` ENUM('Pending', 'Success', 'Failed') NOT NULL,
    `payment_method_id` BINARY(16) NULL,

    UNIQUE INDEX `Payment_order_id_key`(`order_id`),
    INDEX `Payment_customer_id_idx`(`customer_id`),
    INDEX `Payment_order_id_idx`(`order_id`),
    INDEX `Payment_status_idx`(`status`),
    INDEX `Payment_type_idx`(`type`),
    INDEX `Payment_payment_method_id_idx`(`payment_method_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `PaymentMethod` (
    `id` BINARY(16) NOT NULL,
    `data` JSON NOT NULL,
    `type` ENUM('VNPay', 'Momo', 'ZaloPay', 'CashOnDelivery') NOT NULL,

    INDEX `PaymentMethod_type_idx`(`type`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `LaptopOnImage` (
    `laptop_model_id` BINARY(16) NOT NULL,
    `image_id` BINARY(16) NOT NULL,

    PRIMARY KEY (`laptop_model_id`, `image_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Image` (
    `id` BINARY(16) NOT NULL,
    `image_url` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Comment` (
    `id` BINARY(16) NOT NULL,
    `laptop_model_id` BINARY(16) NOT NULL,
    `account_id` BINARY(16) NOT NULL,
    `parent_id` BINARY(16) NULL,
    `body` VARCHAR(191) NOT NULL,

    INDEX `Comment_laptop_model_id_idx`(`laptop_model_id`),
    INDEX `Comment_account_id_idx`(`account_id`),
    INDEX `Comment_parent_id_idx`(`parent_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Chat` (
    `id` BINARY(16) NOT NULL,
    `sender_id` BINARY(16) NOT NULL,
    `receiver_id` BINARY(16) NOT NULL,
    `message` VARCHAR(191) NOT NULL,
    `create_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Address` (
    `id` BINARY(16) NOT NULL,
    `customer_id` BINARY(16) NOT NULL,
    `city` VARCHAR(191) NOT NULL,
    `district` VARCHAR(191) NOT NULL,
    `ward` VARCHAR(191) NULL,
    `street` VARCHAR(191) NOT NULL,
    `phone` VARCHAR(191) NOT NULL,

    INDEX `Address_customer_id_idx`(`customer_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Cart` (
    `id` BINARY(16) NOT NULL,
    `customer_id` BINARY(16) NOT NULL,
    `quantity` INTEGER NOT NULL,

    INDEX `Cart_customer_id_idx`(`customer_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `LaptopOnCart` (
    `cart_id` BINARY(16) NOT NULL,
    `laptop_model_id` BINARY(16) NOT NULL,
    `quantity` INTEGER NOT NULL,

    PRIMARY KEY (`cart_id`, `laptop_model_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Account` ADD CONSTRAINT `Account_role_fkey` FOREIGN KEY (`role`) REFERENCES `Role`(`name`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Customer` ADD CONSTRAINT `Customer_account_id_fkey` FOREIGN KEY (`account_id`) REFERENCES `Account`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Admin` ADD CONSTRAINT `Admin_account_id_fkey` FOREIGN KEY (`account_id`) REFERENCES `Account`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `LaptopOnSale` ADD CONSTRAINT `LaptopOnSale_laptop_model_id_fkey` FOREIGN KEY (`laptop_model_id`) REFERENCES `LaptopModel`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `LaptopOnSale` ADD CONSTRAINT `LaptopOnSale_sale_id_fkey` FOREIGN KEY (`sale_id`) REFERENCES `Sale`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Laptop` ADD CONSTRAINT `Laptop_model_id_fkey` FOREIGN KEY (`model_id`) REFERENCES `LaptopModel`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Order` ADD CONSTRAINT `Order_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `Customer`(`account_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `OrderDetail` ADD CONSTRAINT `OrderDetail_order_id_fkey` FOREIGN KEY (`order_id`) REFERENCES `Order`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `OrderDetail` ADD CONSTRAINT `OrderDetail_laptop_model_id_fkey` FOREIGN KEY (`laptop_model_id`) REFERENCES `LaptopModel`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Payment` ADD CONSTRAINT `Payment_order_id_fkey` FOREIGN KEY (`order_id`) REFERENCES `Order`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Payment` ADD CONSTRAINT `Payment_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `Customer`(`account_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Payment` ADD CONSTRAINT `Payment_payment_method_id_fkey` FOREIGN KEY (`payment_method_id`) REFERENCES `PaymentMethod`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `LaptopOnImage` ADD CONSTRAINT `LaptopOnImage_laptop_model_id_fkey` FOREIGN KEY (`laptop_model_id`) REFERENCES `LaptopModel`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `LaptopOnImage` ADD CONSTRAINT `LaptopOnImage_image_id_fkey` FOREIGN KEY (`image_id`) REFERENCES `Image`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Comment` ADD CONSTRAINT `Comment_laptop_model_id_fkey` FOREIGN KEY (`laptop_model_id`) REFERENCES `LaptopModel`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Comment` ADD CONSTRAINT `Comment_account_id_fkey` FOREIGN KEY (`account_id`) REFERENCES `Account`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Comment` ADD CONSTRAINT `Comment_parent_id_fkey` FOREIGN KEY (`parent_id`) REFERENCES `Comment`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Chat` ADD CONSTRAINT `Chat_sender_id_fkey` FOREIGN KEY (`sender_id`) REFERENCES `Account`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Chat` ADD CONSTRAINT `Chat_receiver_id_fkey` FOREIGN KEY (`receiver_id`) REFERENCES `Account`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Address` ADD CONSTRAINT `Address_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `Customer`(`account_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Cart` ADD CONSTRAINT `Cart_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `Customer`(`account_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `LaptopOnCart` ADD CONSTRAINT `LaptopOnCart_cart_id_fkey` FOREIGN KEY (`cart_id`) REFERENCES `Cart`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `LaptopOnCart` ADD CONSTRAINT `LaptopOnCart_laptop_model_id_fkey` FOREIGN KEY (`laptop_model_id`) REFERENCES `LaptopModel`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

