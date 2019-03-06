/*
Navicat MySQL Data Transfer

Source Server         : 192.9.210.89
Source Server Version : 50718
Source Host           : 192.9.210.89:3306
Source Database       : rap2_delos_app

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2019-03-06 09:55:15
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for foreign_room
-- ----------------------------
DROP TABLE IF EXISTS `foreign_room`;
CREATE TABLE `foreign_room` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `repositoryId` bigint(20) DEFAULT NULL,
  `roomProjectId` bigint(20) DEFAULT NULL,
  `hostname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of foreign_room
-- ----------------------------

-- ----------------------------
-- Table structure for interfaces
-- ----------------------------
DROP TABLE IF EXISTS `interfaces`;
CREATE TABLE `interfaces` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `url` varchar(256) NOT NULL,
  `method` varchar(255) NOT NULL,
  `description` text,
  `priority` bigint(11) NOT NULL DEFAULT '1',
  `status` int(11) DEFAULT '200',
  `creatorId` int(11) DEFAULT NULL,
  `lockerId` int(11) DEFAULT NULL,
  `moduleId` int(11) DEFAULT NULL,
  `repositoryId` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creatorId` (`creatorId`),
  KEY `lockerId` (`lockerId`),
  KEY `moduleId` (`moduleId`),
  KEY `repositoryId` (`repositoryId`),
  CONSTRAINT `interfaces_ibfk_1` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `interfaces_ibfk_2` FOREIGN KEY (`lockerId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `interfaces_ibfk_3` FOREIGN KEY (`moduleId`) REFERENCES `modules` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `interfaces_ibfk_4` FOREIGN KEY (`repositoryId`) REFERENCES `repositories` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of interfaces
-- ----------------------------
INSERT INTO `interfaces` VALUES ('136', '示例接口', '/example/1551835588784', 'GET', '示例接口描述', '1', '200', '100000012', null, '46', '16', '2019-03-06 01:26:28', '2019-03-06 01:26:28', null);

-- ----------------------------
-- Table structure for loggers
-- ----------------------------
DROP TABLE IF EXISTS `loggers`;
CREATE TABLE `loggers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` enum('create','update','delete','lock','unlock','join','exit') NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `userId` int(11) NOT NULL,
  `organizationId` int(11) DEFAULT NULL,
  `repositoryId` int(11) DEFAULT NULL,
  `moduleId` int(11) DEFAULT NULL,
  `interfaceId` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creatorId` (`creatorId`),
  KEY `userId` (`userId`),
  KEY `organizationId` (`organizationId`),
  KEY `repositoryId` (`repositoryId`),
  KEY `moduleId` (`moduleId`),
  KEY `interfaceId` (`interfaceId`),
  CONSTRAINT `loggers_ibfk_1` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `loggers_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `loggers_ibfk_3` FOREIGN KEY (`organizationId`) REFERENCES `organizations` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `loggers_ibfk_4` FOREIGN KEY (`repositoryId`) REFERENCES `repositories` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `loggers_ibfk_5` FOREIGN KEY (`moduleId`) REFERENCES `modules` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `loggers_ibfk_6` FOREIGN KEY (`interfaceId`) REFERENCES `interfaces` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of loggers
-- ----------------------------
INSERT INTO `loggers` VALUES ('4', 'create', null, '100000012', null, '16', null, null, '2019-03-06 01:26:29', '2019-03-06 01:26:29', null);
INSERT INTO `loggers` VALUES ('5', 'update', null, '100000012', null, null, '46', null, '2019-03-06 01:28:04', '2019-03-06 01:28:04', null);

-- ----------------------------
-- Table structure for modules
-- ----------------------------
DROP TABLE IF EXISTS `modules`;
CREATE TABLE `modules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `description` text NOT NULL,
  `priority` bigint(11) NOT NULL DEFAULT '1',
  `creatorId` int(11) DEFAULT NULL,
  `repositoryId` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creatorId` (`creatorId`),
  KEY `repositoryId` (`repositoryId`),
  CONSTRAINT `modules_ibfk_1` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `modules_ibfk_2` FOREIGN KEY (`repositoryId`) REFERENCES `repositories` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of modules
-- ----------------------------
INSERT INTO `modules` VALUES ('46', '示例模块', '示例模块2', '1', '100000012', '16', '2019-03-06 01:26:28', '2019-03-06 01:28:04', null);

-- ----------------------------
-- Table structure for notifications
-- ----------------------------
DROP TABLE IF EXISTS `notifications`;
CREATE TABLE `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fromId` int(11) DEFAULT NULL,
  `toId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `param1` varchar(128) DEFAULT NULL,
  `param2` varchar(128) DEFAULT NULL,
  `param3` varchar(128) DEFAULT NULL,
  `readed` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of notifications
-- ----------------------------

-- ----------------------------
-- Table structure for organizations
-- ----------------------------
DROP TABLE IF EXISTS `organizations`;
CREATE TABLE `organizations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `description` text,
  `logo` varchar(256) DEFAULT NULL,
  `visibility` tinyint(1) NOT NULL DEFAULT '1',
  `creatorId` int(11) DEFAULT NULL,
  `ownerId` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creatorId` (`creatorId`),
  KEY `ownerId` (`ownerId`),
  CONSTRAINT `organizations_ibfk_1` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `organizations_ibfk_2` FOREIGN KEY (`ownerId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of organizations
-- ----------------------------

-- ----------------------------
-- Table structure for organizations_members
-- ----------------------------
DROP TABLE IF EXISTS `organizations_members`;
CREATE TABLE `organizations_members` (
  `userId` int(11) NOT NULL,
  `organizationId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`userId`,`organizationId`),
  UNIQUE KEY `organizations_members_userId_organizationId_unique` (`userId`,`organizationId`),
  KEY `organizationId` (`organizationId`),
  CONSTRAINT `organizations_members_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `organizations_members_ibfk_2` FOREIGN KEY (`organizationId`) REFERENCES `organizations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of organizations_members
-- ----------------------------

-- ----------------------------
-- Table structure for properties
-- ----------------------------
DROP TABLE IF EXISTS `properties`;
CREATE TABLE `properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `scope` enum('request','response') NOT NULL DEFAULT 'response',
  `type` enum('String','Number','Boolean','Object','Array','Function','RegExp') NOT NULL,
  `pos` int(11) NOT NULL DEFAULT '2',
  `name` varchar(256) NOT NULL,
  `rule` varchar(128) DEFAULT NULL,
  `value` text,
  `description` text,
  `parentId` int(11) NOT NULL DEFAULT '-1',
  `priority` bigint(11) NOT NULL DEFAULT '1',
  `interfaceId` int(11) DEFAULT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `moduleId` int(11) DEFAULT NULL,
  `repositoryId` int(11) DEFAULT NULL,
  `required` tinyint(1) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `interfaceId` (`interfaceId`),
  KEY `creatorId` (`creatorId`),
  KEY `moduleId` (`moduleId`),
  KEY `repositoryId` (`repositoryId`),
  CONSTRAINT `properties_ibfk_1` FOREIGN KEY (`interfaceId`) REFERENCES `interfaces` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `properties_ibfk_2` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `properties_ibfk_3` FOREIGN KEY (`moduleId`) REFERENCES `modules` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `properties_ibfk_4` FOREIGN KEY (`repositoryId`) REFERENCES `repositories` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of properties
-- ----------------------------
INSERT INTO `properties` VALUES ('1', 'request', 'String', '2', 'foo', '', '@ctitle', '请求属性示例', '-1', '1', '136', '100000012', '46', '16', null, '2019-03-06 01:26:28', '2019-03-06 01:26:28', null);
INSERT INTO `properties` VALUES ('2', 'response', 'String', '2', 'string', '1-10', '★', '字符串属性示例', '-1', '1', '136', '100000012', '46', '16', null, '2019-03-06 01:26:28', '2019-03-06 01:26:28', null);
INSERT INTO `properties` VALUES ('3', 'response', 'Number', '2', 'number', '1-100', '1', '数字属性示例', '-1', '1', '136', '100000012', '46', '16', null, '2019-03-06 01:26:29', '2019-03-06 01:26:29', null);
INSERT INTO `properties` VALUES ('4', 'response', 'Boolean', '2', 'boolean', '1-2', 'true', '布尔属性示例', '-1', '1', '136', '100000012', '46', '16', null, '2019-03-06 01:26:29', '2019-03-06 01:26:29', null);
INSERT INTO `properties` VALUES ('5', 'response', 'RegExp', '2', 'regexp', '', '/[a-z][A-Z][0-9]/', '正则属性示例', '-1', '1', '136', '100000012', '46', '16', null, '2019-03-06 01:26:29', '2019-03-06 01:26:29', null);
INSERT INTO `properties` VALUES ('6', 'response', 'Function', '2', 'function', '', '() => Math.random()', '函数属性示例', '-1', '1', '136', '100000012', '46', '16', null, '2019-03-06 01:26:29', '2019-03-06 01:26:29', null);
INSERT INTO `properties` VALUES ('7', 'response', 'Array', '2', 'array', '1-10', '', '数组属性示例', '-1', '1', '136', '100000012', '46', '16', null, '2019-03-06 01:26:29', '2019-03-06 01:26:29', null);
INSERT INTO `properties` VALUES ('8', 'response', 'Number', '2', 'foo', '+1', '1', '数组元素示例', '7', '1', '136', '100000012', '46', '16', null, '2019-03-06 01:26:29', '2019-03-06 01:26:29', null);
INSERT INTO `properties` VALUES ('9', 'response', 'String', '2', 'bar', '1-10', '★', '数组元素示例', '7', '1', '136', '100000012', '46', '16', null, '2019-03-06 01:26:29', '2019-03-06 01:26:29', null);
INSERT INTO `properties` VALUES ('10', 'response', 'Array', '2', 'items', '', '[1, true, \'hello\', /\\w{10}/]', '自定义数组元素示例', '-1', '1', '136', '100000012', '46', '16', null, '2019-03-06 01:26:29', '2019-03-06 01:26:29', null);
INSERT INTO `properties` VALUES ('11', 'response', 'Object', '2', 'object', '', '', '对象属性示例', '-1', '1', '136', '100000012', '46', '16', null, '2019-03-06 01:26:29', '2019-03-06 01:26:29', null);
INSERT INTO `properties` VALUES ('12', 'response', 'Number', '2', 'foo', '+1', '1', '对象属性示例', '11', '1', '136', '100000012', '46', '16', null, '2019-03-06 01:26:29', '2019-03-06 01:26:29', null);
INSERT INTO `properties` VALUES ('13', 'response', 'String', '2', 'bar', '1-10', '★', '对象属性示例', '11', '1', '136', '100000012', '46', '16', null, '2019-03-06 01:26:29', '2019-03-06 01:26:29', null);
INSERT INTO `properties` VALUES ('14', 'response', 'String', '2', 'placeholder', '', '@title', '占位符示例', '-1', '1', '136', '100000012', '46', '16', null, '2019-03-06 01:26:29', '2019-03-06 01:26:29', null);

-- ----------------------------
-- Table structure for repositories
-- ----------------------------
DROP TABLE IF EXISTS `repositories`;
CREATE TABLE `repositories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `description` text,
  `logo` varchar(256) DEFAULT NULL,
  `visibility` tinyint(1) NOT NULL DEFAULT '1',
  `ownerId` int(11) DEFAULT NULL,
  `organizationId` int(11) DEFAULT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `lockerId` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ownerId` (`ownerId`),
  KEY `organizationId` (`organizationId`),
  KEY `creatorId` (`creatorId`),
  KEY `lockerId` (`lockerId`),
  CONSTRAINT `repositories_ibfk_1` FOREIGN KEY (`ownerId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `repositories_ibfk_2` FOREIGN KEY (`organizationId`) REFERENCES `organizations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `repositories_ibfk_3` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `repositories_ibfk_4` FOREIGN KEY (`lockerId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of repositories
-- ----------------------------
INSERT INTO `repositories` VALUES ('16', 'aarm', '资源更新服务api', null, '1', '100000012', null, '100000012', null, '2019-03-06 01:26:28', '2019-03-06 01:26:28', null);

-- ----------------------------
-- Table structure for repositories_collaborators
-- ----------------------------
DROP TABLE IF EXISTS `repositories_collaborators`;
CREATE TABLE `repositories_collaborators` (
  `repositoryId` int(11) NOT NULL,
  `collaboratorId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`repositoryId`,`collaboratorId`),
  UNIQUE KEY `repositories_collaborators_collaboratorId_repositoryId_unique` (`repositoryId`,`collaboratorId`),
  KEY `collaboratorId` (`collaboratorId`),
  CONSTRAINT `repositories_collaborators_ibfk_1` FOREIGN KEY (`repositoryId`) REFERENCES `repositories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `repositories_collaborators_ibfk_2` FOREIGN KEY (`collaboratorId`) REFERENCES `repositories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of repositories_collaborators
-- ----------------------------

-- ----------------------------
-- Table structure for repositories_members
-- ----------------------------
DROP TABLE IF EXISTS `repositories_members`;
CREATE TABLE `repositories_members` (
  `repositoryId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`repositoryId`,`userId`),
  KEY `userId` (`userId`),
  CONSTRAINT `repositories_members_ibfk_1` FOREIGN KEY (`repositoryId`) REFERENCES `repositories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `repositories_members_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of repositories_members
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fullname` varchar(32) NOT NULL,
  `password` varchar(32) DEFAULT NULL,
  `email` varchar(128) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=100000013 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('100000000', 'admin', '8d1df36c45db85bf10fe7531230620c7', 'admin@rap2.com', '2019-03-04 10:08:37', '2019-03-04 10:08:37', null);
INSERT INTO `users` VALUES ('100000012', '刘阳', '8d1df36c45db85bf10fe7531230620c7', 'liuyang06@agree.com.cn', '2019-03-05 01:37:11', '2019-03-05 01:37:11', null);
