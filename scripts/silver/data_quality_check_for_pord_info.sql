-- for primry key
SELECT
  *
FROM
(
		SELECT
		*,
		ROW_NUMBER() OVER(PARTITION BY prd_id ORDER BY prd_start_dt DESC) flag
		FROM bronze.crm_prd_info
		WHERE prd_id IS NOT NULL
	)t
	WHERE flag = 1;
