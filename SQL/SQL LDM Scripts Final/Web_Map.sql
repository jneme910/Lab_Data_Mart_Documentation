SET QUOTED_IDENTIFIER ON

USE [master]
GO
ALTER DATABASE [ncsslabdata] SET COMPATIBILITY_LEVEL = 130
GO

GO
SET STATISTICS IO ON 
set statistics time on
GO 

SELECT @@VERSION AS SQL_Server_Version

USE ncsslabdata

DROP TABLE	IF EXISTS lab_webmap
DROP TABLE    IF EXISTS lab_webmap
DROP TABLE    IF EXISTS SDA_webmap

CREATE TABLE lab_webmap
( wmiid INT IDENTITY (1,1),
[Series] VARCHAR(80) COLLATE Latin1_General_CS_AS, 
[User_Pedon_ID] VARCHAR(40), 
[Pedon_Key] INT, 
[peiid] INT,
[Soil_Classification] nvarchar(1000),
[Primary_Lab_Report] nvarchar(1000),
[Taxonomy_Report] nvarchar(1000),
[Supplementary_Lab_Report] nvarchar(1000),
[Water_Retention_Report] nvarchar(1000),
[Correlation_Report] nvarchar(1000),
[Pedon_Description_Report] nvarchar(1000),
[Soil_Profile] nvarchar(1000), 
[Soil_Web] nvarchar(1000),
lat DECIMAL(12,9),
long DECIMAL(12,9),
latlong GEOMETRY 
	  -- CONSTRAINT pk_lab_map PRIMARY KEY CLUSTERED ([Pedon_Key])
	 -- )

	 CONSTRAINT [pk_lab_map] PRIMARY KEY CLUSTERED 
(
    [wmiid] ASC, [Pedon_Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)) ON [PRIMARY]

	  go

INSERT INTO lab_webmap


 SELECT 
CASE WHEN [corr_name] IS NULL THEN   UPPER(LEFT([samp_name],1))+LOWER(SUBSTRING([samp_name],2,LEN([samp_name]))) ELSE  UPPER(LEFT([corr_name],1))+LOWER(SUBSTRING([corr_name],2,LEN([corr_name]))) END AS [Series],
[upedonid] AS [User_Pedon_ID], 
 [pedon_key] AS [Pedon_Key],
 [pedoniid]  AS [peiid],
CASE WHEN [corr_classification_name] IS NULL THEN [samp_classification_name] ELSE [corr_classification_name] END AS [Soil_Classification],
CONCAT ('https://ncsslabdatamart.sc.egov.usda.gov/rptExecute.aspx?p=', [pedon_key] , '&r=1&submit1=Get+Report') AS [Primary_Lab_Report],
CONCAT ('https://ncsslabdatamart.sc.egov.usda.gov/rptExecute.aspx?p=', [pedon_key] , '&r=3&submit1=Get+Report') AS [Taxonomy_Report],
CONCAT ('https://ncsslabdatamart.sc.egov.usda.gov/rptExecute.aspx?p=', [pedon_key] , '&r=2&submit1=Get+Report') AS [Supplementary_Lab_Report],
CONCAT ('https://ncsslabdatamart.sc.egov.usda.gov/rptExecute.aspx?p=', [pedon_key] , '&r=6&submit1=Get+Report') AS [Water_Retention_Report],
CONCAT ('https://ncsslabdatamart.sc.egov.usda.gov/rptExecute.aspx?p=', [pedon_key] , '&r=7&submit1=Get+Report') AS [Correlation_Report],
CONCAT ('https://nasis.sc.egov.usda.gov/NasisReportsWebSite/limsreport.aspx?report_name=Pedon_Site_Description_usepedonid&pedon_id=', [upedonid] ) AS [Pedon_Description_Report],
CONCAT ('https://nasis.sc.egov.usda.gov/NasisReportsWebSite/limsreport.aspx?report_name=WEB-profiles-by-PEIID&pedon_peiid=', [pedoniid] ) AS [Soil_Profile],
CONCAT ('https://casoilresource.lawr.ucdavis.edu/gmap/?loc=', [latitude_decimal_degrees], ',' , [longitude_decimal_degrees]  ) AS [Soil_Web],
[latitude_decimal_degrees] AS lat,
[longitude_decimal_degrees] AS long,
geometry ::Point([longitude_decimal_degrees], [latitude_decimal_degrees] , 4326) AS latlong
  FROM [ncsslabdata].[dbo].[combine_nasis_ncss] WHERE CASE WHEN  [latitude_decimal_degrees] IS NULL THEN 2 WHEN [longitude_decimal_degrees] IS NULL THEN 2 ELSE 1 END = 1

CREATE INDEX  lab_webmap_series_idx2 ON  lab_webmap ([Series] )
CREATE INDEX  lab_webmap_upedonid_idx3 ON  lab_webmap ([User_Pedon_ID])
CREATE INDEX  lab_webmap_pedonkey_idx4 ON  lab_webmap ([Pedon_Key])
CREATE INDEX  lab_webmap_peiid_idx5 ON  lab_webmap ([peiid])
--CREATE SPATIAL INDEX si_lab_webmap_geometry_latlong_idx5 --lab_webmap_latlong_idx5 
--ON  [ncsslabdata].[dbo].[lab_webmap] ([latlong]) USING Geometry_grid -- Geometry_auto_grid 

--WITH 
--( BOUNDING_BOX= (xmin=-180, ymin=-90, xmax=180, ymax=90)

--WITH (  
--    BOUNDING_BOX = (xmin=-180, ymin=-90, xmax=180, ymax=90),  
--    GRIDS = (HIGH, HIGH, HIGH, HIGH),  
--    CELLS_PER_OBJECT = 64,  
  --  PAD_INDEX  = ON ) ON [PRIMARY]

CREATE SPATIAL INDEX [ si_lab_webmap_geometry_latlong_idx5] ON [ncsslabdata].[dbo].[lab_webmap]
(
	[latlong]
)USING  GEOMETRY_GRID 
WITH (BOUNDING_BOX =(-180, -90, 180, 90), GRIDS =(LEVEL_1 = HIGH,LEVEL_2 = HIGH,LEVEL_3 = HIGH,LEVEL_4 = HIGH), 
CELLS_PER_OBJECT = 64, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

 ; 
--(BOUNDING_BOX =(xmin=-180, ymin=-90, xmax=180, ymax=90))
   --  GRIDS=(LEVEL_1 = HIGH,LEVEL_2 = HIGH, LEVEL_3 = HIGH, LEVEL_4 = HIGH)  , CELLS_PER_OBJECT = 64


--ON [PRIMARY] 
--;
 --- TRUNCATE TABLE  IF EXISTS lab_webmap

 GO

SET STATISTICS IO OFF 
set statistics time OFF
GO
