/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 8.0.30 : Database - laravel_laundry
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`laravel_laundry` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `laravel_laundry`;

/*Table structure for table `antar_jemput` */

DROP TABLE IF EXISTS `antar_jemput`;

CREATE TABLE `antar_jemput` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_pesanan` bigint unsigned DEFAULT NULL,
  `id_pelanggan` bigint unsigned DEFAULT NULL,
  `tracking_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_pelanggan` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_hp` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `layanan` enum('antar','jemput','antar-jemput') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'antar',
  `alamat_antar` text COLLATE utf8mb4_unicode_ci,
  `alamat_jemput` text COLLATE utf8mb4_unicode_ci,
  `layanan_laundry` enum('daily_kiloan','cuci_setrika','laundry_sepatu','laundry_tas','laundry_sarung_bantal','laundry_bed_cover','laundry_sprei','laundry_boneka') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'daily_kiloan',
  `status` enum('baru','proses','siap_ambil','antar','jemput','selesai','batal') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'baru',
  `selesai_at` datetime DEFAULT NULL,
  `waktu_antar` datetime DEFAULT NULL,
  `waktu_jemput` datetime DEFAULT NULL,
  `harga` decimal(10,2) NOT NULL DEFAULT '5000.00',
  `status_pembayaran` enum('belum dibayar','sudah dibayar') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'belum dibayar',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `antar_jemput_id_pesanan_foreign` (`id_pesanan`),
  KEY `antar_jemput_id_pelanggan_foreign` (`id_pelanggan`),
  CONSTRAINT `antar_jemput_id_pelanggan_foreign` FOREIGN KEY (`id_pelanggan`) REFERENCES `pelanggan` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `antar_jemput_id_pesanan_foreign` FOREIGN KEY (`id_pesanan`) REFERENCES `pesanan` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `antar_jemput` */

/*Table structure for table `antarjemput_status` */

DROP TABLE IF EXISTS `antarjemput_status`;

CREATE TABLE `antarjemput_status` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `antarjemput_status` */

/*Table structure for table `customers` */

DROP TABLE IF EXISTS `customers`;

CREATE TABLE `customers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_hp` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `customers` */

/*Table structure for table `data_pelanggan` */

DROP TABLE IF EXISTS `data_pelanggan`;

CREATE TABLE `data_pelanggan` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jenis_kelamin` enum('L','P') COLLATE utf8mb4_unicode_ci NOT NULL,
  `telepon` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `mitra_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `data_pelanggan_telepon_unique` (`telepon`),
  KEY `data_pelanggan_mitra_id_foreign` (`mitra_id`),
  CONSTRAINT `data_pelanggan_mitra_id_foreign` FOREIGN KEY (`mitra_id`) REFERENCES `mitra` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `data_pelanggan` */

/*Table structure for table `detail_layanan_transaksi` */

DROP TABLE IF EXISTS `detail_layanan_transaksi`;

CREATE TABLE `detail_layanan_transaksi` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `harga_jenis_layanan_id` bigint unsigned NOT NULL,
  `detail_transaksi_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `detail_layanan_transaksi_harga_jenis_layanan_id_foreign` (`harga_jenis_layanan_id`),
  KEY `detail_layanan_transaksi_detail_transaksi_id_foreign` (`detail_transaksi_id`),
  CONSTRAINT `detail_layanan_transaksi_detail_transaksi_id_foreign` FOREIGN KEY (`detail_transaksi_id`) REFERENCES `detail_transaksi` (`id`),
  CONSTRAINT `detail_layanan_transaksi_harga_jenis_layanan_id_foreign` FOREIGN KEY (`harga_jenis_layanan_id`) REFERENCES `harga_jenis_layanan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `detail_layanan_transaksi` */

/*Table structure for table `detail_transaksi` */

DROP TABLE IF EXISTS `detail_transaksi`;

