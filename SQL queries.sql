USE agriculture;
SELECT * FROM area_har_cult_prod AS harvested;
SELECT * FROM energy_consumption;
SELECT * FROM harvested_prod_eu_stand_humidity;
SELECT * FROM eu_utilised_area;
SELECT * FROM orange_import_export_monthly;
SELECT * FROM orange_prices;

-- concatenated Country-year--
SELECT a.country_code, a.year, a.value AS harvested_area, e.value AS energy_consumption, p.value AS harvested_production, u.value AS eu_utilized_area
FROM area_har_cult_prod a
JOIN energy_consumption e ON a.country_code = e.country_code AND a.year = e.year
JOIN harvested_prod_eu_stand_humidity p ON e.country_code = p.country_code AND e.year = p.year
JOIN eu_utilised_area u ON p.country_code = u.country_code AND p.year = u.year;

-- import-export monthly data sorted--
SELECT date_format(CONVERT(left(date,10),date), '%Y-%m') AS 'date', ROUND(export_volume,2) AS export_volume, ROUND(import_volume,2) AS import_volume
FROM orange_import_export_monthly 
ORDER BY date;

-- import-export-price monthly --
SELECT op.date, ROUND(export_volume,2) AS export_volume, ROUND(import_volume,2) AS import_volume, op.price
FROM orange_import_export_monthly ie JOIN orange_prices op ON ie.date=op.date
ORDER BY date;

-- yearly average import-export-
SELECT year, ROUND(AVG(export_volume),2) AS avg_export_volume, ROUND(AVG(import_volume),2) AS avg_import_volume 
FROM orange_import_export_monthly 
GROUP BY year;

-- monthly import-export-price--
SELECT op.date, ROUND(AVG(export_volume),2) AS export_volume, ROUND(AVG(import_volume),2) AS import_volume, op.price
FROM orange_import_export_monthly ie JOIN orange_prices op ON ie.date=op.date
GROUP BY date;
-- yearly average orange prices--
SELECT year, ROUND(AVG(price),2) AS avg_price FROM orange_prices GROUP BY year;