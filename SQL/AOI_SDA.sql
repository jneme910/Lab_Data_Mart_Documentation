DECLARE @bounds geometry;
SET @bounds = geometry::STPolyFromText('POLYGON((-91.57097 43.37706,-91.57097 43.48543,-91.28187 43.48543,-91.28187 43.37706,-91.57097 43.37706))', 4326 );

DECLARE @b TABLE (Series	VARCHAR(80) NULL, User_pedon_ID VARCHAR(40) NULL ,	pedon_Key INT NULL	,peiid INT NULL,	lat [decimal](12, 9) NULL,	long [decimal](12, 9) NULL,	wmiid  [int]  NOT NULL,	 layer_key INT NULL, labsampnum  VARCHAR(80) NULL);


INSERT INTO @b


SELECT DISTINCT  Series,	User_pedon_ID,	
 lab_webmap.pedon_Key,	peiid, lat, long, wmiid, layer_key, labsampnum
 FROM lab_webmap 
 INNER JOIN lab_layer ON lab_layer.pedon_key= lab_webmap.pedon_key
  WHERE latlong.STWithin( @bounds )  = 1
  GROUP BY Series,	User_pedon_ID,	
 lab_webmap.pedon_Key,	peiid, lat, long, wmiid,  layer_key, labsampnum