CREATE TABLE `detail_transaksi` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `total_item` int NOT NULL,
  `harga_layanan_akhir` double NOT NULL,
  `total_biaya_layanan` double NOT NULL,
  `total_biaya_prioritas` double NOT NULL,
  `transaksi_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `detail_transaksi_transaksi_id_foreign` (`transaksi_id`),
  CONSTRAINT `detail_transaksi_transaksi_id_foreign` FOREIGN KEY (`transaksi_id`) REFERENCES `transaksi` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `detail_transaksi` */

/*Table structure for table `failed_jobs` */

DROP TABLE IF EXISTS `failed_jobs`;

CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `failed_jobs` */

/*Table structure for table `harga_jenis_layanan` */

DROP TABLE IF EXISTS `harga_jenis_layanan`;

CREATE TABLE `harga_jenis_layanan` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `harga` double NOT NULL,
  `jenis_satuan` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jenis_layanan_id` bigint unsigned NOT NULL,
  `jenis_item_id` bigint unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `harga_jenis_layanan_jenis_layanan_id_foreign` (`jenis_layanan_id`),
  KEY `harga_jenis_layanan_jenis_item_id_foreign` (`jenis_item_id`),
  CONSTRAINT `harga_jenis_layanan_jenis_item_id_foreign` FOREIGN KEY (`jenis_item_id`) REFERENCES `jenis_item` (`id`),
  CONSTRAINT `harga_jenis_layanan_jenis_layanan_id_foreign` FOREIGN KEY (`jenis_layanan_id`) REFERENCES `jenis_layanan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `harga_jenis_layanan` */

/*Table structure for table `jenis_item` */

DROP TABLE IF EXISTS `jenis_item`;

CREATE TABLE `jenis_item` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deskripsi` text COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `jenis_item` */

/*Table structure for table `jenis_layanan` */

DROP TABLE IF EXISTS `jenis_layanan`;

CREATE TABLE `jenis_layanan` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama_layanan` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deskripsi` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `jenis_layanan` */

insert  into `jenis_layanan`(`id`,`nama_layanan`,`deskripsi`,`deleted_at`,`created_at`,`updated_at`) values 
(1,'Laundry Kiloan','Pakaian dicuci berdasarkan berat per kilogram, cocok untuk pakaian harian dalam jumlah banyak.',NULL,'2025-11-11 08:53:30','2025-11-11 08:53:30'),
(2,'Laundry Satuan','Pencucian per item, seperti jas, gaun, kebaya, atau selimut yang butuh perhatian khusus.',NULL,'2025-11-11 08:53:30','2025-11-11 08:53:30'),
(3,'Dry Cleaning','Pencucian tanpa air menggunakan cairan kimia khusus untuk bahan sensitif seperti sutra atau wol.',NULL,'2025-11-11 08:53:30','2025-11-11 08:53:30'),
(4,'Cuci Setrika (Wash & Iron)','Pakaian dicuci dan disetrika hingga rapi dan wangi, siap langsung dipakai.',NULL,'2025-11-11 08:53:30','2025-11-11 08:53:30'),
(5,'Cuci Lipat (Wash & Fold)','Pakaian hanya dicuci dan dilipat tanpa proses setrika, praktis untuk pakaian santai.',NULL,'2025-11-11 08:53:30','2025-11-11 08:53:30'),
(6,'Setrika Saja','Layanan hanya penyetrikaan untuk pakaian yang sudah dicuci sendiri di rumah.',NULL,'2025-11-11 08:53:30','2025-11-11 08:53:30'),
(7,'Laundry Express','Layanan cuci cepat dengan waktu pengerjaan 3–6 jam atau 1 hari, cocok untuk kebutuhan mendesak.',NULL,'2025-11-11 08:53:30','2025-11-11 08:53:30'),
(8,'Laundry Sepatu & Tas','Perawatan khusus sepatu dan tas dengan teknik aman sesuai material.',NULL,'2025-11-11 08:53:30','2025-11-11 08:53:30'),
(9,'Laundry Karpet & Gorden','Pencucian khusus untuk karpet, gorden, atau barang besar agar bersih dan wangi.',NULL,'2025-11-11 08:53:30','2025-11-11 08:53:30'),
(10,'Laundry Boneka','Membersihkan boneka agar tetap lembut, bersih, dan aman untuk anak-anak.',NULL,'2025-11-11 08:53:30','2025-11-11 08:53:30'),
(11,'Laundry Hotel & Restoran','Layanan skala besar untuk sprei, selimut, seragam, dan linen dengan standar kebersihan tinggi.',NULL,'2025-11-11 08:53:30','2025-11-11 08:53:30');

/*Table structure for table `layanan_prioritas` */

DROP TABLE IF EXISTS `layanan_prioritas`;

CREATE TABLE `layanan_prioritas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deskripsi` text COLLATE utf8mb4_unicode_ci,
  `harga` double NOT NULL,
  `prioritas` int NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `layanan_prioritas` */

