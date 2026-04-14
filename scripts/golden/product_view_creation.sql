--Only Need the current data
SELECT 
  p_info.prd_id,
  p_info.cat_id,
  p_info.prd_key,
  p_info.prd_nm,
  p_info.prd_line,
  p_info.prd_cost,
  p_info.prd_start_dt
FROM 
  silver.crm_prd_info as p_info
WHERE p_info.prd_end_dt IS NULL;


SELECT prd_id, COUNT(*)
FROM
(
SELECT 
  p_info.prd_id,
  p_info.cat_id,
  p_info.prd_key,
  p_info.prd_nm,
  p_info.prd_line,
  p_info.prd_cost,
  p_info.prd_start_dt,
  p_cat.cat,
  p_cat.subcat,
  p_cat.maintenance
FROM 
  silver.crm_prd_info as p_info
LEFT JOIN
   silver.erp_px_cat_g1v2 as p_cat
ON p_info.cat_id = p_cat.id
WHERE p_info.prd_end_dt IS NULL
) t
GROUP BY prd_id HAVING COUNT(*) > 1;
