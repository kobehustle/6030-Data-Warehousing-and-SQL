-- Setting the schemas used 
USE hospital;

-- checking the dataset
SELECT * FROM bed_type;
SELECT * FROM bed_fact;
SELECT * FROM business;

-- 1)	Top 10 Licensed beds by the total ICU or SICU license beds

SELECT 
    b.business_name,
    SUM(f.license_beds) AS 'ICU or SICU licensed beds'
FROM business b 
INNER JOIN bed_fact f USING (ims_org_id)
INNER JOIN bed_type t USING (bed_id)
WHERE t.bed_desc = 'ICU' or t.bed_desc = 'SICU'
GROUP BY 1, b.ims_org_id
ORDER BY 2 DESC
LIMIT 10;

-- 2)	Top 10 census beds by total ICU or SICU license 

SELECT 
    b.business_name,
    SUM(f.census_beds) AS 'ICU or SICU census beds'
FROM business b 
INNER JOIN bed_fact f USING (ims_org_id)
INNER JOIN bed_type t USING (bed_id)
WHERE t.bed_desc = 'ICU' or t.bed_desc = 'SICU'
GROUP BY 1, b.ims_org_id
ORDER BY 2 DESC
LIMIT 10;

-- 3)	Top 10 staffed beds by total ICU or SICU license 

SELECT 
    b.business_name,
    SUM(f.staffed_beds) AS 'ICU or SICU staffed beds'
FROM business b 
INNER JOIN bed_fact f USING (ims_org_id)
INNER JOIN bed_type t USING (bed_id)
WHERE t.bed_desc = 'ICU' or t.bed_desc = 'SICU'
GROUP BY 1, b.ims_org_id
ORDER BY 2 DESC
LIMIT 10;

-- 4)	Top one or two hospitals per list based on bed volumn
SELECT 
	business_name,
    licensed_beds,
    rnk_licenced,
    bed_type
FROM
(
SELECT 
    b.business_name,
    SUM(f.license_beds) AS 'licensed_beds',
    RANK() OVER(ORDER BY SUM(f.license_beds) DESC) AS rnk_licenced,
    'licensed' AS bed_type
FROM business b 
INNER JOIN bed_fact f USING (ims_org_id)
INNER JOIN bed_type t USING (bed_id)
WHERE t.bed_desc = 'ICU' or t.bed_desc = 'SICU'
GROUP BY 1, b.ims_org_id
ORDER BY 2 DESC
LIMIT 10) a
WHERE rnk_licenced = 1 OR rnk_licenced = 2
UNION ALL
SELECT 
	business_name,
    census_beds,
    rnk_census,
    bed_type
FROM
(
SELECT 
    b.business_name,
    SUM(f.census_beds) AS 'census_beds',
    RANK() OVER(ORDER BY SUM(f.census_beds) DESC) AS rnk_census,
    'census' AS bed_type
FROM business b 
INNER JOIN bed_fact f USING (ims_org_id)
INNER JOIN bed_type t USING (bed_id)
WHERE t.bed_desc = 'ICU' or t.bed_desc = 'SICU'
GROUP BY 1, b.ims_org_id
ORDER BY 2 DESC
LIMIT 10) a
WHERE rnk_census = 1 OR rnk_census = 2
UNION ALL
SELECT 
	business_name,
    staffed_beds,
    rnk_staffed,
    bed_type
FROM
(
SELECT 
    b.business_name,
    SUM(f.staffed_beds) AS 'staffed_beds',
    RANK() OVER(ORDER BY SUM(f.staffed_beds) DESC) AS rnk_staffed,
    'staffed' AS bed_type
FROM business b 
INNER JOIN bed_fact f USING (ims_org_id)
INNER JOIN bed_type t USING (bed_id)
WHERE t.bed_desc = 'ICU' or t.bed_desc = 'SICU'
GROUP BY 1, b.ims_org_id
ORDER BY 2 DESC
LIMIT 10) a
WHERE rnk_staffed = 1 OR rnk_staffed = 2;

-- 4)	Multiple appearance
WITH a AS 
(
SELECT 
    b.business_name,
    SUM(f.license_beds) AS 'ICU or SICU licensed beds'
FROM business b 
INNER JOIN bed_fact f USING (ims_org_id)
INNER JOIN bed_type t USING (bed_id)
WHERE t.bed_desc = 'ICU' or t.bed_desc = 'SICU'
GROUP BY 1, b.ims_org_id
ORDER BY 2 DESC
LIMIT 10)

,b AS  
(
SELECT 
    b.business_name,
    SUM(f.census_beds) AS 'ICU or SICU census beds'
FROM business b 
INNER JOIN bed_fact f USING (ims_org_id)
INNER JOIN bed_type t USING (bed_id)
WHERE t.bed_desc = 'ICU' or t.bed_desc = 'SICU'
GROUP BY 1, b.ims_org_id
ORDER BY 2 DESC
LIMIT 10)

,c AS
(
SELECT 
    b.business_name,
    SUM(f.staffed_beds) AS 'ICU or SICU staffed beds'
FROM business b 
INNER JOIN bed_fact f USING (ims_org_id)
INNER JOIN bed_type t USING (bed_id)
WHERE t.bed_desc = 'ICU' or t.bed_desc = 'SICU'
GROUP BY 1, b.ims_org_id
ORDER BY 2 DESC
LIMIT 10)

SELECT 
	business_name,
    cnt AS count
    
FROM (
SELECT 
	business_name,
    COUNT(business_name) AS cnt
FROM
(SELECT * 
FROM a
UNION ALL 
SELECT *
FROM b
UNION ALL 
SELECT *
FROM c) a
GROUP BY business_name
) b
WHERE cnt > 1
ORDER BY cnt DESC;







-- 