/*Table structure for table `layanan_tambahan` */

DROP TABLE IF EXISTS `layanan_tambahan`;

CREATE TABLE `layanan_tambahan` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `harga` double NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `layanan_tambahan` */

/*Table structure for table `layanan_tambahan_transaksi` */

DROP TABLE IF EXISTS `layanan_tambahan_transaksi`;

CREATE TABLE `layanan_tambahan_transaksi` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `layanan_tambahan_id` bigint unsigned NOT NULL,
  `transaksi_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `mitra_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `layanan_tambahan_transaksi_layanan_tambahan_id_foreign` (`layanan_tambahan_id`),
  KEY `layanan_tambahan_transaksi_transaksi_id_foreign` (`transaksi_id`),
  KEY `layanan_tambahan_transaksi_mitra_id_foreign` (`mitra_id`),
  CONSTRAINT `layanan_tambahan_transaksi_layanan_tambahan_id_foreign` FOREIGN KEY (`layanan_tambahan_id`) REFERENCES `layanan_tambahan` (`id`),
  CONSTRAINT `layanan_tambahan_transaksi_mitra_id_foreign` FOREIGN KEY (`mitra_id`) REFERENCES `mitra` (`id`) ON DELETE CASCADE,
  CONSTRAINT `layanan_tambahan_transaksi_transaksi_id_foreign` FOREIGN KEY (`transaksi_id`) REFERENCES `transaksi` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `layanan_tambahan_transaksi` */

/*Table structure for table `migrations` */

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `migrations` */

insert  into `migrations`(`id`,`migration`,`batch`) values 
(1,'2014_10_12_000000_create_users_table',1),
(2,'2014_10_12_100000_create_password_reset_tokens_table',1),
(3,'2019_08_19_000000_create_failed_jobs_table',1),
(4,'2019_12_14_000001_create_personal_access_tokens_table',1),
(5,'2023_12_12_072543_create_permission_tables',1),
(6,'2023_12_31_064553_create_settings_table',1),
(7,'2025_09_08_041747_create_customers_table',1),
(8,'2025_09_08_041811_create_services_table',1),
(9,'2025_09_08_042021_create_orders_table',1),
(10,'2025_09_08_084850_create_pelanggan_table',1),
(11,'2025_09_09_065039_create_paket_table',1),
(12,'2025_09_09_065137_create_pesanan_table',1),
(13,'2025_09_09_065158_create_antar_jemput_table',1),
(14,'2025_09_09_065440_create_antarjemput_status_table',1),
(15,'2025_09_09_065724_create_riwayat_table',1),
(16,'2025_09_09_065842_create_toko_status_table',1),
(17,'2025_09_25_085344_create_data_pelanggan_table',1),
(18,'2025_09_25_132053_create_pegawai_laundry_table',1),
(19,'2025_09_25_133259_create_jenis_layanan_table',1),
(20,'2025_09_25_134623_create_jenis_item_table',1),
(21,'2025_09_25_134808_create_harga_jenis_layanan_table',1),
(22,'2025_09_25_141235_create_layanan_prioritas_table',1),
(23,'2025_09_25_141257_create_transaksi_table',1),
(24,'2025_09_25_141606_create_detail_transaksi_table',1),
(25,'2025_09_25_141745_create_detail_layanan_transaksi_table',1),
(26,'2025_09_25_141823_create_layanan_tambahan_table',1),
(27,'2025_09_25_141849_create_layanan_tambahan_transaksi_table',1),
(28,'2025_10_16_082748_create_mitra_table',1),
(29,'2025_10_16_083559_add_mitra_id_to_existing_tables',1);

/*Table structure for table `mitra` */

DROP TABLE IF EXISTS `mitra`;

CREATE TABLE `mitra` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama_laundry` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status_validasi` enum('menunggu','diterima','ditolak') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'menunggu',
  `alamat_laundry` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto_ktp` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status_toko` enum('buka','tutup') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'buka',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `mitra` */

/*Table structure for table `model_has_permissions` */

DROP TABLE IF EXISTS `model_has_permissions`;

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `model_has_permissions` */

/*Table structure for table `model_has_roles` */

DROP TABLE IF EXISTS `model_has_roles`;

