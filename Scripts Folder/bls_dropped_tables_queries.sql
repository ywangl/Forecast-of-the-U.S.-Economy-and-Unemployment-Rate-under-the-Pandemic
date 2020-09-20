CREATE TABLE `dim_age` (
  `age_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `age` varchar(45) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`age_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `dim_education` (
  `edu_id` smallint(6) NOT NULL AUTO_INCREMENT,
  `edu_type` varchar(45) NOT NULL,
  PRIMARY KEY (`edu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

CREATE TABLE `dim_races` (
  `races_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `race` varchar(45) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`races_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `dim_sexes` (
  `sexes_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `sexes` varchar(45) NOT NULL,
  `sexes_code` varchar(2) DEFAULT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`sexes_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `fact_fin_data` (
  `fin_id` smallint(5) unsigned NOT NULL,
  `bls_type_id` smallint(5) unsigned NOT NULL,
  `period_id` smallint(5) NOT NULL,
  `fin_value` decimal(10,0) DEFAULT NULL,
  `notes` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`fin_id`),
  KEY `bls_type_id_fk_idx` (`bls_type_id`),
  KEY `period_id_fk_idx` (`period_id`),
  CONSTRAINT `bls_type_id_fk` FOREIGN KEY (`bls_type_id`) REFERENCES `t_bls_Unemployed_codes` (`stg_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `period_id_fk` FOREIGN KEY (`period_id`) REFERENCES `dim_period` (`period_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
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


CREATE TABLE `Inflation_Rate` (
  `year` year(4) NOT NULL,
  `month` varchar(45) DEFAULT NULL,
  `Inflation_Rate` float DEFAULT NULL,
  `dim_period_period_id` smallint(6) NOT NULL,
  KEY `fk_Inflation_Rate_dim_period1_idx` (`dim_period_period_id`),
  CONSTRAINT `fk_Inflation_Rate_dim_period1` FOREIGN KEY (`dim_period_period_id`) REFERENCES `dim_period` (`period_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `dim_bls_series_name` (
  `bls_series_name_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `bls_series_name` varchar(45) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`bls_series_name_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;


CREATE TABLE `data_duration_final` (
  `year` int(11) DEFAULT NULL,
  `period` text,
  `periodName` text,
  `value` double DEFAULT NULL,
  `seriesID` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `dim_employment_ratio` (
  `idemployment_ratio` int(11) NOT NULL,
  `employment_ratio` float DEFAULT NULL,
  `edu_id` int(11) DEFAULT NULL,
  `year` year(4) DEFAULT NULL,
  `month` varchar(45) DEFAULT NULL,
  `period_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`idemployment_ratio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `dim_Index` (
  `Index_id` smallint(6) NOT NULL AUTO_INCREMENT,
  `dowJones` float NOT NULL,
  `nasdaq` float NOT NULL,
  `sp500` float NOT NULL,
  `currencyExchangeRate` float DEFAULT NULL,
  `consumerPriceIndex` float DEFAULT NULL,
  `periodID` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`Index_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1155 DEFAULT CHARSET=latin1;


CREATE TABLE `dim_LaborForce` (
  `id` int(11) DEFAULT NULL,
  `ratio` double DEFAULT NULL,
  `edu_type` int(11) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `month` varchar(8) DEFAULT NULL,
  `period_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `dim_marital_status` (
  `mar_stat_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `marital_status` varchar(45) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`mar_stat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;



CREATE TABLE `dim_Unemployment_ratio` (
  `id` int(11) DEFAULT NULL,
  `ratio` double DEFAULT NULL,
  `edu_type` int(11) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `month` int(11) DEFAULT NULL,
  `period_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `dim_US_Euro_Exchange_Rate` (
  `id` int(11) DEFAULT NULL,
  `DEXUSEU` double DEFAULT NULL,
  `year` year(4) DEFAULT NULL,
  `month` int(11) DEFAULT NULL,
  `period_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `duration_classfication` (
  `category_id` smallint(6) NOT NULL,
  `category_name` varchar(45) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `fact_fin_data` (
  `fin_id` smallint(5) unsigned NOT NULL,
  `bls_type_id` smallint(5) unsigned NOT NULL,
  `period_id` smallint(5) NOT NULL,
  `fin_value` decimal(10,0) DEFAULT NULL,
  `notes` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`fin_id`),
  KEY `bls_type_id_fk_idx` (`bls_type_id`),
  KEY `period_id_fk_idx` (`period_id`),
  CONSTRAINT `bls_type_id_fk` FOREIGN KEY (`bls_type_id`) REFERENCES `t_bls_Unemployed_codes` (`stg_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `period_id_fk` FOREIGN KEY (`period_id`) REFERENCES `dim_period` (`period_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Inflation_Rate` (
  `year` year(4) NOT NULL,
  `month` varchar(45) DEFAULT NULL,
  `Inflation_Rate` float DEFAULT NULL,
  `dim_period_period_id` smallint(6) NOT NULL,
  KEY `fk_Inflation_Rate_dim_period1_idx` (`dim_period_period_id`),
  CONSTRAINT `fk_Inflation_Rate_dim_period1` FOREIGN KEY (`dim_period_period_id`) REFERENCES `dim_period` (`period_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `t_fact_bls_Unemployed_data` (
  `stg_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `year` varchar(45) DEFAULT NULL,
  `period` varchar(45) DEFAULT NULL,
  `periodName` varchar(45) DEFAULT NULL,
  `latest` varchar(10) DEFAULT NULL,
  `value` double DEFAULT NULL,
  `footnotes` varchar(45) DEFAULT NULL,
  `seriesID` varchar(45) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`stg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5298 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `t_bls_Unemployed_codes` (
  `stg_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(45) DEFAULT NULL,
  `sexes` varchar(4) DEFAULT NULL,
  `races` varchar(10) DEFAULT NULL,
  `age` varchar(10) DEFAULT NULL,
  `education` varchar(255) DEFAULT NULL,
  `marital_status` varchar(45) DEFAULT NULL,
  `bls_type` varchar(45) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`stg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4
