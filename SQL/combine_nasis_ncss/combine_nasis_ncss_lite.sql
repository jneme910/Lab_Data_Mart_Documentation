CREATE TABLE dbo.combine_nasis_ncss_lite (
	pedlabsampnum varchar(12) NULL,
	peiid int NOT NULL,
	upedonid varchar(60) NULL,
	labdatadescflag smallint NULL,
	[priority] varchar(1) NULL,
	priority2 varchar(1) NULL,
	samp_name varchar(60) NULL,
	samp_class_type varchar(128) NULL,
	samp_classdate datetime NULL,
	samp_classification_name varchar(120) NULL,
	samp_taxorder varchar(100) NULL,
	samp_taxsuborder varchar(120) NULL,
	samp_taxgrtgroup varchar(120) NULL,
	samp_taxsubgrp varchar(120) NULL,
	samp_taxpartsize varchar(120) NULL,
	samp_taxpartsizemod varchar(120) NULL,
	samp_taxceactcl varchar(120) NULL,
	samp_taxreaction varchar(120) NULL,
	samp_taxtempcl varchar(120) NULL,
	samp_taxmoistscl varchar(120) NULL,
	samp_taxtempregime varchar(120) NULL,
	samp_taxminalogy varchar(120) NULL,
	samp_taxother varchar(120) NULL,
	samp_osdtypelocflag int NULL,
	corr_name varchar(60) NULL,
	corr_class_type varchar(128) NULL,
	corr_classdate datetime NULL,
	corr_classification_name varchar(120) NULL,
	corr_taxorder varchar(100) NULL,
	corr_taxsuborder varchar(120) NULL,
	corr_taxgrtgroup varchar(120) NULL,
	corr_taxsubgrp varchar(120) NULL,
	corr_taxpartsize varchar(120) NULL,
	corr_taxpartsizemod varchar(120) NULL,
	corr_taxceactcl varchar(120) NULL,
	corr_taxreaction varchar(120) NULL,
	corr_taxtempcl varchar(120) NULL,
	corr_taxmoistscl varchar(120) NULL,
	corr_taxtempregime varchar(120) NULL,
	corr_taxminalogy varchar(120) NULL,
	corr_taxother varchar(120) NULL,
	corr_osdtypelocflag int NULL,
	siteiid int NULL,
	usiteid varchar(60) NULL,
	site_obsdate datetime NULL,
	latitude_decimal_degrees float NULL,
	longitude_decimal_degrees float NULL,
	country_symbol varchar(100) NULL,
	state_symbol varchar(20) NULL,
	county_symbol varchar(20) NULL,
	mlra_symbol varchar(20) NULL,
	ssa_symbol varchar(20) NULL,
	park_symbol varchar(20) NULL,
	nforest_symbol varchar(20) NULL,
	note varchar(54) NULL,
	samp_taxfamhahatmatcl varchar(120) NULL,
	corr_taxfamhahatmatcl varchar(120) NULL,
	pedobjupdate datetime NULL,
	siteobjupdate datetime NULL
) 

