-- Create AOI table with polygon geometry. Coordinate system must be WGS1984 (EPSG 4326)
-- 
USE sdmONLINE;

DROP TABLE IF EXISTS #AoiTableKSSL;
DROP TABLE IF EXISTS #AoiAcresKSSL ;
DROP TABLE IF EXISTS #AoiSoilsKSSL ;
DROP TABLE IF EXISTS #AoiSoilsKSSL;
DROP TABLE IF EXISTS #AoiSoils2KSSL;

	DECLARE @aoiGeom Geometry;
	DECLARE @aoiGeomFixed Geometry;
	DECLARE @pAoiId INT ;
	DECLARE @intersectedPolygonGeometries table (id int, geom geometry);
	DECLARE @intersectedPolygonGeographies table (id int, geog geography);

DECLARE @b table(y int, m INT, log_id INT, wss_activity VARCHAR (250),  [state] VARCHAR(30));


CREATE TABLE #AoiTableKSSL
    ( aoiid INT IDENTITY (1,1),
    landunit CHAR(20),
    aoigeom GEOMETRY )


	SELECT @aoiGeom = GEOMETRY::STGeomFromText('MULTIPOLYGON (((-89.62921 43.15060,-89.27181 43.15060,-89.27181 43.33916,-89.62921 43.33916,-89.62921 43.15060)))', 4326); 
---89.65393 43.31269,-89.55711 43.13256,-89.51454 43.19967,-89.44725 43.13206,-89.39095 43.30719,-89.46991 43.30020,-89.49120 43.23720,-89.51866 43.27521,-89.53239 43.23220,-89.57840 43.29170,-89.65393 43.31269
	
SELECT @aoiGeomFixed = @aoiGeom.MakeValid().STUnion(@aoiGeom.STStartPoint()); 
INSERT INTO #AoiTableKSSL ( landunit, aoigeom )  
VALUES ('TEMPID1', @aoiGeomFixed); 

-- #AoiAcres table to contain summary acres for each landunit
CREATE TABLE #AoiAcresKSSL
    ( aoiid INT,
    landunit CHAR(20),
    landunit_acres FLOAT )
;
-- Populate #AoiAcres table
INSERT INTO #AoiAcresKSSL (aoiid, landunit, landunit_acres )
    SELECT  aoiid, landunit,
    SUM( ROUND( ( ( GEOGRAPHY::STGeomFromWKB(aoigeom.STAsBinary(), 4326 ).STArea() ) / 4046.8564224 ), 3 ) ) AS landunit_acres
    FROM #AoiTableKSSL
    GROUP BY aoiid, landunit

	INSERT INTO #AoiAcresKSSL (aoiid, landunit, landunit_acres )
    SELECT  aoiid, landunit,
    SUM( ROUND( ( ( GEOGRAPHY::STGeomFromWKB(aoigeom.STAsBinary(), 4326 ).STArea() ) / 4046.8564224 ), 3 ) ) AS landunit_acres
    FROM #AoiTableKSSL
    GROUP BY aoiid, landunit
;


-- #AoiSoils table contains intersected soil polygon table with geometry
CREATE TABLE #AoiSoilsKSSL
    ( polyid INT IDENTITY (1,1),
    aoiid INT,
    landunit CHAR(20),
    mukey INT,
    soilgeom GEOMETRY )
;


-- Populate #AoiSoils table with intersected soil polygon geometry
INSERT INTO #AoiSoilsKSSL (aoiid, landunit, mukey, soilgeom)
    SELECT A.aoiid, A.landunit, M.mukey, M.mupolygongeo.STIntersection(A.aoigeom ) AS soilgeom
    FROM mupolygon M, #AoiTableKSSL A
    WHERE mupolygongeo.STIntersects(A.aoigeom) = 1
;


-- #AoiSoils2 table contains Soil geometry with landunits
CREATE TABLE #AoiSoils2KSSL
    ( aoiid INT,
    polyid INT,
    landunit CHAR(20),
    mukey INT,
    poly_acres FLOAT,
    soilgeog GEOGRAPHY )
;
-- Populate #AoiSoils2 Soil geometry with landunit attribute
INSERT INTO #AoiSoils2KSSL
    SELECT aoiid, polyid, landunit, mukey, ROUND((( GEOGRAPHY::STGeomFromWKB(soilgeom.STAsBinary(), 4326 ).STArea() ) / 4046.8564224 ), 3 ) AS poly_acres, GEOGRAPHY::STGeomFromWKB(soilgeom.STAsBinary(), 4326 ) AS soilgeog
    FROM #AoiSoilsKSSL


