/*
 Navicat Premium Dump SQL

 Source Server         : preh5
 Source Server Type    : MySQL
 Source Server Version : 80045 (8.0.45)
 Source Host           : 119.28.114.156:13306
 Source Schema         : gva

 Target Server Type    : MySQL
 Target Server Version : 80045 (8.0.45)
 File Encoding         : 65001

 Date: 27/05/2026 23:06:31
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for activity_data
-- ----------------------------
DROP TABLE IF EXISTS `activity_data`;
CREATE TABLE `activity_data` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `name_cn` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name_en` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `market_id` bigint unsigned DEFAULT NULL,
  `total_amount` decimal(14,2) DEFAULT NULL,
  `package_id` bigint unsigned DEFAULT NULL,
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` tinyint unsigned DEFAULT NULL,
  `sort` bigint DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_activity_data_deleted_at` (`deleted_at`),
  KEY `idx_activity_market` (`market_id`),
  KEY `idx_activity_package` (`package_id`),
  KEY `idx_activity_status` (`status`),
  KEY `idx_activity_sort` (`sort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of activity_data
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for activity_market
-- ----------------------------
DROP TABLE IF EXISTS `activity_market`;
CREATE TABLE `activity_market` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name_cn` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name_en` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` tinyint unsigned DEFAULT NULL,
  `sort` bigint DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_market_code` (`code`),
  KEY `idx_activity_market_deleted_at` (`deleted_at`),
  KEY `idx_market_status` (`status`),
  KEY `idx_market_sort` (`sort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of activity_market
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for activity_package
-- ----------------------------
DROP TABLE IF EXISTS `activity_package`;
CREATE TABLE `activity_package` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `default_total_amount` decimal(14,2) DEFAULT NULL,
  `status` tinyint unsigned DEFAULT NULL,
  `sort` bigint DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_package_name` (`name`),
  KEY `idx_package_sort` (`sort`),
  KEY `idx_activity_package_deleted_at` (`deleted_at`),
  KEY `idx_package_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of activity_package
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ad_campaign
-- ----------------------------
DROP TABLE IF EXISTS `ad_campaign`;
CREATE TABLE `ad_campaign` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `platform_id` bigint unsigned DEFAULT NULL,
  `link_id` bigint unsigned DEFAULT NULL,
  `campaign_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `campaign_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `account_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `region_id` bigint unsigned DEFAULT NULL,
  `group_id` bigint unsigned DEFAULT NULL,
  `status` tinyint unsigned DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_ad_campaign_deleted_at` (`deleted_at`),
  KEY `idx_campaign_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of ad_campaign
-- ----------------------------
BEGIN;
INSERT INTO `ad_campaign` (`id`, `created_at`, `updated_at`, `deleted_at`, `platform_id`, `link_id`, `campaign_code`, `campaign_name`, `account_name`, `region_id`, `group_id`, `status`, `remark`) VALUES (1, '2026-03-22 09:50:28.913', '2026-03-22 09:50:28.913', NULL, 11, 1, '1', 'test', '', 1, 1, 1, '');
COMMIT;

-- ----------------------------
-- Table structure for ad_daily_summary
-- ----------------------------
DROP TABLE IF EXISTS `ad_daily_summary`;
CREATE TABLE `ad_daily_summary` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `summary_date` date DEFAULT NULL,
  `platform_id` bigint unsigned DEFAULT NULL,
  `campaign_id` bigint unsigned DEFAULT NULL,
  `keyword_id` bigint unsigned DEFAULT NULL,
  `link_id` bigint unsigned DEFAULT NULL,
  `region_id` bigint unsigned DEFAULT NULL,
  `device_type` enum('pc','mobile','tablet','other') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'other',
  `impressions` bigint unsigned DEFAULT NULL,
  `clicks` bigint unsigned DEFAULT NULL,
  `unique_ips` bigint unsigned DEFAULT NULL,
  `uv` bigint unsigned DEFAULT NULL,
  `pv` bigint unsigned DEFAULT NULL,
  `calls` bigint unsigned DEFAULT NULL,
  `leads` bigint unsigned DEFAULT NULL,
  `conversions` bigint unsigned DEFAULT NULL,
  `cost` decimal(14,2) DEFAULT NULL,
  `avg_rank` decimal(6,2) DEFAULT NULL,
  `ocpc` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_ad_daily_summary_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of ad_daily_summary
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ad_keyword
-- ----------------------------
DROP TABLE IF EXISTS `ad_keyword`;
CREATE TABLE `ad_keyword` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `campaign_id` bigint unsigned DEFAULT NULL,
  `keyword` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `match_type` enum('exact','phrase','broad','negative') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'broad',
  `landing_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ocpc` tinyint(1) DEFAULT NULL,
  `status` tinyint unsigned DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_ad_keyword_deleted_at` (`deleted_at`),
  KEY `idx_keyword_campaign` (`campaign_id`),
  KEY `idx_keyword_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of ad_keyword
-- ----------------------------
BEGIN;
INSERT INTO `ad_keyword` (`id`, `created_at`, `updated_at`, `deleted_at`, `campaign_id`, `keyword`, `match_type`, `landing_url`, `ocpc`, `status`, `remark`) VALUES (1, '2026-03-22 09:50:44.679', '2026-03-22 09:50:54.315', NULL, 1, '宝宝', 'broad', '', 0, 0, '');
COMMIT;

-- ----------------------------
-- Table structure for ad_platform
-- ----------------------------
DROP TABLE IF EXISTS `ad_platform`;
CREATE TABLE `ad_platform` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户UUID',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `platform_key` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` tinyint unsigned DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_ad_platform_deleted_at` (`deleted_at`),
  KEY `idx_platform_status` (`status`),
  KEY `idx_platform_uuid` (`uuid`),
  KEY `idk_platform_key` (`platform_key`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of ad_platform
-- ----------------------------
BEGIN;
INSERT INTO `ad_platform` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `platform_key`, `name`, `status`, `remark`) VALUES (1, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-20 23:47:04.570', '2026-03-20 23:47:04.570', NULL, '百度OCPC', '百度OCPC', 1, '');
INSERT INTO `ad_platform` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `platform_key`, `name`, `status`, `remark`) VALUES (2, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-20 23:47:14.032', '2026-05-09 21:12:03.749', NULL, '百度cpc', '百度cpc', 1, '');
INSERT INTO `ad_platform` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `platform_key`, `name`, `status`, `remark`) VALUES (3, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-20 23:47:26.499', '2026-03-20 23:47:26.499', NULL, '百度信息流', '百度信息流', 1, '');
INSERT INTO `ad_platform` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `platform_key`, `name`, `status`, `remark`) VALUES (4, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-20 23:47:43.522', '2026-03-20 23:47:43.522', NULL, '360点晴', '360点晴', 1, '');
INSERT INTO `ad_platform` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `platform_key`, `name`, `status`, `remark`) VALUES (5, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-20 23:48:05.922', '2026-03-20 23:48:05.922', NULL, '神马（UC/卧龙）', '神马（UC/卧龙）', 1, '');
INSERT INTO `ad_platform` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `platform_key`, `name`, `status`, `remark`) VALUES (6, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-20 23:48:32.319', '2026-03-20 23:48:32.319', NULL, 'huichuan', 'UC(超级汇川)', 1, '');
INSERT INTO `ad_platform` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `platform_key`, `name`, `status`, `remark`) VALUES (7, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-20 23:48:39.313', '2026-03-20 23:48:39.313', NULL, '搜狗', '搜狗', 1, '');
INSERT INTO `ad_platform` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `platform_key`, `name`, `status`, `remark`) VALUES (8, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-20 23:48:46.491', '2026-03-20 23:48:46.491', NULL, '今日头条', '今日头条', 1, '');
INSERT INTO `ad_platform` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `platform_key`, `name`, `status`, `remark`) VALUES (9, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-20 23:48:53.524', '2026-03-20 23:48:53.524', NULL, '抖音', '抖音', 1, '');
INSERT INTO `ad_platform` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `platform_key`, `name`, `status`, `remark`) VALUES (10, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-20 23:49:04.707', '2026-03-20 23:49:04.707', NULL, 'OPPO', 'OPPO', 1, '');
INSERT INTO `ad_platform` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `platform_key`, `name`, `status`, `remark`) VALUES (11, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-20 23:49:15.391', '2026-03-20 23:49:15.391', NULL, '腾讯广告', '腾讯广告', 1, '');
INSERT INTO `ad_platform` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `platform_key`, `name`, `status`, `remark`) VALUES (12, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', '2026-05-10 19:44:08.663', '2026-05-10 19:44:08.663', NULL, '11', '111', 1, '');
INSERT INTO `ad_platform` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `platform_key`, `name`, `status`, `remark`) VALUES (13, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', '2026-05-23 11:02:00.461', '2026-05-23 11:02:00.461', NULL, '12', '抖音', 1, '');
INSERT INTO `ad_platform` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `platform_key`, `name`, `status`, `remark`) VALUES (14, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', '2026-05-23 20:47:49.448', '2026-05-23 21:00:03.893', NULL, '百度', '百度大搜', 1, '');
INSERT INTO `ad_platform` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `platform_key`, `name`, `status`, `remark`) VALUES (15, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', '2026-05-24 21:48:15.083', '2026-05-24 21:48:15.083', NULL, '360', '360大搜', 1, '');
COMMIT;

-- ----------------------------
-- Table structure for casbin_rule
-- ----------------------------
DROP TABLE IF EXISTS `casbin_rule`;
CREATE TABLE `casbin_rule` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ptype` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `v0` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `v1` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `v2` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `v3` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `v4` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `v5` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_casbin_rule` (`ptype`,`v0`,`v1`,`v2`,`v3`,`v4`,`v5`)
) ENGINE=InnoDB AUTO_INCREMENT=3375 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of casbin_rule
-- ----------------------------
BEGIN;
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3063, 'p', '888', '/api/createApi', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3062, 'p', '888', '/api/deleteApi', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3057, 'p', '888', '/api/deleteApisByIds', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3054, 'p', '888', '/api/enterSyncApi', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3059, 'p', '888', '/api/getAllApis', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3058, 'p', '888', '/api/getApiById', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3055, 'p', '888', '/api/getApiGroups', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3060, 'p', '888', '/api/getApiList', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3053, 'p', '888', '/api/ignoreApi', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3056, 'p', '888', '/api/syncApi', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3061, 'p', '888', '/api/updateApi', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2919, 'p', '888', '/attachmentCategory/addCategory', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2918, 'p', '888', '/attachmentCategory/deleteCategory', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2920, 'p', '888', '/attachmentCategory/getCategoryList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3052, 'p', '888', '/authority/copyAuthority', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3051, 'p', '888', '/authority/createAuthority', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3050, 'p', '888', '/authority/deleteAuthority', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3048, 'p', '888', '/authority/getAuthorityList', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3047, 'p', '888', '/authority/setDataAuthority', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3049, 'p', '888', '/authority/updateAuthority', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2951, 'p', '888', '/authorityBtn/canRemoveAuthorityBtn', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2952, 'p', '888', '/authorityBtn/getAuthorityBtn', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2953, 'p', '888', '/authorityBtn/setAuthorityBtn', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2980, 'p', '888', '/autoCode/addFunc', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2988, 'p', '888', '/autoCode/createPackage', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2998, 'p', '888', '/autoCode/createTemp', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2985, 'p', '888', '/autoCode/delPackage', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2981, 'p', '888', '/autoCode/delSysHistory', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2996, 'p', '888', '/autoCode/getColumn', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3000, 'p', '888', '/autoCode/getDB', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2984, 'p', '888', '/autoCode/getMeta', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2986, 'p', '888', '/autoCode/getPackage', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2992, 'p', '888', '/autoCode/getPluginList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2982, 'p', '888', '/autoCode/getSysHistory', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2999, 'p', '888', '/autoCode/getTables', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2987, 'p', '888', '/autoCode/getTemplates', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2995, 'p', '888', '/autoCode/installPlugin', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2991, 'p', '888', '/autoCode/mcp', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2989, 'p', '888', '/autoCode/mcpList', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2990, 'p', '888', '/autoCode/mcpTest', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2997, 'p', '888', '/autoCode/preview', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2994, 'p', '888', '/autoCode/pubPlug', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2993, 'p', '888', '/autoCode/removePlugin', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2983, 'p', '888', '/autoCode/rollback', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3045, 'p', '888', '/casbin/getPolicyPathByAuthorityId', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3046, 'p', '888', '/casbin/updateCasbin', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3003, 'p', '888', '/customer/customer', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3002, 'p', '888', '/customer/customer', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3004, 'p', '888', '/customer/customer', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3005, 'p', '888', '/customer/customer', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3001, 'p', '888', '/customer/customerList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2955, 'p', '888', '/email/emailTest', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2954, 'p', '888', '/email/sendEmail', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3034, 'p', '888', '/fileUploadAndDownload/breakpointContinue', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3033, 'p', '888', '/fileUploadAndDownload/breakpointContinueFinish', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3030, 'p', '888', '/fileUploadAndDownload/deleteFile', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3029, 'p', '888', '/fileUploadAndDownload/editFileName', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3035, 'p', '888', '/fileUploadAndDownload/findFile', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3028, 'p', '888', '/fileUploadAndDownload/getFileList', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3027, 'p', '888', '/fileUploadAndDownload/importURL', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3032, 'p', '888', '/fileUploadAndDownload/removeChunk', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3031, 'p', '888', '/fileUploadAndDownload/upload', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2933, 'p', '888', '/info/createInfo', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2932, 'p', '888', '/info/deleteInfo', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2931, 'p', '888', '/info/deleteInfoByIds', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2929, 'p', '888', '/info/findInfo', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2928, 'p', '888', '/info/getInfoList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2930, 'p', '888', '/info/updateInfo', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3082, 'p', '888', '/jwt/jsonInBlacklist', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3044, 'p', '888', '/menu/addBaseMenu', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3036, 'p', '888', '/menu/addMenuAuthority', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3042, 'p', '888', '/menu/deleteBaseMenu', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3040, 'p', '888', '/menu/getBaseMenuById', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3038, 'p', '888', '/menu/getBaseMenuTree', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3043, 'p', '888', '/menu/getMenu', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3037, 'p', '888', '/menu/getMenuAuthority', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3039, 'p', '888', '/menu/getMenuList', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3041, 'p', '888', '/menu/updateBaseMenu', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2870, 'p', '888', '/promotion/createActivityData', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2868, 'p', '888', '/promotion/createActivityMarket', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2869, 'p', '888', '/promotion/createActivityPackage', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2866, 'p', '888', '/promotion/createAdCampaign', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2867, 'p', '888', '/promotion/createAdKeyword', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2865, 'p', '888', '/promotion/createAdPlatform', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2878, 'p', '888', '/promotion/createGroupMember', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2876, 'p', '888', '/promotion/createPromotionDomain', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2875, 'p', '888', '/promotion/createPromotionGroup', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2874, 'p', '888', '/promotion/createPromotionLink', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2872, 'p', '888', '/promotion/createQAAnswer', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2822, 'p', '888', '/promotion/createQAAvatarNickname', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2871, 'p', '888', '/promotion/createQAQuestion', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2873, 'p', '888', '/promotion/createQAReply', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2825, 'p', '888', '/promotion/createQASignature', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2824, 'p', '888', '/promotion/createQATag', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2823, 'p', '888', '/promotion/createQATitle', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2877, 'p', '888', '/promotion/createRegionCategory', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2836, 'p', '888', '/promotion/createTemplateWidget', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2889, 'p', '888', '/promotion/deleteActivityData', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2887, 'p', '888', '/promotion/deleteActivityMarket', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2888, 'p', '888', '/promotion/deleteActivityPackage', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2885, 'p', '888', '/promotion/deleteAdCampaign', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2886, 'p', '888', '/promotion/deleteAdKeyword', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2884, 'p', '888', '/promotion/deleteAdPlatform', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2897, 'p', '888', '/promotion/deleteGroupMember', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2895, 'p', '888', '/promotion/deletePromotionDomain', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2894, 'p', '888', '/promotion/deletePromotionGroup', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2893, 'p', '888', '/promotion/deletePromotionLink', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2891, 'p', '888', '/promotion/deleteQAAnswer', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2826, 'p', '888', '/promotion/deleteQAAvatarNickname', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2890, 'p', '888', '/promotion/deleteQAQuestion', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2892, 'p', '888', '/promotion/deleteQAReply', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2829, 'p', '888', '/promotion/deleteQASignature', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2828, 'p', '888', '/promotion/deleteQATag', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2827, 'p', '888', '/promotion/deleteQATitle', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2896, 'p', '888', '/promotion/deleteRegionCategory', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2837, 'p', '888', '/promotion/deleteTemplateWidget', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2863, 'p', '888', '/promotion/findGroupMember', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2839, 'p', '888', '/promotion/findPromotionDomain', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2840, 'p', '888', '/promotion/findPromotionGroup', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2841, 'p', '888', '/promotion/findPromotionLink', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2862, 'p', '888', '/promotion/findRegionCategory', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2835, 'p', '888', '/promotion/findTemplateWidget', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2855, 'p', '888', '/promotion/getActivityDataList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2857, 'p', '888', '/promotion/getActivityMarketList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2856, 'p', '888', '/promotion/getActivityPackageList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2860, 'p', '888', '/promotion/getAdCampaignList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2858, 'p', '888', '/promotion/getAdDailySummaryList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2859, 'p', '888', '/promotion/getAdKeywordList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2861, 'p', '888', '/promotion/getAdPlatformList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2817, 'p', '888', '/promotion/getAllEnabledQAAvatarNickname', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2816, 'p', '888', '/promotion/getAllEnabledQASignature', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2818, 'p', '888', '/promotion/getAllEnabledQATag', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2819, 'p', '888', '/promotion/getAllEnabledQATitle', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2842, 'p', '888', '/promotion/getGroupMemberList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2851, 'p', '888', '/promotion/getLinkBasic', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2852, 'p', '888', '/promotion/getLinkCode', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2853, 'p', '888', '/promotion/getLinkComment', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2854, 'p', '888', '/promotion/getLinkCompany', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2807, 'p', '888', '/promotion/getLinkGroupMembers', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2850, 'p', '888', '/promotion/getLinkTheme', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2844, 'p', '888', '/promotion/getPromotionDomainList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2845, 'p', '888', '/promotion/getPromotionGroupList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2846, 'p', '888', '/promotion/getPromotionLinkList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2805, 'p', '888', '/promotion/getQAAnswerDetail/:id', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2848, 'p', '888', '/promotion/getQAAnswerList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2815, 'p', '888', '/promotion/getQAAvatarNicknameList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2813, 'p', '888', '/promotion/getQAQuestionDetail/:id', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2849, 'p', '888', '/promotion/getQAQuestionList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2847, 'p', '888', '/promotion/getQAReplyList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2821, 'p', '888', '/promotion/getQASignatureList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2820, 'p', '888', '/promotion/getQATagList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2814, 'p', '888', '/promotion/getQATitleList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2843, 'p', '888', '/promotion/getRegionCategoryList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2834, 'p', '888', '/promotion/getTemplateWidgetList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2809, 'p', '888', '/promotion/landingMessage/list', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2810, 'p', '888', '/promotion/landingPhone/list', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2808, 'p', '888', '/promotion/landingVisit/list', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2812, 'p', '888', '/promotion/publishPromotionLink', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2903, 'p', '888', '/promotion/updateActivityData', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2901, 'p', '888', '/promotion/updateActivityMarket', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2902, 'p', '888', '/promotion/updateActivityPackage', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2899, 'p', '888', '/promotion/updateAdCampaign', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2900, 'p', '888', '/promotion/updateAdKeyword', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2898, 'p', '888', '/promotion/updateAdPlatform', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2910, 'p', '888', '/promotion/updateGroupMember', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2806, 'p', '888', '/promotion/updateGroupMemberStatus', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2909, 'p', '888', '/promotion/updatePromotionDomain', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2908, 'p', '888', '/promotion/updatePromotionGroup', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2907, 'p', '888', '/promotion/updatePromotionLink', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2811, 'p', '888', '/promotion/updatePromotionLinkOcpc', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2905, 'p', '888', '/promotion/updateQAAnswer', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2830, 'p', '888', '/promotion/updateQAAvatarNickname', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2904, 'p', '888', '/promotion/updateQAQuestion', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2906, 'p', '888', '/promotion/updateQAReply', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2833, 'p', '888', '/promotion/updateQASignature', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2832, 'p', '888', '/promotion/updateQATag', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2831, 'p', '888', '/promotion/updateQATitle', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2864, 'p', '888', '/promotion/updateRegionCategory', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2838, 'p', '888', '/promotion/updateTemplateWidget', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2882, 'p', '888', '/promotion/upsertLinkBasic', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2881, 'p', '888', '/promotion/upsertLinkCode', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2880, 'p', '888', '/promotion/upsertLinkComment', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2879, 'p', '888', '/promotion/upsertLinkCompany', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2883, 'p', '888', '/promotion/upsertLinkTheme', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2957, 'p', '888', '/simpleUploader/checkFileMd5', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2956, 'p', '888', '/simpleUploader/mergeFileMd5', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2958, 'p', '888', '/simpleUploader/upload', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3013, 'p', '888', '/skills/createReference', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3016, 'p', '888', '/skills/createResource', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3019, 'p', '888', '/skills/createScript', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3010, 'p', '888', '/skills/createTemplate', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3007, 'p', '888', '/skills/getGlobalConstraint', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3012, 'p', '888', '/skills/getReference', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3015, 'p', '888', '/skills/getResource', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3018, 'p', '888', '/skills/getScript', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3021, 'p', '888', '/skills/getSkillDetail', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3022, 'p', '888', '/skills/getSkillList', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3009, 'p', '888', '/skills/getTemplate', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3023, 'p', '888', '/skills/getTools', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3006, 'p', '888', '/skills/saveGlobalConstraint', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3011, 'p', '888', '/skills/saveReference', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3014, 'p', '888', '/skills/saveResource', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3017, 'p', '888', '/skills/saveScript', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3020, 'p', '888', '/skills/saveSkill', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3008, 'p', '888', '/skills/saveTemplate', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3077, 'p', '888', '/sysApiToken/createApiToken', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3075, 'p', '888', '/sysApiToken/deleteApiToken', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3076, 'p', '888', '/sysApiToken/getApiTokenList', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2970, 'p', '888', '/sysDictionary/createSysDictionary', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2969, 'p', '888', '/sysDictionary/deleteSysDictionary', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2964, 'p', '888', '/sysDictionary/exportSysDictionary', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2967, 'p', '888', '/sysDictionary/findSysDictionary', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2966, 'p', '888', '/sysDictionary/getSysDictionaryList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2965, 'p', '888', '/sysDictionary/importSysDictionary', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2968, 'p', '888', '/sysDictionary/updateSysDictionary', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2978, 'p', '888', '/sysDictionaryDetail/createSysDictionaryDetail', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2977, 'p', '888', '/sysDictionaryDetail/deleteSysDictionaryDetail', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2976, 'p', '888', '/sysDictionaryDetail/findSysDictionaryDetail', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2972, 'p', '888', '/sysDictionaryDetail/getDictionaryDetailsByParent', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2971, 'p', '888', '/sysDictionaryDetail/getDictionaryPath', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2974, 'p', '888', '/sysDictionaryDetail/getDictionaryTreeList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2973, 'p', '888', '/sysDictionaryDetail/getDictionaryTreeListByType', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2975, 'p', '888', '/sysDictionaryDetail/getSysDictionaryDetailList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2979, 'p', '888', '/sysDictionaryDetail/updateSysDictionaryDetail', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2940, 'p', '888', '/sysError/createSysError', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2939, 'p', '888', '/sysError/deleteSysError', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2938, 'p', '888', '/sysError/deleteSysErrorByIds', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2936, 'p', '888', '/sysError/findSysError', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2935, 'p', '888', '/sysError/getSysErrorList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2934, 'p', '888', '/sysError/getSysErrorSolution', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2937, 'p', '888', '/sysError/updateSysError', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2950, 'p', '888', '/sysExportTemplate/createSysExportTemplate', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2949, 'p', '888', '/sysExportTemplate/deleteSysExportTemplate', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2948, 'p', '888', '/sysExportTemplate/deleteSysExportTemplateByIds', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2944, 'p', '888', '/sysExportTemplate/exportExcel', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2943, 'p', '888', '/sysExportTemplate/exportTemplate', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2946, 'p', '888', '/sysExportTemplate/findSysExportTemplate', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2945, 'p', '888', '/sysExportTemplate/getSysExportTemplateList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2941, 'p', '888', '/sysExportTemplate/importExcel', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2942, 'p', '888', '/sysExportTemplate/previewSQL', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2947, 'p', '888', '/sysExportTemplate/updateSysExportTemplate', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3081, 'p', '888', '/sysLoginLog/deleteLoginLog', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3080, 'p', '888', '/sysLoginLog/deleteLoginLogByIds', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3079, 'p', '888', '/sysLoginLog/findLoginLog', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3078, 'p', '888', '/sysLoginLog/getLoginLogList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2963, 'p', '888', '/sysOperationRecord/createSysOperationRecord', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2960, 'p', '888', '/sysOperationRecord/deleteSysOperationRecord', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2959, 'p', '888', '/sysOperationRecord/deleteSysOperationRecordByIds', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2962, 'p', '888', '/sysOperationRecord/findSysOperationRecord', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2961, 'p', '888', '/sysOperationRecord/getSysOperationRecordList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2927, 'p', '888', '/sysParams/createSysParams', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2926, 'p', '888', '/sysParams/deleteSysParams', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2925, 'p', '888', '/sysParams/deleteSysParamsByIds', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2923, 'p', '888', '/sysParams/findSysParams', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2921, 'p', '888', '/sysParams/getSysParam', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2922, 'p', '888', '/sysParams/getSysParamsList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2924, 'p', '888', '/sysParams/updateSysParams', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3026, 'p', '888', '/system/getServerInfo', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3025, 'p', '888', '/system/getSystemConfig', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3024, 'p', '888', '/system/setSystemConfig', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2912, 'p', '888', '/sysVersion/deleteSysVersion', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2911, 'p', '888', '/sysVersion/deleteSysVersionByIds', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2915, 'p', '888', '/sysVersion/downloadVersionJson', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2914, 'p', '888', '/sysVersion/exportVersion', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2917, 'p', '888', '/sysVersion/findSysVersion', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2916, 'p', '888', '/sysVersion/getSysVersionList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2913, 'p', '888', '/sysVersion/importVersion', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3073, 'p', '888', '/user/admin_register', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3067, 'p', '888', '/user/changePassword', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3074, 'p', '888', '/user/deleteUser', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3069, 'p', '888', '/user/getUserInfo', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3072, 'p', '888', '/user/getUserList', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3065, 'p', '888', '/user/resetPassword', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3070, 'p', '888', '/user/setSelfInfo', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3064, 'p', '888', '/user/setSelfSetting', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3068, 'p', '888', '/user/setUserAuthorities', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3066, 'p', '888', '/user/setUserAuthority', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3071, 'p', '888', '/user/setUserInfo', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (176, 'p', '8881', '/api/createApi', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (179, 'p', '8881', '/api/deleteApi', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (181, 'p', '8881', '/api/getAllApis', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (178, 'p', '8881', '/api/getApiById', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (177, 'p', '8881', '/api/getApiList', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (180, 'p', '8881', '/api/updateApi', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (182, 'p', '8881', '/authority/createAuthority', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (183, 'p', '8881', '/authority/deleteAuthority', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (184, 'p', '8881', '/authority/getAuthorityList', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (185, 'p', '8881', '/authority/setDataAuthority', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (204, 'p', '8881', '/casbin/getPolicyPathByAuthorityId', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (203, 'p', '8881', '/casbin/updateCasbin', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (210, 'p', '8881', '/customer/customer', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (211, 'p', '8881', '/customer/customer', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (208, 'p', '8881', '/customer/customer', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (209, 'p', '8881', '/customer/customer', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (212, 'p', '8881', '/customer/customerList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (200, 'p', '8881', '/fileUploadAndDownload/deleteFile', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (201, 'p', '8881', '/fileUploadAndDownload/editFileName', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (199, 'p', '8881', '/fileUploadAndDownload/getFileList', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (202, 'p', '8881', '/fileUploadAndDownload/importURL', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (198, 'p', '8881', '/fileUploadAndDownload/upload', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (205, 'p', '8881', '/jwt/jsonInBlacklist', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (188, 'p', '8881', '/menu/addBaseMenu', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (190, 'p', '8881', '/menu/addMenuAuthority', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (192, 'p', '8881', '/menu/deleteBaseMenu', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (194, 'p', '8881', '/menu/getBaseMenuById', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (189, 'p', '8881', '/menu/getBaseMenuTree', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (186, 'p', '8881', '/menu/getMenu', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (191, 'p', '8881', '/menu/getMenuAuthority', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (187, 'p', '8881', '/menu/getMenuList', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (193, 'p', '8881', '/menu/updateBaseMenu', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (206, 'p', '8881', '/system/getSystemConfig', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (207, 'p', '8881', '/system/setSystemConfig', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (175, 'p', '8881', '/user/admin_register', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (195, 'p', '8881', '/user/changePassword', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (213, 'p', '8881', '/user/getUserInfo', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (196, 'p', '8881', '/user/getUserList', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (197, 'p', '8881', '/user/setUserAuthority', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3368, 'p', '9528', '/api/createApi', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3367, 'p', '9528', '/api/deleteApi', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3364, 'p', '9528', '/api/getAllApis', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3363, 'p', '9528', '/api/getApiById', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3365, 'p', '9528', '/api/getApiList', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3366, 'p', '9528', '/api/updateApi', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3362, 'p', '9528', '/authority/createAuthority', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3361, 'p', '9528', '/authority/deleteAuthority', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3360, 'p', '9528', '/authority/getAuthorityList', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3359, 'p', '9528', '/authority/setDataAuthority', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3335, 'p', '9528', '/autoCode/createTemp', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3357, 'p', '9528', '/casbin/getPolicyPathByAuthorityId', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3358, 'p', '9528', '/casbin/updateCasbin', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3338, 'p', '9528', '/customer/customer', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3337, 'p', '9528', '/customer/customer', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3339, 'p', '9528', '/customer/customer', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3340, 'p', '9528', '/customer/customer', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3336, 'p', '9528', '/customer/customerList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3346, 'p', '9528', '/fileUploadAndDownload/deleteFile', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3345, 'p', '9528', '/fileUploadAndDownload/editFileName', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3344, 'p', '9528', '/fileUploadAndDownload/getFileList', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3343, 'p', '9528', '/fileUploadAndDownload/importURL', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3347, 'p', '9528', '/fileUploadAndDownload/upload', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3374, 'p', '9528', '/jwt/jsonInBlacklist', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3356, 'p', '9528', '/menu/addBaseMenu', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3348, 'p', '9528', '/menu/addMenuAuthority', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3354, 'p', '9528', '/menu/deleteBaseMenu', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3352, 'p', '9528', '/menu/getBaseMenuById', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3350, 'p', '9528', '/menu/getBaseMenuTree', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3355, 'p', '9528', '/menu/getMenu', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3349, 'p', '9528', '/menu/getMenuAuthority', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3351, 'p', '9528', '/menu/getMenuList', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3353, 'p', '9528', '/menu/updateBaseMenu', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3294, 'p', '9528', '/promotion/createActivityData', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3292, 'p', '9528', '/promotion/createActivityMarket', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3293, 'p', '9528', '/promotion/createActivityPackage', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3290, 'p', '9528', '/promotion/createAdCampaign', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3291, 'p', '9528', '/promotion/createAdKeyword', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3289, 'p', '9528', '/promotion/createAdPlatform', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3302, 'p', '9528', '/promotion/createGroupMember', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3300, 'p', '9528', '/promotion/createPromotionDomain', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3299, 'p', '9528', '/promotion/createPromotionGroup', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3298, 'p', '9528', '/promotion/createPromotionLink', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3296, 'p', '9528', '/promotion/createQAAnswer', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3246, 'p', '9528', '/promotion/createQAAvatarNickname', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3295, 'p', '9528', '/promotion/createQAQuestion', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3297, 'p', '9528', '/promotion/createQAReply', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3249, 'p', '9528', '/promotion/createQASignature', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3248, 'p', '9528', '/promotion/createQATag', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3247, 'p', '9528', '/promotion/createQATitle', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3301, 'p', '9528', '/promotion/createRegionCategory', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3260, 'p', '9528', '/promotion/createTemplateWidget', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3313, 'p', '9528', '/promotion/deleteActivityData', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3311, 'p', '9528', '/promotion/deleteActivityMarket', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3312, 'p', '9528', '/promotion/deleteActivityPackage', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3309, 'p', '9528', '/promotion/deleteAdCampaign', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3310, 'p', '9528', '/promotion/deleteAdKeyword', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3308, 'p', '9528', '/promotion/deleteAdPlatform', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3321, 'p', '9528', '/promotion/deleteGroupMember', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3319, 'p', '9528', '/promotion/deletePromotionDomain', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3318, 'p', '9528', '/promotion/deletePromotionGroup', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3317, 'p', '9528', '/promotion/deletePromotionLink', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3315, 'p', '9528', '/promotion/deleteQAAnswer', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3250, 'p', '9528', '/promotion/deleteQAAvatarNickname', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3314, 'p', '9528', '/promotion/deleteQAQuestion', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3316, 'p', '9528', '/promotion/deleteQAReply', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3253, 'p', '9528', '/promotion/deleteQASignature', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3252, 'p', '9528', '/promotion/deleteQATag', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3251, 'p', '9528', '/promotion/deleteQATitle', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3320, 'p', '9528', '/promotion/deleteRegionCategory', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3261, 'p', '9528', '/promotion/deleteTemplateWidget', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3287, 'p', '9528', '/promotion/findGroupMember', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3263, 'p', '9528', '/promotion/findPromotionDomain', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3264, 'p', '9528', '/promotion/findPromotionGroup', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3265, 'p', '9528', '/promotion/findPromotionLink', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3286, 'p', '9528', '/promotion/findRegionCategory', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3259, 'p', '9528', '/promotion/findTemplateWidget', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3279, 'p', '9528', '/promotion/getActivityDataList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3281, 'p', '9528', '/promotion/getActivityMarketList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3280, 'p', '9528', '/promotion/getActivityPackageList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3284, 'p', '9528', '/promotion/getAdCampaignList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3282, 'p', '9528', '/promotion/getAdDailySummaryList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3283, 'p', '9528', '/promotion/getAdKeywordList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3285, 'p', '9528', '/promotion/getAdPlatformList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3241, 'p', '9528', '/promotion/getAllEnabledQAAvatarNickname', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3240, 'p', '9528', '/promotion/getAllEnabledQASignature', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3242, 'p', '9528', '/promotion/getAllEnabledQATag', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3243, 'p', '9528', '/promotion/getAllEnabledQATitle', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3266, 'p', '9528', '/promotion/getGroupMemberList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3275, 'p', '9528', '/promotion/getLinkBasic', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3276, 'p', '9528', '/promotion/getLinkCode', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3277, 'p', '9528', '/promotion/getLinkComment', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3278, 'p', '9528', '/promotion/getLinkCompany', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3231, 'p', '9528', '/promotion/getLinkGroupMembers', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3274, 'p', '9528', '/promotion/getLinkTheme', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3268, 'p', '9528', '/promotion/getPromotionDomainList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3269, 'p', '9528', '/promotion/getPromotionGroupList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3270, 'p', '9528', '/promotion/getPromotionLinkList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3229, 'p', '9528', '/promotion/getQAAnswerDetail/:id', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3272, 'p', '9528', '/promotion/getQAAnswerList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3239, 'p', '9528', '/promotion/getQAAvatarNicknameList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3237, 'p', '9528', '/promotion/getQAQuestionDetail/:id', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3273, 'p', '9528', '/promotion/getQAQuestionList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3271, 'p', '9528', '/promotion/getQAReplyList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3245, 'p', '9528', '/promotion/getQASignatureList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3244, 'p', '9528', '/promotion/getQATagList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3238, 'p', '9528', '/promotion/getQATitleList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3267, 'p', '9528', '/promotion/getRegionCategoryList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3258, 'p', '9528', '/promotion/getTemplateWidgetList', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3233, 'p', '9528', '/promotion/landingMessage/list', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3234, 'p', '9528', '/promotion/landingPhone/list', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3232, 'p', '9528', '/promotion/landingVisit/list', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3236, 'p', '9528', '/promotion/publishPromotionLink', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3327, 'p', '9528', '/promotion/updateActivityData', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3325, 'p', '9528', '/promotion/updateActivityMarket', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3326, 'p', '9528', '/promotion/updateActivityPackage', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3323, 'p', '9528', '/promotion/updateAdCampaign', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3324, 'p', '9528', '/promotion/updateAdKeyword', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3322, 'p', '9528', '/promotion/updateAdPlatform', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3334, 'p', '9528', '/promotion/updateGroupMember', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3230, 'p', '9528', '/promotion/updateGroupMemberStatus', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3333, 'p', '9528', '/promotion/updatePromotionDomain', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3332, 'p', '9528', '/promotion/updatePromotionGroup', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3331, 'p', '9528', '/promotion/updatePromotionLink', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3235, 'p', '9528', '/promotion/updatePromotionLinkOcpc', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3329, 'p', '9528', '/promotion/updateQAAnswer', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3254, 'p', '9528', '/promotion/updateQAAvatarNickname', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3328, 'p', '9528', '/promotion/updateQAQuestion', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3330, 'p', '9528', '/promotion/updateQAReply', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3257, 'p', '9528', '/promotion/updateQASignature', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3256, 'p', '9528', '/promotion/updateQATag', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3255, 'p', '9528', '/promotion/updateQATitle', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3288, 'p', '9528', '/promotion/updateRegionCategory', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3262, 'p', '9528', '/promotion/updateTemplateWidget', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3306, 'p', '9528', '/promotion/upsertLinkBasic', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3305, 'p', '9528', '/promotion/upsertLinkCode', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3304, 'p', '9528', '/promotion/upsertLinkComment', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3303, 'p', '9528', '/promotion/upsertLinkCompany', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3307, 'p', '9528', '/promotion/upsertLinkTheme', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3342, 'p', '9528', '/system/getSystemConfig', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3341, 'p', '9528', '/system/setSystemConfig', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3373, 'p', '9528', '/user/admin_register', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3370, 'p', '9528', '/user/changePassword', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3371, 'p', '9528', '/user/getUserInfo', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3372, 'p', '9528', '/user/getUserList', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3369, 'p', '9528', '/user/setUserAuthority', 'POST', '', '', '');
COMMIT;

-- ----------------------------
-- Table structure for domain_ssl_binding
-- ----------------------------
DROP TABLE IF EXISTS `domain_ssl_binding`;
CREATE TABLE `domain_ssl_binding` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `domain_id` bigint unsigned DEFAULT NULL,
  `cert_id` bigint unsigned DEFAULT NULL,
  `https_enabled` tinyint(1) DEFAULT NULL,
  `force_https` tinyint(1) DEFAULT NULL,
  `apply_status` tinyint unsigned DEFAULT NULL,
  `apply_message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_apply_at` datetime DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_binding_status` (`apply_status`),
  KEY `idx_domain_ssl_binding_deleted_at` (`deleted_at`),
  KEY `idx_binding_domain` (`domain_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of domain_ssl_binding
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for exa_attachment_category
-- ----------------------------
DROP TABLE IF EXISTS `exa_attachment_category`;
CREATE TABLE `exa_attachment_category` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '分类名称',
  `pid` bigint DEFAULT '0' COMMENT '父节点ID',
  PRIMARY KEY (`id`),
  KEY `idx_exa_attachment_category_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of exa_attachment_category
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for exa_customers
-- ----------------------------
DROP TABLE IF EXISTS `exa_customers`;
CREATE TABLE `exa_customers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `customer_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '客户名',
  `customer_phone_data` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '客户手机号',
  `sys_user_id` bigint unsigned DEFAULT NULL COMMENT '管理ID',
  `sys_user_authority_id` bigint unsigned DEFAULT NULL COMMENT '管理角色ID',
  PRIMARY KEY (`id`),
  KEY `idx_exa_customers_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of exa_customers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for exa_file_chunks
-- ----------------------------
DROP TABLE IF EXISTS `exa_file_chunks`;
CREATE TABLE `exa_file_chunks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `exa_file_id` bigint unsigned DEFAULT NULL,
  `file_chunk_number` bigint DEFAULT NULL,
  `file_chunk_path` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_exa_file_chunks_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of exa_file_chunks
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for exa_file_upload_and_downloads
-- ----------------------------
DROP TABLE IF EXISTS `exa_file_upload_and_downloads`;
CREATE TABLE `exa_file_upload_and_downloads` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '文件名',
  `class_id` bigint DEFAULT '0' COMMENT '分类id',
  `url` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '文件地址',
  `tag` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '文件标签',
  `key` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '编号',
  PRIMARY KEY (`id`),
  KEY `idx_exa_file_upload_and_downloads_deleted_at` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of exa_file_upload_and_downloads
-- ----------------------------
BEGIN;
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (1, '2026-03-19 23:02:02.695', '2026-03-19 23:02:02.695', NULL, '10.png', 0, 'https://qmplusimg.henrongyi.top/gvalogo.png', 'png', '158787308910.png');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (2, '2026-03-19 23:02:02.695', '2026-03-19 23:02:02.695', NULL, 'logo.png', 0, 'https://qmplusimg.henrongyi.top/1576554439myAvatar.png', 'png', '1587973709logo.png');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (3, '2026-03-21 21:07:20.485', '2026-03-21 21:07:20.485', NULL, '网站系统.png', 0, 'uploads/file/16cf16bab59c1ed41b9eb5a8146de974_20260321210720.png', 'png', '16cf16bab59c1ed41b9eb5a8146de974_20260321210720.png');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (4, '2026-03-21 21:07:27.216', '2026-03-21 21:07:27.216', NULL, '网站系统.png', 0, 'uploads/file/16cf16bab59c1ed41b9eb5a8146de974_20260321210727.png', 'png', '16cf16bab59c1ed41b9eb5a8146de974_20260321210727.png');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (5, '2026-03-21 21:07:40.031', '2026-03-21 21:07:40.031', NULL, '网站系统.png', 0, 'uploads/file/16cf16bab59c1ed41b9eb5a8146de974_20260321210740.png', 'png', '16cf16bab59c1ed41b9eb5a8146de974_20260321210740.png');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (6, '2026-03-21 22:48:50.642', '2026-03-21 22:48:50.642', NULL, '网站系统.png', 0, 'uploads/file/16cf16bab59c1ed41b9eb5a8146de974_20260321224850.png', 'png', '16cf16bab59c1ed41b9eb5a8146de974_20260321224850.png');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (7, '2026-03-21 23:26:15.439', '2026-03-21 23:26:15.439', NULL, 'ZazaPro_logo_副本.png', 0, 'uploads/file/d708d3b6d61633b9bd848ec6acdb8838_20260321232615.png', 'png', 'd708d3b6d61633b9bd848ec6acdb8838_20260321232615.png');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (8, '2026-03-21 23:40:43.861', '2026-03-21 23:40:43.861', NULL, 'ZazaPro_logo_副本.png', 0, 'uploads/file/d708d3b6d61633b9bd848ec6acdb8838_20260321234043.png', 'png', 'd708d3b6d61633b9bd848ec6acdb8838_20260321234043.png');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (9, '2026-03-21 23:42:14.976', '2026-03-21 23:42:14.976', NULL, 'ZazaPro_logo_副本.png', 0, 'uploads/file/d708d3b6d61633b9bd848ec6acdb8838_20260321234214.png', 'png', 'd708d3b6d61633b9bd848ec6acdb8838_20260321234214.png');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (10, '2026-03-21 23:51:26.247', '2026-03-21 23:51:26.247', NULL, 'ZazaPro_logo_副本.png', 0, 'uploads/file/d708d3b6d61633b9bd848ec6acdb8838_20260321235126.png', 'png', 'd708d3b6d61633b9bd848ec6acdb8838_20260321235126.png');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (11, '2026-03-21 23:52:28.530', '2026-03-21 23:52:28.530', NULL, 'ZazaPro_logo_副本.png', 0, 'uploads/file/d708d3b6d61633b9bd848ec6acdb8838_20260321235228.png', 'png', 'd708d3b6d61633b9bd848ec6acdb8838_20260321235228.png');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (12, '2026-03-21 23:57:42.588', '2026-03-21 23:57:42.588', NULL, 'ZazaPro_logo_副本.png', 0, 'uploads/file/d708d3b6d61633b9bd848ec6acdb8838_20260321235742.png', 'png', 'd708d3b6d61633b9bd848ec6acdb8838_20260321235742.png');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (13, '2026-03-21 23:57:58.074', '2026-03-21 23:57:58.074', NULL, 'ZazaPro_logo_副本.png', 0, 'uploads/file/d708d3b6d61633b9bd848ec6acdb8838_20260321235758.png', 'png', 'd708d3b6d61633b9bd848ec6acdb8838_20260321235758.png');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (14, '2026-03-22 11:27:08.950', '2026-03-22 11:27:08.950', NULL, 'ZazaPro_logo_副本.png', 0, 'uploads/file/d708d3b6d61633b9bd848ec6acdb8838_20260322112708.png', 'png', 'd708d3b6d61633b9bd848ec6acdb8838_20260322112708.png');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (15, '2026-03-23 00:50:56.587', '2026-03-23 00:50:56.587', NULL, 'ZazaPro_logo_副本.png', 0, 'uploads/file/d708d3b6d61633b9bd848ec6acdb8838_20260323005056.png', 'png', 'd708d3b6d61633b9bd848ec6acdb8838_20260323005056.png');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (16, '2026-03-23 00:54:02.783', '2026-03-23 00:54:02.783', NULL, 'ZazaPro_logo_副本.png', 0, 'uploads/file/d708d3b6d61633b9bd848ec6acdb8838_20260323005402.png', 'png', 'd708d3b6d61633b9bd848ec6acdb8838_20260323005402.png');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (17, '2026-03-24 18:56:32.243', '2026-03-24 18:56:32.243', NULL, 'ZazaPro_logo_副本.png', 0, 'https://pub-0aa45ce6d1324502a4355b0939c4825b.r2.dev/uploads/1774349790_ZazaPro_logo_副本.png', 'png', '1774349790_ZazaPro_logo_副本.png');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (18, '2026-03-24 22:45:57.994', '2026-03-24 22:45:57.994', NULL, 'ZazaPro_logo_副本.png', 0, 'https://promotion-oss.its-me.club/uploads/1774363556_ZazaPro_logo_副本.png', 'png', '1774363556_ZazaPro_logo_副本.png');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (19, '2026-03-24 22:48:54.873', '2026-03-24 22:48:54.873', NULL, 'ZazaPro_logo_副本.png', 0, 'uploads/file/d708d3b6d61633b9bd848ec6acdb8838_20260324224854.png', 'png', 'd708d3b6d61633b9bd848ec6acdb8838_20260324224854.png');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (20, '2026-03-24 22:49:01.685', '2026-03-24 22:49:01.685', NULL, 'ZazaPro_logo_副本.png', 0, 'uploads/file/d708d3b6d61633b9bd848ec6acdb8838_20260324224901.png', 'png', 'd708d3b6d61633b9bd848ec6acdb8838_20260324224901.png');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (21, '2026-03-24 23:20:41.243', '2026-03-24 23:20:41.243', NULL, '12.png', 0, 'uploads/file/c20ad4d76fe97759aa27a0c99bff6710_20260324232041.png', 'png', 'c20ad4d76fe97759aa27a0c99bff6710_20260324232041.png');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (22, '2026-03-25 22:40:24.563', '2026-03-25 22:40:24.563', NULL, '12.png', 0, 'uploads/file/c20ad4d76fe97759aa27a0c99bff6710_20260325224024.png', 'png', 'c20ad4d76fe97759aa27a0c99bff6710_20260325224024.png');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (23, '2026-03-25 22:40:45.235', '2026-03-25 22:40:45.235', NULL, '12.png', 0, 'uploads/file/c20ad4d76fe97759aa27a0c99bff6710_20260325224045.png', 'png', 'c20ad4d76fe97759aa27a0c99bff6710_20260325224045.png');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (24, '2026-03-25 22:44:04.741', '2026-03-25 22:44:04.741', NULL, '12.png', 0, 'uploads/file/c20ad4d76fe97759aa27a0c99bff6710_20260325224404.png', 'png', 'c20ad4d76fe97759aa27a0c99bff6710_20260325224404.png');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (25, '2026-03-28 22:58:02.921', '2026-03-28 22:58:02.921', NULL, '微信图片_2026-03-28_225733_545.jpg', 0, 'uploads/file/977c9a7ba404c6b700b2838c32d3d403_20260328225802.jpg', 'jpg', '977c9a7ba404c6b700b2838c32d3d403_20260328225802.jpg');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (26, '2026-03-28 22:58:09.684', '2026-03-28 22:58:09.684', NULL, '微信图片_2026-03-28_225751_185.jpg', 0, 'uploads/file/440c630d847a197aa7aa3381a101729c_20260328225809.jpg', 'jpg', '440c630d847a197aa7aa3381a101729c_20260328225809.jpg');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (27, '2026-04-12 21:00:01.950', '2026-04-12 21:00:01.950', NULL, 'ZazaPro_logo_副本.png', 0, 'uploads/file/d708d3b6d61633b9bd848ec6acdb8838_20260412210001.png', 'png', 'd708d3b6d61633b9bd848ec6acdb8838_20260412210001.png');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (28, '2026-04-12 21:01:40.342', '2026-04-12 21:01:40.342', NULL, 'app_logo.png', 0, 'uploads/file/57ac07f36f13d5ba7d9aa291ec107e8e_20260412210140.png', 'png', '57ac07f36f13d5ba7d9aa291ec107e8e_20260412210140.png');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (29, '2026-04-12 21:01:43.944', '2026-04-12 21:01:43.944', NULL, 'app_logo.png', 0, 'uploads/file/57ac07f36f13d5ba7d9aa291ec107e8e_20260412210143.png', 'png', '57ac07f36f13d5ba7d9aa291ec107e8e_20260412210143.png');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (30, '2026-04-12 21:19:50.609', '2026-04-12 21:19:50.609', NULL, 'app_logo.png', 0, 'uploads/file/57ac07f36f13d5ba7d9aa291ec107e8e_20260412211950.png', 'png', '57ac07f36f13d5ba7d9aa291ec107e8e_20260412211950.png');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (31, '2026-04-12 21:20:07.701', '2026-04-12 21:20:07.701', NULL, 'ZazaPro_logo_副本.png', 0, 'uploads/file/d708d3b6d61633b9bd848ec6acdb8838_20260412212007.png', 'png', 'd708d3b6d61633b9bd848ec6acdb8838_20260412212007.png');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (32, '2026-05-19 21:01:39.183', '2026-05-19 21:01:39.183', NULL, 'u=799583587,2198138225&fm=253&fmt=auto&app=138&f=JPEG.jpg', 0, 'uploads/file/44bc64300c7df1312838e8ca611ccafe_20260519210139.jpg', 'jpg', '44bc64300c7df1312838e8ca611ccafe_20260519210139.jpg');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (33, '2026-05-21 21:24:49.354', '2026-05-21 21:24:49.354', NULL, '1 (1).jpeg', 0, 'uploads/file/daa8f13c9d65da091604a1c944e47f3b_20260521212449.jpeg', 'jpeg', 'daa8f13c9d65da091604a1c944e47f3b_20260521212449.jpeg');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (34, '2026-05-21 21:28:09.289', '2026-05-21 21:28:09.289', NULL, '1 (1).jpg', 0, 'uploads/file/daa8f13c9d65da091604a1c944e47f3b_20260521212809.jpg', 'jpg', 'daa8f13c9d65da091604a1c944e47f3b_20260521212809.jpg');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (35, '2026-05-21 21:28:54.926', '2026-05-21 21:28:54.926', NULL, '1 (1).jpg', 0, 'uploads/file/daa8f13c9d65da091604a1c944e47f3b_20260521212854.jpg', 'jpg', 'daa8f13c9d65da091604a1c944e47f3b_20260521212854.jpg');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (36, '2026-05-21 21:32:22.510', '2026-05-21 21:32:22.510', NULL, '1 (1).jpg', 0, 'uploads/file/daa8f13c9d65da091604a1c944e47f3b_20260521213222.jpg', 'jpg', 'daa8f13c9d65da091604a1c944e47f3b_20260521213222.jpg');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (37, '2026-05-21 21:35:54.506', '2026-05-21 21:35:54.506', NULL, '1 (2).jpg', 0, 'uploads/file/dfc0e642be3044e9f018c2ad5b9216b3_20260521213554.jpg', 'jpg', 'dfc0e642be3044e9f018c2ad5b9216b3_20260521213554.jpg');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (38, '2026-05-23 20:49:38.854', '2026-05-23 20:49:38.854', NULL, '大熊.jpg', 0, 'uploads/file/db43365a55128567c696386691fdb633_20260523204938.jpg', 'jpg', 'db43365a55128567c696386691fdb633_20260523204938.jpg');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (39, '2026-05-23 20:50:56.532', '2026-05-23 20:50:56.532', NULL, '1 (1).jpg', 0, 'uploads/file/daa8f13c9d65da091604a1c944e47f3b_20260523205056.jpg', 'jpg', 'daa8f13c9d65da091604a1c944e47f3b_20260523205056.jpg');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (40, '2026-05-23 20:51:12.885', '2026-05-23 20:51:12.885', NULL, '1 (2).jpg', 0, 'uploads/file/dfc0e642be3044e9f018c2ad5b9216b3_20260523205112.jpg', 'jpg', 'dfc0e642be3044e9f018c2ad5b9216b3_20260523205112.jpg');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (41, '2026-05-23 20:51:30.849', '2026-05-23 20:51:30.849', NULL, '1 (3).jpg', 0, 'uploads/file/628aadbeabbe1c09e7559c39ebb66970_20260523205130.jpg', 'jpg', '628aadbeabbe1c09e7559c39ebb66970_20260523205130.jpg');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (42, '2026-05-23 20:52:02.511', '2026-05-23 20:52:02.511', NULL, '1 (4).jpg', 0, 'uploads/file/3e61ea5e7b685bb3337aeb046f009d6c_20260523205202.jpg', 'jpg', '3e61ea5e7b685bb3337aeb046f009d6c_20260523205202.jpg');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (43, '2026-05-23 20:52:27.215', '2026-05-23 20:52:27.215', NULL, '1 (5).jpg', 0, 'uploads/file/c672c7807147fbdaf09ecd1b29843872_20260523205227.jpg', 'jpg', 'c672c7807147fbdaf09ecd1b29843872_20260523205227.jpg');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (44, '2026-05-23 20:53:33.883', '2026-05-23 20:53:33.883', NULL, '1 (6).jpg', 0, 'uploads/file/955308098d929de21c68042c9bf81d29_20260523205333.jpg', 'jpg', '955308098d929de21c68042c9bf81d29_20260523205333.jpg');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (45, '2026-05-23 20:53:51.269', '2026-05-23 20:53:51.269', NULL, '1 (7).jpg', 0, 'uploads/file/94387bbb271592bf7979b0c7cae7cbe3_20260523205351.jpg', 'jpg', '94387bbb271592bf7979b0c7cae7cbe3_20260523205351.jpg');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (46, '2026-05-23 20:54:23.594', '2026-05-23 20:54:23.594', NULL, '1 (8).jpg', 0, 'uploads/file/28a41f24c1b02db5ec14f11189ce05ca_20260523205423.jpg', 'jpg', '28a41f24c1b02db5ec14f11189ce05ca_20260523205423.jpg');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (47, '2026-05-23 20:54:46.017', '2026-05-23 20:54:46.017', NULL, '1 (9).jpg', 0, 'uploads/file/34a3acdf6a5c0db6fcbc7918fe237c0f_20260523205446.jpg', 'jpg', '34a3acdf6a5c0db6fcbc7918fe237c0f_20260523205446.jpg');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (48, '2026-05-23 20:55:04.904', '2026-05-23 20:55:04.904', NULL, '2 (2).jpg', 0, 'uploads/file/722600ba96199b2e5a62a2fbcf31688a_20260523205504.jpg', 'jpg', '722600ba96199b2e5a62a2fbcf31688a_20260523205504.jpg');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (49, '2026-05-23 20:55:28.002', '2026-05-23 20:55:28.002', NULL, '2 (3).jpg', 0, 'uploads/file/fe6d8d65d2ac692a5c88cc07837c402d_20260523205528.jpg', 'jpg', 'fe6d8d65d2ac692a5c88cc07837c402d_20260523205528.jpg');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (50, '2026-05-23 20:55:44.641', '2026-05-23 20:55:44.641', NULL, '2 (1).jpg', 0, 'uploads/file/6d283a0eb007683e94c72317741975ae_20260523205544.jpg', 'jpg', '6d283a0eb007683e94c72317741975ae_20260523205544.jpg');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (51, '2026-05-23 20:56:19.225', '2026-05-23 20:56:19.225', NULL, '3.jpg', 0, 'uploads/file/eccbc87e4b5ce2fe28308fd9f2a7baf3_20260523205619.jpg', 'jpg', 'eccbc87e4b5ce2fe28308fd9f2a7baf3_20260523205619.jpg');
INSERT INTO `exa_file_upload_and_downloads` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `class_id`, `url`, `tag`, `key`) VALUES (52, '2026-05-24 19:58:01.559', '2026-05-24 19:58:01.559', NULL, 'police.jpg', 0, 'uploads/file/814989b983fd853fb374e1676a06ade4_20260524195801.jpg', 'jpg', '814989b983fd853fb374e1676a06ade4_20260524195801.jpg');
COMMIT;

-- ----------------------------
-- Table structure for exa_files
-- ----------------------------
DROP TABLE IF EXISTS `exa_files`;
CREATE TABLE `exa_files` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `file_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `file_md5` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `file_path` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `chunk_total` bigint DEFAULT NULL,
  `is_finish` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_exa_files_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of exa_files
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for group_member
-- ----------------------------
DROP TABLE IF EXISTS `group_member`;
CREATE TABLE `group_member` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户UUID',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `nickname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `region_id` bigint unsigned DEFAULT NULL,
  `group_id` bigint unsigned DEFAULT NULL,
  `real_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `wechat` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `gender` enum('男','女','未知') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '未知',
  `sort` bigint DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `wechat_qrcode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '''客服微信二维码URL''',
  `status` tinyint DEFAULT '2' COMMENT '''状态：1在线 2离线''',
  PRIMARY KEY (`id`),
  KEY `idx_member_group` (`group_id`),
  KEY `idx_member_sort` (`sort`),
  KEY `idx_group_member_deleted_at` (`deleted_at`),
  KEY `idx_member_region` (`region_id`),
  KEY `idx_member_uuid` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of group_member
-- ----------------------------
BEGIN;
INSERT INTO `group_member` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `nickname`, `region_id`, `group_id`, `real_name`, `wechat`, `mobile`, `gender`, `sort`, `remark`, `wechat_qrcode`, `status`) VALUES (1, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-20 23:30:24.077', '2026-04-12 22:30:49.066', NULL, '浅浅', 1, 1, '', '15099653940', '15099653940', '女', 0, '', 'uploads/file/440c630d847a197aa7aa3381a101729c_20260328225809.jpg', 2);
INSERT INTO `group_member` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `nickname`, `region_id`, `group_id`, `real_name`, `wechat`, `mobile`, `gender`, `sort`, `remark`, `wechat_qrcode`, `status`) VALUES (2, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-20 23:31:05.100', '2026-03-28 22:58:04.575', NULL, '阿木', 1, 1, '', '17801728054', '17801728054', '男', 0, '', 'uploads/file/977c9a7ba404c6b700b2838c32d3d403_20260328225802.jpg', 1);
INSERT INTO `group_member` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `nickname`, `region_id`, `group_id`, `real_name`, `wechat`, `mobile`, `gender`, `sort`, `remark`, `wechat_qrcode`, `status`) VALUES (3, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-20 23:31:35.307', '2026-03-20 23:31:35.307', NULL, '阿雅', 2, 2, '', '18210874586', '18210874586', '女', 0, '', NULL, 2);
INSERT INTO `group_member` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `nickname`, `region_id`, `group_id`, `real_name`, `wechat`, `mobile`, `gender`, `sort`, `remark`, `wechat_qrcode`, `status`) VALUES (4, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-20 23:32:00.195', '2026-03-20 23:32:00.195', NULL, '安安', 2, 2, '', '15276530642', '15276530642', '女', 0, '', NULL, 2);
INSERT INTO `group_member` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `nickname`, `region_id`, `group_id`, `real_name`, `wechat`, `mobile`, `gender`, `sort`, `remark`, `wechat_qrcode`, `status`) VALUES (5, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-20 23:32:22.916', '2026-04-12 22:30:44.886', NULL, '小林', 3, 3, '', '17612853586', '17612853586', '男', 0, '', 'uploads/file/d708d3b6d61633b9bd848ec6acdb8838_20260412212007.png', 1);
INSERT INTO `group_member` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `nickname`, `region_id`, `group_id`, `real_name`, `wechat`, `mobile`, `gender`, `sort`, `remark`, `wechat_qrcode`, `status`) VALUES (6, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-20 23:32:44.129', '2026-04-12 21:31:03.433', NULL, '小双', 3, 3, '', '18582329025', '18582329025', '女', 0, '', 'uploads/file/57ac07f36f13d5ba7d9aa291ec107e8e_20260412211950.png', 1);
INSERT INTO `group_member` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `nickname`, `region_id`, `group_id`, `real_name`, `wechat`, `mobile`, `gender`, `sort`, `remark`, `wechat_qrcode`, `status`) VALUES (7, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-20 23:33:10.492', '2026-03-23 09:39:16.916', NULL, '丽丽', 5, 4, '', '15577992072', '15577992072', '女', 0, '', '', 1);
INSERT INTO `group_member` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `nickname`, `region_id`, `group_id`, `real_name`, `wechat`, `mobile`, `gender`, `sort`, `remark`, `wechat_qrcode`, `status`) VALUES (8, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-20 23:33:31.744', '2026-05-09 21:17:16.353', NULL, '大熊', 5, 4, '', '18577993574', '18577993574', '男', 0, '', 'uploads/file/d708d3b6d61633b9bd848ec6acdb8838_20260323005402.png', 2);
INSERT INTO `group_member` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `nickname`, `region_id`, `group_id`, `real_name`, `wechat`, `mobile`, `gender`, `sort`, `remark`, `wechat_qrcode`, `status`) VALUES (9, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', '2026-05-23 20:49:50.709', '2026-05-23 20:49:50.709', NULL, '大熊', 15, 6, '大熊', '18577993574', '18577993574', '男', 1, '', 'uploads/file/db43365a55128567c696386691fdb633_20260523204938.jpg', 1);
COMMIT;

-- ----------------------------
-- Table structure for gva_announcements_info
-- ----------------------------
DROP TABLE IF EXISTS `gva_announcements_info`;
CREATE TABLE `gva_announcements_info` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '公告标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '公告内容',
  `user_id` bigint DEFAULT NULL COMMENT '发布者',
  `attachments` json DEFAULT NULL COMMENT '相关附件',
  PRIMARY KEY (`id`),
  KEY `idx_gva_announcements_info_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of gva_announcements_info
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for jwt_blacklists
-- ----------------------------
DROP TABLE IF EXISTS `jwt_blacklists`;
CREATE TABLE `jwt_blacklists` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `jwt` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'jwt',
  PRIMARY KEY (`id`),
  KEY `idx_jwt_blacklists_deleted_at` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of jwt_blacklists
-- ----------------------------
BEGIN;
INSERT INTO `jwt_blacklists` (`id`, `created_at`, `updated_at`, `deleted_at`, `jwt`) VALUES (4, '2026-05-21 22:10:38.599', '2026-05-21 22:10:38.599', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiNGRlMmVjMGYtNWJmMS00NjNlLWI3NDYtMTA0NGM5NzI4ZTJlIiwiSUQiOjIsIlVzZXJuYW1lIjoiYTMwMzE3NjUzMCIsIk5pY2tOYW1lIjoi5rWL6K-V5a6i5oi3IiwiQXV0aG9yaXR5SWQiOjk1MjgsIkJ1ZmZlclRpbWUiOjg2NDAwLCJpc3MiOiJxbVBsdXMiLCJhdWQiOlsiR1ZBIl0sImV4cCI6MTc3OTk3NDk3MCwibmJmIjoxNzc5MzcwMTcwfQ.2fTnbvuSPXAvwMxpCGf1uObdwB1uvgmT-eMAJp_CXnk');
INSERT INTO `jwt_blacklists` (`id`, `created_at`, `updated_at`, `deleted_at`, `jwt`) VALUES (5, '2026-05-23 11:01:06.478', '2026-05-23 11:01:06.478', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiNGY1M2IyYTItZTZjZC00MGRmLWIzZjktNTBmMGVmOWEyOTdiIiwiSUQiOjEsIlVzZXJuYW1lIjoiU3VwZXIjQWRtaW4jPyIsIk5pY2tOYW1lIjoiTXIu8J-QiCIsIkF1dGhvcml0eUlkIjo4ODgsIkJ1ZmZlclRpbWUiOjg2NDAwLCJpc3MiOiJxbVBsdXMiLCJhdWQiOlsiR1ZBIl0sImV4cCI6MTc4MDEwOTAyMiwibmJmIjoxNzc5NTA0MjIyfQ.UT5GWUmxE8Irjh2LSeiGyUcmShglQj3mSlf4cvNA18M');
INSERT INTO `jwt_blacklists` (`id`, `created_at`, `updated_at`, `deleted_at`, `jwt`) VALUES (6, '2026-05-23 11:02:07.820', '2026-05-23 11:02:07.820', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiNGRlMmVjMGYtNWJmMS00NjNlLWI3NDYtMTA0NGM5NzI4ZTJlIiwiSUQiOjIsIlVzZXJuYW1lIjoiYTMwMzE3NjUzMCIsIk5pY2tOYW1lIjoi5rWL6K-V5a6i5oi3IiwiQXV0aG9yaXR5SWQiOjk1MjgsIkJ1ZmZlclRpbWUiOjg2NDAwLCJpc3MiOiJxbVBsdXMiLCJhdWQiOlsiR1ZBIl0sImV4cCI6MTc4MDExMDA4MiwibmJmIjoxNzc5NTA1MjgyfQ.nwxjPolcUys7H_7x3GOUJV_gVm0bijMHVTmVCYLEdZ4');
INSERT INTO `jwt_blacklists` (`id`, `created_at`, `updated_at`, `deleted_at`, `jwt`) VALUES (7, '2026-05-23 21:09:51.930', '2026-05-23 21:09:51.930', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiNGRlMmVjMGYtNWJmMS00NjNlLWI3NDYtMTA0NGM5NzI4ZTJlIiwiSUQiOjIsIlVzZXJuYW1lIjoiYTMwMzE3NjUzMCIsIk5pY2tOYW1lIjoi5rWL6K-V5a6i5oi3IiwiQXV0aG9yaXR5SWQiOjk1MjgsIkJ1ZmZlclRpbWUiOjg2NDAwLCJpc3MiOiJxbVBsdXMiLCJhdWQiOlsiR1ZBIl0sImV4cCI6MTc4MDE0NjM3NSwibmJmIjoxNzc5NTQxNTc1fQ.0lfQUoGF-K2pUBvQCsgOOW5xxmH1gfdXzUgxfq1Hb5o');
INSERT INTO `jwt_blacklists` (`id`, `created_at`, `updated_at`, `deleted_at`, `jwt`) VALUES (8, '2026-05-25 10:02:38.069', '2026-05-25 10:02:38.069', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiNGY1M2IyYTItZTZjZC00MGRmLWIzZjktNTBmMGVmOWEyOTdiIiwiSUQiOjEsIlVzZXJuYW1lIjoiU3VwZXIjQWRtaW4jPyIsIk5pY2tOYW1lIjoiTXIu8J-QiCIsIkF1dGhvcml0eUlkIjo4ODgsIkJ1ZmZlclRpbWUiOjg2NDAwLCJpc3MiOiJxbVBsdXMiLCJhdWQiOlsiR1ZBIl0sImV4cCI6MTc4MDE0NjYxNSwibmJmIjoxNzc5NTQxODE1fQ.IQNhtdFe40N48rLXfwj90V7IOIYoJ2oR-u9dojgq6ak');
COMMIT;

-- ----------------------------
-- Table structure for landing_messages
-- ----------------------------
DROP TABLE IF EXISTS `landing_messages`;
CREATE TABLE `landing_messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
  `link_id` varchar(255) NOT NULL COMMENT '推广链接ID',
  `name` varchar(255) DEFAULT NULL COMMENT '留言人姓名',
  `phone` varchar(32) DEFAULT NULL COMMENT '留言人手机号',
  `content` text NOT NULL COMMENT '留言内容',
  `email` varchar(255) DEFAULT NULL COMMENT '留言人邮箱',
  `ip` varchar(64) DEFAULT NULL COMMENT '访问IP',
  `user_agent` text COMMENT '访问UA',
  `link_url` varchar(255) NOT NULL COMMENT '访问链接',
  PRIMARY KEY (`id`),
  KEY `idx_landing_messages_deleted_at` (`deleted_at`),
  KEY `idx_landing_messages_link_id` (`link_id`),
  KEY `idx_landing_messages_phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='落地页留言表';

-- ----------------------------
-- Records of landing_messages
-- ----------------------------
BEGIN;
INSERT INTO `landing_messages` (`id`, `created_at`, `updated_at`, `deleted_at`, `link_id`, `name`, `phone`, `content`, `email`, `ip`, `user_agent`, `link_url`) VALUES (1, '2026-03-25 23:31:59', '2026-03-25 23:31:59', NULL, '1', '', '', 'sssdd', '', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', '');
INSERT INTO `landing_messages` (`id`, `created_at`, `updated_at`, `deleted_at`, `link_id`, `name`, `phone`, `content`, `email`, `ip`, `user_agent`, `link_url`) VALUES (2, '2026-03-25 23:33:05', '2026-03-25 23:33:05', NULL, '1', '', '', 'www', '', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', '');
INSERT INTO `landing_messages` (`id`, `created_at`, `updated_at`, `deleted_at`, `link_id`, `name`, `phone`, `content`, `email`, `ip`, `user_agent`, `link_url`) VALUES (3, '2026-03-25 23:38:25', '2026-03-25 23:38:25', NULL, '1', '', '', 'ewasdd', '', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', '');
INSERT INTO `landing_messages` (`id`, `created_at`, `updated_at`, `deleted_at`, `link_id`, `name`, `phone`, `content`, `email`, `ip`, `user_agent`, `link_url`) VALUES (4, '2026-03-25 23:41:35', '2026-03-25 23:41:35', NULL, '1', '', '', 'sasads', '', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', '');
INSERT INTO `landing_messages` (`id`, `created_at`, `updated_at`, `deleted_at`, `link_id`, `name`, `phone`, `content`, `email`, `ip`, `user_agent`, `link_url`) VALUES (5, '2026-03-25 23:46:25', '2026-03-25 23:46:25', NULL, '1', '', '18813968688', 'wwwwwwww', '', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', '');
INSERT INTO `landing_messages` (`id`, `created_at`, `updated_at`, `deleted_at`, `link_id`, `name`, `phone`, `content`, `email`, `ip`, `user_agent`, `link_url`) VALUES (6, '2026-03-28 23:08:59', '2026-03-28 23:08:59', NULL, '1', '', '16165555555', 'hh', '', '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '');
COMMIT;

-- ----------------------------
-- Table structure for landing_phones
-- ----------------------------
DROP TABLE IF EXISTS `landing_phones`;
CREATE TABLE `landing_phones` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
  `link_id` varchar(255) NOT NULL COMMENT '推广链接ID',
  `phone` varchar(32) NOT NULL COMMENT '登录手机号',
  `ip` varchar(64) DEFAULT NULL COMMENT '访问IP',
  `user_agent` text COMMENT '访问UA',
  PRIMARY KEY (`id`),
  KEY `idx_landing_phones_deleted_at` (`deleted_at`),
  KEY `idx_landing_phones_link_id` (`link_id`),
  KEY `idx_landing_phones_phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='落地页手机号收集表';

-- ----------------------------
-- Records of landing_phones
-- ----------------------------
BEGIN;
INSERT INTO `landing_phones` (`id`, `created_at`, `updated_at`, `deleted_at`, `link_id`, `phone`, `ip`, `user_agent`) VALUES (1, '2026-03-25 23:33:05', '2026-03-25 23:33:05', NULL, '1', '18815565555', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36');
INSERT INTO `landing_phones` (`id`, `created_at`, `updated_at`, `deleted_at`, `link_id`, `phone`, `ip`, `user_agent`) VALUES (2, '2026-03-25 23:38:25', '2026-03-25 23:38:25', NULL, '1', '15515551552', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36');
INSERT INTO `landing_phones` (`id`, `created_at`, `updated_at`, `deleted_at`, `link_id`, `phone`, `ip`, `user_agent`) VALUES (3, '2026-03-25 23:41:35', '2026-03-25 23:41:35', NULL, '1', '18813967628', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36');
INSERT INTO `landing_phones` (`id`, `created_at`, `updated_at`, `deleted_at`, `link_id`, `phone`, `ip`, `user_agent`) VALUES (4, '2026-03-25 23:46:25', '2026-03-25 23:46:25', NULL, '1', '18813968688', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36');
INSERT INTO `landing_phones` (`id`, `created_at`, `updated_at`, `deleted_at`, `link_id`, `phone`, `ip`, `user_agent`) VALUES (5, '2026-03-28 23:08:59', '2026-03-28 23:08:59', NULL, '1', '16165555555', '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36');
COMMIT;

-- ----------------------------
-- Table structure for landing_visits
-- ----------------------------
DROP TABLE IF EXISTS `landing_visits`;
CREATE TABLE `landing_visits` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
  `link_id` bigint unsigned NOT NULL COMMENT '推广链接ID',
  `ip` varchar(45) NOT NULL COMMENT '访问IP',
  `referer` text COMMENT '来源链接(JSON body)',
  `user_agent` text COMMENT '浏览器UA(JSON body)',
  `request_referer` text COMMENT '来源链接(HTTP请求头)',
  `request_user_agent` text COMMENT '浏览器UA(HTTP请求头)',
  `device_type` varchar(32) DEFAULT NULL COMMENT '设备类型',
  `os` varchar(32) DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(64) DEFAULT NULL COMMENT '浏览器信息',
  `region` varchar(128) DEFAULT NULL COMMENT 'IP解析地区',
  `duration` int NOT NULL DEFAULT '0' COMMENT '总浏览时长(秒)',
  `is_copied` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否复制客服信息',
  `copied_service_phone` varchar(32) DEFAULT NULL COMMENT '复制的客服号码',
  `copied_service_nickname` varchar(64) DEFAULT NULL COMMENT '复制的客服昵称',
  `last_report_at` datetime DEFAULT NULL COMMENT '最后上报时间',
  `uuid` varchar(100) DEFAULT NULL COMMENT '用户UUID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_ip_link_id` (`ip`,`link_id`,`deleted_at`),
  KEY `idx_ip` (`ip`),
  KEY `idx_link_id` (`link_id`),
  KEY `idx_is_copied` (`is_copied`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='落地页用户访问记录表';

-- ----------------------------
-- Records of landing_visits
-- ----------------------------
BEGIN;
INSERT INTO `landing_visits` (`id`, `created_at`, `updated_at`, `deleted_at`, `link_id`, `ip`, `referer`, `user_agent`, `request_referer`, `request_user_agent`, `device_type`, `os`, `browser`, `region`, `duration`, `is_copied`, `copied_service_phone`, `copied_service_nickname`, `last_report_at`, `uuid`) VALUES (16, '2026-05-24 20:59:57', '2026-05-24 21:00:22', NULL, 1, '43.133.7.32', '', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', 'http://bhpi1.hime.world/api/h5ldy/V4N9HIZs/pc/index.html', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '', '', '', ' 日本', 0, 1, '17801728054', '阿木', '2026-05-24 20:59:57', '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b');
COMMIT;

-- ----------------------------
-- Table structure for promotion_domain
-- ----------------------------
DROP TABLE IF EXISTS `promotion_domain`;
CREATE TABLE `promotion_domain` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户UUID',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `domain` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cname_target` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` tinyint unsigned DEFAULT NULL,
  `https_status` tinyint unsigned DEFAULT NULL,
  `cert_mode` tinyint unsigned DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_promotion_domain_deleted_at` (`deleted_at`),
  KEY `idx_domain_status` (`status`),
  KEY `idx_domain_https` (`https_status`),
  KEY `idx_domain_uuid` (`uuid`),
  KEY `idk_domain_domain` (`domain`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of promotion_domain
-- ----------------------------
BEGIN;
INSERT INTO `promotion_domain` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `domain`, `cname_target`, `status`, `https_status`, `cert_mode`, `remark`, `created_by`, `updated_by`) VALUES (1, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-20 23:34:59.292', '2026-05-10 21:43:57.579', NULL, 'http://bhpi1.hime.world', 'bhpi1.hime.world.admin-h5.its-me.club', 1, 0, 0, '', NULL, NULL);
INSERT INTO `promotion_domain` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `domain`, `cname_target`, `status`, `https_status`, `cert_mode`, `remark`, `created_by`, `updated_by`) VALUES (2, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-05-10 20:23:31.999', '2026-05-10 20:23:31.999', NULL, 'qqqq', 'qqqq.admin-h5.its-me.club', 1, 0, 0, '', NULL, NULL);
INSERT INTO `promotion_domain` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `domain`, `cname_target`, `status`, `https_status`, `cert_mode`, `remark`, `created_by`, `updated_by`) VALUES (3, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-05-10 20:30:28.706', '2026-05-10 20:30:28.706', NULL, '22', '22.admin-h5.its-me.club', 1, 0, 0, '', NULL, NULL);
INSERT INTO `promotion_domain` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `domain`, `cname_target`, `status`, `https_status`, `cert_mode`, `remark`, `created_by`, `updated_by`) VALUES (4, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', '2026-05-18 10:14:47.245', '2026-05-18 10:14:47.245', NULL, 'bhzy.zswdlxs.com', 'bhzy.zswdlxs.com.admin-h5.its-me.club', 1, 0, 0, '', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for promotion_group
-- ----------------------------
DROP TABLE IF EXISTS `promotion_group`;
CREATE TABLE `promotion_group` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户UUID',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `region_id` bigint unsigned DEFAULT NULL,
  `sort` bigint DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_group_region` (`region_id`),
  KEY `idx_group_sort` (`sort`),
  KEY `idx_promotion_group_deleted_at` (`deleted_at`),
  KEY `idx_group_uuid` (`uuid`),
  KEY `idk_group_name` (`name`) USING BTREE,
  KEY `idx_group_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of promotion_group
-- ----------------------------
BEGIN;
INSERT INTO `promotion_group` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `name`, `region_id`, `sort`, `remark`) VALUES (1, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-20 23:26:16.417', '2026-03-20 23:26:16.417', NULL, '北京', 1, 99, '');
INSERT INTO `promotion_group` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `name`, `region_id`, `sort`, `remark`) VALUES (2, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-20 23:26:27.334', '2026-03-20 23:26:27.334', NULL, '新疆', 2, 99, '');
INSERT INTO `promotion_group` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `name`, `region_id`, `sort`, `remark`) VALUES (3, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-20 23:26:43.745', '2026-03-20 23:26:43.745', NULL, '四川', 3, 99, '');
INSERT INTO `promotion_group` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `name`, `region_id`, `sort`, `remark`) VALUES (4, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-20 23:26:54.823', '2026-03-20 23:27:00.216', NULL, '北海', 5, 99, '');
INSERT INTO `promotion_group` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `name`, `region_id`, `sort`, `remark`) VALUES (5, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-21 09:51:41.590', '2026-03-21 09:51:41.590', NULL, '	 港澳', 4, 5, '');
INSERT INTO `promotion_group` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `name`, `region_id`, `sort`, `remark`) VALUES (6, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', '2026-05-23 20:48:07.398', '2026-05-23 20:48:07.398', NULL, '北海', 15, 1, '');
COMMIT;

-- ----------------------------
-- Table structure for promotion_link
-- ----------------------------
DROP TABLE IF EXISTS `promotion_link`;
CREATE TABLE `promotion_link` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uuid` varchar(100) DEFAULT NULL COMMENT '用户UUID',
  `platform_id` bigint unsigned DEFAULT NULL,
  `account_id` bigint unsigned DEFAULT NULL,
  `region_id` bigint unsigned DEFAULT NULL,
  `group_id` bigint unsigned DEFAULT NULL,
  `domain_id` bigint unsigned DEFAULT NULL,
  `question_id` bigint unsigned DEFAULT NULL,
  `visit_count` bigint unsigned DEFAULT NULL COMMENT '访问次数',
  `copy_count` bigint unsigned DEFAULT NULL COMMENT '复制次数',
  `inquiry_count` bigint unsigned DEFAULT NULL COMMENT '咨询次数',
  `conversion_count` bigint unsigned DEFAULT NULL COMMENT '转化次数',
  `follow_count` bigint unsigned DEFAULT NULL COMMENT '到粉次数',
  `mobile_url` varchar(255) DEFAULT NULL COMMENT '移动端推广链接',
  `pc_url` varchar(255) DEFAULT NULL COMMENT 'PC端推广链接',
  `ocpc_key` varchar(128) DEFAULT NULL COMMENT 'OCPC Key',
  `ocpc_secret` varchar(128) DEFAULT NULL COMMENT 'OCPC Secret',
  `ocpc_conversion_type` tinyint unsigned DEFAULT NULL COMMENT 'OCPC转化类型 3 表单提交成功 35 微信复制按钮点击 49注册激活后登录',
  `ocpc_callback_type` tinyint unsigned DEFAULT NULL COMMENT 'OCPC回传方式 1=手动回传 2=自动回传',
  `https_enabled` tinyint(1) DEFAULT NULL,
  `sort` bigint DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `random_code` varchar(32) DEFAULT NULL COMMENT '随机编号，用于静态页面路径',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_random_code` (`random_code`),
  KEY `idx_link_domain` (`domain_id`),
  KEY `idx_link_region` (`region_id`),
  KEY `idx_link_group` (`group_id`),
  KEY `idx_link_platform` (`platform_id`),
  KEY `fk_link_question` (`question_id`),
  KEY `idx_promotion_link_deleted_at` (`deleted_at`),
  KEY `idx_link_uuid` (`uuid`),
  CONSTRAINT `fk_link_domain` FOREIGN KEY (`domain_id`) REFERENCES `promotion_domain` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `fk_link_group` FOREIGN KEY (`group_id`) REFERENCES `promotion_group` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `fk_link_platform` FOREIGN KEY (`platform_id`) REFERENCES `ad_platform` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_link_question` FOREIGN KEY (`question_id`) REFERENCES `qa_question` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `fk_link_region` FOREIGN KEY (`region_id`) REFERENCES `region_category` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='推广链接-核心表';

-- ----------------------------
-- Records of promotion_link
-- ----------------------------
BEGIN;
INSERT INTO `promotion_link` (`id`, `uuid`, `platform_id`, `account_id`, `region_id`, `group_id`, `domain_id`, `question_id`, `visit_count`, `copy_count`, `inquiry_count`, `conversion_count`, `follow_count`, `mobile_url`, `pc_url`, `ocpc_key`, `ocpc_secret`, `ocpc_conversion_type`, `ocpc_callback_type`, `https_enabled`, `sort`, `remark`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`, `random_code`) VALUES (1, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', 11, NULL, 1, 1, 1, 1, 13, 6, 0, 0, 0, 'http://bhpi1.hime.world/api/h5ldy/V4N9HIZs/m/index.html', 'http://bhpi1.hime.world/api/h5ldy/V4N9HIZs/pc/index.html', '22', '12', 4, 2, 0, 0, '啊啊啊', NULL, NULL, '2026-03-21 10:02:30.400', '2026-05-24 21:00:22.082', NULL, 'V4N9HIZs');
INSERT INTO `promotion_link` (`id`, `uuid`, `platform_id`, `account_id`, `region_id`, `group_id`, `domain_id`, `question_id`, `visit_count`, `copy_count`, `inquiry_count`, `conversion_count`, `follow_count`, `mobile_url`, `pc_url`, `ocpc_key`, `ocpc_secret`, `ocpc_conversion_type`, `ocpc_callback_type`, `https_enabled`, `sort`, `remark`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`, `random_code`) VALUES (2, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', 9, NULL, 3, 3, 1, 1, 1, 1, 0, 0, 0, 'http://bhpi1.hime.world/api/h5ldy/xehh0pBm/m/index.html', 'http://bhpi1.hime.world/api/h5ldy/xehh0pBm/pc/index.html', '', '', 0, 0, 0, 0, '', NULL, NULL, '2026-03-22 20:37:02.322', '2026-05-24 17:06:31.729', NULL, 'xehh0pBm');
INSERT INTO `promotion_link` (`id`, `uuid`, `platform_id`, `account_id`, `region_id`, `group_id`, `domain_id`, `question_id`, `visit_count`, `copy_count`, `inquiry_count`, `conversion_count`, `follow_count`, `mobile_url`, `pc_url`, `ocpc_key`, `ocpc_secret`, `ocpc_conversion_type`, `ocpc_callback_type`, `https_enabled`, `sort`, `remark`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`, `random_code`) VALUES (3, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', 14, NULL, 15, 6, 4, 4, 1, 1, 0, 0, 0, 'bhzy.zswdlxs.com/api/h5ldy/11HT07VM/m/index.html', 'bhzy.zswdlxs.com/api/h5ldy/11HT07VM/pc/index.html', '', '', 0, 0, 0, 1, '百度大搜-北海6月', NULL, NULL, '2026-05-23 21:00:30.260', '2026-05-24 21:41:46.063', NULL, '11HT07VM');
INSERT INTO `promotion_link` (`id`, `uuid`, `platform_id`, `account_id`, `region_id`, `group_id`, `domain_id`, `question_id`, `visit_count`, `copy_count`, `inquiry_count`, `conversion_count`, `follow_count`, `mobile_url`, `pc_url`, `ocpc_key`, `ocpc_secret`, `ocpc_conversion_type`, `ocpc_callback_type`, `https_enabled`, `sort`, `remark`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`, `random_code`) VALUES (4, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', 14, NULL, 15, 6, 4, 4, 0, 0, 0, 0, 0, '', '', '', '', 0, 0, 0, 2131, '', NULL, NULL, '2026-05-24 21:42:06.683', '2026-05-24 21:42:06.683', '2026-05-24 21:47:57.218', '');
COMMIT;

-- ----------------------------
-- Table structure for promotion_link_basic
-- ----------------------------
DROP TABLE IF EXISTS `promotion_link_basic`;
CREATE TABLE `promotion_link_basic` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uuid` varchar(100) DEFAULT NULL COMMENT '用户UUID',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `link_id` bigint unsigned DEFAULT NULL,
  `template_mobile_id` bigint unsigned DEFAULT NULL COMMENT '手机端模板ID（关联promotion_template_widget.id）',
  `template_pc_id` bigint unsigned DEFAULT NULL COMMENT '电脑端模板ID（关联promotion_template_widget.id）',
  `mobile_copy_widget_id` bigint unsigned DEFAULT NULL COMMENT '手机复制插件ID（关联promotion_template_widget.id）',
  `mobile_bottom_widget_id` bigint unsigned DEFAULT NULL COMMENT '手机底部插件ID（关联promotion_template_widget.id）',
  `pc_qrcode_widget_id` bigint unsigned DEFAULT NULL COMMENT '电脑端二维码插件ID（关联promotion_template_widget.id）',
  `pc_copy_widget_id` bigint unsigned DEFAULT NULL COMMENT '电脑端复制插件ID（关联promotion_template_widget.id）',
  `show_12301_phone` tinyint(1) NOT NULL DEFAULT '0' COMMENT '显示12301投诉电话',
  `mobile_show_qrcode` tinyint(1) DEFAULT NULL COMMENT '移动端显示二维码',
  `pc_show_right_qrcode` tinyint(1) DEFAULT NULL COMMENT '电脑端右侧二维码',
  `auto_detect_device` tinyint(1) DEFAULT NULL COMMENT '自动判断移动电脑端',
  `show12301_phone` tinyint(1) DEFAULT NULL COMMENT '显示12301投诉电话',
  `seo_keywords` varchar(500) DEFAULT NULL COMMENT 'SEO关键词（逗号分隔）',
  `seo_description` varchar(500) DEFAULT NULL COMMENT 'SEO描述',
  `seo_title` varchar(255) DEFAULT NULL COMMENT 'SEO标题',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_basic_link` (`link_id`),
  KEY `idx_deleted_at` (`deleted_at`),
  KEY `fk_basic_template_mobile` (`template_mobile_id`),
  KEY `fk_basic_template_pc` (`template_pc_id`),
  KEY `fk_basic_copy_widget` (`mobile_copy_widget_id`),
  KEY `fk_basic_bottom_widget` (`mobile_bottom_widget_id`),
  KEY `fk_basic_qrcode_widget` (`pc_qrcode_widget_id`),
  KEY `idx_promotion_link_basic_deleted_at` (`deleted_at`),
  KEY `idx_basic_uuid` (`uuid`),
  CONSTRAINT `fk_basic_bottom_widget` FOREIGN KEY (`mobile_bottom_widget_id`) REFERENCES `promotion_template_widget` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `fk_basic_copy_widget` FOREIGN KEY (`mobile_copy_widget_id`) REFERENCES `promotion_template_widget` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `fk_basic_qrcode_widget` FOREIGN KEY (`pc_qrcode_widget_id`) REFERENCES `promotion_template_widget` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `fk_basic_template_mobile` FOREIGN KEY (`template_mobile_id`) REFERENCES `promotion_template_widget` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `fk_basic_template_pc` FOREIGN KEY (`template_pc_id`) REFERENCES `promotion_template_widget` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='推广链接基本设置表';

-- ----------------------------
-- Records of promotion_link_basic
-- ----------------------------
BEGIN;
INSERT INTO `promotion_link_basic` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `link_id`, `template_mobile_id`, `template_pc_id`, `mobile_copy_widget_id`, `mobile_bottom_widget_id`, `pc_qrcode_widget_id`, `pc_copy_widget_id`, `show_12301_phone`, `mobile_show_qrcode`, `pc_show_right_qrcode`, `auto_detect_device`, `show12301_phone`, `seo_keywords`, `seo_description`, `seo_title`) VALUES (1, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-21 23:25:55.107', '2026-04-12 19:30:15.439', NULL, 1, 2, 11, 13, 17, 20, NULL, 0, 0, 0, 0, 0, '北海，旅游，休闲', '北海是一个不错的旅游地方', '北海旅游');
INSERT INTO `promotion_link_basic` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `link_id`, `template_mobile_id`, `template_pc_id`, `mobile_copy_widget_id`, `mobile_bottom_widget_id`, `pc_qrcode_widget_id`, `pc_copy_widget_id`, `show_12301_phone`, `mobile_show_qrcode`, `pc_show_right_qrcode`, `auto_detect_device`, `show12301_phone`, `seo_keywords`, `seo_description`, `seo_title`) VALUES (2, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-22 20:37:41.599', '2026-04-12 20:58:46.620', NULL, 2, 3, 12, 14, 18, 21, NULL, 0, 0, 1, 0, 1, '111', '1111', '11');
INSERT INTO `promotion_link_basic` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `link_id`, `template_mobile_id`, `template_pc_id`, `mobile_copy_widget_id`, `mobile_bottom_widget_id`, `pc_qrcode_widget_id`, `pc_copy_widget_id`, `show_12301_phone`, `mobile_show_qrcode`, `pc_show_right_qrcode`, `auto_detect_device`, `show12301_phone`, `seo_keywords`, `seo_description`, `seo_title`) VALUES (3, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', '2026-05-23 21:09:44.599', '2026-05-23 21:10:28.766', NULL, 3, 2, 11, 13, 17, 20, NULL, 0, 0, 1, 1, 0, '', '', '');
INSERT INTO `promotion_link_basic` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `link_id`, `template_mobile_id`, `template_pc_id`, `mobile_copy_widget_id`, `mobile_bottom_widget_id`, `pc_qrcode_widget_id`, `pc_copy_widget_id`, `show_12301_phone`, `mobile_show_qrcode`, `pc_show_right_qrcode`, `auto_detect_device`, `show12301_phone`, `seo_keywords`, `seo_description`, `seo_title`) VALUES (4, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', '2026-05-24 21:42:42.262', '2026-05-24 21:42:42.262', NULL, 4, 3, 12, 14, 18, 21, NULL, 0, 0, 1, 0, 0, '', '', '');
COMMIT;

-- ----------------------------
-- Table structure for promotion_link_code
-- ----------------------------
DROP TABLE IF EXISTS `promotion_link_code`;
CREATE TABLE `promotion_link_code` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户UUID',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `link_id` bigint unsigned DEFAULT NULL,
  `stat_header_html` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `stat_footer_html` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `conversion_script` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `css_style_text` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_code_link` (`link_id`),
  KEY `idx_promotion_link_code_deleted_at` (`deleted_at`),
  KEY `idx_code_uuid` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of promotion_link_code
-- ----------------------------
BEGIN;
INSERT INTO `promotion_link_code` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `link_id`, `stat_header_html`, `stat_footer_html`, `conversion_script`, `css_style_text`) VALUES (1, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-21 21:02:37.863', '2026-03-21 21:02:37.863', NULL, 1, '1', '1', '1', '1');
COMMIT;

-- ----------------------------
-- Table structure for promotion_link_comment
-- ----------------------------
DROP TABLE IF EXISTS `promotion_link_comment`;
CREATE TABLE `promotion_link_comment` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户UUID',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `link_id` bigint unsigned DEFAULT NULL,
  `enable_comment` tinyint(1) DEFAULT NULL,
  `permission` enum('mobile_login','guest') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'mobile_login',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_comment_link` (`link_id`),
  KEY `idx_promotion_link_comment_deleted_at` (`deleted_at`),
  KEY `idx_comment_uuid` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of promotion_link_comment
-- ----------------------------
BEGIN;
INSERT INTO `promotion_link_comment` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `link_id`, `enable_comment`, `permission`) VALUES (1, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-22 15:22:18.897', '2026-03-22 15:22:18.897', NULL, 1, 1, 'guest');
COMMIT;

-- ----------------------------
-- Table structure for promotion_link_company
-- ----------------------------
DROP TABLE IF EXISTS `promotion_link_company`;
CREATE TABLE `promotion_link_company` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户UUID',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `link_id` bigint unsigned DEFAULT NULL,
  `company_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `icp_record_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `license_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `homepage_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `about_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `logo_pc_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `logo_mobile_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_company_link` (`link_id`),
  KEY `idx_promotion_link_company_deleted_at` (`deleted_at`),
  KEY `idx_company_uuid` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of promotion_link_company
-- ----------------------------
BEGIN;
INSERT INTO `promotion_link_company` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `link_id`, `company_name`, `icp_record_no`, `license_no`, `homepage_url`, `about_url`, `logo_pc_url`, `logo_mobile_url`) VALUES (1, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-21 21:02:31.028', '2026-04-12 13:47:53.748', NULL, 1, '1', '1', '1', 'https://www.baidu.com', '1', 'uploads/file/d708d3b6d61633b9bd848ec6acdb8838_20260321235742.png', 'uploads/file/d708d3b6d61633b9bd848ec6acdb8838_20260321235758.png');
INSERT INTO `promotion_link_company` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `link_id`, `company_name`, `icp_record_no`, `license_no`, `homepage_url`, `about_url`, `logo_pc_url`, `logo_mobile_url`) VALUES (2, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-04-12 21:00:03.539', '2026-04-12 21:01:45.133', NULL, 2, '22', '22', '22', 'https://baidu.com', 'https://baidu.com', 'uploads/file/57ac07f36f13d5ba7d9aa291ec107e8e_20260412210143.png', 'uploads/file/57ac07f36f13d5ba7d9aa291ec107e8e_20260412210140.png');
INSERT INTO `promotion_link_company` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `link_id`, `company_name`, `icp_record_no`, `license_no`, `homepage_url`, `about_url`, `logo_pc_url`, `logo_mobile_url`) VALUES (3, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', '2026-05-23 21:12:13.045', '2026-05-23 21:13:55.716', NULL, 3, '3123', '13', '213', 'bhzy.zswdlxs.com', ' bhzy.zswdlxs.com', '', '');
COMMIT;

-- ----------------------------
-- Table structure for promotion_link_theme
-- ----------------------------
DROP TABLE IF EXISTS `promotion_link_theme`;
CREATE TABLE `promotion_link_theme` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户UUID',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `link_id` bigint unsigned DEFAULT NULL,
  `color_wechat_phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `color_service_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `color_copyright` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bold_all` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_theme_link` (`link_id`),
  KEY `idx_promotion_link_theme_deleted_at` (`deleted_at`),
  KEY `idx_theme_uuid` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of promotion_link_theme
-- ----------------------------
BEGIN;
INSERT INTO `promotion_link_theme` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `link_id`, `color_wechat_phone`, `color_service_name`, `color_copyright`, `bold_all`) VALUES (1, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-22 15:22:02.194', '2026-03-22 15:22:02.194', NULL, 1, 'rgb(37, 27, 222)', 'rgb(228, 45, 45)', 'rgb(151, 245, 11)', 1);
COMMIT;

-- ----------------------------
-- Table structure for promotion_template_widget
-- ----------------------------
DROP TABLE IF EXISTS `promotion_template_widget`;
CREATE TABLE `promotion_template_widget` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
  `name` varchar(128) NOT NULL COMMENT '名称',
  `type` tinyint unsigned NOT NULL COMMENT '类型 1=手机端模板 2=电脑端模板 3=手机复制插件 4=手机底部插件 5=电脑端二维码插件',
  `preview_image` varchar(256) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `idx_widget_type` (`type`),
  KEY `idx_deleted_at` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='模板插件表';

-- ----------------------------
-- Records of promotion_template_widget
-- ----------------------------
BEGIN;
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (1, '2026-03-22 18:47:59', '2026-05-10 11:51:26', '2026-05-10 19:51:27', 'template-00', 1, '');
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (2, '2026-03-22 18:47:59', '2026-03-25 22:44:06', NULL, 'template-01', 1, 'uploads/file/c20ad4d76fe97759aa27a0c99bff6710_20260325224404.png');
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (3, '2026-03-22 18:47:59', '2026-05-24 19:58:03', NULL, 'template-02', 1, 'uploads/file/814989b983fd853fb374e1676a06ade4_20260524195801.jpg');
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (4, '2026-03-22 18:47:59', '2026-05-10 11:51:20', '2026-05-10 19:51:21', 'template-03', 1, '');
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (5, '2026-03-22 18:47:59', '2026-05-10 11:51:13', '2026-05-10 19:51:13', 'template-04', 1, '');
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (6, '2026-03-22 18:47:59', '2026-05-10 11:51:15', '2026-05-10 19:51:15', 'template-05', 1, '');
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (7, '2026-03-22 18:47:59', '2026-05-10 11:51:08', '2026-05-10 19:51:08', 'template-06', 1, '');
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (8, '2026-03-22 18:47:59', '2026-05-10 11:51:05', '2026-05-10 19:51:06', 'template-07', 1, '');
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (9, '2026-03-22 18:47:59', '2026-05-10 11:51:10', '2026-05-10 19:51:11', 'template-08', 1, '');
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (10, '2026-03-22 18:47:59', '2026-05-10 11:51:03', '2026-05-10 19:51:03', 'template-09', 1, '');
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (11, '2026-03-22 18:47:59', '2026-03-22 18:47:59', NULL, 'template-01', 2, '');
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (12, '2026-03-22 18:47:59', '2026-03-22 18:47:59', NULL, 'template-02', 2, '');
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (32, NOW(), NOW(), NULL, 'template-05', 2, '');
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (13, '2026-03-22 18:47:59', '2026-03-22 18:47:59', NULL, 'wechat-copy-1', 3, '');
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (14, '2026-03-22 18:47:59', '2026-03-22 18:47:59', NULL, 'wechat-copy-2', 3, '');
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (15, '2026-03-22 18:47:59', '2026-05-10 11:50:59', '2026-05-10 19:50:59', 'wechat-copy-3', 3, '');
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (16, '2026-03-22 18:47:59', '2026-05-10 11:50:56', '2026-05-10 19:50:57', 'wechat-copy-4', 3, '');
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (17, '2026-03-22 18:47:59', '2026-03-22 18:47:59', NULL, 'bottom-bar-1', 4, '');
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (18, '2026-03-22 18:47:59', '2026-03-22 18:47:59', NULL, 'bottom-bar-2', 4, '');
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (19, '2026-03-22 18:47:59', '2026-05-10 11:50:53', '2026-05-10 19:50:54', 'bottom-bar-3', 4, '');
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (20, '2026-03-22 18:47:59', '2026-03-22 18:47:59', NULL, 'pc-qrcode-1', 5, '');
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (21, '2026-03-22 18:47:59', '2026-03-22 18:47:59', NULL, 'pc-qrcode-2', 5, '');
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (22, '2026-03-22 18:47:59', '2026-05-10 11:50:50', '2026-05-10 19:50:50', 'pc-qrcode-3', 5, '');
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (23, '2026-03-22 19:52:53', '2026-05-10 11:50:48', '2026-05-10 19:50:48', 'wechat-copy-5', 3, '');
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (24, '2026-03-22 19:52:59', '2026-05-10 11:50:45', '2026-05-10 19:50:46', 'wechat-copy-6', 3, '');
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (25, '2026-03-22 19:53:07', '2026-05-10 11:50:43', '2026-05-10 19:50:43', 'wechat-copy-7', 3, '');
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (26, '2026-03-22 19:54:19', '2026-05-10 11:50:40', '2026-05-10 19:50:41', 'wechat-copy-8', 3, '');
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (27, '2026-03-22 19:54:19', '2026-05-10 11:50:38', '2026-05-10 19:50:39', 'wechat-copy-9', 3, '');
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (28, '2026-03-22 19:54:19', '2026-05-10 11:50:36', '2026-05-10 19:50:37', 'wechat-copy-10', 3, '');
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (29, '2026-03-22 19:54:19', '2026-05-10 11:50:34', '2026-05-10 19:50:35', 'wechat-copy-11', 3, '');
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (30, '2026-03-22 19:54:19', '2026-05-10 11:50:32', '2026-05-10 19:50:32', 'wechat-copy-12', 3, '');
INSERT INTO `promotion_template_widget` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `preview_image`) VALUES (31, '2026-03-22 19:54:19', '2026-05-10 11:50:30', '2026-05-10 19:50:31', 'wechat-copy-13', 3, '');
COMMIT;

-- ----------------------------
-- Table structure for qa_answer
-- ----------------------------
DROP TABLE IF EXISTS `qa_answer`;
CREATE TABLE `qa_answer` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uuid` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户UUID',
  `question_id` bigint unsigned DEFAULT NULL,
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `avatar_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `title_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `signature` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `level` bigint unsigned DEFAULT '0',
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `follow_count` bigint unsigned DEFAULT '0',
  `favorite_count` bigint unsigned DEFAULT '0',
  `like_count` bigint unsigned DEFAULT '0',
  `time_text` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `skill` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `audit_status` tinyint(1) DEFAULT '0',
  `reply_count` bigint unsigned DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `author_id` bigint unsigned DEFAULT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `images_json` json DEFAULT NULL,
  `is_accepted` tinyint(1) DEFAULT NULL,
  `sort` bigint DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_answer_question` (`question_id`),
  KEY `idx_answer_audit_status` (`audit_status`),
  KEY `idx_qa_answer_deleted_at` (`deleted_at`),
  KEY `idx_answer_author` (`author_id`),
  KEY `idx_answer_uuid` (`uuid`),
  CONSTRAINT `fk_answer_question` FOREIGN KEY (`question_id`) REFERENCES `qa_question` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='问答-回答表';

-- ----------------------------
-- Records of qa_answer
-- ----------------------------
BEGIN;
INSERT INTO `qa_answer` (`id`, `uuid`, `question_id`, `nickname`, `avatar_url`, `title_name`, `signature`, `level`, `content`, `follow_count`, `favorite_count`, `like_count`, `time_text`, `skill`, `audit_status`, `reply_count`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`, `author_id`, `title`, `images_json`, `is_accepted`, `sort`, `remark`) VALUES (1, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', 1, '小猫22', 'uploads/file/c20ad4d76fe97759aa27a0c99bff6710_20260324232041.png', '放心旅行者', '每一次旅行对我而言都是一份礼物，开心的、新奇的、惊喜的、真实的。', 7, '<p><br></p><p style=\"text-indent: 2em; text-align: left;\">我是江苏的，我去北海玩了2次，给你大概说下吧，希望对你有帮助。</p><p style=\"text-indent: 2em; text-align: left;\">第一次是和家人一起，熟人给介绍的我们江苏当地出发的旅游团。确实很便宜，可到了北海后，行程太赶太累不说，核心的景点都没能好好体验，还加了购物店。给我的感觉是被转卖给了北海的旅行社，品质根本没有得到保障，反正不好玩。虽然是熟人介绍，还是不建议当地报团。</p><p style=\"text-indent: 2em; text-align: left;\">第二次也就是去年，也是玩的最满意，最省钱的一次。我们自己订好机票，提前联系了当地口碑很好专门接待自由行的<span style=\"color: rgb(85, 85, 85);\">大熊</span>，由<span style=\"color: rgb(85, 85, 85);\">他</span>全程安排了5天的行程，根本不用自己操心。也很划算。</p><p style=\"text-indent: 2em; text-align: left;\">玩5天才1000左右，包括4个晚上的豪华酒店（<strong>大熊还贴心的给我们安排的是海边附近的酒店，阳台外面就是海景，早上的海边日出太美了，强烈推荐！！！我查了以海边为中心周围10公里的4星酒店，1晚都是400起，自己订住宿太贵了）</strong>，还有<span style=\"color: rgb(0, 176, 240);\"><strong>景点门票，涠洲的往返船票，所有的车费、吃饭、保险什么的。而且大熊是24小时管家式服务</strong></span>，真的很贴心，强烈推荐一下（整个行程下来无自费无套路，玩的非常开心）。</p><p style=\"text-align: left;\"><img src=\"https://ldy.qyzcm.com/upload/30/202408/27/202408270002186641.jpeg\" alt=\"\" data-href=\"\" style=\"\"></p><p style=\"text-indent: 2em; text-align: left;\">分享下<span style=\"color: rgb(85, 85, 85);\">大熊</span>根据我游玩的时间和想去的景点规划的行程，具体的想知道北海该怎么玩，可以让<span style=\"color: rgb(85, 85, 85);\">大熊</span>给你们免<strong>费规划行程+免费咨询</strong>北海涠洲旅游各种疑难问题，大家找<span style=\"color: rgb(85, 85, 85);\">他</span>详细了解下。</p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"color: rgb(255, 0, 0);\">温馨提示：景点和涠洲船票是需要提前实名预约，身份证必须随身携带，大家去北海旅游之前可以找大熊预约一下景点门票和船票（旺季船票不提前定，基本没机会抢到票）！</span></p><p style=\"text-indent: 2em; text-align: left;\">现在<span style=\"color: rgb(85, 85, 85);\">大熊</span>好像在搞活动，大家有兴趣的可以加<span style=\"color: rgb(85, 85, 85);\">他</span>微信问一下，<span style=\"color: rgb(85, 85, 85);\">大熊</span>有时候还会不定时的发优惠券呢！</p><p style=\"text-align: left;\"><strong>大熊的微信：18577993574</strong><span style=\"color: rgb(0, 0, 0);\">（大</span>家想规划自己的北海旅游行程或者预定景点门票+船票等都可以找<span style=\"color: rgb(85, 85, 85);\">大熊</span>帮忙，想在北海涠洲住宿好又便宜的也可以找<span style=\"color: rgb(85, 85, 85);\">大熊</span>拿底价房）</p><p style=\"text-align: left;\"><img src=\"https://ldy.qyzcm.com/upload/30/202408/27/202408270008169927.jpg\" alt=\"\" data-href=\"\" style=\"\"></p><p style=\"text-align: left;\">✨北海涠洲经典5天高端深度游✨ &nbsp;</p><p style=\"text-align: left;\">🌴D1：接机/接站 （专人接机，前往酒店，办理入住休息后，可自行前往最繁华、最热闹的侨港风情街品尝美食，感受一下北海风情-🏠宿：北海</p><p style=\"text-align: left;\">🌴D2：百年老街(北海最具历史的骑楼文化)-北部湾广场-北海十里银滩(中国第一滩)- 疍家小镇（特色风情小镇），🏠宿：北海-餐：早</p><p style=\"text-align: left;\">🌴D3：上涠洲，鳄鱼山风景区(火山地质公园)-标志广场-天主教堂-海上运动基地-海滩拾贝看日落，🏠宿：涠洲-餐：早</p><p style=\"text-align: left;\">🌴D4：涠洲自由行，早起可前往五彩滩看日出，贝壳沙滩抓螃蟹/拾海螺，电瓶车骑行环岛游，享受浪漫的海岛风光，🏠宿：涠洲-餐：早</p><p style=\"text-align: left;\">🌴D5：睡到自然醒，根据返程时间安排送机/送站，餐：早</p><p style=\"text-align: left;\">由于<span style=\"color: rgb(85, 85, 85);\">大熊</span>帮我们安排在海边附近的酒店，所以下午想去海边就非常方便。</p><p style=\"text-align: left;\">特别推荐一下<span style=\"color: rgb(85, 85, 85);\">大熊</span>，想去北海的可以提前找<span style=\"color: rgb(85, 85, 85);\">他</span>问一下。<strong>大熊的微信是：18577993574（点击复制微信免费预定门票和船票+属于你自己的行程路线）</strong></p><p style=\"text-align: left;\">回到北海后，我们并没有直接返程，而是在北海多留了一天，</p><p style=\"text-align: left;\"><span style=\"color: rgb(85, 85, 85);\">大熊</span>帮我们拿的<span style=\"color: rgb(85, 85, 85);\">他</span>们合作酒店底价房间，很实惠，如果你也想多玩一天给<span style=\"color: rgb(85, 85, 85);\">大熊</span>说让帮你拿底价房，蛮不错的。</p><p style=\"text-align: left;\">其实<strong>广西还有很多好玩的地方，南宁大瀑布、古龙大峡谷、桂林山水、甚至是境外越南</strong>的游玩行程都可以咨询<span style=\"color: rgb(85, 85, 85);\">大熊</span>。</p><p style=\"text-align: left;\">如果你想去广西的话可以问<span style=\"color: rgb(85, 85, 85);\">大熊</span>，办事真的很靠谱，很负责<span style=\"color: rgb(0, 0, 0);\"><strong>（去北海的机票动车票都比较贵，酒店住房也是一样，找</strong></span><strong>##昵称加号码##</strong><span style=\"color: rgb(0, 0, 0);\"><strong>预定会有优惠，另外像涠洲的景点门票和船票的可以提前前预定，想去北海涠洲的亲们记得一定要提早预定好，不然就怕白跑了还玩不到什么，不想麻烦的可以找大熊帮你们统一提前安排好）</strong></span></p>', 3, 4, 2, '啊啊', '题主采纳', 1, 0, NULL, NULL, '2026-03-22 11:53:26.476', '2026-04-12 20:05:41.841', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for qa_avatar_nickname
-- ----------------------------
DROP TABLE IF EXISTS `qa_avatar_nickname`;
CREATE TABLE `qa_avatar_nickname` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uuid` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户UUID',
  `avatar_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '头像地址',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态 1:启用 0:禁用',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_sort` (`sort`),
  KEY `idx_avatar_uuid` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='QA头像昵称管理表';

-- ----------------------------
-- Records of qa_avatar_nickname
-- ----------------------------
BEGIN;
INSERT INTO `qa_avatar_nickname` (`id`, `uuid`, `avatar_url`, `nickname`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (1, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', 'uploads/file/d708d3b6d61633b9bd848ec6acdb8838_20260322112708.png', '小猫', 0, 1, '2026-03-22 11:27:19', '2026-05-10 09:57:56', NULL);
INSERT INTO `qa_avatar_nickname` (`id`, `uuid`, `avatar_url`, `nickname`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (2, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', 'uploads/file/daa8f13c9d65da091604a1c944e47f3b_20260521212449.jpeg', '风沙带来快乐', 1, 1, '2026-05-21 21:25:04', '2026-05-23 12:50:03', '2026-05-23 20:50:03');
INSERT INTO `qa_avatar_nickname` (`id`, `uuid`, `avatar_url`, `nickname`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (3, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', 'uploads/file/daa8f13c9d65da091604a1c944e47f3b_20260521213222.jpg', '小啊七', 0, 1, '2026-05-21 21:35:40', '2026-05-21 13:36:25', '2026-05-21 21:36:25');
INSERT INTO `qa_avatar_nickname` (`id`, `uuid`, `avatar_url`, `nickname`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (4, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', 'uploads/file/dfc0e642be3044e9f018c2ad5b9216b3_20260521213554.jpg', '洛河路', 3, 1, '2026-05-21 21:36:10', '2026-05-23 12:50:05', '2026-05-23 20:50:06');
INSERT INTO `qa_avatar_nickname` (`id`, `uuid`, `avatar_url`, `nickname`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (5, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', 'uploads/file/daa8f13c9d65da091604a1c944e47f3b_20260523205056.jpg', '小啊七', 1, 1, '2026-05-23 20:51:00', '2026-05-23 20:51:00', NULL);
INSERT INTO `qa_avatar_nickname` (`id`, `uuid`, `avatar_url`, `nickname`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (6, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', 'uploads/file/dfc0e642be3044e9f018c2ad5b9216b3_20260523205112.jpg', '阿昔', 2, 1, '2026-05-23 20:51:23', '2026-05-23 20:51:23', NULL);
INSERT INTO `qa_avatar_nickname` (`id`, `uuid`, `avatar_url`, `nickname`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (7, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', 'uploads/file/628aadbeabbe1c09e7559c39ebb66970_20260523205130.jpg', '硬汉五', 3, 1, '2026-05-23 20:51:50', '2026-05-23 20:51:50', NULL);
INSERT INTO `qa_avatar_nickname` (`id`, `uuid`, `avatar_url`, `nickname`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (8, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', 'uploads/file/3e61ea5e7b685bb3337aeb046f009d6c_20260523205202.jpg', '费米兰', 4, 1, '2026-05-23 20:52:17', '2026-05-23 20:52:17', NULL);
INSERT INTO `qa_avatar_nickname` (`id`, `uuid`, `avatar_url`, `nickname`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (9, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', 'uploads/file/c672c7807147fbdaf09ecd1b29843872_20260523205227.jpg', '江南烟雨', 5, 1, '2026-05-23 20:52:38', '2026-05-23 20:52:38', NULL);
INSERT INTO `qa_avatar_nickname` (`id`, `uuid`, `avatar_url`, `nickname`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (10, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', 'uploads/file/955308098d929de21c68042c9bf81d29_20260523205333.jpg', '心悦', 6, 1, '2026-05-23 20:53:40', '2026-05-23 20:53:40', NULL);
INSERT INTO `qa_avatar_nickname` (`id`, `uuid`, `avatar_url`, `nickname`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (11, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', 'uploads/file/94387bbb271592bf7979b0c7cae7cbe3_20260523205351.jpg', '敏敏', 7, 1, '2026-05-23 20:54:06', '2026-05-23 20:54:13', NULL);
INSERT INTO `qa_avatar_nickname` (`id`, `uuid`, `avatar_url`, `nickname`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (12, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', 'uploads/file/28a41f24c1b02db5ec14f11189ce05ca_20260523205423.jpg', '放飞心情', 8, 1, '2026-05-23 20:54:33', '2026-05-23 20:54:33', NULL);
INSERT INTO `qa_avatar_nickname` (`id`, `uuid`, `avatar_url`, `nickname`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (13, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', 'uploads/file/34a3acdf6a5c0db6fcbc7918fe237c0f_20260523205446.jpg', '洱海边', 9, 1, '2026-05-23 20:54:54', '2026-05-23 20:54:54', NULL);
INSERT INTO `qa_avatar_nickname` (`id`, `uuid`, `avatar_url`, `nickname`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (14, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', 'uploads/file/722600ba96199b2e5a62a2fbcf31688a_20260523205504.jpg', '烟火中的你我', 10, 1, '2026-05-23 20:55:14', '2026-05-23 20:55:14', NULL);
INSERT INTO `qa_avatar_nickname` (`id`, `uuid`, `avatar_url`, `nickname`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (15, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', 'uploads/file/fe6d8d65d2ac692a5c88cc07837c402d_20260523205528.jpg', 'gahgfa', 11, 1, '2026-05-23 20:55:30', '2026-05-23 20:55:30', NULL);
INSERT INTO `qa_avatar_nickname` (`id`, `uuid`, `avatar_url`, `nickname`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (16, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', 'uploads/file/6d283a0eb007683e94c72317741975ae_20260523205544.jpg', '旅途中你我他', 12, 1, '2026-05-23 20:56:08', '2026-05-23 20:56:08', NULL);
INSERT INTO `qa_avatar_nickname` (`id`, `uuid`, `avatar_url`, `nickname`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (17, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', 'uploads/file/eccbc87e4b5ce2fe28308fd9f2a7baf3_20260523205619.jpg', '酱酱紫', 13, 1, '2026-05-23 20:56:25', '2026-05-23 20:56:25', NULL);
COMMIT;

-- ----------------------------
-- Table structure for qa_question
-- ----------------------------
DROP TABLE IF EXISTS `qa_question`;
CREATE TABLE `qa_question` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uuid` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户UUID',
  `region_id` bigint unsigned DEFAULT NULL,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `time_at` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `avatar_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `title_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `signature` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `follow_count` bigint unsigned DEFAULT NULL,
  `look_count` bigint unsigned DEFAULT NULL,
  `favorite_count` bigint unsigned DEFAULT NULL,
  `like_count` bigint unsigned DEFAULT NULL,
  `label` json DEFAULT NULL,
  `sort` bigint DEFAULT NULL,
  `answer_count` bigint unsigned DEFAULT NULL,
  `status` tinyint unsigned DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `account_id` bigint unsigned DEFAULT NULL,
  `category_id` bigint unsigned DEFAULT NULL,
  `cover_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_pinned` tinyint(1) DEFAULT NULL,
  `is_private` tinyint(1) DEFAULT NULL,
  `view_count` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_question_region` (`region_id`),
  KEY `idx_question_status` (`status`),
  KEY `idx_question_sort` (`sort`),
  KEY `idx_qa_question_deleted_at` (`deleted_at`),
  KEY `idx_question_account` (`account_id`),
  KEY `idx_question_category` (`category_id`),
  KEY `idx_question_uuid` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='问答-问题表';

-- ----------------------------
-- Records of qa_question
-- ----------------------------
BEGIN;
INSERT INTO `qa_question` (`id`, `uuid`, `region_id`, `title`, `content`, `time_at`, `remark`, `nickname`, `avatar_url`, `title_name`, `signature`, `follow_count`, `look_count`, `favorite_count`, `like_count`, `label`, `sort`, `answer_count`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`, `account_id`, `category_id`, `cover_url`, `is_pinned`, `is_private`, `view_count`) VALUES (1, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', 2, '2026北海旅游攻略-北海怎么玩？涠洲岛攻略？北海游玩必去景点？', '<p style=\"text-align: left;\"><strong>##昵称加号码##</strong>准备广西北海玩几天，计划5-6天行程怎么安排比较好？北海有哪些经典必去景点？大概要花多少钱？现在去 怎么玩好？哪些景点需要提前预订门票？北海住宿有推荐的吗？有没有近期去 北海涠洲 旅游的人解答我的疑问，谢谢！</p><p style=\"text-align: left;\"><br></p><hr/><p style=\"text-indent: 2em; text-align: left;\"><br></p><p style=\"text-indent: 2em; text-align: left;\">计划去北海涠洲旅游5天，我打算带上我一家人去玩玩，问下去玩几天比较合适，请问去过得要怎么样玩比较省心省钱少走弯路？有哪些注意事项防止被坑？好点得景点和路线推荐下，如何才能够轻松自在，不操心？还有我要兼顾老人小孩，不想出什么差错，所以想考虑周全些，有能回答我的朋友十分感谢！</p><p><img src=\"/api/uploads/file/3755522c7727bbb58137af545608f72c_20260322133417.webp\" alt=\"game_banner.webp\" data-href=\"\" style=\"\"/></p>', '2天前', '', '小猫', 'uploads/file/d708d3b6d61633b9bd848ec6acdb8838_20260322112708.png', '细心旅行家', '仗剑走天涯 四海皆为家', 1033, 14039, 39, 160, '[\"美食\", \"跟团游\", \"半自助游\", \"自助游\"]', 2, 0, 2, NULL, NULL, '2026-03-22 11:29:22.498', '2026-04-12 21:09:19.945', NULL, 0, NULL, '', 0, 0, 0);
INSERT INTO `qa_question` (`id`, `uuid`, `region_id`, `title`, `content`, `time_at`, `remark`, `nickname`, `avatar_url`, `title_name`, `signature`, `follow_count`, `look_count`, `favorite_count`, `like_count`, `label`, `sort`, `answer_count`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`, `account_id`, `category_id`, `cover_url`, `is_pinned`, `is_private`, `view_count`) VALUES (2, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', 2, '啊啊', '<p>SD啊菜单上v擦</p>', '啊啊是', '1221', '小猫', 'uploads/file/d708d3b6d61633b9bd848ec6acdb8838_20260322112708.png', '狂热旅客', '旅行之于我，是一个迷失自己，然后发现自己的过程。', 1, 2, 3, 4, '[]', 1, 0, 2, NULL, NULL, '2026-03-22 11:50:30.935', '2026-03-24 23:16:50.681', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qa_question` (`id`, `uuid`, `region_id`, `title`, `content`, `time_at`, `remark`, `nickname`, `avatar_url`, `title_name`, `signature`, `follow_count`, `look_count`, `favorite_count`, `like_count`, `label`, `sort`, `answer_count`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`, `account_id`, `category_id`, `cover_url`, `is_pinned`, `is_private`, `view_count`) VALUES (3, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', 1, 'w', '<p>www</p>', 'w', 'w', '小猫', 'uploads/file/d708d3b6d61633b9bd848ec6acdb8838_20260322112708.png', '登山勇士', '每一次旅行对我而言都是一份礼物，开心的、新奇的、惊喜的、真实的。', 1, 1, 1, 0, '[\"亲子游\", \"美食\"]', 1, 0, 2, NULL, NULL, '2026-03-22 12:07:54.746', '2026-03-22 12:07:54.746', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `qa_question` (`id`, `uuid`, `region_id`, `title`, `content`, `time_at`, `remark`, `nickname`, `avatar_url`, `title_name`, `signature`, `follow_count`, `look_count`, `favorite_count`, `like_count`, `label`, `sort`, `answer_count`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`, `account_id`, `category_id`, `cover_url`, `is_pinned`, `is_private`, `view_count`) VALUES (4, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', NULL, '2026北海旅游攻略-北海怎么玩？涠洲岛攻略？北海游玩必去景点？', '<p style=\"text-align: left;\">准备广西北海玩几天，计划5-6天行程怎么安排比较好？北海有哪些经典必去景点？大概要花多少钱？现在去 怎么玩好？哪些景点需要提前预订门票？北海住宿有推荐的吗？有没有近期去 北海涠洲 旅游的人解答我的疑问，谢谢！</p><hr/><p><br></p><p style=\"text-indent: 2em; text-align: left;\">计划去北海涠洲旅游5天，我打算带上我一家人去玩玩，问下去玩几天比较合适，请问去过得要怎么样玩比较省心省钱少走弯路？有哪些注意事项防止被坑？好点得景点和路线推荐下，如何才能够轻松自在，不操心？还有我要兼顾老人小孩，不想出什么差错，所以想考虑周全些，有能回答我的朋友十分感谢！</p>', '一个月前', '北海26-5-19', '旧时光的旅者', 'uploads/file/44bc64300c7df1312838e8ca611ccafe_20260519210139.jpg', '精彩旅者', '', 44146, 92546, 56891, 65981, '[\"自由行\", \"亲子家庭游\", \"高品质纯玩\", \"私人订制小包团\", \"美食推荐\"]', 99, 0, 2, NULL, NULL, '2026-05-19 21:07:58.813', '2026-05-19 21:07:58.813', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for qa_reply
-- ----------------------------
DROP TABLE IF EXISTS `qa_reply`;
CREATE TABLE `qa_reply` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uuid` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户UUID',
  `answer_id` bigint unsigned DEFAULT NULL,
  `parent_id` bigint unsigned DEFAULT NULL,
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `avatar_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `title_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `signature` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `level` bigint unsigned DEFAULT '0',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `follow_count` bigint unsigned DEFAULT '0',
  `favorite_count` bigint unsigned DEFAULT '0',
  `like_count` bigint unsigned DEFAULT '0',
  `time_text` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `skill` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `audit_status` tinyint(1) DEFAULT '0',
  `status` tinyint unsigned DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `author_id` bigint unsigned DEFAULT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_reply_answer` (`answer_id`),
  KEY `idx_reply_parent` (`parent_id`),
  KEY `idx_reply_audit_status` (`audit_status`),
  KEY `idx_qa_reply_deleted_at` (`deleted_at`),
  KEY `idx_reply_status` (`status`),
  KEY `idx_reply_uuid` (`uuid`),
  CONSTRAINT `fk_reply_answer` FOREIGN KEY (`answer_id`) REFERENCES `qa_answer` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_reply_parent` FOREIGN KEY (`parent_id`) REFERENCES `qa_reply` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='问答-回复表';

-- ----------------------------
-- Records of qa_reply
-- ----------------------------
BEGIN;
INSERT INTO `qa_reply` (`id`, `uuid`, `answer_id`, `parent_id`, `nickname`, `avatar_url`, `title_name`, `signature`, `level`, `content`, `follow_count`, `favorite_count`, `like_count`, `time_text`, `skill`, `audit_status`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`, `author_id`, `title`, `remark`) VALUES (1, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', 1, NULL, '小猫', 'uploads/file/d708d3b6d61633b9bd848ec6acdb8838_20260322112708.png', '漫游者', '仗剑走天涯 四海皆为家', 1, '<p style=\"text-indent: 2em;\"><span style=\"color: rgb(85, 85, 85); background-color: rgb(255, 255, 255); font-size: 15px;\">你们玩的也太舒服了吧，看的我都想马上出发了。现在北海的天气怎么样？想天气好的时候去玩几天！能自驾过去吗？停车是否方便？</span><strong>##昵称加号码##</strong></p>', 3, 2, 2, '2天前', '行程向导', 1, 1, NULL, NULL, '2026-03-22 12:06:12.156', '2026-04-12 20:05:56.709', NULL, NULL, NULL, NULL);
INSERT INTO `qa_reply` (`id`, `uuid`, `answer_id`, `parent_id`, `nickname`, `avatar_url`, `title_name`, `signature`, `level`, `content`, `follow_count`, `favorite_count`, `like_count`, `time_text`, `skill`, `audit_status`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`, `author_id`, `title`, `remark`) VALUES (2, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', 1, NULL, '小猫', 'uploads/file/d708d3b6d61633b9bd848ec6acdb8838_20260322112708.png', '探索者', '旅行之于我，是一个迷失自己，然后发现自己的过程。', 3, '<p style=\"text-align: left;\">@乖一点就抱你</p><p style=\"text-align: left;\">我去的时候也是找<strong>##昵称加号码##</strong>问了北海那边的天气，然后再决定具体日期去的，你可以加<span style=\"color: rgb(85, 85, 85);\">大熊</span>的微信问一下，<span style=\"color: rgb(85, 85, 85);\">他</span>人非常好的！顺便还可以咨询下北海和涠洲的各大景点和注意事项。</p><p style=\"text-align: left;\">自驾的话我不太清楚，我是直接做高铁出发，然后<span style=\"color: rgb(85, 85, 85);\">他</span>来接的我们，我们玩的时候都是<span style=\"color: rgb(85, 85, 85);\">他</span>车接车送的，但是涠洲岛是只能坐船，车子不能上船，如果你自驾出发，可以详细问问<span style=\"color: rgb(85, 85, 85);\">他</span>，让<span style=\"color: rgb(85, 85, 85);\">他</span>找一个靠谱的地方给你停好车</p><p style=\"text-align: left;\"><img src=\"https://ldy.qyzcm.com/upload/30/202409/04/202409042307316862.jpg\" alt=\"\" data-href=\"\" style=\"\"></p><p style=\"text-align: left;\"><img src=\"https://ldy.qyzcm.com/upload/30/202409/04/202409042307538892.jpg\" alt=\"\" data-href=\"\" style=\"\"></p>', 2, 1, 2, '', '', 1, 1, NULL, NULL, '2026-03-22 14:49:05.085', '2026-04-12 20:05:50.789', NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for qa_signature
-- ----------------------------
DROP TABLE IF EXISTS `qa_signature`;
CREATE TABLE `qa_signature` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uuid` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户UUID',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '个性签名内容',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态 1:启用 0:禁用',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_sort` (`sort`),
  KEY `idx_signature_uuid` (`uuid`),
  KEY `uk_content` (`content`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='QA个性签名管理表';

-- ----------------------------
-- Records of qa_signature
-- ----------------------------
BEGIN;
INSERT INTO `qa_signature` (`id`, `uuid`, `content`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (1, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '假如生活欺骗了你，不如一路向西去大理。', 1, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_signature` (`id`, `uuid`, `content`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (2, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '旅行对我来说，是恢复青春的活力水。', 2, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_signature` (`id`, `uuid`, `content`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (3, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '接受突如其来的失去，珍惜不期而遇的惊喜。', 3, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_signature` (`id`, `uuid`, `content`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (4, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '世界这么大，我要出去给人看看。', 4, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_signature` (`id`, `uuid`, `content`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (5, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '步履不停，脚步不止。', 5, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_signature` (`id`, `uuid`, `content`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (6, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '脚长在自己身上，往前走就对了。', 6, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_signature` (`id`, `uuid`, `content`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (7, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '旅行，就是从自己活腻的地方到别人活腻的地方去。', 7, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_signature` (`id`, `uuid`, `content`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (8, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '旅行要学会随遇而安，淡然一点，走走停停。', 8, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_signature` (`id`, `uuid`, `content`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (9, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '旅行，就是一次心灵的逃避，一种精神的徜徉。', 9, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_signature` (`id`, `uuid`, `content`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (10, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '旅行，就是离开生活常态，去寻找另一个自己的过程。', 10, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_signature` (`id`, `uuid`, `content`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (11, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '漫无目的的流浪，任凭大自然左右，不做生活的奴隶。', 11, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_signature` (`id`, `uuid`, `content`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (12, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '感受不同的风景，充实自己的心灵，留下一份美好的回忆。', 12, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_signature` (`id`, `uuid`, `content`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (13, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '人生不止有苟且，还有诗和远方', 13, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_signature` (`id`, `uuid`, `content`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (14, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '旅行，是平凡生活的必备梦想', 14, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_signature` (`id`, `uuid`, `content`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (15, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '跟我的司机永远在路上', 15, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_signature` (`id`, `uuid`, `content`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (16, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '下一站，你去哪儿', 16, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_signature` (`id`, `uuid`, `content`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (17, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '仗剑走天涯 四海皆为家', 17, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_signature` (`id`, `uuid`, `content`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (18, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '旅行之于我，是一个迷失自己，然后发现自己的过程。', 18, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_signature` (`id`, `uuid`, `content`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (19, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '梦想便是想仗剑走天涯，看一看世界的繁华。', 19, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_signature` (`id`, `uuid`, `content`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (20, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '每一次旅行对我而言都是一份礼物，开心的、新奇的、惊喜的、真实的。', 20, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
COMMIT;

-- ----------------------------
-- Table structure for qa_tag
-- ----------------------------
DROP TABLE IF EXISTS `qa_tag`;
CREATE TABLE `qa_tag` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uuid` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户UUID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标签名称',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态 1:启用 0:禁用',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_sort` (`sort`),
  KEY `idx_tag_uuid` (`uuid`),
  KEY `uk_name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='QA标签管理表';

-- ----------------------------
-- Records of qa_tag
-- ----------------------------
BEGIN;
INSERT INTO `qa_tag` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (1, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '自由行', 1, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_tag` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (2, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '亲子游', 2, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_tag` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (3, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '品质游', 3, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_tag` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (4, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '半自助游', 4, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_tag` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (5, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '自助游', 5, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_tag` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (6, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '美食', 6, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_tag` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (7, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '跟团游', 7, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_tag` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (8, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '私人订制', 8, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
COMMIT;

-- ----------------------------
-- Table structure for qa_title
-- ----------------------------
DROP TABLE IF EXISTS `qa_title`;
CREATE TABLE `qa_title` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uuid` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户UUID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '称号名称',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态 1:启用 0:禁用',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_sort` (`sort`),
  KEY `idx_title_uuid` (`uuid`),
  KEY `uk_name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='QA称号管理表';

-- ----------------------------
-- Records of qa_title
-- ----------------------------
BEGIN;
INSERT INTO `qa_title` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (1, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '旅游达人', 1, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_title` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (2, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '精彩旅行家', 2, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_title` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (3, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '热爱旅行者', 3, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_title` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (4, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '行走的梦想家', 4, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_title` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (5, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '观光旅客', 5, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_title` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (6, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '旅游探索者', 6, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_title` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (7, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '追求自由旅行', 7, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_title` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (8, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '海边星辰', 8, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_title` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (9, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '潜水家', 9, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_title` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (10, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '自助旅行狂人', 10, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_title` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (11, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '奇幻旅程', 11, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_title` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (12, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '放飞梦想的旅人', 12, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_title` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (13, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '世界游走者', 13, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_title` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (14, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '发现者', 14, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_title` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (15, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '探索者', 15, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_title` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (16, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '漫游者', 16, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_title` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (17, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '放心旅行者', 17, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_title` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (18, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '细心旅行家', 18, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_title` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (19, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '狂热旅客', 19, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_title` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (20, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '登山勇士', 20, 1, '2026-03-22 11:06:04', '2026-05-10 09:57:57', NULL);
INSERT INTO `qa_title` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (21, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', '爱玩好玩', 1, 1, '2026-05-23 20:57:55', '2026-05-23 20:57:55', NULL);
INSERT INTO `qa_title` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (22, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', '丈量大地高度', 2, 1, '2026-05-23 20:58:48', '2026-05-23 20:58:48', NULL);
INSERT INTO `qa_title` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (23, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', '月儿早', 0, 1, '2026-05-23 20:58:59', '2026-05-23 20:58:59', NULL);
INSERT INTO `qa_title` (`id`, `uuid`, `name`, `sort`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (24, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', '森林里的烟火', 3, 1, '2026-05-23 20:59:15', '2026-05-23 20:59:15', NULL);
COMMIT;

-- ----------------------------
-- Table structure for region_category
-- ----------------------------
DROP TABLE IF EXISTS `region_category`;
CREATE TABLE `region_category` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户UUID',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `parent_id` bigint unsigned DEFAULT NULL,
  `sort` bigint DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_region_category_deleted_at` (`deleted_at`),
  KEY `idx_region_parent` (`parent_id`),
  KEY `idx_region_sort` (`sort`),
  KEY `idx_region_uuid` (`uuid`),
  KEY `idk_region_name` (`name`) USING BTREE,
  KEY `idx_region_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of region_category
-- ----------------------------
BEGIN;
INSERT INTO `region_category` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `name`, `parent_id`, `sort`, `remark`) VALUES (1, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-20 23:12:29.411', '2026-03-20 23:12:29.411', NULL, '北京', NULL, 5, '');
INSERT INTO `region_category` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `name`, `parent_id`, `sort`, `remark`) VALUES (2, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-20 23:12:44.530', '2026-03-20 23:12:44.530', NULL, '新疆', NULL, 4, '');
INSERT INTO `region_category` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `name`, `parent_id`, `sort`, `remark`) VALUES (3, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-20 23:12:58.040', '2026-03-20 23:12:58.040', NULL, '四川', NULL, 3, '');
INSERT INTO `region_category` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `name`, `parent_id`, `sort`, `remark`) VALUES (4, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-20 23:13:06.920', '2026-03-20 23:13:06.920', NULL, '港澳', NULL, 2, '');
INSERT INTO `region_category` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `name`, `parent_id`, `sort`, `remark`) VALUES (5, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', '2026-03-20 23:13:13.786', '2026-03-20 23:13:13.786', NULL, '北海', NULL, 1, '');
INSERT INTO `region_category` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `name`, `parent_id`, `sort`, `remark`) VALUES (13, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', '2026-05-21 21:36:05.502', '2026-05-21 21:36:05.502', NULL, '北京', 0, 1, '北京');
INSERT INTO `region_category` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `name`, `parent_id`, `sort`, `remark`) VALUES (14, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', '2026-05-23 11:01:33.548', '2026-05-23 11:01:33.548', NULL, '上海', NULL, 2, '');
INSERT INTO `region_category` (`id`, `uuid`, `created_at`, `updated_at`, `deleted_at`, `name`, `parent_id`, `sort`, `remark`) VALUES (15, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', '2026-05-23 20:47:23.300', '2026-05-23 20:47:23.300', NULL, '北海', 15, 3, '');
COMMIT;

-- ----------------------------
-- Table structure for ssl_certificate
-- ----------------------------
DROP TABLE IF EXISTS `ssl_certificate`;
CREATE TABLE `ssl_certificate` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `provider` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `serial_no` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `issuer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `not_before` datetime DEFAULT NULL,
  `not_after` datetime DEFAULT NULL,
  `status` tinyint unsigned DEFAULT NULL,
  `pem_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `key_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_ssl_certificate_deleted_at` (`deleted_at`),
  KEY `idx_cert_expire` (`not_after`),
  KEY `idx_cert_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of ssl_certificate
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_api_tokens
-- ----------------------------
DROP TABLE IF EXISTS `sys_api_tokens`;
CREATE TABLE `sys_api_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL COMMENT '用户ID',
  `authority_id` bigint unsigned DEFAULT NULL COMMENT '角色ID',
  `token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'Token',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态',
  `expires_at` datetime(3) DEFAULT NULL COMMENT '过期时间',
  `remark` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `idx_sys_api_tokens_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of sys_api_tokens
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_apis
-- ----------------------------
DROP TABLE IF EXISTS `sys_apis`;
CREATE TABLE `sys_apis` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `path` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'api路径',
  `description` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'api中文描述',
  `api_group` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'api组',
  `method` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'POST' COMMENT '方法',
  PRIMARY KEY (`id`),
  KEY `idx_sys_apis_deleted_at` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=279 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of sys_apis
-- ----------------------------
BEGIN;
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (1, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/jwt/jsonInBlacklist', 'jwt加入黑名单(退出，必选)', 'jwt', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (2, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysLoginLog/deleteLoginLog', '删除登录日志', '登录日志', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (3, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysLoginLog/deleteLoginLogByIds', '批量删除登录日志', '登录日志', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (4, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysLoginLog/findLoginLog', '根据ID获取登录日志', '登录日志', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (5, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysLoginLog/getLoginLogList', '获取登录日志列表', '登录日志', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (6, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysApiToken/createApiToken', '签发API Token', 'API Token', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (7, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysApiToken/getApiTokenList', '获取API Token列表', 'API Token', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (8, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysApiToken/deleteApiToken', '作废API Token', 'API Token', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (9, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/user/deleteUser', '删除用户', '系统用户', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (10, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/user/admin_register', '用户注册', '系统用户', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (11, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/user/getUserList', '获取用户列表', '系统用户', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (12, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/user/setUserInfo', '设置用户信息', '系统用户', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (13, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/user/setSelfInfo', '设置自身信息(必选)', '系统用户', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (14, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/user/getUserInfo', '获取自身信息(必选)', '系统用户', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (15, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/user/setUserAuthorities', '设置权限组', '系统用户', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (16, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/user/changePassword', '修改密码（建议选择)', '系统用户', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (17, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/user/setUserAuthority', '修改用户角色(必选)', '系统用户', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (18, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/user/resetPassword', '重置用户密码', '系统用户', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (19, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/user/setSelfSetting', '用户界面配置', '系统用户', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (20, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/api/createApi', '创建api', 'api', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (21, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/api/deleteApi', '删除Api', 'api', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (22, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/api/updateApi', '更新Api', 'api', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (23, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/api/getApiList', '获取api列表', 'api', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (24, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/api/getAllApis', '获取所有api', 'api', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (25, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/api/getApiById', '获取api详细信息', 'api', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (26, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/api/deleteApisByIds', '批量删除api', 'api', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (27, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/api/syncApi', '获取待同步API', 'api', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (28, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/api/getApiGroups', '获取路由组', 'api', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (29, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/api/enterSyncApi', '确认同步API', 'api', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (30, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/api/ignoreApi', '忽略API', 'api', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (31, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/authority/copyAuthority', '拷贝角色', '角色', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (32, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/authority/createAuthority', '创建角色', '角色', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (33, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/authority/deleteAuthority', '删除角色', '角色', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (34, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/authority/updateAuthority', '更新角色信息', '角色', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (35, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/authority/getAuthorityList', '获取角色列表', '角色', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (36, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/authority/setDataAuthority', '设置角色资源权限', '角色', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (37, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/casbin/updateCasbin', '更改角色api权限', 'casbin', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (38, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/casbin/getPolicyPathByAuthorityId', '获取权限列表', 'casbin', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (39, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/menu/addBaseMenu', '新增菜单', '菜单', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (40, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/menu/getMenu', '获取菜单树(必选)', '菜单', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (41, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/menu/deleteBaseMenu', '删除菜单', '菜单', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (42, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/menu/updateBaseMenu', '更新菜单', '菜单', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (43, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/menu/getBaseMenuById', '根据id获取菜单', '菜单', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (44, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/menu/getMenuList', '分页获取基础menu列表', '菜单', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (45, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/menu/getBaseMenuTree', '获取用户动态路由', '菜单', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (46, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/menu/getMenuAuthority', '获取指定角色menu', '菜单', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (47, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/menu/addMenuAuthority', '增加menu和角色关联关系', '菜单', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (48, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/fileUploadAndDownload/findFile', '寻找目标文件（秒传）', '分片上传', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (49, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/fileUploadAndDownload/breakpointContinue', '断点续传', '分片上传', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (50, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/fileUploadAndDownload/breakpointContinueFinish', '断点续传完成', '分片上传', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (51, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/fileUploadAndDownload/removeChunk', '上传完成移除文件', '分片上传', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (52, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/fileUploadAndDownload/upload', '文件上传（建议选择）', '文件上传与下载', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (53, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/fileUploadAndDownload/deleteFile', '删除文件', '文件上传与下载', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (54, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/fileUploadAndDownload/editFileName', '文件名或者备注编辑', '文件上传与下载', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (55, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/fileUploadAndDownload/getFileList', '获取上传文件列表', '文件上传与下载', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (56, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/fileUploadAndDownload/importURL', '导入URL', '文件上传与下载', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (57, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/system/getServerInfo', '获取服务器信息', '系统服务', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (58, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/system/getSystemConfig', '获取配置文件内容', '系统服务', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (59, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/system/setSystemConfig', '设置配置文件内容', '系统服务', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (60, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/skills/getTools', '获取技能工具列表', 'skills', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (61, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/skills/getSkillList', '获取技能列表', 'skills', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (62, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/skills/getSkillDetail', '获取技能详情', 'skills', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (63, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/skills/saveSkill', '保存技能定义', 'skills', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (64, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/skills/createScript', '创建技能脚本', 'skills', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (65, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/skills/getScript', '读取技能脚本', 'skills', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (66, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/skills/saveScript', '保存技能脚本', 'skills', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (67, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/skills/createResource', '创建技能资源', 'skills', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (68, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/skills/getResource', '读取技能资源', 'skills', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (69, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/skills/saveResource', '保存技能资源', 'skills', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (70, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/skills/createReference', '创建技能参考', 'skills', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (71, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/skills/getReference', '读取技能参考', 'skills', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (72, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/skills/saveReference', '保存技能参考', 'skills', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (73, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/skills/createTemplate', '创建技能模板', 'skills', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (74, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/skills/getTemplate', '读取技能模板', 'skills', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (75, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/skills/saveTemplate', '保存技能模板', 'skills', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (76, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/skills/getGlobalConstraint', '读取全局约束', 'skills', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (77, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/skills/saveGlobalConstraint', '保存全局约束', 'skills', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (78, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/customer/customer', '更新客户', '客户', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (79, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/customer/customer', '创建客户', '客户', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (80, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/customer/customer', '删除客户', '客户', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (81, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/customer/customer', '获取单一客户', '客户', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (82, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/customer/customerList', '获取客户列表', '客户', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (83, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/autoCode/getDB', '获取所有数据库', '代码生成器', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (84, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/autoCode/getTables', '获取数据库表', '代码生成器', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (85, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/autoCode/createTemp', '自动化代码', '代码生成器', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (86, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/autoCode/preview', '预览自动化代码', '代码生成器', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (87, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/autoCode/getColumn', '获取所选table的所有字段', '代码生成器', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (88, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/autoCode/installPlugin', '安装插件', '代码生成器', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (89, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/autoCode/pubPlug', '打包插件', '代码生成器', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (90, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/autoCode/removePlugin', '卸载插件', '代码生成器', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (91, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/autoCode/getPluginList', '获取已安装插件', '代码生成器', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (92, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/autoCode/mcp', '自动生成 MCP Tool 模板', '代码生成器', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (93, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/autoCode/mcpTest', 'MCP Tool 测试', '代码生成器', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (94, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/autoCode/mcpList', '获取 MCP ToolList', '代码生成器', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (95, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/autoCode/createPackage', '配置模板', '模板配置', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (96, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/autoCode/getTemplates', '获取模板文件', '模板配置', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (97, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/autoCode/getPackage', '获取所有模板', '模板配置', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (98, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/autoCode/delPackage', '删除模板', '模板配置', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (99, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/autoCode/getMeta', '获取meta信息', '代码生成器历史', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (100, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/autoCode/rollback', '回滚自动生成代码', '代码生成器历史', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (101, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/autoCode/getSysHistory', '查询回滚记录', '代码生成器历史', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (102, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/autoCode/delSysHistory', '删除回滚记录', '代码生成器历史', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (103, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/autoCode/addFunc', '增加模板方法', '代码生成器历史', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (104, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysDictionaryDetail/updateSysDictionaryDetail', '更新字典内容', '系统字典详情', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (105, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysDictionaryDetail/createSysDictionaryDetail', '新增字典内容', '系统字典详情', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (106, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysDictionaryDetail/deleteSysDictionaryDetail', '删除字典内容', '系统字典详情', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (107, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysDictionaryDetail/findSysDictionaryDetail', '根据ID获取字典内容', '系统字典详情', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (108, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysDictionaryDetail/getSysDictionaryDetailList', '获取字典内容列表', '系统字典详情', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (109, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysDictionaryDetail/getDictionaryTreeList', '获取字典数列表', '系统字典详情', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (110, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysDictionaryDetail/getDictionaryTreeListByType', '根据分类获取字典数列表', '系统字典详情', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (111, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysDictionaryDetail/getDictionaryDetailsByParent', '根据父级ID获取字典详情', '系统字典详情', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (112, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysDictionaryDetail/getDictionaryPath', '获取字典详情的完整路径', '系统字典详情', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (113, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysDictionary/createSysDictionary', '新增字典', '系统字典', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (114, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysDictionary/deleteSysDictionary', '删除字典', '系统字典', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (115, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysDictionary/updateSysDictionary', '更新字典', '系统字典', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (116, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysDictionary/findSysDictionary', '根据ID获取字典（建议选择）', '系统字典', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (117, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysDictionary/getSysDictionaryList', '获取字典列表', '系统字典', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (118, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysDictionary/importSysDictionary', '导入字典JSON', '系统字典', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (119, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysDictionary/exportSysDictionary', '导出字典JSON', '系统字典', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (120, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysOperationRecord/createSysOperationRecord', '新增操作记录', '操作记录', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (121, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysOperationRecord/findSysOperationRecord', '根据ID获取操作记录', '操作记录', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (122, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysOperationRecord/getSysOperationRecordList', '获取操作记录列表', '操作记录', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (123, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysOperationRecord/deleteSysOperationRecord', '删除操作记录', '操作记录', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (124, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysOperationRecord/deleteSysOperationRecordByIds', '批量删除操作历史', '操作记录', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (125, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/simpleUploader/upload', '插件版分片上传', '断点续传(插件版)', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (126, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/simpleUploader/checkFileMd5', '文件完整度验证', '断点续传(插件版)', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (127, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/simpleUploader/mergeFileMd5', '上传完成合并文件', '断点续传(插件版)', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (128, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/email/emailTest', '发送测试邮件', 'email', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (129, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/email/sendEmail', '发送邮件', 'email', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (130, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/authorityBtn/setAuthorityBtn', '设置按钮权限', '按钮权限', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (131, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/authorityBtn/getAuthorityBtn', '获取已有按钮权限', '按钮权限', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (132, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/authorityBtn/canRemoveAuthorityBtn', '删除按钮', '按钮权限', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (133, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysExportTemplate/createSysExportTemplate', '新增导出模板', '导出模板', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (134, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysExportTemplate/deleteSysExportTemplate', '删除导出模板', '导出模板', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (135, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysExportTemplate/deleteSysExportTemplateByIds', '批量删除导出模板', '导出模板', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (136, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysExportTemplate/updateSysExportTemplate', '更新导出模板', '导出模板', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (137, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysExportTemplate/findSysExportTemplate', '根据ID获取导出模板', '导出模板', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (138, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysExportTemplate/getSysExportTemplateList', '获取导出模板列表', '导出模板', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (139, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysExportTemplate/exportExcel', '导出Excel', '导出模板', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (140, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysExportTemplate/exportTemplate', '下载模板', '导出模板', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (141, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysExportTemplate/previewSQL', '预览SQL', '导出模板', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (142, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysExportTemplate/importExcel', '导入Excel', '导出模板', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (143, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysError/createSysError', '新建错误日志', '错误日志', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (144, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysError/deleteSysError', '删除错误日志', '错误日志', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (145, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysError/deleteSysErrorByIds', '批量删除错误日志', '错误日志', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (146, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysError/updateSysError', '更新错误日志', '错误日志', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (147, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysError/findSysError', '根据ID获取错误日志', '错误日志', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (148, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysError/getSysErrorList', '获取错误日志列表', '错误日志', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (149, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysError/getSysErrorSolution', '触发错误处理(异步)', '错误日志', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (150, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/info/createInfo', '新建公告', '公告', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (151, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/info/deleteInfo', '删除公告', '公告', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (152, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/info/deleteInfoByIds', '批量删除公告', '公告', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (153, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/info/updateInfo', '更新公告', '公告', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (154, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/info/findInfo', '根据ID获取公告', '公告', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (155, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/info/getInfoList', '获取公告列表', '公告', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (156, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysParams/createSysParams', '新建参数', '参数管理', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (157, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysParams/deleteSysParams', '删除参数', '参数管理', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (158, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysParams/deleteSysParamsByIds', '批量删除参数', '参数管理', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (159, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysParams/updateSysParams', '更新参数', '参数管理', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (160, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysParams/findSysParams', '根据ID获取参数', '参数管理', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (161, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysParams/getSysParamsList', '获取参数列表', '参数管理', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (162, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysParams/getSysParam', '获取参数列表', '参数管理', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (163, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/attachmentCategory/getCategoryList', '分类列表', '媒体库分类', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (164, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/attachmentCategory/addCategory', '添加/编辑分类', '媒体库分类', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (165, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/attachmentCategory/deleteCategory', '删除分类', '媒体库分类', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (166, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysVersion/findSysVersion', '获取单一版本', '版本控制', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (167, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysVersion/getSysVersionList', '获取版本列表', '版本控制', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (168, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysVersion/downloadVersionJson', '下载版本json', '版本控制', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (169, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysVersion/exportVersion', '创建版本', '版本控制', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (170, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysVersion/importVersion', '同步版本', '版本控制', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (171, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysVersion/deleteSysVersion', '删除版本', '版本控制', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (172, '2026-03-19 23:02:02.457', '2026-03-19 23:02:02.457', NULL, '/sysVersion/deleteSysVersionByIds', '批量删除版本', '版本控制', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (173, '2026-03-20 23:08:00.687', '2026-03-20 23:08:00.687', NULL, '/promotion/updateGroupMember', 'updateGroupMember', 'promotion', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (174, '2026-03-20 23:08:01.951', '2026-03-20 23:08:01.951', NULL, '/promotion/updatePromotionDomain', 'updatePromotionDomain', 'promotion', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (175, '2026-03-20 23:08:02.671', '2026-03-20 23:08:02.671', NULL, '/promotion/updatePromotionGroup', 'updatePromotionGroup', 'promotion', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (176, '2026-03-20 23:08:03.437', '2026-03-20 23:08:03.437', NULL, '/promotion/updatePromotionLink', 'updatePromotionLink', 'promotion', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (177, '2026-03-20 23:08:04.054', '2026-03-20 23:08:04.054', NULL, '/promotion/updateQAReply', 'updateQAReply', 'promotion', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (178, '2026-03-20 23:08:04.678', '2026-03-20 23:08:04.678', NULL, '/promotion/updateQAAnswer', 'updateQAAnswer', 'promotion', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (179, '2026-03-20 23:08:05.517', '2026-03-20 23:08:05.517', NULL, '/promotion/updateQAQuestion', 'updateQAQuestion', 'promotion', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (180, '2026-03-20 23:08:06.152', '2026-03-20 23:08:06.152', NULL, '/promotion/updateActivityData', 'updateActivityData', 'promotion', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (181, '2026-03-20 23:08:06.687', '2026-03-20 23:08:06.687', NULL, '/promotion/updateActivityPackage', 'updateActivityPackage', 'promotion', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (182, '2026-03-20 23:08:07.205', '2026-03-20 23:08:07.205', NULL, '/promotion/updateActivityMarket', 'updateActivityMarket', 'promotion', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (183, '2026-03-20 23:08:07.829', '2026-03-20 23:08:07.829', NULL, '/promotion/updateAdKeyword', 'updateAdKeyword', 'promotion', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (184, '2026-03-20 23:08:08.329', '2026-03-20 23:08:08.329', NULL, '/promotion/updateAdCampaign', 'updateAdCampaign', 'promotion', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (185, '2026-03-20 23:08:08.737', '2026-03-20 23:08:08.737', NULL, '/promotion/updateAdPlatform', 'updateAdPlatform', 'promotion', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (186, '2026-03-20 23:08:09.137', '2026-03-20 23:08:09.137', NULL, '/promotion/deleteGroupMember', 'deleteGroupMember', 'promotion', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (187, '2026-03-20 23:08:09.581', '2026-03-20 23:08:09.581', NULL, '/promotion/deleteRegionCategory', 'deleteRegionCategory', 'promotion', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (188, '2026-03-20 23:08:10.038', '2026-03-20 23:08:10.038', NULL, '/promotion/deletePromotionDomain', 'deletePromotionDomain', 'promotion', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (189, '2026-03-20 23:08:10.598', '2026-03-20 23:08:10.598', NULL, '/promotion/deletePromotionGroup', 'deletePromotionGroup', 'promotion', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (190, '2026-03-20 23:08:11.262', '2026-03-20 23:08:11.262', NULL, '/promotion/deletePromotionLink', 'deletePromotionLink', 'promotion', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (191, '2026-03-20 23:08:11.738', '2026-03-20 23:08:11.738', NULL, '/promotion/deleteQAReply', 'deleteQAReply', 'promotion', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (192, '2026-03-20 23:08:12.237', '2026-03-20 23:08:12.237', NULL, '/promotion/deleteQAAnswer', 'deleteQAAnswer', 'promotion', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (193, '2026-03-20 23:08:12.661', '2026-03-20 23:08:12.661', NULL, '/promotion/deleteQAQuestion', 'deleteQAQuestion', 'promotion', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (194, '2026-03-20 23:08:12.935', '2026-03-20 23:08:12.935', NULL, '/promotion/deleteActivityData', 'deleteActivityData', 'promotion', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (195, '2026-03-20 23:08:13.197', '2026-03-20 23:08:13.197', NULL, '/promotion/deleteActivityPackage', 'deleteActivityPackage', 'promotion', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (196, '2026-03-20 23:08:13.437', '2026-03-20 23:08:13.437', NULL, '/promotion/deleteActivityMarket', 'deleteActivityMarket', 'promotion', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (197, '2026-03-20 23:08:13.654', '2026-03-20 23:08:13.654', NULL, '/promotion/deleteAdKeyword', 'deleteAdKeyword', 'promotion', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (198, '2026-03-20 23:08:13.854', '2026-03-20 23:08:13.854', NULL, '/promotion/deleteAdCampaign', 'deleteAdCampaign', 'promotion', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (199, '2026-03-20 23:08:14.069', '2026-03-20 23:08:14.069', NULL, '/promotion/deleteAdPlatform', 'deleteAdPlatform', 'promotion', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (200, '2026-03-20 23:08:17.767', '2026-03-20 23:08:17.767', NULL, '/promotion/upsertLinkTheme', 'upsertLinkTheme', 'promotion', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (201, '2026-03-20 23:08:18.437', '2026-03-20 23:08:18.437', NULL, '/promotion/upsertLinkBasic', 'upsertLinkBasic', 'promotion', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (202, '2026-03-20 23:08:18.745', '2026-03-20 23:08:18.745', NULL, '/promotion/upsertLinkCode', 'upsertLinkCode', 'promotion', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (203, '2026-03-20 23:08:19.012', '2026-03-20 23:08:19.012', NULL, '/promotion/upsertLinkComment', 'upsertLinkComment', 'promotion', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (204, '2026-03-20 23:08:19.389', '2026-03-20 23:08:19.389', NULL, '/promotion/upsertLinkCompany', 'upsertLinkCompany', 'promotion', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (205, '2026-03-20 23:08:19.628', '2026-03-20 23:08:19.628', NULL, '/promotion/createGroupMember', 'createGroupMember', 'promotion', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (206, '2026-03-20 23:08:19.926', '2026-03-20 23:08:19.926', NULL, '/promotion/createRegionCategory', 'createRegionCategory', 'promotion', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (207, '2026-03-20 23:08:20.149', '2026-03-20 23:08:20.149', NULL, '/promotion/createPromotionDomain', 'createPromotionDomain', 'promotion', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (208, '2026-03-20 23:08:20.437', '2026-03-20 23:08:20.437', NULL, '/promotion/createPromotionGroup', 'createPromotionGroup', 'promotion', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (209, '2026-03-20 23:08:20.668', '2026-03-20 23:08:20.668', NULL, '/promotion/createPromotionLink', 'createPromotionLink', 'promotion', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (210, '2026-03-20 23:08:20.869', '2026-03-20 23:08:20.869', NULL, '/promotion/createQAReply', 'createQAReply', 'promotion', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (211, '2026-03-20 23:08:21.101', '2026-03-20 23:08:21.101', NULL, '/promotion/createQAAnswer', 'createQAAnswer', 'promotion', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (212, '2026-03-20 23:08:21.318', '2026-03-20 23:08:21.318', NULL, '/promotion/createQAQuestion', 'createQAQuestion', 'promotion', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (213, '2026-03-20 23:08:21.560', '2026-03-20 23:08:21.560', NULL, '/promotion/createActivityData', 'createActivityData', 'promotion', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (214, '2026-03-20 23:08:21.758', '2026-03-20 23:08:21.758', NULL, '/promotion/createActivityPackage', 'createActivityPackage', 'promotion', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (215, '2026-03-20 23:08:22.005', '2026-03-20 23:08:22.005', NULL, '/promotion/createActivityMarket', 'createActivityMarket', 'promotion', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (216, '2026-03-20 23:08:22.205', '2026-03-20 23:08:22.205', NULL, '/promotion/createAdKeyword', 'createAdKeyword', 'promotion', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (217, '2026-03-20 23:08:22.421', '2026-03-20 23:08:22.421', NULL, '/promotion/createAdCampaign', 'createAdCampaign', 'promotion', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (218, '2026-03-20 23:08:22.702', '2026-03-20 23:08:22.702', NULL, '/promotion/createAdPlatform', 'createAdPlatform', 'promotion', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (219, '2026-03-20 23:08:24.038', '2026-03-20 23:08:24.038', NULL, '/promotion/updateRegionCategory', 'updateRegionCategory', 'promotion', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (220, '2026-03-20 23:09:59.092', '2026-03-20 23:09:59.092', NULL, '/promotion/findGroupMember', 'findGroupMember', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (221, '2026-03-20 23:10:01.622', '2026-03-20 23:10:01.622', NULL, '/promotion/findRegionCategory', 'findRegionCategory', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (222, '2026-03-20 23:10:05.320', '2026-03-20 23:10:05.320', NULL, '/promotion/getAdPlatformList', 'getAdPlatformList', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (223, '2026-03-20 23:10:05.830', '2026-03-20 23:10:05.830', NULL, '/promotion/getAdCampaignList', 'getAdCampaignList', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (224, '2026-03-20 23:10:06.529', '2026-03-20 23:10:06.529', NULL, '/promotion/getAdKeywordList', 'getAdKeywordList', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (225, '2026-03-20 23:10:06.734', '2026-03-20 23:10:06.734', NULL, '/promotion/getAdDailySummaryList', 'getAdDailySummaryList', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (226, '2026-03-20 23:10:06.928', '2026-03-20 23:10:06.928', NULL, '/promotion/getActivityMarketList', 'getActivityMarketList', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (227, '2026-03-20 23:10:07.095', '2026-03-20 23:10:07.095', NULL, '/promotion/getActivityPackageList', 'getActivityPackageList', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (228, '2026-03-20 23:10:07.841', '2026-03-20 23:10:07.841', NULL, '/promotion/getActivityDataList', 'getActivityDataList', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (229, '2026-03-20 23:10:08.045', '2026-03-20 23:10:08.045', NULL, '/promotion/getLinkCompany', 'getLinkCompany', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (230, '2026-03-20 23:10:08.254', '2026-03-20 23:10:08.254', NULL, '/promotion/getLinkComment', 'getLinkComment', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (231, '2026-03-20 23:10:08.461', '2026-03-20 23:10:08.461', NULL, '/promotion/getLinkCode', 'getLinkCode', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (232, '2026-03-20 23:10:08.662', '2026-03-20 23:10:08.662', NULL, '/promotion/getLinkBasic', 'getLinkBasic', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (233, '2026-03-20 23:10:08.862', '2026-03-20 23:10:08.862', NULL, '/promotion/getLinkTheme', 'getLinkTheme', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (234, '2026-03-20 23:10:09.086', '2026-03-20 23:10:09.086', NULL, '/promotion/getQAQuestionList', 'getQAQuestionList', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (235, '2026-03-20 23:10:09.269', '2026-03-20 23:10:09.269', NULL, '/promotion/getQAAnswerList', 'getQAAnswerList', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (236, '2026-03-20 23:10:09.479', '2026-03-20 23:10:09.479', NULL, '/promotion/getQAReplyList', 'getQAReplyList', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (237, '2026-03-20 23:10:09.686', '2026-03-20 23:10:09.686', NULL, '/promotion/getPromotionLinkList', 'getPromotionLinkList', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (238, '2026-03-20 23:10:09.895', '2026-03-20 23:10:09.895', NULL, '/promotion/getPromotionGroupList', 'getPromotionGroupList', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (239, '2026-03-20 23:10:10.095', '2026-03-20 23:10:10.095', NULL, '/promotion/getPromotionDomainList', 'getPromotionDomainList', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (240, '2026-03-20 23:10:10.335', '2026-03-20 23:10:10.335', NULL, '/promotion/getRegionCategoryList', 'getRegionCategoryList', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (241, '2026-03-20 23:10:10.670', '2026-03-20 23:10:10.670', NULL, '/promotion/getGroupMemberList', 'getGroupMemberList', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (242, '2026-03-20 23:10:10.886', '2026-03-20 23:10:10.886', NULL, '/promotion/findPromotionLink', 'findPromotionLink', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (243, '2026-03-20 23:10:11.102', '2026-03-20 23:10:11.102', NULL, '/promotion/findPromotionGroup', 'findPromotionGroup', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (244, '2026-03-20 23:10:11.333', '2026-03-20 23:10:11.333', NULL, '/promotion/findPromotionDomain', 'findPromotionDomain', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (245, '2026-03-21 20:58:31.537', '2026-03-21 20:58:31.537', NULL, '/promotion/updateTemplateWidget', 'updateTemplateWidget', 'promotion', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (246, '2026-03-21 20:58:35.012', '2026-03-21 20:58:35.012', NULL, '/promotion/deleteTemplateWidget', 'deleteTemplateWidget', 'promotion', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (247, '2026-03-21 20:58:36.090', '2026-03-21 20:58:36.090', NULL, '/promotion/createTemplateWidget', 'createTemplateWidget', 'promotion', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (248, '2026-03-21 20:58:37.388', '2026-03-21 20:58:37.388', NULL, '/promotion/findTemplateWidget', 'findTemplateWidget', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (249, '2026-03-21 20:58:38.881', '2026-03-21 20:58:38.881', NULL, '/promotion/getTemplateWidgetList', 'getTemplateWidgetList', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (250, '2026-03-22 11:26:15.722', '2026-03-22 11:26:15.722', NULL, '/promotion/updateQASignature', 'updateQASignature', 'promotion', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (251, '2026-03-22 11:26:16.503', '2026-03-22 11:26:16.503', NULL, '/promotion/updateQATag', 'updateQATag', 'promotion', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (252, '2026-03-22 11:26:17.006', '2026-03-22 11:26:17.006', NULL, '/promotion/updateQATitle', 'updateQATitle', 'promotion', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (253, '2026-03-22 11:26:17.694', '2026-03-22 11:26:17.694', NULL, '/promotion/updateQAAvatarNickname', 'updateQAAvatarNickname', 'promotion', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (254, '2026-03-22 11:26:18.240', '2026-03-22 11:26:18.240', NULL, '/promotion/deleteQASignature', 'deleteQASignature', 'promotion', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (255, '2026-03-22 11:26:19.534', '2026-03-22 11:26:19.534', NULL, '/promotion/deleteQATag', 'deleteQATag', 'promotion', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (256, '2026-03-22 11:26:19.946', '2026-03-22 11:26:19.946', NULL, '/promotion/deleteQATitle', 'deleteQATitle', 'promotion', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (257, '2026-03-22 11:26:20.358', '2026-03-22 11:26:20.358', NULL, '/promotion/deleteQAAvatarNickname', 'deleteQAAvatarNickname', 'promotion', 'DELETE');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (258, '2026-03-22 11:26:21.619', '2026-03-22 11:26:21.619', NULL, '/promotion/createQASignature', 'createQASignature', 'promotion', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (259, '2026-03-22 11:26:22.125', '2026-03-22 11:26:22.125', NULL, '/promotion/createQATag', 'createQATag', 'promotion', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (260, '2026-03-22 11:26:22.550', '2026-03-22 11:26:22.550', NULL, '/promotion/createQATitle', 'createQATitle', 'promotion', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (261, '2026-03-22 11:26:23.148', '2026-03-22 11:26:23.148', NULL, '/promotion/createQAAvatarNickname', 'createQAAvatarNickname', 'promotion', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (262, '2026-03-22 11:26:25.786', '2026-03-22 11:26:25.786', NULL, '/promotion/getQASignatureList', 'getQASignatureList', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (263, '2026-03-22 11:26:26.989', '2026-03-22 11:26:26.989', NULL, '/promotion/getQATagList', 'getQATagList', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (264, '2026-03-22 11:26:29.150', '2026-03-22 11:26:29.150', NULL, '/promotion/getAllEnabledQATitle', 'getAllEnabledQATitle', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (265, '2026-03-22 11:26:29.685', '2026-03-22 11:26:29.685', NULL, '/promotion/getAllEnabledQATag', 'getAllEnabledQATag', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (266, '2026-03-22 11:26:31.063', '2026-03-22 11:26:31.063', NULL, '/promotion/getAllEnabledQAAvatarNickname', 'getAllEnabledQAAvatarNickname', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (267, '2026-03-22 11:26:32.019', '2026-03-22 11:26:32.019', NULL, '/promotion/getAllEnabledQASignature', 'getAllEnabledQASignature', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (268, '2026-03-22 11:26:32.536', '2026-03-22 11:26:32.536', NULL, '/promotion/getQAAvatarNicknameList', 'getQAAvatarNicknameList', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (269, '2026-03-22 11:26:33.053', '2026-03-22 11:26:33.053', NULL, '/promotion/getQATitleList', 'getQATitleList', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (270, '2026-03-22 13:25:00.628', '2026-03-22 13:25:00.628', NULL, '/promotion/getQAQuestionDetail/:id', 'getQAQuestionDetail', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (271, '2026-03-22 15:15:34.755', '2026-03-22 15:15:34.755', NULL, '/promotion/publishPromotionLink', 'publishPromotionLink', 'promotion', 'POST');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (272, '2026-03-22 15:15:37.595', '2026-03-22 15:15:37.595', NULL, '/promotion/updatePromotionLinkOcpc', 'updatePromotionLinkOcpc', 'promotion', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (273, '2026-03-28 23:39:08.496', '2026-03-28 23:39:08.496', NULL, '/promotion/landingPhone/list', '登录信息', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (274, '2026-03-28 23:39:09.373', '2026-03-28 23:39:09.373', NULL, '/promotion/landingMessage/list', '留言信息', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (275, '2026-04-12 11:53:44.737', '2026-04-12 11:53:44.737', NULL, '/promotion/landingVisit/list', '落地页列表', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (276, '2026-04-12 22:18:16.526', '2026-04-12 22:18:16.526', NULL, '/promotion/getLinkGroupMembers', '获取推广链接客服成员', 'promotion', 'GET');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (277, '2026-04-12 22:19:23.694', '2026-04-12 22:19:23.694', NULL, '/promotion/updateGroupMemberStatus', '更新客服成员状态', 'promotion', 'PUT');
INSERT INTO `sys_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `description`, `api_group`, `method`) VALUES (278, '2026-05-23 10:44:28.883', '2026-05-23 10:44:28.883', NULL, '/promotion/getQAAnswerDetail/:id', 'getQAAnswerDetail', 'promotion', 'GET');
COMMIT;

-- ----------------------------
-- Table structure for sys_authorities
-- ----------------------------
DROP TABLE IF EXISTS `sys_authorities`;
CREATE TABLE `sys_authorities` (
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `authority_id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `authority_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '角色名',
  `parent_id` bigint unsigned DEFAULT NULL COMMENT '父角色ID',
  `default_router` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'dashboard' COMMENT '默认菜单',
  PRIMARY KEY (`authority_id`),
  UNIQUE KEY `uni_sys_authorities_authority_id` (`authority_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9529 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of sys_authorities
-- ----------------------------
BEGIN;
INSERT INTO `sys_authorities` (`created_at`, `updated_at`, `deleted_at`, `authority_id`, `authority_name`, `parent_id`, `default_router`) VALUES ('2026-03-19 23:02:02.469', '2026-04-12 22:34:03.423', NULL, 888, '超级管理员', 0, 'dashboard');
INSERT INTO `sys_authorities` (`created_at`, `updated_at`, `deleted_at`, `authority_id`, `authority_name`, `parent_id`, `default_router`) VALUES ('2026-03-19 23:02:02.469', '2026-03-19 23:02:02.693', NULL, 8881, '普通用户子角色', 888, 'dashboard');
INSERT INTO `sys_authorities` (`created_at`, `updated_at`, `deleted_at`, `authority_id`, `authority_name`, `parent_id`, `default_router`) VALUES ('2026-03-19 23:02:02.469', '2026-05-10 19:49:46.850', NULL, 9528, 'VIP用户', 0, 'routerHolder');
COMMIT;

-- ----------------------------
-- Table structure for sys_authority_btns
-- ----------------------------
DROP TABLE IF EXISTS `sys_authority_btns`;
CREATE TABLE `sys_authority_btns` (
  `authority_id` bigint unsigned DEFAULT NULL COMMENT '角色ID',
  `sys_menu_id` bigint unsigned DEFAULT NULL COMMENT '菜单ID',
  `sys_base_menu_btn_id` bigint unsigned DEFAULT NULL COMMENT '菜单按钮ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of sys_authority_btns
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_authority_menus
-- ----------------------------
DROP TABLE IF EXISTS `sys_authority_menus`;
CREATE TABLE `sys_authority_menus` (
  `sys_base_menu_id` bigint unsigned NOT NULL,
  `sys_authority_authority_id` bigint unsigned NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`sys_base_menu_id`,`sys_authority_authority_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of sys_authority_menus
-- ----------------------------
BEGIN;
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (1, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (1, 8881);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (2, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (2, 8881);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (3, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (3, 8881);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (4, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (4, 8881);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (4, 9528);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (5, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (5, 8881);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (6, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (6, 8881);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (7, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (7, 8881);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (8, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (8, 8881);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (9, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (9, 8881);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (10, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (11, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (12, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (13, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (14, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (15, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (16, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (17, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (17, 8881);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (18, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (18, 8881);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (19, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (19, 8881);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (20, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (20, 8881);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (21, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (21, 8881);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (22, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (22, 8881);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (23, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (23, 8881);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (24, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (24, 8881);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (25, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (25, 8881);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (26, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (26, 8881);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (27, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (27, 8881);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (28, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (28, 8881);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (29, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (29, 8881);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (30, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (30, 8881);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (31, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (31, 8881);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (32, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (32, 8881);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (33, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (33, 8881);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (34, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (34, 8881);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (35, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (36, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (37, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (38, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (39, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (40, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (40, 9528);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (41, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (41, 9528);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (42, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (42, 9528);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (43, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (43, 9528);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (44, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (44, 9528);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (45, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (45, 9528);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (46, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (46, 9528);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (51, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (51, 9528);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (52, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (52, 9528);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (55, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (55, 9528);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (56, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (57, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (57, 9528);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (58, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (59, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (60, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (61, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (62, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (63, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (64, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (65, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (66, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (66, 9528);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (67, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (67, 9528);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (68, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (68, 9528);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (69, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (69, 9528);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (70, 888);
INSERT INTO `sys_authority_menus` (`sys_base_menu_id`, `sys_authority_authority_id`) VALUES (70, 9528);
COMMIT;

-- ----------------------------
-- Table structure for sys_auto_code_histories
-- ----------------------------
DROP TABLE IF EXISTS `sys_auto_code_histories`;
CREATE TABLE `sys_auto_code_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `table_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '表名',
  `package` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模块名/插件名',
  `request` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '前端传入的结构化信息',
  `struct_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '结构体名称',
  `abbreviation` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '结构体名称缩写',
  `business_db` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '业务库',
  `description` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Struct中文名称',
  `templates` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '模板信息',
  `Injections` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '注入路径',
  `flag` bigint DEFAULT NULL COMMENT '[0:创建,1:回滚]',
  `api_ids` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'api表注册内容',
  `menu_id` bigint unsigned DEFAULT NULL COMMENT '菜单ID',
  `export_template_id` bigint unsigned DEFAULT NULL COMMENT '导出模板ID',
  `package_id` bigint unsigned DEFAULT NULL COMMENT '包ID',
  PRIMARY KEY (`id`),
  KEY `idx_sys_auto_code_histories_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of sys_auto_code_histories
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_auto_code_packages
-- ----------------------------
DROP TABLE IF EXISTS `sys_auto_code_packages`;
CREATE TABLE `sys_auto_code_packages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `desc` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '描述',
  `label` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '展示名',
  `template` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模版',
  `package_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '包名',
  `module` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_sys_auto_code_packages_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of sys_auto_code_packages
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_base_menu_btns
-- ----------------------------
DROP TABLE IF EXISTS `sys_base_menu_btns`;
CREATE TABLE `sys_base_menu_btns` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '按钮关键key',
  `desc` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sys_base_menu_id` bigint unsigned DEFAULT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`),
  KEY `idx_sys_base_menu_btns_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of sys_base_menu_btns
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_base_menu_parameters
-- ----------------------------
DROP TABLE IF EXISTS `sys_base_menu_parameters`;
CREATE TABLE `sys_base_menu_parameters` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `sys_base_menu_id` bigint unsigned DEFAULT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '地址栏携带参数为params还是query',
  `key` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '地址栏携带参数的key',
  `value` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '地址栏携带参数的值',
  PRIMARY KEY (`id`),
  KEY `idx_sys_base_menu_parameters_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of sys_base_menu_parameters
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_base_menus
-- ----------------------------
DROP TABLE IF EXISTS `sys_base_menus`;
CREATE TABLE `sys_base_menus` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `menu_level` bigint unsigned DEFAULT NULL,
  `parent_id` bigint unsigned DEFAULT NULL COMMENT '父菜单ID',
  `path` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '路由path',
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '路由name',
  `hidden` tinyint(1) DEFAULT NULL COMMENT '是否在列表隐藏',
  `component` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '对应前端文件路径',
  `sort` bigint DEFAULT NULL COMMENT '排序标记',
  `active_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '高亮菜单',
  `keep_alive` tinyint(1) DEFAULT NULL COMMENT '是否缓存',
  `default_menu` tinyint(1) DEFAULT NULL COMMENT '是否是基础路由（开发中）',
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '菜单名',
  `icon` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '菜单图标',
  `close_tab` tinyint(1) DEFAULT NULL COMMENT '自动关闭tab',
  `transition_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '路由切换动画',
  PRIMARY KEY (`id`),
  KEY `idx_sys_base_menus_deleted_at` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of sys_base_menus
-- ----------------------------
BEGIN;
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (1, '2026-03-19 23:02:02.480', '2026-04-12 22:32:08.044', NULL, 0, 0, 'dashboard', 'dashboard', 1, 'view/dashboard/index.vue', 1, '', 0, 0, '仪表盘', 'odometer', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (2, '2026-03-19 23:02:02.480', '2026-04-12 22:37:29.021', NULL, 0, 0, 'about', 'about', 1, 'view/about/index.vue', 9, '', 0, 0, '关于我们', 'info-filled', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (3, '2026-03-19 23:02:02.480', '2026-03-19 23:02:02.480', NULL, 0, 0, 'admin', 'superAdmin', 0, 'view/superAdmin/index.vue', 3, '', 0, 0, '超级管理员', 'user', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (4, '2026-03-19 23:02:02.480', '2026-03-19 23:02:02.480', NULL, 0, 0, 'person', 'person', 1, 'view/person/person.vue', 4, '', 0, 0, '个人信息', 'message', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (5, '2026-03-19 23:02:02.480', '2026-04-12 22:32:51.256', NULL, 0, 0, 'example', 'example', 1, 'view/example/index.vue', 7, '', 0, 0, '示例文件', 'management', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (6, '2026-03-19 23:02:02.480', '2026-03-19 23:02:02.480', NULL, 0, 0, 'systemTools', 'systemTools', 0, 'view/systemTools/index.vue', 5, '', 0, 0, '系统工具', 'tools', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (7, '2026-03-19 23:02:02.480', '2026-03-19 23:02:02.480', NULL, 0, 0, 'https://www.gin-vue-admin.com', 'https://www.gin-vue-admin.com', 0, '/', 0, '', 0, 0, '官方网站', 'customer-gva', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (8, '2026-03-19 23:02:02.480', '2026-05-10 19:53:24.634', NULL, 0, 0, 'state', 'state', 0, 'view/system/state.vue', 8, '', 0, 0, '服务器状态', 'cloudy', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (9, '2026-03-19 23:02:02.480', '2026-04-12 22:33:04.257', NULL, 0, 0, 'plugin', 'plugin', 1, 'view/routerHolder.vue', 6, '', 0, 0, '插件系统', 'cherry', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (10, '2026-03-19 23:02:02.481', '2026-03-19 23:02:02.481', NULL, 1, 3, 'authority', 'authority', 0, 'view/superAdmin/authority/authority.vue', 1, '', 0, 0, '角色管理', 'avatar', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (11, '2026-03-19 23:02:02.481', '2026-03-19 23:02:02.481', NULL, 1, 3, 'menu', 'menu', 0, 'view/superAdmin/menu/menu.vue', 2, '', 1, 0, '菜单管理', 'tickets', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (12, '2026-03-19 23:02:02.481', '2026-03-19 23:02:02.481', NULL, 1, 3, 'api', 'api', 0, 'view/superAdmin/api/api.vue', 3, '', 1, 0, 'api管理', 'platform', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (13, '2026-03-19 23:02:02.481', '2026-03-19 23:02:02.481', NULL, 1, 3, 'user', 'user', 0, 'view/superAdmin/user/user.vue', 4, '', 0, 0, '用户管理', 'coordinate', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (14, '2026-03-19 23:02:02.481', '2026-03-19 23:02:02.481', NULL, 1, 3, 'dictionary', 'dictionary', 0, 'view/superAdmin/dictionary/sysDictionary.vue', 5, '', 0, 0, '字典管理', 'notebook', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (15, '2026-03-19 23:02:02.481', '2026-03-19 23:02:02.481', NULL, 1, 3, 'operation', 'operation', 0, 'view/superAdmin/operation/sysOperationRecord.vue', 6, '', 0, 0, '操作历史', 'pie-chart', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (16, '2026-03-19 23:02:02.481', '2026-03-19 23:02:02.481', NULL, 1, 3, 'sysParams', 'sysParams', 0, 'view/superAdmin/params/sysParams.vue', 7, '', 0, 0, '参数管理', 'compass', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (17, '2026-03-19 23:02:02.481', '2026-03-19 23:02:02.481', NULL, 1, 5, 'upload', 'upload', 0, 'view/example/upload/upload.vue', 5, '', 0, 0, '媒体库（上传下载）', 'upload', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (18, '2026-03-19 23:02:02.481', '2026-03-19 23:02:02.481', NULL, 1, 5, 'breakpoint', 'breakpoint', 0, 'view/example/breakpoint/breakpoint.vue', 6, '', 0, 0, '断点续传', 'upload-filled', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (19, '2026-03-19 23:02:02.481', '2026-03-19 23:02:02.481', NULL, 1, 5, 'customer', 'customer', 0, 'view/example/customer/customer.vue', 7, '', 0, 0, '客户列表（资源示例）', 'avatar', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (20, '2026-03-19 23:02:02.481', '2026-03-19 23:02:02.481', NULL, 1, 6, 'autoCode', 'autoCode', 0, 'view/systemTools/autoCode/index.vue', 1, '', 1, 0, '代码生成器', 'cpu', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (21, '2026-03-19 23:02:02.481', '2026-03-19 23:02:02.481', NULL, 1, 6, 'formCreate', 'formCreate', 0, 'view/systemTools/formCreate/index.vue', 3, '', 1, 0, '表单生成器', 'magic-stick', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (22, '2026-03-19 23:02:02.481', '2026-03-19 23:02:02.481', NULL, 1, 6, 'system', 'system', 0, 'view/systemTools/system/system.vue', 4, '', 0, 0, '系统配置', 'operation', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (23, '2026-03-19 23:02:02.481', '2026-03-19 23:02:02.481', NULL, 1, 6, 'autoCodeAdmin', 'autoCodeAdmin', 0, 'view/systemTools/autoCodeAdmin/index.vue', 2, '', 0, 0, '自动化代码管理', 'magic-stick', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (24, '2026-03-19 23:02:02.481', '2026-03-19 23:02:02.481', NULL, 1, 6, 'loginLog', 'loginLog', 0, 'view/systemTools/loginLog/index.vue', 5, '', 0, 0, '登录日志', 'monitor', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (25, '2026-03-19 23:02:02.481', '2026-03-19 23:02:02.481', NULL, 1, 6, 'apiToken', 'apiToken', 0, 'view/systemTools/apiToken/index.vue', 6, '', 0, 0, 'API Token', 'key', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (26, '2026-03-19 23:02:02.481', '2026-03-19 23:02:02.481', NULL, 1, 6, 'autoCodeEdit/:id', 'autoCodeEdit', 1, 'view/systemTools/autoCode/index.vue', 0, '', 0, 0, '自动化代码-${id}', 'magic-stick', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (27, '2026-03-19 23:02:02.481', '2026-03-19 23:02:02.481', NULL, 1, 6, 'autoPkg', 'autoPkg', 0, 'view/systemTools/autoPkg/autoPkg.vue', 0, '', 0, 0, '模板配置', 'folder', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (28, '2026-03-19 23:02:02.481', '2026-03-19 23:02:02.481', NULL, 1, 6, 'exportTemplate', 'exportTemplate', 0, 'view/systemTools/exportTemplate/exportTemplate.vue', 5, '', 0, 0, '导出模板', 'reading', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (29, '2026-03-19 23:02:02.481', '2026-03-19 23:02:02.481', NULL, 1, 6, 'skills', 'skills', 0, 'view/systemTools/skills/index.vue', 6, '', 0, 0, 'Skills管理', 'document', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (30, '2026-03-19 23:02:02.481', '2026-03-19 23:02:02.481', NULL, 1, 6, 'picture', 'picture', 0, 'view/systemTools/autoCode/picture.vue', 6, '', 0, 0, 'AI页面绘制', 'picture-filled', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (31, '2026-03-19 23:02:02.481', '2026-03-19 23:02:02.481', NULL, 1, 6, 'mcpTool', 'mcpTool', 0, 'view/systemTools/autoCode/mcp.vue', 7, '', 0, 0, 'Mcp Tools模板', 'magnet', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (32, '2026-03-19 23:02:02.481', '2026-03-19 23:02:02.481', NULL, 1, 6, 'mcpTest', 'mcpTest', 0, 'view/systemTools/autoCode/mcpTest.vue', 7, '', 0, 0, 'Mcp Tools测试', 'partly-cloudy', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (33, '2026-03-19 23:02:02.481', '2026-03-19 23:02:02.481', NULL, 1, 6, 'sysVersion', 'sysVersion', 0, 'view/systemTools/version/version.vue', 8, '', 0, 0, '版本管理', 'server', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (34, '2026-03-19 23:02:02.481', '2026-03-19 23:02:02.481', NULL, 1, 6, 'sysError', 'sysError', 0, 'view/systemTools/sysError/sysError.vue', 9, '', 0, 0, '错误日志', 'warn', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (35, '2026-03-19 23:02:02.481', '2026-03-19 23:02:02.481', NULL, 1, 9, 'https://plugin.gin-vue-admin.com/', 'https://plugin.gin-vue-admin.com/', 0, 'https://plugin.gin-vue-admin.com/', 0, '', 0, 0, '插件市场', 'shop', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (36, '2026-03-19 23:02:02.481', '2026-03-19 23:02:02.481', NULL, 1, 9, 'installPlugin', 'installPlugin', 0, 'view/systemTools/installPlugin/index.vue', 1, '', 0, 0, '插件安装', 'box', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (37, '2026-03-19 23:02:02.481', '2026-03-19 23:02:02.481', NULL, 1, 9, 'pubPlug', 'pubPlug', 0, 'view/systemTools/pubPlug/pubPlug.vue', 3, '', 0, 0, '打包插件', 'files', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (38, '2026-03-19 23:02:02.481', '2026-03-19 23:02:02.481', NULL, 1, 9, 'plugin-email', 'plugin-email', 0, 'plugin/email/view/index.vue', 4, '', 0, 0, '邮件插件', 'message', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (39, '2026-03-19 23:02:02.481', '2026-03-19 23:02:02.481', NULL, 1, 9, 'anInfo', 'anInfo', 0, 'plugin/announcement/view/info.vue', 5, '', 0, 0, '公告管理[示例]', 'scaleToOriginal', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (40, '2026-03-20 09:57:27.105', '2026-03-20 09:57:27.105', NULL, 0, 0, 'routerHolder', 'routerHolder', 0, 'view/routerHolder.vue', 1, '', 1, 0, '推广运营', 'management', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (41, '2026-03-20 09:58:53.140', '2026-03-22 15:33:52.149', NULL, 0, 55, 'promotionRegion', 'promotionRegion', 0, 'view/promotion/region/index.vue', 1, '', 1, 0, '所属分类', 'location', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (42, '2026-03-20 10:00:15.019', '2026-03-20 12:36:42.374', NULL, 0, 55, 'promotionMember', 'promotionMember', 0, 'view/promotion/member/index.vue', 3, '', 1, 0, '成员管理', 'user-filled', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (43, '2026-03-20 10:01:28.403', '2026-03-20 12:36:33.970', NULL, 0, 55, 'promotionGroup', 'promotionGroup', 0, 'view/promotion/group/index.vue', 2, '', 1, 0, '分组管理', 'user', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (44, '2026-03-20 10:02:02.861', '2026-04-12 22:29:00.437', NULL, 0, 45, 'promotionDomain', 'promotionDomain', 0, 'view/promotion/domain/index.vue', 0, '', 1, 0, '推广域名', 'link', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (45, '2026-03-20 10:03:19.724', '2026-04-12 22:26:57.031', NULL, 0, 40, 'promotionLinkBase', 'promotionLinkBase', 0, 'view/routerHolder2', 4, '', 1, 0, '推广链接配置', 'link', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (46, '2026-03-20 10:10:23.445', '2026-03-21 00:06:31.806', NULL, 0, 45, 'promotionLink', 'promotionLink', 0, 'view/promotion/link/index.vue', 1, '', 1, 0, '推广链接', 'link', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (47, '2026-03-20 10:11:05.837', '2026-03-20 10:11:05.837', '2026-03-21 22:52:47.627', 0, 45, 'promotionLinkCompany', 'promotionLinkCompany', 0, 'view/promotion/link-company/index.vue', 2, '', 1, 0, '资质公司', 'office-building', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (48, '2026-03-20 10:11:50.522', '2026-03-20 10:11:50.522', '2026-03-21 22:52:50.062', 0, 45, 'promotionLinkCode', 'promotionLinkCode', 0, 'view/promotion/link-code/index.vue', 3, '', 1, 0, '代码设置', 'coffee-cup', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (49, '2026-03-20 10:12:15.280', '2026-03-20 23:50:33.180', '2026-03-21 22:52:51.815', 0, 45, 'promotionLinkTheme', 'promotionLinkTheme', 0, 'view/promotion/link-theme/index.vue', 4, '', 1, 0, '颜色调整', 'brush', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (50, '2026-03-20 10:12:49.432', '2026-03-20 10:12:49.432', '2026-03-21 22:52:54.726', 0, 45, 'promotionLinkComment', 'promotionLinkComment', 0, 'view/promotion/link-comment/index.vue', 5, '', 1, 0, '评论设置', 'chat-dot-square', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (51, '2026-03-20 12:33:26.462', '2026-05-10 22:23:18.148', NULL, 0, 40, 'qa', 'qa', 0, 'view/routerHolder.vue', 3, '', 1, 0, '页面管理', 'chat-round', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (52, '2026-03-20 12:34:13.482', '2026-05-10 22:23:48.092', NULL, 0, 51, 'qaQuestion', 'qaQuestion', 0, 'view/qa/question/index.vue', 0, '', 1, 0, '页面管理', 'chat-line-square', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (53, '2026-03-20 12:34:42.016', '2026-03-20 12:34:42.016', '2026-03-22 09:49:17.346', 0, 51, 'qaAnswer', 'qaAnswer', 0, 'view/qa/answer/index.vue', 0, '', 1, 0, '回答管理', 'chat-square', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (54, '2026-03-20 12:35:10.948', '2026-03-20 12:35:10.948', '2026-03-22 09:49:08.839', 0, 51, 'qaReply', 'qaReply', 0, 'view/qa/reply/index.vue', 0, '', 1, 0, '回复管理', 'chat-line-round', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (55, '2026-03-20 12:36:12.949', '2026-03-20 12:42:50.571', NULL, 0, 40, 'promotionBase', 'promotionBase', 0, 'view/routerHolder.vue', 0, '', 1, 0, '基础管理', 'location', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (56, '2026-03-20 12:37:59.239', '2026-04-12 22:26:32.439', NULL, 0, 40, 'ad', 'ad', 1, 'view/routerHolder.vue', 5, '', 1, 0, '广告统计', 'histogram', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (57, '2026-03-20 12:38:40.455', '2026-04-12 22:26:19.332', NULL, 0, 55, 'adPlatform', 'adPlatform', 0, 'view/ad/platform/index.vue', 1, '', 1, 0, '推广平台', 'monitor', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (58, '2026-03-20 12:39:07.614', '2026-04-12 14:33:10.333', NULL, 0, 56, 'adCampaign', 'adCampaign', 1, 'view/ad/campaign/index.vue', 2, '', 1, 0, '活动计划', 'tickets', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (59, '2026-03-20 12:39:41.063', '2026-03-20 12:39:41.063', NULL, 0, 56, 'adKeyword', 'adKeyword', 0, 'view/ad/keyword/index.vue', 2, '', 1, 0, '关键词', 'aim', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (60, '2026-03-20 12:40:06.476', '2026-04-12 14:33:14.527', NULL, 0, 56, 'adSummary', 'adSummary', 1, 'view/ad/summary/index.vue', 3, '', 1, 0, '日汇总', 'calendar', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (61, '2026-03-20 12:40:47.287', '2026-04-12 14:32:58.268', NULL, 0, 40, 'activity', 'activity', 1, 'view/routerHolder.vue', 6, '', 1, 0, '活动数据', 'collection', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (62, '2026-03-20 12:41:10.232', '2026-03-20 12:41:10.232', NULL, 0, 61, 'activityMarket', 'activityMarket', 0, 'view/activity/market/index.vue', 1, '', 1, 0, '市场', 'location-information', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (63, '2026-03-20 12:41:34.938', '2026-03-20 12:41:34.938', NULL, 0, 61, 'activityPackage', 'activityPackage', 0, 'view/activity/package/index.vue', 2, '', 1, 0, '套餐', 'box', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (64, '2026-03-20 12:41:59.657', '2026-03-20 12:41:59.657', NULL, 0, 61, 'activityData', 'activityData', 0, 'view/activity/data/index.vue', 3, '', 1, 0, '活动', 'help', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (65, '2026-03-21 20:57:48.369', '2026-03-21 20:57:48.369', NULL, 0, 55, 'templateWidget', 'templateWidget', 0, 'view/promotion/template-widget/index.vue', 5, '', 1, 0, '模板插件管理', 'menu', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (66, '2026-03-22 11:12:36.068', '2026-03-22 11:12:36.068', NULL, 0, 51, 'index', 'index', 0, 'view/qa/avatar-nickname/index.vue', 2, '', 1, 0, '头像昵称管理', 'avatar', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (67, '2026-03-22 11:23:41.249', '2026-03-22 11:23:41.249', NULL, 0, 51, 'qaTtitle', 'qaTtitle', 0, 'view/qa/title/index.vue', 3, '', 1, 0, '称号管理', 'grid', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (68, '2026-03-22 11:24:36.590', '2026-03-22 11:24:36.590', NULL, 0, 51, 'qaSignature', 'qaSignature', 0, 'view/qa/signature/index.vue', 4, '', 1, 0, '个性签名管理', 'list', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (69, '2026-03-22 11:25:16.804', '2026-03-22 11:25:16.804', NULL, 0, 51, 'qaTag', 'qaTag', 0, 'view/qa/tag/index.vue', 6, '', 1, 0, '标签管理', 'collection-tag', 0, '');
INSERT INTO `sys_base_menus` (`id`, `created_at`, `updated_at`, `deleted_at`, `menu_level`, `parent_id`, `path`, `name`, `hidden`, `component`, `sort`, `active_name`, `keep_alive`, `default_menu`, `title`, `icon`, `close_tab`, `transition_type`) VALUES (70, '2026-04-12 11:50:42.838', '2026-04-12 11:50:42.838', NULL, 0, 45, 'landingVisit', 'landingVisit', 0, 'view/promotion/landingVisit/index.vue', 2, '', 1, 0, '落地页访问记录', 'data-analysis', 0, '');
COMMIT;

-- ----------------------------
-- Table structure for sys_data_authority_id
-- ----------------------------
DROP TABLE IF EXISTS `sys_data_authority_id`;
CREATE TABLE `sys_data_authority_id` (
  `sys_authority_authority_id` bigint unsigned NOT NULL COMMENT '角色ID',
  `data_authority_id_authority_id` bigint unsigned NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`sys_authority_authority_id`,`data_authority_id_authority_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of sys_data_authority_id
-- ----------------------------
BEGIN;
INSERT INTO `sys_data_authority_id` (`sys_authority_authority_id`, `data_authority_id_authority_id`) VALUES (888, 888);
INSERT INTO `sys_data_authority_id` (`sys_authority_authority_id`, `data_authority_id_authority_id`) VALUES (888, 8881);
INSERT INTO `sys_data_authority_id` (`sys_authority_authority_id`, `data_authority_id_authority_id`) VALUES (888, 9528);
INSERT INTO `sys_data_authority_id` (`sys_authority_authority_id`, `data_authority_id_authority_id`) VALUES (9528, 8881);
INSERT INTO `sys_data_authority_id` (`sys_authority_authority_id`, `data_authority_id_authority_id`) VALUES (9528, 9528);
COMMIT;

-- ----------------------------
-- Table structure for sys_dictionaries
-- ----------------------------
DROP TABLE IF EXISTS `sys_dictionaries`;
CREATE TABLE `sys_dictionaries` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '字典名（中）',
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '字典名（英）',
  `status` tinyint(1) DEFAULT NULL COMMENT '状态',
  `desc` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '描述',
  `parent_id` bigint unsigned DEFAULT NULL COMMENT '父级字典ID',
  PRIMARY KEY (`id`),
  KEY `idx_sys_dictionaries_deleted_at` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of sys_dictionaries
-- ----------------------------
BEGIN;
INSERT INTO `sys_dictionaries` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `status`, `desc`, `parent_id`) VALUES (1, '2026-03-19 23:02:02.473', '2026-03-19 23:02:02.474', NULL, '性别', 'gender', 1, '性别字典', NULL);
INSERT INTO `sys_dictionaries` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `status`, `desc`, `parent_id`) VALUES (2, '2026-03-19 23:02:02.473', '2026-03-19 23:02:02.475', NULL, '数据库int类型', 'int', 1, 'int类型对应的数据库类型', NULL);
INSERT INTO `sys_dictionaries` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `status`, `desc`, `parent_id`) VALUES (3, '2026-03-19 23:02:02.473', '2026-03-19 23:02:02.476', NULL, '数据库时间日期类型', 'time.Time', 1, '数据库时间日期类型', NULL);
INSERT INTO `sys_dictionaries` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `status`, `desc`, `parent_id`) VALUES (4, '2026-03-19 23:02:02.473', '2026-03-19 23:02:02.477', NULL, '数据库浮点型', 'float64', 1, '数据库浮点型', NULL);
INSERT INTO `sys_dictionaries` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `status`, `desc`, `parent_id`) VALUES (5, '2026-03-19 23:02:02.473', '2026-03-19 23:02:02.478', NULL, '数据库字符串', 'string', 1, '数据库字符串', NULL);
INSERT INTO `sys_dictionaries` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `type`, `status`, `desc`, `parent_id`) VALUES (6, '2026-03-19 23:02:02.473', '2026-03-19 23:02:02.479', NULL, '数据库bool类型', 'bool', 1, '数据库bool类型', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_dictionary_details
-- ----------------------------
DROP TABLE IF EXISTS `sys_dictionary_details`;
CREATE TABLE `sys_dictionary_details` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `label` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '展示值',
  `value` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '字典值',
  `extend` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '扩展值',
  `status` tinyint(1) DEFAULT NULL COMMENT '启用状态',
  `sort` bigint DEFAULT NULL COMMENT '排序标记',
  `sys_dictionary_id` bigint unsigned DEFAULT NULL COMMENT '关联标记',
  `parent_id` bigint unsigned DEFAULT NULL COMMENT '父级字典详情ID',
  `level` bigint DEFAULT NULL COMMENT '层级深度',
  `path` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '层级路径',
  PRIMARY KEY (`id`),
  KEY `idx_sys_dictionary_details_deleted_at` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of sys_dictionary_details
-- ----------------------------
BEGIN;
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (1, '2026-03-19 23:02:02.474', '2026-03-19 23:02:02.474', NULL, '男', '1', '', 1, 1, 1, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (2, '2026-03-19 23:02:02.474', '2026-03-19 23:02:02.474', NULL, '女', '2', '', 1, 2, 1, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (3, '2026-03-19 23:02:02.475', '2026-03-19 23:02:02.475', NULL, 'smallint', '1', 'mysql', 1, 1, 2, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (4, '2026-03-19 23:02:02.475', '2026-03-19 23:02:02.475', NULL, 'mediumint', '2', 'mysql', 1, 2, 2, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (5, '2026-03-19 23:02:02.475', '2026-03-19 23:02:02.475', NULL, 'int', '3', 'mysql', 1, 3, 2, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (6, '2026-03-19 23:02:02.475', '2026-03-19 23:02:02.475', NULL, 'bigint', '4', 'mysql', 1, 4, 2, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (7, '2026-03-19 23:02:02.475', '2026-03-19 23:02:02.475', NULL, 'int2', '5', 'pgsql', 1, 5, 2, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (8, '2026-03-19 23:02:02.475', '2026-03-19 23:02:02.475', NULL, 'int4', '6', 'pgsql', 1, 6, 2, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (9, '2026-03-19 23:02:02.475', '2026-03-19 23:02:02.475', NULL, 'int6', '7', 'pgsql', 1, 7, 2, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (10, '2026-03-19 23:02:02.475', '2026-03-19 23:02:02.475', NULL, 'int8', '8', 'pgsql', 1, 8, 2, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (11, '2026-03-19 23:02:02.476', '2026-03-19 23:02:02.476', NULL, 'date', '0', 'mysql', 1, 0, 3, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (12, '2026-03-19 23:02:02.476', '2026-03-19 23:02:02.476', NULL, 'time', '1', 'mysql', 1, 1, 3, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (13, '2026-03-19 23:02:02.476', '2026-03-19 23:02:02.476', NULL, 'year', '2', 'mysql', 1, 2, 3, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (14, '2026-03-19 23:02:02.476', '2026-03-19 23:02:02.476', NULL, 'datetime', '3', 'mysql', 1, 3, 3, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (15, '2026-03-19 23:02:02.476', '2026-03-19 23:02:02.476', NULL, 'timestamp', '5', 'mysql', 1, 5, 3, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (16, '2026-03-19 23:02:02.476', '2026-03-19 23:02:02.476', NULL, 'timestamptz', '6', 'pgsql', 1, 5, 3, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (17, '2026-03-19 23:02:02.477', '2026-03-19 23:02:02.477', NULL, 'float', '0', 'mysql', 1, 0, 4, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (18, '2026-03-19 23:02:02.477', '2026-03-19 23:02:02.477', NULL, 'double', '1', 'mysql', 1, 1, 4, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (19, '2026-03-19 23:02:02.477', '2026-03-19 23:02:02.477', NULL, 'decimal', '2', 'mysql', 1, 2, 4, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (20, '2026-03-19 23:02:02.477', '2026-03-19 23:02:02.477', NULL, 'numeric', '3', 'pgsql', 1, 3, 4, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (21, '2026-03-19 23:02:02.477', '2026-03-19 23:02:02.477', NULL, 'smallserial', '4', 'pgsql', 1, 4, 4, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (22, '2026-03-19 23:02:02.478', '2026-03-19 23:02:02.478', NULL, 'char', '0', 'mysql', 1, 0, 5, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (23, '2026-03-19 23:02:02.478', '2026-03-19 23:02:02.478', NULL, 'varchar', '1', 'mysql', 1, 1, 5, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (24, '2026-03-19 23:02:02.478', '2026-03-19 23:02:02.478', NULL, 'tinyblob', '2', 'mysql', 1, 2, 5, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (25, '2026-03-19 23:02:02.478', '2026-03-19 23:02:02.478', NULL, 'tinytext', '3', 'mysql', 1, 3, 5, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (26, '2026-03-19 23:02:02.478', '2026-03-19 23:02:02.478', NULL, 'text', '4', 'mysql', 1, 4, 5, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (27, '2026-03-19 23:02:02.478', '2026-03-19 23:02:02.478', NULL, 'blob', '5', 'mysql', 1, 5, 5, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (28, '2026-03-19 23:02:02.478', '2026-03-19 23:02:02.478', NULL, 'mediumblob', '6', 'mysql', 1, 6, 5, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (29, '2026-03-19 23:02:02.478', '2026-03-19 23:02:02.478', NULL, 'mediumtext', '7', 'mysql', 1, 7, 5, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (30, '2026-03-19 23:02:02.478', '2026-03-19 23:02:02.478', NULL, 'longblob', '8', 'mysql', 1, 8, 5, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (31, '2026-03-19 23:02:02.478', '2026-03-19 23:02:02.478', NULL, 'longtext', '9', 'mysql', 1, 9, 5, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (32, '2026-03-19 23:02:02.479', '2026-03-19 23:02:02.479', NULL, 'tinyint', '1', 'mysql', 1, 0, 6, NULL, 0, '');
INSERT INTO `sys_dictionary_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `label`, `value`, `extend`, `status`, `sort`, `sys_dictionary_id`, `parent_id`, `level`, `path`) VALUES (33, '2026-03-19 23:02:02.479', '2026-03-19 23:02:02.479', NULL, 'bool', '2', 'pgsql', 1, 0, 6, NULL, 0, '');
COMMIT;

-- ----------------------------
-- Table structure for sys_error
-- ----------------------------
DROP TABLE IF EXISTS `sys_error`;
CREATE TABLE `sys_error` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `form` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '错误来源',
  `info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '错误内容',
  `level` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '日志等级',
  `solution` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '解决方案',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '未处理' COMMENT '处理状态',
  PRIMARY KEY (`id`),
  KEY `idx_sys_error_deleted_at` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=11304 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of sys_error
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_export_template_condition
-- ----------------------------
DROP TABLE IF EXISTS `sys_export_template_condition`;
CREATE TABLE `sys_export_template_condition` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `template_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模板标识',
  `from` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '条件取的key',
  `column` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '作为查询条件的字段',
  `operator` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作符',
  PRIMARY KEY (`id`),
  KEY `idx_sys_export_template_condition_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of sys_export_template_condition
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_export_template_join
-- ----------------------------
DROP TABLE IF EXISTS `sys_export_template_join`;
CREATE TABLE `sys_export_template_join` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `template_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模板标识',
  `joins` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '关联',
  `table` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '关联表',
  `on` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '关联条件',
  PRIMARY KEY (`id`),
  KEY `idx_sys_export_template_join_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of sys_export_template_join
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_export_templates
-- ----------------------------
DROP TABLE IF EXISTS `sys_export_templates`;
CREATE TABLE `sys_export_templates` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `db_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '数据库名称',
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模板名称',
  `table_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '表名称',
  `template_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模板标识',
  `template_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `sql` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '自定义导出SQL',
  `import_sql` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '自定义导入SQL',
  `limit` bigint DEFAULT NULL COMMENT '导出限制',
  `order` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`),
  KEY `idx_sys_export_templates_deleted_at` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of sys_export_templates
-- ----------------------------
BEGIN;
INSERT INTO `sys_export_templates` (`id`, `created_at`, `updated_at`, `deleted_at`, `db_name`, `name`, `table_name`, `template_id`, `template_info`, `sql`, `import_sql`, `limit`, `order`) VALUES (1, '2026-03-19 23:02:02.689', '2026-03-19 23:02:02.689', NULL, '', 'api', 'sys_apis', 'api', '{\n\"path\":\"路径\",\n\"method\":\"方法（大写）\",\n\"description\":\"方法介绍\",\n\"api_group\":\"方法分组\"\n}', '', '', NULL, '');
COMMIT;

-- ----------------------------
-- Table structure for sys_ignore_apis
-- ----------------------------
DROP TABLE IF EXISTS `sys_ignore_apis`;
CREATE TABLE `sys_ignore_apis` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `path` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'api路径',
  `method` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'POST' COMMENT '方法',
  PRIMARY KEY (`id`),
  KEY `idx_sys_ignore_apis_deleted_at` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of sys_ignore_apis
-- ----------------------------
BEGIN;
INSERT INTO `sys_ignore_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `method`) VALUES (1, '2026-03-19 23:02:02.462', '2026-03-19 23:02:02.462', NULL, '/swagger/*any', 'GET');
INSERT INTO `sys_ignore_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `method`) VALUES (2, '2026-03-19 23:02:02.462', '2026-03-19 23:02:02.462', NULL, '/api/freshCasbin', 'GET');
INSERT INTO `sys_ignore_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `method`) VALUES (3, '2026-03-19 23:02:02.462', '2026-03-19 23:02:02.462', NULL, '/uploads/file/*filepath', 'GET');
INSERT INTO `sys_ignore_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `method`) VALUES (4, '2026-03-19 23:02:02.462', '2026-03-19 23:02:02.462', NULL, '/health', 'GET');
INSERT INTO `sys_ignore_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `method`) VALUES (5, '2026-03-19 23:02:02.462', '2026-03-19 23:02:02.462', NULL, '/uploads/file/*filepath', 'HEAD');
INSERT INTO `sys_ignore_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `method`) VALUES (6, '2026-03-19 23:02:02.462', '2026-03-19 23:02:02.462', NULL, '/autoCode/llmAuto', 'POST');
INSERT INTO `sys_ignore_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `method`) VALUES (7, '2026-03-19 23:02:02.462', '2026-03-19 23:02:02.462', NULL, '/system/reloadSystem', 'POST');
INSERT INTO `sys_ignore_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `method`) VALUES (8, '2026-03-19 23:02:02.462', '2026-03-19 23:02:02.462', NULL, '/base/login', 'POST');
INSERT INTO `sys_ignore_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `method`) VALUES (9, '2026-03-19 23:02:02.462', '2026-03-19 23:02:02.462', NULL, '/base/captcha', 'POST');
INSERT INTO `sys_ignore_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `method`) VALUES (10, '2026-03-19 23:02:02.462', '2026-03-19 23:02:02.462', NULL, '/init/initdb', 'POST');
INSERT INTO `sys_ignore_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `method`) VALUES (11, '2026-03-19 23:02:02.462', '2026-03-19 23:02:02.462', NULL, '/init/checkdb', 'POST');
INSERT INTO `sys_ignore_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `method`) VALUES (12, '2026-03-19 23:02:02.462', '2026-03-19 23:02:02.462', NULL, '/info/getInfoDataSource', 'GET');
INSERT INTO `sys_ignore_apis` (`id`, `created_at`, `updated_at`, `deleted_at`, `path`, `method`) VALUES (13, '2026-03-19 23:02:02.462', '2026-03-19 23:02:02.462', NULL, '/info/getInfoPublic', 'GET');
COMMIT;

-- ----------------------------
-- Table structure for sys_login_logs
-- ----------------------------
DROP TABLE IF EXISTS `sys_login_logs`;
CREATE TABLE `sys_login_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户名',
  `ip` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '请求ip',
  `status` tinyint(1) DEFAULT NULL COMMENT '登录状态',
  `error_message` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '错误信息',
  `agent` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '代理',
  `user_id` bigint unsigned DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`),
  KEY `idx_sys_login_logs_deleted_at` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of sys_login_logs
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_operation_records
-- ----------------------------
DROP TABLE IF EXISTS `sys_operation_records`;
CREATE TABLE `sys_operation_records` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `ip` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '请求ip',
  `method` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '请求方法',
  `path` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '请求路径',
  `status` bigint DEFAULT NULL COMMENT '请求状态',
  `latency` bigint DEFAULT NULL COMMENT '延迟',
  `agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '代理',
  `error_message` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '错误信息',
  `body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '请求Body',
  `resp` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '响应Body',
  `user_id` bigint unsigned DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`),
  KEY `idx_sys_operation_records_deleted_at` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=5080 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of sys_operation_records
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_params
-- ----------------------------
DROP TABLE IF EXISTS `sys_params`;
CREATE TABLE `sys_params` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '参数名称',
  `key` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '参数键',
  `value` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '参数值',
  `desc` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '参数说明',
  PRIMARY KEY (`id`),
  KEY `idx_sys_params_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of sys_params
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_user_authority
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_authority`;
CREATE TABLE `sys_user_authority` (
  `sys_user_id` bigint unsigned NOT NULL,
  `sys_authority_authority_id` bigint unsigned NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`sys_user_id`,`sys_authority_authority_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of sys_user_authority
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_authority` (`sys_user_id`, `sys_authority_authority_id`) VALUES (1, 888);
INSERT INTO `sys_user_authority` (`sys_user_id`, `sys_authority_authority_id`) VALUES (2, 9528);
COMMIT;

-- ----------------------------
-- Table structure for sys_users
-- ----------------------------
DROP TABLE IF EXISTS `sys_users`;
CREATE TABLE `sys_users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `uuid` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户UUID',
  `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户登录名',
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户登录密码',
  `nick_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '系统用户' COMMENT '用户昵称',
  `header_img` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'https://qmplusimg.henrongyi.top/gva_header.jpg' COMMENT '用户头像',
  `authority_id` bigint unsigned DEFAULT '888' COMMENT '用户角色ID',
  `phone` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户手机号',
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户邮箱',
  `enable` bigint DEFAULT '1' COMMENT '用户是否被冻结 1正常 2冻结',
  `origin_setting` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '配置',
  PRIMARY KEY (`id`),
  KEY `idx_sys_users_deleted_at` (`deleted_at`),
  KEY `idx_sys_users_uuid` (`uuid`),
  KEY `idx_sys_users_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of sys_users
-- ----------------------------
BEGIN;
INSERT INTO `sys_users` (`id`, `created_at`, `updated_at`, `deleted_at`, `uuid`, `username`, `password`, `nick_name`, `header_img`, `authority_id`, `phone`, `email`, `enable`, `origin_setting`) VALUES (1, '2026-03-19 23:02:02.684', '2026-05-10 21:10:54.745', NULL, '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b', 'Super#Admin#?', '$2a$10$9Rw6tHLtpihn/3lKTd0eLuD7.gucVA89J5dNSWCTLrDx.J6HSgbKq', 'Mr.🐈', 'https://qmplusimg.henrongyi.top/gva_header.jpg', 888, '17611111111', '333333333@qq.com', 1, NULL);
INSERT INTO `sys_users` (`id`, `created_at`, `updated_at`, `deleted_at`, `uuid`, `username`, `password`, `nick_name`, `header_img`, `authority_id`, `phone`, `email`, `enable`, `origin_setting`) VALUES (2, '2026-03-19 23:02:02.684', '2026-05-10 19:42:47.115', NULL, '4de2ec0f-5bf1-463e-b746-1044c9728e2e', 'a303176530', '$2a$10$LEjsQVhG4O0dAUpqVOUdoOSxyOOmGh5oXMmShWnx/adkzLwCv6Bky', '测试客户', 'https://qmplusimg.henrongyi.top/1572075907logo.png', 9528, '17611111111', '333333333@qq.com', 1, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_versions
-- ----------------------------
DROP TABLE IF EXISTS `sys_versions`;
CREATE TABLE `sys_versions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `version_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '版本名称',
  `version_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '版本号',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '版本描述',
  `version_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '版本数据JSON',
  PRIMARY KEY (`id`),
  KEY `idx_sys_versions_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of sys_versions
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
