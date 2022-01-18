/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [mir_scan_det_id]
      ,[rep_num]
      ,[caco3_predict]
      ,[gypsum_predict]
      ,[light_source]
      ,[qc_percent_similar]
      ,[qc_file_status]
      ,[scan_file_status]
      ,[scan_date]
      ,[scan_path_name]
      ,[mir_scan_mas_id]
      ,[qc_hit_quality]
  FROM [lims].[dbo].[mir_scan_det_data]-- Join MIR Scan Master

  /*
  SELECT TOP (1000) [mir_scan_mas_id]
      ,[anal_batch_id]
      ,[smp_id]
      ,[batch_ord_pos]
      ,[mir_plate_id]
  FROM [lims].[dbo].[mir_scan_mas_data]*/