CREATE TABLE `model_has_roles` (
  `role_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `model_has_roles` */

insert  into `model_has_roles`(`role_id`,`model_type`,`model_id`) values 
(1,'App\\Models\\User','1'),
(3,'App\\Models\\User','2'),
(3,'App\\Models\\User','3');

/*Table structure for table `orders` */

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` bigint unsigned NOT NULL,
  `service_id` bigint unsigned NOT NULL,
  `berat` decimal(8,2) NOT NULL,
  `total_harga` decimal(10,2) NOT NULL,
  `status` enum('pending','processing','ready','completed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `perkiraan_selesai` timestamp NULL DEFAULT NULL,
  `catatan` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orders_order_number_unique` (`order_number`),
  KEY `orders_customer_id_foreign` (`customer_id`),
  KEY `orders_service_id_foreign` (`service_id`),
  CONSTRAINT `orders_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `orders_service_id_foreign` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `orders` */

/*Table structure for table `paket` */

DROP TABLE IF EXISTS `paket`;

CREATE TABLE `paket` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `harga` decimal(10,2) NOT NULL,
  `keterangan` text COLLATE utf8mb4_unicode_ci,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `paket` */

/*Table structure for table `password_reset_tokens` */

DROP TABLE IF EXISTS `password_reset_tokens`;

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `password_reset_tokens` */

/*Table structure for table `pegawai_laundry` */

DROP TABLE IF EXISTS `pegawai_laundry`;

CREATE TABLE `pegawai_laundry` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jenis_kelamin` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tempat_lahir` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `telepon` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `mulai_kerja` date DEFAULT NULL,
  `selesai_kerja` date DEFAULT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `mitra_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pegawai_laundry_user_id_foreign` (`user_id`),
  KEY `pegawai_laundry_mitra_id_foreign` (`mitra_id`),
  CONSTRAINT `pegawai_laundry_mitra_id_foreign` FOREIGN KEY (`mitra_id`) REFERENCES `mitra` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pegawai_laundry_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `pegawai_laundry` */

/*Table structure for table `pelanggan` */

DROP TABLE IF EXISTS `pelanggan`;

CREATE TABLE `pelanggan` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `alamat` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `pelanggan_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pelanggan_user_id_foreign` (`user_id`),
  KEY `pelanggan_pelanggan_id_foreign` (`pelanggan_id`),
  CONSTRAINT `pelanggan_pelanggan_id_foreign` FOREIGN KEY (`pelanggan_id`) REFERENCES `pelanggan` (`id`) ON DELETE SET NULL,
  CONSTRAINT `pelanggan_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `pelanggan` */

/*Table structure for table `permissions` */

DROP TABLE IF EXISTS `permissions`;

CREATE TABLE `permissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `permissions` */

insert  into `permissions`(`id`,`name`,`guard_name`,`created_at`,`updated_at`) values 
(1,'dashboard','api','2025-11-11 08:53:28','2025-11-11 08:53:28'),
(2,'master','api','2025-11-11 08:53:28','2025-11-11 08:53:28'),
(3,'master-user','api','2025-11-11 08:53:28','2025-11-11 08:53:28'),
(4,'master-role','api','2025-11-11 08:53:28','2025-11-11 08:53:28'),
(5,'website','api','2025-11-11 08:53:28','2025-11-11 08:53:28'),
(6,'setting','api','2025-11-11 08:53:28','2025-11-11 08:53:28'),
(7,'antar-jemput','api','2025-11-11 08:53:28','2025-11-11 08:53:28'),
(8,'datapelanggan','api','2025-11-11 08:53:29','2025-11-11 08:53:29'),
(9,'pendapatan','api','2025-11-11 08:53:29','2025-11-11 08:53:29'),
(10,'tambahpelanggan','api','2025-11-11 08:53:29','2025-11-11 08:53:29'),
(11,'mitra','api','2025-11-11 08:53:29','2025-11-11 08:53:29'),
(12,'laundrydetail','api','2025-11-11 08:53:29','2025-11-11 08:53:29'),
(13,'pendaftaran','api','2025-11-11 08:53:29','2025-11-11 08:53:29'),
(14,'layanan','api','2025-11-11 08:53:29','2025-11-11 08:53:29'),
(15,'jenisitem','api','2025-11-11 08:53:29','2025-11-11 08:53:29'),
(16,'jenislayanan','api','2025-11-11 08:53:29','2025-11-11 08:53:29'),
(17,'hargajenislayanan','api','2025-11-11 08:53:29','2025-11-11 08:53:29'),
(18,'layananprioritas','api','2025-11-11 08:53:29','2025-11-11 08:53:29'),
(19,'layanantambahan','api','2025-11-11 08:53:29','2025-11-11 08:53:29'),
(20,'transaksi','api','2025-11-11 08:53:29','2025-11-11 08:53:29'),
(21,'transaksilayanan','api','2025-11-11 08:53:29','2025-11-11 08:53:29'),
(22,'beranda','api','2025-11-11 08:53:29','2025-11-11 08:53:29'),
(23,'pelanggan','api','2025-11-11 08:53:29','2025-11-11 08:53:29'),
(24,'antar','api','2025-11-11 08:53:29','2025-11-11 08:53:29'),
(25,'jemput','api','2025-11-11 08:53:29','2025-11-11 08:53:29'),
(26,'riwayat','api','2025-11-11 08:53:29','2025-11-11 08:53:29');

/*Table structure for table `personal_access_tokens` */

DROP TABLE IF EXISTS `personal_access_tokens`;

CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `personal_access_tokens` */

/*Table structure for table `pesanan` */

DROP TABLE IF EXISTS `pesanan`;

CREATE TABLE `pesanan` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tracking_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_pelanggan` bigint unsigned DEFAULT NULL,
  `id_paket` bigint unsigned DEFAULT NULL,
  `berat` decimal(5,2) DEFAULT NULL,
  `harga` decimal(10,2) DEFAULT NULL,
  `status` enum('diproses','selesai','dibatalkan') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'diproses',
  `status_pembayaran` enum('belum_dibayar','sudah_dibayar') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'belum_dibayar',
  `waktu` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `harga_custom` decimal(10,2) NOT NULL DEFAULT '0.00',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pesanan_tracking_code_unique` (`tracking_code`),
  KEY `pesanan_id_pelanggan_foreign` (`id_pelanggan`),
  KEY `pesanan_id_paket_foreign` (`id_paket`),
  CONSTRAINT `pesanan_id_paket_foreign` FOREIGN KEY (`id_paket`) REFERENCES `paket` (`id`) ON DELETE SET NULL,
  CONSTRAINT `pesanan_id_pelanggan_foreign` FOREIGN KEY (`id_pelanggan`) REFERENCES `pelanggan` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `pesanan` */

/*Table structure for table `riwayat` */

DROP TABLE IF EXISTS `riwayat`;

CREATE TABLE `riwayat` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_pesanan` bigint unsigned NOT NULL,
  `tgl_selesai` date NOT NULL,
  `harga` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `riwayat_id_pesanan_foreign` (`id_pesanan`),
  CONSTRAINT `riwayat_id_pesanan_foreign` FOREIGN KEY (`id_pesanan`) REFERENCES `pesanan` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `riwayat` */

/*Table structure for table `role_has_permissions` */

DROP TABLE IF EXISTS `role_has_permissions`;

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `role_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `role_has_permissions` */

insert  into `role_has_permissions`(`permission_id`,`role_id`) values 
(1,1),
(2,1),
(3,1),
(4,1),
(5,1),
(6,1),
(7,1),
(8,1),
(9,1),
(10,1),
(11,1),
(12,1),
(13,1),
(14,1),
(15,1),
(16,1),
(17,1),
(18,1),
(19,1),
(20,1),
(21,1),
(22,2),
(23,2),
(24,2),
(25,2),
(26,2),
(20,4),
(21,4);

/*Table structure for table `roles` */

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `full_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `roles` */

insert  into `roles`(`id`,`name`,`full_name`,`guard_name`,`created_at`,`updated_at`) values 
(1,'admin','Administrator','api','2025-11-11 08:53:28','2025-11-11 08:53:28'),
(2,'pelangan','pelanggan','api','2025-11-11 08:53:28','2025-11-11 08:53:28'),
(3,'pegawai','Pegawai','api','2025-11-11 08:53:28','2025-11-11 08:53:28'),
(4,'mitra','Mitra','api','2025-11-11 08:53:28','2025-11-11 08:53:28');

/*Table structure for table `services` */

DROP TABLE IF EXISTS `services`;

CREATE TABLE `services` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deskripsi` text COLLATE utf8mb4_unicode_ci,
  `harga_per_kg` decimal(10,2) NOT NULL,
  `durasi_jam` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `services` */

/*Table structure for table `settings` */

DROP TABLE IF EXISTS `settings`;

CREATE TABLE `settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `app` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `banner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bg_auth` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dinas` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pemerintah` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telepon` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_uuid_unique` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `settings` */

insert  into `settings`(`id`,`uuid`,`app`,`description`,`logo`,`banner`,`bg_auth`,`dinas`,`pemerintah`,`alamat`,`telepon`,`email`,`created_at`,`updated_at`) values 
(1,'5f753942-be8c-466b-96bc-066054654424','e-SAKIP DLH','Aplikasi e-SAKIP Dinas Lingkungan Hidup','/media/logo.png','/media/misc/banner.jpg','/media/misc/bg-auth.jpg','Dinas Lingkungan Hidup','Pemerintah Provinsi Jawa Timur','','','','2025-11-11 08:53:30','2025-11-11 08:53:30');

/*Table structure for table `toko_status` */

DROP TABLE IF EXISTS `toko_status`;

CREATE TABLE `toko_status` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('buka','tutup') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'buka',
  `waktu` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `toko_status` */

/*Table structure for table `transaksi` */

DROP TABLE IF EXISTS `transaksi`;

CREATE TABLE `transaksi` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nota_layanan` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nota_pelanggan` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `waktu` datetime NOT NULL,
  `total_biaya_layanan` double NOT NULL,
  `total_biaya_prioritas` double NOT NULL,
  `total_biaya_layanan_tambahan` double NOT NULL,
  `total_bayar_akhir` double NOT NULL,
  `jenis_pembayaran` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bayar` double NOT NULL,
  `kembalian` double NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `layanan_prioritas_id` bigint unsigned NOT NULL,
  `pelanggan_id` bigint unsigned NOT NULL,
  `pegawai_id` bigint unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaksi_nota_layanan_unique` (`nota_layanan`),
  UNIQUE KEY `transaksi_nota_pelanggan_unique` (`nota_pelanggan`),
  KEY `transaksi_layanan_prioritas_id_foreign` (`layanan_prioritas_id`),
  KEY `transaksi_pelanggan_id_foreign` (`pelanggan_id`),
  KEY `transaksi_pegawai_id_foreign` (`pegawai_id`),
  CONSTRAINT `transaksi_layanan_prioritas_id_foreign` FOREIGN KEY (`layanan_prioritas_id`) REFERENCES `layanan_prioritas` (`id`),
  CONSTRAINT `transaksi_pegawai_id_foreign` FOREIGN KEY (`pegawai_id`) REFERENCES `pegawai_laundry` (`id`),
  CONSTRAINT `transaksi_pelanggan_id_foreign` FOREIGN KEY (`pelanggan_id`) REFERENCES `data_pelanggan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `transaksi` */

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `mitra_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_uuid_unique` (`uuid`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_phone_unique` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`uuid`,`name`,`email`,`phone`,`photo`,`password`,`remember_token`,`created_at`,`updated_at`,`mitra_id`) values 
(1,'49d22d0c-3adb-45f7-ad4b-89b859063838','Admin','admin@gmail.com','08123456789',NULL,'$2y$12$YeS0Rkqy.FZk1erT3poV1uJlQlZdjNd8OstEf2zrbAU6y8b4byJKq',NULL,'2025-11-11 08:53:29','2025-11-11 08:53:29',NULL),
(2,'963dbe69-d665-482b-a987-5f7e137f076d','Pegawai','pegawai@gmail.com','08123456788',NULL,'$2y$12$N8Vy9Xa5BPtJTvinHHrzs.tHrCjxwp4x5L0Bj5Z4ZoMGfvjTVezIW',NULL,'2025-11-11 08:53:29','2025-11-11 08:53:29',NULL),
(3,'3fbe9b18-c35f-4f9e-bf5f-5b8b702afbd2','mitra1','mitra1@gmail.com','08123459998',NULL,'$2y$12$eRA4pQpX/Pv/L9vTAZQHFex7xiaFax8.TVCU2ztJinUiqDOTzKu2K',NULL,'2025-11-11 08:53:30','2025-11-11 08:53:30',1),
(5,'adc2a006-56eb-4430-a11b-065d58c69e1c','sarah','sarahcyntiaa.07@gmail.com','08123456786',NULL,'$2y$12$S0TVzXLKuPeM6KxpVqRPnO4qeEgBkfs.p2HuwQg1SsR6XxDse5wz6',NULL,'2025-11-11 14:30:56','2025-11-11 14:30:56',NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
