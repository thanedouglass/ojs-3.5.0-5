-- ==============================================================================
-- Database Initialization for Ukweli Open Journal Systems (OJS 3.5.0-5)
-- ==============================================================================

CREATE DATABASE IF NOT EXISTS `okweli_ojs` 
    CHARACTER SET utf8mb4 
    COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS 'ojs_admin'@'%' IDENTIFIED BY 'SovereignKernel888!';
CREATE USER IF NOT EXISTS 'ojs_admin'@'localhost' IDENTIFIED BY 'SovereignKernel888!';

GRANT ALL PRIVILEGES ON `okweli_ojs`.* TO 'ojs_admin'@'%';
GRANT ALL PRIVILEGES ON `okweli_ojs`.* TO 'ojs_admin'@'localhost';

FLUSH PRIVILEGES;
