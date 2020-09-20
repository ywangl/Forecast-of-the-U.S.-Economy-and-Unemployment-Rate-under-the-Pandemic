USE DEPA_final;

CREATE TABLE dim_bls_series_name (
  bls_series_name_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  bls_series_name VARCHAR(45) NOT NULL,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (bls_series_name_id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;


SET AUTOCOMMIT=0;
INSERT INTO  dim_bls_series_name (bls_series_name) VALUES ('Unemployed'),('Unemployment Ratio');


CREATE TABLE dim_sexes (
  sexes_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  sexes VARCHAR(45) NOT NULL,
  sexes_code VARCHAR(2),
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (sexes_id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

INSERT INTO  dim_sexes  (sexes,sexes_code) VALUES ('Both','B'),('Men','M'),('Women','W');
#UPDATE `DEPA_final`.`dim_sexes` SET `sexes` = 'Men' WHERE (`sexes_id` = '2');
#UPDATE `DEPA_final`.`dim_sexes` SET `sexes` = 'Women', `sexes_code` = 'W' WHERE (`sexes_id` = '3');

ALTER TABLE `DEPA_final`.`dim_education` 
CHANGE COLUMN `edu_id` `edu_id` SMALLINT(6) NOT NULL AUTO_INCREMENT ;

INSERT INTO DEPA_final.dim_education (edu_type) VALUES ('Less than a High School diploma'),
('Some college or associate degree'),('Some college, no degree'),('Associate degree'),('Bachelors degree only'),('Advanced degree');

CREATE TABLE DEPA_final.dim_age (
  age_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  age VARCHAR(45) NOT NULL,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (age_id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

INSERT INTO DEPA_final.dim_age (age) VALUES ('25+');
#DELETE FROM `DEPA_final`.`dim_age` WHERE (`age_id` = '2');

CREATE TABLE DEPA_final.dim_marital_status (
  mar_stat_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  marital_status VARCHAR(45) NOT NULL,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (mar_stat_id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

INSERT INTO DEPA_final.dim_marital_status (marital_status) VALUES ('All');

CREATE TABLE DEPA_final.dim_races (
  races_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  race VARCHAR(45) NOT NULL,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (races_id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

INSERT INTO  DEPA_final.dim_races ( race) VALUES ('All');


CREATE TABLE `fact_bls_data` (
  `bls_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `period_id` SMALLINT(6)  NOT NULL,
  `bls_type_id` SMALLINT  NOT NULL,
  `bls_value` DECIMAL(10,2) NOT NULL,
  `last_update` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (`bls_id`),
  KEY `fk_bls_period_idx`(`period_id`),
  KEY `fk_bls_bls_type_idx`(`bls_type_id`),
  CONSTRAINT `fk_bls_period_c` FOREIGN KEY (`period_id`) REFERENCES `dim_period` (`period_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_bls_bls_type_c` FOREIGN KEY (`bls_type_id`) REFERENCES `fact_bls_type` (`bls_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



CREATE TABLE `fact_bls_type` (
  `bls_type_id` smallint(5) NOT NULL AUTO_INCREMENT,
  `bls_series_name_id` smallint(5) unsigned NOT NULL,
  `sexes_id` smallint(5) unsigned NOT NULL,
  `age_id` smallint(5) unsigned NOT NULL,
  `edu_id` smallint(5) NOT NULL,
  `mar_stat_id` smallint(5) unsigned NOT NULL,
  `races_id` smallint(5) unsigned NOT NULL,
  `bls_series` varchar(45) DEFAULT NULL,
  `notes` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`bls_type_id`),
  KEY `fk_bls_series_name_id_idx` (`bls_series_name_id`),
  KEY `fk_sexes_id_idx` (`sexes_id`),
  KEY `fk_age_id_idx` (`age_id`),
  KEY `fk_edu_id_idx` (`edu_id`),
  KEY `fk_mar_stat_id_idx` (`mar_stat_id`),
  KEY `fk_races_id_idx` (`races_id`),
  CONSTRAINT `fk_age_id` FOREIGN KEY (`age_id`) REFERENCES `dim_age` (`age_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_bls_series_name_id` FOREIGN KEY (`bls_series_name_id`) REFERENCES `dim_bls_series_name` (`bls_series_name_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_edu_id` FOREIGN KEY (`edu_id`) REFERENCES `dim_education` (`edu_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_mar_stat_id` FOREIGN KEY (`mar_stat_id`) REFERENCES `dim_marital_status` (`mar_stat_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_races_id` FOREIGN KEY (`races_id`) REFERENCES `dim_races` (`races_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_sexes_id` FOREIGN KEY (`sexes_id`) REFERENCES `dim_sexes` (`sexes_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



#Fact FIN

CREATE TABLE `DEPA_final`.`fact_fin_data` (
  `fin_id` SMALLINT(5) UNSIGNED NOT NULL,
  `bls_type_id` SMALLINT(5) UNSIGNED NOT NULL,
  `period_id` SMALLINT(5) NOT NULL,
  `fin_value` DECIMAL NULL,
  `notes` VARCHAR(45) NULL,
  PRIMARY KEY (`fin_id`),
  INDEX `bls_type_id_fk_idx` (`bls_type_id` ASC),
  INDEX `period_id_fk_idx` (`period_id` ASC),
  CONSTRAINT `bls_type_id_fk`
    FOREIGN KEY (`bls_type_id`)
    REFERENCES `DEPA_final`.`t_bls_Unemployed_codes` (`stg_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `period_id_fk`
    FOREIGN KEY (`period_id`)
    REFERENCES `DEPA_final`.`dim_period` (`period_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

INSERT INTO `DEPA_final`.`t_bls_Unemployed_codes` (`stg_id`, `code`, `bls_type`) VALUES ('54', 'DJSTOCK', 'Dow Jones Index Value');
INSERT INTO `DEPA_final`.`t_bls_Unemployed_codes` (`stg_id`, `code`, `bls_type`) VALUES ('55', 'SP500STOCK', 'SP 500 Index Value');
INSERT INTO `DEPA_final`.`t_bls_Unemployed_codes` (`stg_id`, `code`, `bls_type`) VALUES ('56', 'NASDSTOCK', 'NASDAQ Index Value');
INSERT INTO `DEPA_final`.`t_bls_Unemployed_codes` (`code`, `bls_type`) VALUES ('DEXUSEU', 'USD - EUR Currency Exchange Rate');


#Updated Fact_BLS_DATA
ALTER TABLE `DEPA_final`.`fact_bls_data` 
DROP FOREIGN KEY `fk_bls_code_c`;
ALTER TABLE `DEPA_final`.`fact_bls_data` 
ADD INDEX `fk_bls_code_c_idx` (`bls_type_id` ASC),
DROP INDEX `fk_bls_code_c_idx` ;
;
ALTER TABLE `DEPA_final`.`fact_bls_data` 
ADD CONSTRAINT `fk_bls_code_c`
  FOREIGN KEY (`bls_type_id`)
  REFERENCES `DEPA_final`.`dim_master_codes` (`stg_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  
ALTER TABLE `DEPA_final`.`fact_bls_data` 
RENAME TO  `DEPA_final`.`fact_econ_data` ;


#Industry Data
ALTER TABLE `DEPA_final`.`dim_Industry_returnRate` 
ADD COLUMN `period_id` SMALLINT(6) NULL AFTER `return_rate`,
ADD INDEX `fk_period_id_idx` (`period_id` ASC);
;
ALTER TABLE `DEPA_final`.`dim_Industry_returnRate` 
ADD CONSTRAINT `fk_period_id`
  FOREIGN KEY (`period_id`)
  REFERENCES `DEPA_final`.`dim_period` (`period_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


#OLTP
#period year, month, value, type

  

USE `DEPA_final`;
DROP procedure IF EXISTS `insert_econ_data`;

DELIMITER $$
USE `DEPA_final`$$
CREATE PROCEDURE `DEPA_final`.`insert_econ_data` 
(IN year_num YEAR(4)
,IN month_num varchar(40)
,IN value decimal(10,2)
,IN type_id SMALLINT(5) UNSIGNED)
BEGIN
	SET sql_mode='';  
	insert into dim_period 
	(`period_month`,
	`period_month_number`,
	`period_year`)
	values( monthname(STR_TO_DATE(@month_num,'%m')), @month_num,@year);
END$$

DELIMITER ;
