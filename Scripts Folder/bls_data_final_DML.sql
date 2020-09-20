USE DEPA_final;

INSERT INTO `DEPA_final`.`fact_bls_data`
(
`period_id`,
`bls_type_id`,
`bls_value`)
SELECT 
    p.period_id, c.stg_id, d.value
FROM
    t_fact_bls_Unemployed_data d
        INNER JOIN
    dim_period p ON d.year = p.period_year
        AND d.periodName = p.period_month
        INNER JOIN
    t_bls_Unemployed_codes c ON c.code = d.seriesID;


/*SELECT 
    p.period_id, c.stg_id, d.value
FROM
    t_fact_bls_Unemployed_data d
        INNER JOIN
    dim_period p ON d.year = p.period_year
        AND d.periodName = p.period_month
        INNER JOIN
    t_bls_Unemployed_codes c ON c.code = d.seriesID;*/
    
    
INSERT INTO `DEPA_final`.`fact_bls_data`
(
`period_id`,
`bls_type_id`,
`bls_value`)
SELECT 
    d.period_id, 48 as stg_id, d.ratio
FROM
    dim_Unemployment_ratio d
    WHERE d.edu_type = 1;
    

INSERT INTO `DEPA_final`.`fact_bls_data`
(
`period_id`,
`bls_type_id`,
`bls_value`)
SELECT 
    d.period_id, 49 as stg_id, d.ratio
FROM
    dim_Unemployment_ratio d
    WHERE d.edu_type = 2
    AND d.period_id is not NULL;
    
##Load Employment Data

INSERT INTO `DEPA_final`.`fact_bls_data`
(
`period_id`,
`bls_type_id`,
`bls_value`)
SELECT 
    d.period_id, 50 as stg_id, d.employment_ratio
FROM
    dim_employment_ratio d
    WHERE d.edu_id = 1;
    
INSERT INTO `DEPA_final`.`fact_bls_data`
(
`period_id`,
`bls_type_id`,
`bls_value`)
SELECT 
    d.period_id, 51 as stg_id, d.employment_ratio
FROM
    dim_employment_ratio d
    WHERE d.edu_id = 2
    AND d.period_id is not NULL;
    

##Load Labor Force Data

INSERT INTO `DEPA_final`.`fact_bls_data`
(
`period_id`,
`bls_type_id`,
`bls_value`)
SELECT 
    d.period_id, 52 as stg_id, d.ratio
FROM
    DEPA_final.dim_LaborForce d
    WHERE d.edu_type = 1
    AND d.period_id is not NULL;
    
INSERT INTO `DEPA_final`.`fact_bls_data`
(
`period_id`,
`bls_type_id`,
`bls_value`)
SELECT 
    d.period_id, 53 as stg_id, d.ratio
FROM
    DEPA_final.dim_LaborForce d
    WHERE d.edu_type = 2
    AND d.period_id is not NULL;

# Duration
UPDATE `DEPA_final`.`t_bls_Unemployed_codes` 
SET 
    `bls_type` = 'Percent Unemployed 15-26 Weeks'
WHERE
    (`stg_id` = '45');


UPDATE `DEPA_final`.`t_bls_Unemployed_codes` 
SET 
    `code` = 'LNU03025703',
    `bls_type` = 'Percent Unemployed 27 Weeks & over'
WHERE
    (`stg_id` = '46');

# FIN Metrics
#DOWJONES
INSERT INTO `DEPA_final`.`fact_bls_data`
(
`period_id`,
`bls_type_id`,
`bls_value`)
select periodID, 54 as stg_id, dowJones from dim_Index 
WHERE periodID is not NULL;

#SP500
INSERT INTO `DEPA_final`.`fact_bls_data`
(
`period_id`,
`bls_type_id`,
`bls_value`)
select periodID, 55 as stg_id, sp500 from dim_Index 
WHERE periodID is not NULL;

#NASDAQ
INSERT INTO `DEPA_final`.`fact_bls_data`
(
`period_id`,
`bls_type_id`,
`bls_value`)
select periodID, 56 as stg_id, nasdaq from dim_Index 
WHERE periodID is not NULL;

#Currency Exchange Rate
INSERT INTO `DEPA_final`.`fact_bls_data`
(
`period_id`,
`bls_type_id`,
`bls_value`)
select periodID, 57 as stg_id, currencyExchangeRate from dim_Index 
WHERE periodID is not NULL;

DELETE FROM `DEPA_final`.`fact_bls_data`
WHERE bls_type_id = 43;

UPDATE `DEPA_final`.`t_bls_Unemployed_codes` 
SET 
    `code` = 'LNU03026299',
    `bls_type` = 'Percent Unemployed 27-51 Weeks'
WHERE
    (`stg_id` = '46');


#Add Duration Data
INSERT INTO `DEPA_final`.`fact_bls_data`
(
`period_id`,
`bls_type_id`,
`bls_value`)
SELECT 
  p1.period_id,c.stg_id,f.value
FROM
    data_duration_final f
        INNER JOIN
    dim_period p1 ON concat(f.periodName,f.year) = concat(p1.period_month,p1.period_year)
		inner join 
	t_bls_Unemployed_codes c ON c.code = f.seriesID;
    
    
#INDUSTRY DATA MERGE

UPDATE `DEPA_final`.`dim_Industry_returnRate` t1 JOIN dim_period t2
    ON t1.year = t2.period_year AND t1.month = t2.period_month
   SET t1.period_id = t2.period_id;


select count(*) from dim_Index;

#43,44,45,46,47
#LNU03008397 1 Less than 5 Weeks
#LNU03025701 2 5-14 Weeks
#LNU03025702 3 15-26 Weeks
#LNU03025703 4 27 weeks & over
#LNU03026299
#LNU03026300
    
select * from dim_Unemployment_ratio where edu_type = 2 AND period_id is not NULL;
    
SELECT 
  p.period_id, 49 as stg_id, r.ratio
FROM
    dim_Unemployment_ratio r
        INNER JOIN
    dim_period p ON r.month = p.period_month_number
        INNER JOIN
    dim_period p2 ON p2.period_year = (r.year)
WHERE
    edu_type = 2;

select * from t_bls_Unemployed_codes ;

select * from dim_employment_ratio;

SELECT count(*) FROM DEPA_final.dim_LaborForce where edu_type = 2 and period_id is not NULL;

SELECT * FROM DEPA_final.dim_duration_unemployment;

SELECT 
     p.period_id, 43 as stg_id, r.ratio
FROM
    DEPA_final.dim_duration_unemployment d
    WHERE d.duration_category = 1
    AND d.period_id is not NULL;

select b.bls_value , d.dowJones  from fact_bls_data b inner join dim_Index d ON b.period_id = d.periodID and b.bls_type_id = 54;

