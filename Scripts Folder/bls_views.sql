# view containing DOWJONES ONLY
CREATE VIEW djValues AS
SELECT
	d.period_id,
    p.period_month AS month_name,
	LPAD(p.period_month_number,2,'0') AS month_number,
    p.period_year AS year,
    LAST_DAY(cast(concat(p.period_year,"/",p.period_month_number,"/","1") as date)) as period_date,
    c.bls_type as value_name,
    c.education as education,
    c.sexes as sexes,
    d.bls_value as value
FROM
    fact_econ_data d
        INNER JOIN
    dim_master_codes c ON c.stg_id = d.bls_type_id
        INNER JOIN
    dim_period p ON p.period_id = d.period_id
    WHERE d.bls_type_id = 54
    order by year asc ,month_number asc;
    
    
# view containing DOWJONES ONLY
CREATE VIEW sp500Values AS
SELECT
	d.period_id,
    p.period_month AS month_name,
	LPAD(p.period_month_number,2,'0') AS month_number,
    p.period_year AS year,
    LAST_DAY(cast(concat(p.period_year,"/",p.period_month_number,"/","1") as date)) as period_date,
    c.bls_type as value_name,
    c.education as education,
    c.sexes as sexes,
    d.bls_value as value
FROM
    fact_econ_data d
        INNER JOIN
    dim_master_codes c ON c.stg_id = d.bls_type_id
        INNER JOIN
    dim_period p ON p.period_id = d.period_id
    WHERE d.bls_type_id = 55
    order by year asc ,month_number asc;
    


