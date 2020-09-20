USE DEPA_final;

#Create staging table
CREATE TABLE `t_backup_bls_Unemployed_data` (
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

#DIM PERIOD
CREATE TABLE `dim_period` (
  `period_id` smallint(6) NOT NULL,
  `period_month` varchar(45) NOT NULL,
  `period_month_number` varchar(40) NOT NULL,
  `period_year` year(4) NOT NULL,
  PRIMARY KEY (`period_id`),
  KEY `idx_period_month` (`period_month`,`period_year`),
  KEY `fk_dim_period_employment_ratio` (`period_month`,`period_year`),
  KEY `fk_dim_period_employment_ratio_idx` (`period_month`,`period_year`),
  KEY `eduration_period_fk` (`period_month`,`period_year`),
  KEY `fk_dim_period_unemployment_ratio` (`period_year`,`period_month`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

#DIM MASTER CODES
CREATE TABLE `dim_master_codes` (
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
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4;

#DIM INDUSTRY RATES
CREATE TABLE `dim_Industry_returnRate` (
  `return_rate_id` int(11) NOT NULL AUTO_INCREMENT,
  `year` int(11) DEFAULT NULL,
  `month` int(11) DEFAULT NULL,
  `industry` int(11) DEFAULT NULL,
  `industry_name` varchar(45) DEFAULT NULL,
  `return_rate` double DEFAULT NULL,
  `period_id` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`return_rate_id`),
  KEY `fk_period_id_idx` (`period_id`),
  CONSTRAINT `fk_period_id` FOREIGN KEY (`period_id`) REFERENCES `dim_period` (`period_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1873 DEFAULT CHARSET=utf8mb4;

#FACT TABLE
CREATE TABLE `fact_econ_data` (
  `bls_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `period_id` smallint(6) NOT NULL,
  `bls_type_id` smallint(6) unsigned NOT NULL,
  `bls_value` decimal(10,2) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`bls_id`),
  KEY `fk_bls_period_idx` (`period_id`),
  KEY `fk_bls_code_c_idx` (`bls_type_id`),
  CONSTRAINT `fk_bls_code_c` FOREIGN KEY (`bls_type_id`) REFERENCES `dim_master_codes` (`stg_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_bls_period_c` FOREIGN KEY (`period_id`) REFERENCES `dim_period` (`period_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11766 DEFAULT CHARSET=utf8mb4;



#Standalone MongoDB

CREATE TABLE `fact_table_mongoDB` (
  `fact_table_id` int(11) NOT NULL AUTO_INCREMENT,
  `period_id` int(11) NOT NULL,
  `year` year(4) DEFAULT NULL,
  `month` int(11) DEFAULT NULL,
  `employment_ratio` float DEFAULT NULL,
  `edu_employment` int(11) DEFAULT NULL,
  `laborForce_ratio` double DEFAULT NULL,
  `edu_laborForce` int(11) DEFAULT NULL,
  `unemployment_ratio` double DEFAULT NULL,
  `edu_unemployment` int(11) DEFAULT NULL,
  `unemploymentDuration_ratio` double DEFAULT NULL,
  `duration_id` int(11) DEFAULT NULL,
  `dowJones` float DEFAULT NULL,
  `nasdaq` float DEFAULT NULL,
  `sp500` float DEFAULT NULL,
  PRIMARY KEY (`fact_table_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4096 DEFAULT CHARSET=utf8mb4;