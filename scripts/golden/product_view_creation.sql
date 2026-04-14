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
