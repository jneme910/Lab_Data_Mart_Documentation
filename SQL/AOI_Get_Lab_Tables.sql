DROP TABLE IF EXISTS #p

WITH polygons
 USE sdmONline;
 
 AS (SELECT 'p1' id, 
            geometry::STGeomFromText('polygon ((-91.58145  43.50322,-91.58145  43.61755,-91.34480  43.61755,-91.34480  43.50322,-91.58145  43.50322))', 4326) poly
),
 points
 AS (SELECT *, latlong as p FROM lab_webmap)
 SELECT Series,	User_pedon_ID,	
 pedon_Key
 ,	peiid, lat, long, 
        points.wmiid, 
       p.STAsText() as Location
INTO #p
 FROM polygons
      RIGHT JOIN points ON polygons.poly.STIntersects(points.p) = 1
 WHERE polygons.id IS NOT NULL;



 SELECT Series,	User_pedon_ID,	
 pedon_Key
 ,	peiid, lat, long, 
        points.wmiid, 
       p.STAsText() as Location ,
FROM #p
INNER JOIN lab_layer
INNER JOIN 

