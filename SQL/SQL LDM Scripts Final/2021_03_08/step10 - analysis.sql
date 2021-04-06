USE ncsslabdata;
GO


-------- truncate existing data
TRUNCATE TABLE lab_analysis_procedure;



--------- add new data
INSERT INTO lab_analysis_procedure
            SELECT
                1,
                'Aggregate Stability',
                'Aggregate Stability, 2- to 0.5-mm Aggregates Retained',
                'AGGSTAB',
                'SSIR No. 42, version 4, page 163',
                213,
                241,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=241',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                2,
                'Atterberg Limits',
                'Atterberg Limits, NSMC Lab',
                'ATTERBERG',
                'SSIR No. 42, version 4, page 167',
                218,
                246,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=246',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                3,
                'Bulk Density, Clod',
                'Bulk Density and Water Retention, Pressure-Plate, Clods',
                'DBH2ORET',
                'SSIR No. 42, version 4, page 104',
                138,
                166,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=166',
                'what is on v.4 page 104 is on v.5 138, but it doesn�t say anything about clods only cores';
INSERT INTO lab_analysis_procedure
            SELECT
                4,
                'Bulk Density, Soil Core',
                'Bulk Density and Water Retention, Pressure-Plate, Cores',
                'DBH2ORETCO',
                'SSIR No. 42, version 4, page 104',
                138,
                166,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=166',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                5,
                'Bulk Density, Reconstituted',
                'Bulk Density and Water Retention, Reconstituted',
                'DBRECON',
                'SSIR No. 42, version 4, page 99',
                125,
                153,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=153',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                6,
                'Bulk Density, Compliant Cavity ',
                'Bulk Density, Compliant Cavity',
                'DBCOMPCAV',
                'SSIR No. 42, version 4, page 98',
                130,
                158,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=158',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                8,
                'Bulk Density, Clod, Field State',
                'Bulk Density, Field State',
                'DBFLDSTATE',
                'SSIR No. 42, version 4, page 75',
                101,
                129,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=129',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                9,
                'Bulk Density, Reconstituted, Moist',
                'Bulk Density, Reconstituted, Moist',
                'DBRECON_M',
                'SSIR No. 42, version 5, page 125',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                10,
                'Bulk Density, Clod, Rewet',
                'Bulk Density, Rewet, Clods',
                'DBREWET',
                'SSIR No. 42, version 4, page 89',
                119,
                147,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=147',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                12,
                'Calcium Carbonate Equivalent, <2mm',
                'Calcium Carbonate Equivalent, HCl, <2mm',
                'CACO3',
                'SSIR No. 42, version 4, page 269',
                370,
                398,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=398',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                13,
                'Calcium Carbonate Equivalent, 2-20mm',
                'Calcium Carbonate Equivalent, HCl, 2-20mm',
                'CACO3_20',
                'SSIR No. 42, version 4, page 269',
                370,
                398,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=398',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                14,
                'Carbon, Total',
                'Carbon, Total',
                'TOTC',
                'SSIR No. 42, version 4, page 473',
                713,
                741,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=741',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                15,
                'Acid Oxalate Extract',
                'Cations, Acid Oxalate Extractable',
                'OXAL',
                'SSIR No. 42, version 4, page 312',
                432,
                460,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=460',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                16,
                'Dithionite-Citrate Extract',
                'Cations, Dithionite-Citrate Extractable',
                'DITH',
                'SSIR No. 42, version 4, page 307',
                426,
                454,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=454',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                17,
                'KCl Extract',
                'Cations, Potassium Chloride Extractable',
                'KCL',
                'SSIR No. 42, version 4, page 197',
                254,
                282,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=282',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                18,
                'Na-Pyrophosphate Extract',
                'Cations, Pyrophosphate Extractable',
                'PYRO',
                'SSIR No. 42, version 4, page 317',
                440,
                468,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=468',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                19,
                'CEC and Cations, Neutral Salts',
                'CEC and Cations, NH4Cl',
                'CECCL',
                'SSIR No. 42, version 4, page 181',
                236,
                264,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=264',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                20,
                'CEC and Cations, Routine',
                'CEC and Cations, NH4OAc',
                'CECNH4',
                'SSIR No. 42, version 4, page 173',
                230,
                258,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=258',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                21,
                'Clay Mineralogy, DSC',
                'Differential Scanning Calorimetry, Thermal Analyzer',
                'DSC910S',
                'SSIR No. 42, version 4, page 410',
                987,
                1015,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=1015',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                22,
                'Effervescence, 1N HCl',
                'Effervescence, 1N HCl',
                'EFF_1nhcl',
                'SSIR No. 42, version 4, page 25',
                35,
                63,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=63',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                23,
                'Extractable Acidity, BaCl2-TEA',
                'Extractable Acidity, BaCl2-Triethanolamine, Titration',
                'EXTRACID',
                'SSIR No. 42, version 4, page 192',
                603,
                631,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=631',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                24,
                'Gypsum, <2mm',
                'Gypsum, H2O Extraction, Acetone Precipitation, <2mm',
                'GYPSUM',
                'SSIR No. 42, version 4, page 273',
                375,
                403,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=403',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                25,
                'Gypsum, 2-20mm',
                'Gypsum, H2O Extraction, Acetone Precipitation, 2-20mm',
                'GYP20',
                'SSIR No. 42, version 4, page 273',
                375,
                403,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=403',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                26,
                'Mineral Content',
                'Mineral Content, Loss on Ignition',
                'MINIGNITE',
                'SSIR No. 42, version 4, page 368',
                495,
                523,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=523',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                27,
                'Nitrate, KCl Extractable',
                'Nitrate, 1 M KCl Extractable, FIA',
                'NO3KCL',
                'SSIR No. 42, version 4, page 260',
                360,
                388,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=388',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                28,
                'Nitrogen, Mineralizable',
                'Nitrogen, Mineralizable',
                'MINT',
                'SSIR No. 42, version 4, page 388',
                664,
                692,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=692',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                29,
                'Nitrogen, Total',
                'Nitrogen, Total',
                'TOTN',
                'SSIR No. 42, version 4, page 475',
                716,
                744,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=744',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                30,
                'Optical Analysis, Glass Count',
                'Optical Analysis, Glass Count',
                'OPTICAL_G',
                'SSIR No. 42, version 4, page 428',
                566,
                594,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=594',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                31,
                'Optical Analysis, Full Count',
                'Optical Analysis, Full Grain Count',
                'OPTICAL_F',
                'SSIR No. 42, version 4, page 428',
                566,
                594,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=594',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                32,
                'Fiber Analysis',
                'Organic Fiber Analysis',
                'FIBANAL',
                'SSIR No. 42, version 4, page 371',
                499,
                527,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=527',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                33,
                'Particle Density <2mm',
                'Particle density <2 mm',
                'pd_l2',
                'SSIR No. 42, version 4, page 165',
                216,
                244,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=244',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                34,
                'Particle Density >2mm',
                'Particle density >2 mm',
                'pd_g2',
                'SSIR No. 42, version 4, page 165',
                216,
                244,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=244',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                35,
                'pH, KCl',
                'pH, 1N KCl',
                'PHKCL',
                'SSIR No. 42, version 4, page 215',
                279,
                307,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=307',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                36,
                'pH, NaF',
                'pH, 1N NaF',
                'PHNAF',
                'SSIR No. 42, version 4, page 205',
                267,
                295,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=295',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                37,
                'pH, Oxidized',
                'pH, Oxidized',
                'PHOXID',
                'SSIR No. 42, version 4, page 209',
                271,
                299,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=299',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                38,
                'pH, Routine',
                'pH, Routine, 1:1 Water and 1:2 0.01M CaCl2',
                'PHROUT',
                'SSIR No. 42, version 4, page 213',
                276,
                304,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=304',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                39,
                'Phosphate, Water Soluble',
                'Phosphate, Water Soluble',
                'H2OPO4',
                'SSIR No. 42, version 4, page 226',
                292,
                320,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=320',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                40,
                'Phosphorus, Bray 1',
                'Phosphorus, Bray 1',
                'BRAYP',
                'SSIR No. 42, version 4, page 231',
                327,
                355,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=355',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                41,
                'Phosphorus, Bray 2',
                'Phosphorus, Bray 2',
                'BRAY2P',
                'SSIR No. 42, version 4, page 239',
                331,
                359,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=359',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                42,
                'Phosphorus, Citric Acid Extractable',
                'Phosphorus, Citric Acid Extractable',
                'CITACIDP',
                'SSIR No. 42, version 4, page 253',
                351,
                379,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=379',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                43,
                'New Zealand Phosphorus Retention',
                'Phosphorus, New Zealand P Retention',
                'NZPRET',
                'SSIR No. 42, version 4, page 257',
                356,
                384,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=384',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                44,
                'Phosphorus, Olsen',
                'Phosphorus, Olsen',
                'OLSENP',
                'SSIR No. 42, version 4, page 242',
                336,
                364,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=364',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                45,
                'PSDA, Dith, Pipet',
                'PSDA, Dith, Pipet',
                'PSDADITH',
                'SSIR No. 42, version 4, page 46',
                67,
                95,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=95',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                46,
                'PSDA, Moist, Dith, Pipet',
                'PSDA, Moist, Dith, Pipet',
                'PSDAMDITH',
                'SSIR No. 42, version 4, page 52',
                74,
                102,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=102',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                47,
                'PSDA, Moist, NaOAc, Pipet',
                'PSDA, Moist, NaOAc, Pipet',
                'PSDAMNAOAC',
                'SSIR No. 42, version 4, page 51',
                73,
                101,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=101',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                48,
                'PSDA, Moist, NaOH, Pipet',
                'PSDA, Moist, NaOH, Pipet',
                'PSDAMNAOH',
                'SSIR No. 42, version 4, page 53',
                75,
                103,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=103',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                49,
                'PSDA, Moist, Pipet',
                'PSDA, Moist, Pipet',
                'PSDAMST',
                'SSIR No. 42, version 4, page 50',
                72,
                100,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=100',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                50,
                'PSDA, Moist, Ultrasonic, Pipet',
                'PSDA, Moist, Ultrasonic, Pipet',
                'PSDAMULTRA',
                'SSIR No. 42, version 4, page 53',
                76,
                104,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=104',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                51,
                'PSDA, NaOAc, Pipet',
                'PSDA, NaOAc, Pipet',
                'PSDANAOAC',
                'SSIR No. 42, version 4, page 46',
                66,
                94,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=94',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                52,
                'PSDA, NaOH, Pipet',
                'PSDA, NaOH, Pipet',
                'PSDANAOH',
                'SSIR No. 42, version 4, page 47',
                67,
                95,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=95',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                53,
                'PSDA, Air-dry, <2 mm Particles',
                'PSDA, Routine, Pipet',
                'PSDA',
                'SSIR No. 42, version 4, page 41',
                60,
                88,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=88',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                54,
                'PSDA, Ultrasonic, Pipet',
                'PSDA, Ultrasonic, Pipet',
                'PSDAULTRA',
                'SSIR No. 42, version 4, page 47',
                68,
                96,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=96',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                55,
                'PSDA, Water Dispersible, Air-dry',
                'PSDA, Water Dispersible, Air-dry',
                'H2OPSDAAD',
                'SSIR No. 42, version 4, page 49',
                70,
                98,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=98',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                56,
                'PSDA, Water Dispersible, hydrometer, air-dry',
                'PSDA, Water Dispersible, hydrometer, air-dry',
                'H2OHYDRAD',
                'NULL',
                '',
                28,
                '',
                'Does not appear in manual';
INSERT INTO lab_analysis_procedure
            SELECT
                57,
                'PSDA, Water Dispersible, Moist',
                'PSDA, Water Dispersible, Moist',
                'H2OPSDAM',
                'SSIR No. 42, version 4, page 55',
                78,
                106,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=106',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                58,
                'Salt Predict',
                'Salt Prediction, 1:2 (w/v)',
                'PREDICT',
                'SSIR No. 42, version 4, page 277',
                383,
                411,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=411',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                59,
                'Saturated Paste and Soluble Salts',
                'Saturated Paste and Soluble Salts',
                'SATP',
                'SSIR No. 42, version 4, page 278',
                390,
                418,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=418',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                60,
                'Sulfur, Total',
                'Sulfur, Total',
                'TOTS',
                'CMS, LIMS, elementar NCS SSIR No. 42, version 4, page 528',
                464,
                492,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=492',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                61,
                'Surface Area, EGME',
                'Surface Area, EGME',
                'EGME',
                'SSIR No. 42, version 4, page 555',
                819,
                847,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=847',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                62,
                'Clay Mineralogy, TGA',
                'Thermogravimetric Analysis',
                'TGA51',
                'SSIR No. 42, version 4, page 415',
                533,
                561,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=561',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                63,
                'Micromorphology, Thin Section',
                'Thin Section',
                'THINSECT',
                'SSIR No. 42, version 4, page 140',
                181,
                209,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=209',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                64,
                'Total Elemental Analysis',
                'Total Analysis, HF, HNO3, HCl Dissolution',
                'TOTANAL',
                'SSIR No. 42, version 4, page 341',
                456,
                484,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=484',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                65,
                'Water Retention, 0.06 Bar, Pressure-Plate, <2mm',
                'Water Retention, 0.06 Bar, Pressure-Plate, <2mm',
                'H2O.06Br<2',
                'SSIR No. 42, version 4, page 106',
                141,
                169,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=169',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                66,
                'Water Retention, 0.1 Bar, Pressure-Plate, <2mm',
                'Water Retention, 0.1 Bar, Pressure-Plate, <2mm',
                'H2O.1Bar<2',
                'SSIR No. 42, version 4, page 106',
                141,
                169,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=169',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                67,
                'Water Retention, 0.33 Bar, Pressure-Plate, <2mm',
                'Water Retention, 0.33 Bar, Pressure-Plate, <2mm',
                'H2O.33Br<2',
                'SSIR No. 42, version 4, page 106',
                141,
                169,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=169',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                68,
                'Water Retention, 1 Bar, Pressure-Plate, <2mm',
                'Water Retention, 1 Bar, Pressure-Plate, <2mm',
                'H2O1Bar<2',
                'SSIR No. 42, version 4, page 106',
                141,
                169,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=169',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                69,
                'Water Retention, 15 Bar, Pressure-Plate, <2mm',
                'Water Retention, 15 Bar, Pressure-Plate, <2mm',
                'H2O15Bar<2',
                'SSIR No. 42, version 4, page 106',
                165,
                193,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=193',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                70,
                'Water Retention, 2 Bar, Pressure-Plate, <2mm',
                'Water Retention, 2 Bar, Pressure-Plate, <2mm',
                'H2O2Bar<2',
                'SSIR No. 42, version 4, page 106',
                141,
                169,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=169',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                71,
                'Water Retention, ADOD',
                'Water Retention, ADOD',
                'ADOD',
                'SSIR No. 42, version 4, page 132',
                171,
                199,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=199',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                72,
                'Water Retention, Field State',
                'Water Retention, Field State',
                'H2ORETFLD',
                'SSIR No. 42, version 4, page 131',
                169,
                197,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=197',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                73,
                'Clay Mineralogy, X-ray Diffraction',
                'X-ray Diffraction, Thin Film on Glass, Resin Pretreatment',
                'XRAY',
                'SSIR No. 42, version 4, page 399',
                676,
                704,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=704',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                74,
                'Total Nitrogen, Carbon and Sulfur',
                'Total N, C, S',
                'NCS_Tot',
                'SSIR No. 42, version 4, page 347',
                464,
                492,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=492',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                75,
                'Melanic Index',
                'Melanic Index',
                'Melanic',
                'SSIR No. 42, version 4, page 374',
                502,
                530,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=530',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                76,
                'Phosphorus, Mehlich III',
                'Phosphorus, Mehlich III',
                'MEHLICH3P',
                'SSIR No. 42, version 4, page 246',
                340,
                368,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=368',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                77,
                'Trace Elements',
                'Trace Elements (HNO3 + HCl)',
                'TrElem',
                'SSIR No. 42, version 4, page 324',
                445,
                473,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=473',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                78,
                'Major Elements',
                'Major Elements (HF+HNO3+HCl)',
                'MjElem',
                'SSIR No. 42, version 4, page 341',
                456,
                484,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=484',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                79,
                'Nitrogen, Mineralizable (EPA)',
                'Nitrogen, Mineralizable (EPA)',
                'MINTEPA',
                'SSIR No. 42, version 4, page 265',
                365,
                393,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=393',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                80,
                'CEC and Cations, Routine',
                'CEC and Cations, NH4OAc, 2M KCl displacement',
                'CECdNH4',
                'NULL',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                81,
                'Acid Oxalate extraction',
                'Cations, Acid Oxalate Extractable, Optical Density',
                'OXAL',
                'CMS, SSIR No. 42, version 3, page ',
                742,
                770,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=770',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                82,
                'Acid Oxalate extraction',
                'Cations, Acid Oxalate Extractable, Optical Density',
                'OXAL',
                'CMS, SSIR No. 42, version 3, page 279',
                846,
                874,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=874',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                83,
                'Phosphorus, Bray 1',
                'Phosphorus, Bray 1',
                'unknown',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                84,
                'Bulk Density',
                'Bulk Density',
                'unknown',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                85,
                'Bulk Density',
                'Bulk Density, estimated',
                'Dbest',
                'CMS',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                86,
                'Bulk Density, Clod',
                'Bulk Density and Water Retention, Clods',
                'DBH2ORET',
                'CMS, SSIR No. 42, 1972, page 14',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                87,
                'Bulk Density, Clod',
                'Bulk Density and Water Retention, Clods',
                'unknown',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                88,
                'Bulk Density, Clod, Rewet',
                'Bulk Density, Rewet, Clods',
                'unknown',
                'CMS',
                '',
                28,
                '',
                'Patty unsure';
INSERT INTO lab_analysis_procedure
            SELECT
                89,
                'Calcium Carbonate Equivalent, <2mm',
                'Calcium Carbonate Equivalent, H2SO4, <2mm (6E3a)',
                'CACO3',
                'CMS, SSIR No. 42, 1972, page 35',
                933,
                961,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=961',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                90,
                'Calcium Carbonate Equivalent, <2mm',
                'Calcium Carbonate Equivalent, HCl, <2mm, weight gain (6E1d)',
                'CACO3',
                'CMS, SSIR No. 42, 1972, page 34',
                932,
                960,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=960',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                91,
                'Calcium Carbonate Equivalent, <2mm',
                'Calcium Carbonate Equivalent, HCl, <2mm, weight loss (6E1c)',
                'CACO3',
                'CMS, SSIR No. 42, 1972, page 34',
                930,
                958,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=958',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                92,
                'Calcium Carbonate Equivalent, <2mm',
                'Calcium Carbonate Equivalent, HCl, <2mm, manometer (6E1b)',
                'CACO3',
                'CMS, SSIR No. 42, 1972, page 33',
                929,
                957,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=957',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                93,
                'Calcium Carbonate Equivalent, <2mm',
                'Calcium Carbonate Equivalent, HCl, <2mm, manometer, electronic (6E1g)',
                'CACO3',
                'CMS, SSIR No. 42, 1984, page 39',
                370,
                398,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=398',
                'code in name should be changed, went to 4E1a1a1a1';
INSERT INTO lab_analysis_procedure
            SELECT
                94,
                'Calcium Carbonate Equivalent, <2mm',
                'Calcium Carbonate Equivalent, HCl, <2mm, manometric (6E1a)',
                'CACO3',
                'CMS, SSIR No. 42, 1972, page',
                929,
                957,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=957',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                95,
                'Calcium Carbonate Equivalent, <2mm',
                'Calcium Carbonate Equivalent, HCl, <2mm, Warburg (6E1f)',
                'CACO3',
                'CMS, SSIR No. 42, version 3, page 271',
                932,
                960,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=960',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                96,
                'CEC and Cations, BaCl2, pH 8.2',
                'CEC, BaCl2, pH 8.2',
                'CECbacl',
                'CMS, SSIR No. 42, 1972, page 23',
                906,
                934,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=934',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                97,
                'CEC and Cations, KOAc, pH 7.0',
                'CEC, KOAc, pH 7.0',
                'CECkac',
                'CMS, SSIR No. 42, 1972, page 23',
                905,
                933,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=933',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                98,
                'CEC and Cations, NaOAc, pH 8.2',
                'CEC, NaOAc, pH 8.2, centrifuge',
                'CECnac',
                'CMS, SSIR No. 42, 1972, page 23',
                904,
                932,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=932',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                99,
                'CEC and Cations, NH4OAc, pH 7.0',
                'CEC, NH4OAc, pH 7.0, Buchner funnel, direct distillation',
                'CECNH4b',
                'CMS, SSIR No. 42, 1972, page 22',
                903,
                931,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=931',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                100,
                'CEC and Cations, NH4OAc, pH 7.0',
                'CEC, NH4OAc, pH 7.0',
                'unknown',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                101,
                'CEC and Cations, NH4OAc, pH 7.0',
                'CEC, NH4OAc, pH 7.0, leaching tube, direct distillation',
                'CECNH4l',
                'CMS, SSIR No. 42, 1972, page 24',
                907,
                935,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=935',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                102,
                'CEC and Cations, NH4OAc, pH 7.0',
                'CEC, NH4OAc, pH 7.0, automatic extractor',
                'CECNH4ae',
                'CMS, SSIR No. 42, 1984, page 29',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                103,
                'CEC and Cations, NH4OAc, pH 7.0',
                'CEC, NH4OAc, pH 7.0, automatic extractor, direct distillation',
                'CECNH4aed',
                'CMS, SSIR No. 42, 1984, page 30',
                908,
                936,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=936',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                104,
                'CEC and Cations, NH4OAc, pH 7.0',
                'CEC, NH4OAc, pH 7.0,  automatic extractor, steam distillation I',
                'CECNH4aes',
                'CMS, SSIR No. 42, 1984, page 30',
                827,
                855,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=855',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                105,
                'Dithionite-Citrate Extract',
                'Cations, Dithionite-Citrate Extractable',
                'unknown',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                106,
                'Dithionite-Citrate Extract',
                'Cations, Dithionite-Citrate Extractable',
                'DITH',
                'CMS, SSIR No. 42, 1972, page 31',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                107,
                'Dithionite-Citrate Extract',
                'Cations, Dithionite-Citrate Extractable',
                'DITH',
                'CMS, SSIR No. 42, 1984, page 37',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                108,
                'Dithionite-Citrate Extract',
                'Cations, Dithionite-Citrate Extractable',
                'DITH',
                'CMS, SSIR No. 42, version 3, page 233',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                109,
                'Dithionite-Citrate Extract',
                'Cations, Dithionite-Citrate Extractable',
                'DITH',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                110,
                'Dithionite-Citrate Extract',
                'Cations, Dithionite-Citrate Extractable',
                'DITH',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                111,
                'Dithionite-Citrate Extract',
                'Cations, Dithionite-Citrate Extractable',
                'DITH',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                112,
                'Extractable Acidity, BaCl2-TEA',
                'Extractable Acidity, BaCl2-Triethanolamine I',
                'EXTRACID',
                'CMS, SSIR No. 1, 1972, page 38',
                943,
                971,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=971',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                113,
                'Extractable Acidity, BaCl2-TEA',
                'Extractable Acidity, BaCl2-Triethanolamine II',
                'EXTRACID',
                'CMS, SSIR No. 1, 1972, page 38',
                '',
                28,
                '',
                'This method is not in the manual (6H2b)';
INSERT INTO lab_analysis_procedure
            SELECT
                114,
                'Extractable Acidity, BaCl2-TEA',
                'Extractable Acidity, BaCl2-Triethanolamine III',
                'EXTRACID',
                'CMS, SSIR No. 1, 1984, page 45',
                946,
                974,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=974',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                115,
                'Extractable Acidity, BaCl2-TEA',
                'Extractable Acidity, BaCl2-Triethanolamine IV, automatic extractor',
                'EXTRACID',
                'CMS, SSIR No. 1, 1984, page 45',
                903,
                931,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=931',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                116,
                'Extractable Acidity, BaCl2-TEA',
                'Extractable Acidity, BaCl2-Triethanolamine',
                'unknown',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                117,
                'Gypsum, <2mm',
                'Gypsum',
                'unknown',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                118,
                'Gypsum, <2mm',
                'Gypsum, indirect estimate, Ca & SO4',
                'GYPSUM',
                'CMS, SSIR No. 42, 1972, page 36',
                936,
                964,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=964',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                119,
                'Gypsum, <2mm',
                'Gypsum, weight loss',
                'GYPSUM',
                'CMS, SSIR No. 42, 1984, page 41',
                936,
                964,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=964',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                120,
                'Gypsum, <2mm',
                'Gypsum, ion chromatograph',
                'GYPSUM',
                'CMS, SSIR No. 42, 1984, page 41',
                935,
                963,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=963',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                121,
                'Gypsum, <2mm',
                'Gypsum, H2O Extraction, Acetone Precipitation, <2mm',
                'GYPSUM',
                'CMS, SSIR No. 42, 1972, page 35 duplicate delete',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                122,
                'Major Elements',
                'Major Elements',
                'unknown',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                123,
                'Major Elements',
                'Major Elements (HF dissolution, AA)',
                'MjElem',
                'CMS, SSIR No. 42, 1984, page 60',
                '',
                28,
                '',
                'no method was written';
INSERT INTO lab_analysis_procedure
            SELECT
                124,
                'Major Elements',
                'Major Elements (HFdissolution, ICP)',
                'MjElem',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                125,
                'Fiber Analysis',
                'Organic Fiber Analysis',
                'unknown',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                126,
                'KCl Extract',
                'Cations, Potassium Chloride Extractable',
                'unknown',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                127,
                'KCl Extract, Al',
                'Cations, Potassium Chloride Extractable I (6G1b)',
                'AL_KCL',
                'CMS, SSIR No. 1, 1972, page 36',
                939,
                967,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=967',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                128,
                'KCl Extract, Al',
                'Cations, Potassium Chloride Extractable II, overnight (6G2a)',
                'AL_KCL',
                'CMS, SSIR No. 1, 1972, page 37',
                940,
                968,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=968',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                129,
                'KCl Extract, Al',
                'Cations, Potassium Chloride Extractable, 1N, automatic extractor, AA (6G9a)',
                'AL_KCL',
                'CMS, SSIR No. 1, 1984, page 43',
                858,
                886,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=886',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                130,
                'KCl Extract',
                'Cations, Potassium Chloride Extractable, 1 N, automatic extractor< ICP',
                'KCL',
                'CMS, SSIR No. 42, 1984, page 43',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                131,
                'Organic Carbon',
                'Organic Carbon, acid dichromate digestion, FeSO4 titration',
                'WBC1',
                'CMS, SSIR No. 42, 1972, page 26',
                911,
                939,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=939',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                132,
                'Organic Carbon',
                'Organic Carbon, acid dichromate digestion, CO2 evolution, gravimetric',
                'ALLI',
                'CMS, SSIR No. 42, 1972, page 26',
                912,
                940,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=940',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                133,
                'Organic Carbon',
                'Organic Carbon, acid dichromate digestion, FeSO4 titration, automatic titrator',
                'WBC2',
                'CMS, SSIR No. 42, 1984, page 34',
                '',
                28,
                '',
                'Code not in manual (6A1c)';
INSERT INTO lab_analysis_procedure
            SELECT
                134,
                'Organic Carbon',
                'Organic Carbon, 6A',
                'unknown',
                'CMS',
                '',
                28,
                '',
                'Patty says this should be called "Reactive Carbon"';
INSERT INTO lab_analysis_procedure
            SELECT
                135,
                'pH, KCl',
                'pH, 1:1 1N KCl, automated system',
                'PHKCL',
                'CMS, SSIR No. 42, version 3, page 419',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                136,
                'pH, KCl',
                'pH, 1N KCl',
                'unknown',
                'CMS, SSIR No. 42, 1972, page 59',
                992,
                1020,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=1020',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                137,
                'pH, H2O',
                'pH, 1:1 Water',
                'pHH2O',
                'CMS, SSIR No. 42, 1972, page 59',
                992,
                1020,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=1020',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                138,
                'pH, H2O',
                'pH, 1:1 Water',
                'unknown',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                139,
                'pH, CaCl2',
                'pH,  1:2 0.01M CaCl2',
                'pHcacl',
                'CMS, SSIR No. 42, 1972, page 60',
                992,
                1020,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=1020',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                140,
                'pH, CaCl2',
                'pH,  1:2 0.01M CaCl2',
                'unknown',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                141,
                'pH, 1:10 H2O',
                'pH, 1:10 Water',
                'pHh2o10',
                'CMS',
                992,
                1020,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=1020',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                142,
                'pH, 1:10 CaCl2',
                'pH,  1:10 0.01M CaCl2',
                'pHcacl10',
                'CMS',
                276,
                304,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=304',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                143,
                'Phosphorus Adsorption Coefficient',
                'Phosphorus Adsorption Coefficient',
                'PCoeff',
                'CMS, SSIR No. 42, 1984, page 52',
                974,
                1002,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=1002',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                144,
                'PSDA, Air-dry, <2 mm Particles',
                'PSDA, Air-dry, <2 mm Particles',
                'unknown',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                145,
                'Sample Preparation',
                'Bulk Sample Preparation',
                'unknown',
                'CMS',
                '',
                28,
                '',
                'Patty unsure';
INSERT INTO lab_analysis_procedure
            SELECT
                146,
                'Saturated Paste and Soluble Salts',
                'Saturated Paste and Soluble Salts',
                'unknown',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                147,
                'Saturated Paste and Soluble Salts',
                'Saturated Paste and Soluble Salts',
                'SATP',
                'CMS, SSIR No. 42, 1972, page 57',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                148,
                'Na-Pyrophosphate Extract',
                'Cations, Pyrophosphate Extractable',
                'unknown',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                149,
                'Na-Pyrophosphate Extract',
                'Cations, Pyrophosphate Extractable I',
                'PYRO',
                'CMS, SSIR No. 42, 1972, page 32',
                '',
                28,
                '',
                'Retired instrument, no method written';
INSERT INTO lab_analysis_procedure
            SELECT
                150,
                'Na-Pyrophosphate Extract',
                'Cations, Pyrophosphate Extractable II',
                'PYRO',
                'CMS, SSIR No. 42, 1984, page 38',
                '',
                28,
                '',
                'Retired instrument, no method written';
INSERT INTO lab_analysis_procedure
            SELECT
                151,
                'Na-Pyrophosphate Extract',
                'Cations, Pyrophosphate Extractable III',
                'PYRO',
                'CMS, SSIR No. 42, version 3, page 247',
                '',
                28,
                '',
                'Retired instrument, no method written';
INSERT INTO lab_analysis_procedure
            SELECT
                152,
                'Surface Area',
                'Surface Area, EGME',
                'unknown',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                153,
                'Surface Area',
                'Surface Area, EGME',
                'EGME',
                'CMS, SSIR No. 42, version 3, page 393',
                819,
                847,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=847',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                154,
                'Surface Area',
                'Surface Area, ethylene glycol',
                'unknown',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                155,
                'Surface Area',
                'Surface Area, ethylene glycol',
                'SAEG',
                'CMS, SSIR No. 42, 1972, page 56',
                988,
                1016,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=1016',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                156,
                'Carbon, Total',
                'Total Carbon, dry combustion, CO2 evolution I, gravimetric',
                'TOTC',
                'CMS, SSIR No. 42, 1972, page 27',
                914,
                942,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=942',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                157,
                'Carbon, Total',
                'Total Carbon, dry combustion, CO2 evolution II, gravimetric',
                'TOTC',
                'CMS, SSIR No. 42, 1972, page 27',
                915,
                943,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=943',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                158,
                'Carbon, Total',
                'Total Carbon, dry combustion, CO2 evolution III',
                'TOTC',
                'CMS, SSIR No. 42, 1984, page 35',
                915,
                943,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=943',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                159,
                'Carbon, Total',
                'Total Carbon, dry combustion, CO2 evolution IV',
                'TOTC',
                'CMS, SSIR No. 42, version 1, page 238',
                836,
                864,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=864',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                160,
                'Carbon, Total',
                'Total Carbon, dry combustion, CO2 evolution V',
                'TOTC',
                'CMS, SSIR No. 42, version 3, page 223',
                713,
                741,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=741',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                161,
                'Nitrogen, Total',
                'Total Nitrogen, Kjeldahl digestion, ammonia distillation',
                'TOTN',
                'CMS, SSIR No. 42, 1972, page 29',
                918,
                946,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=946',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                162,
                'Nitrogen, Total',
                'Total Nitrogen, semimicro Kjeldahl, ammonia distillation',
                'TOTN',
                'CMS, SSIR No. 42, 1972, page 29',
                920,
                948,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=948',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                163,
                'Nitrogen, Total',
                'Total Nitrogen, Kjeldahl digestion I, ammonia distillation, automatic titrator',
                'TOTN',
                'CMS, SSIR No. 42, 1984, page 36',
                918,
                946,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=946',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                164,
                'Nitrogen, Total',
                'Total Nitrogen, Kjeldahl digestion II, ammonia steam distillation, automatic titrator',
                'TOTN',
                'CMS, SSIR No. 42, 184, page 36',
                838,
                866,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=866',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                165,
                'Nitrogen, Total',
                'Total Nitrogen, dry combustion, N2 Evolution',
                'TOTN',
                'CMS, SSIR No. 42, version 3, page 227',
                716,
                744,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=744',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                166,
                'Nitrogen, Total',
                'Nitrogen, Kjeldahl Digestion III, Ammonia Steam Distillation',
                'TOTN',
                'CMS',
                718,
                746,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=746',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                167,
                'Nitrogen, Total',
                'Total Nitrogen',
                'unknown',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                168,
                'Phosphorus, Total',
                'Total Phosphorus, perchloric acid digestion',
                'TotP',
                'CMS, SSIR No. 42, 1972, page 49',
                973,
                1001,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=1001',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                169,
                'Sulfur, Total',
                'Sulfur, Total, SO2 evolution, KIO3 titration',
                'TOTS',
                'CMS, SSIR No. 42, 1984, page 51',
                971,
                999,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=999',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                170,
                'Sulfur, Total',
                'Sulfur, Total, SO2 evolution, infrared I',
                'TOTS',
                'CMS, SSIR No. 42, version 1, page 215',
                871,
                899,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=899',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                171,
                'Sulfur, Total',
                'Sulfur, Total',
                'unknown',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                172,
                'Water Retention, ADOD',
                'Water Retention, <2mm, air-dry/ovendry ratio',
                'ADOD',
                'CMS, SSIR No. 42, 1984, page 24',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                173,
                'Water Retention, ADOD',
                'Water Retention, <2mm, air-dry/ovendry ratio',
                'unknown',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                174,
                'Water Retention, FMOD',
                'Water Retention, <2mm, moist/ovendry ratio',
                'FMOD',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                175,
                'Water Retention, 15 Bar, <2mm, air-dry',
                'Water Retention, 15 Bar, Pressure-Plate, <2mm, air-dry',
                'H2O15ba<2',
                'CMS, SSIR No. 42, 1972, page 17',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                176,
                'Water Retention, 15 Bar, <2mm, air-dry',
                'Water Retention, 15 Bar, Pressure-Plate, <2mm, air-dry',
                'unknown',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                177,
                'Water Retention, 15 Bar, <2mm, moist',
                'Water Retention, 15 Bar, Pressure-Plate, <2mm, moist',
                'H2O15bm<2',
                'CMS, SSIR No. 42, 1972, page 17',
                165,
                193,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=193',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                178,
                'Water Retention, 15 Bar, <2mm, moist',
                'Water Retention, 15 Bar, Pressure-Plate, <2mm, moist',
                'unknown',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                179,
                'Water Retention, 0.06 Bar, <2mm',
                'Water Retention, <2mm air-dry, 0.06, 0.1, or 2 bar, pressure-plate extraction',
                'H2O.06Br<2',
                'CMS, SSIR No. 42, 1984, page 23',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                180,
                'Water Retention, 0.1 Bar, <2mm',
                'Water Retention, <2mm air-dry, 0.06, 0.1, or 2 bar, pressure-plate extraction',
                'H2O.1Bar<2',
                'CMS, SSIR No. 42, 1984, page 23',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                181,
                'Water Retention, 2 Bar, <2mm',
                'Water Retention, <2mm air-dry, 0.06, 0.1, or 2 bar, pressure-plate extraction',
                'H2O2Bar<2',
                'CMS, SSIR No. 42, 1984, page 23',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                182,
                'Water Retention, 1 Bar, <2mm',
                'Water Retention, <2mm air-dry, 0.06, 0.1, or 2 bar, pressure-plate extraction',
                'H2O1Bar<2',
                'CMS, SSIR No. 42, version 1, page 152',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                183,
                'Water Retention, 2 Bar, <2mm',
                'Water Retention, <2mm air-dry, 0.06, 0.1, or 2 bar, pressure-plate extraction',
                'H2O2Bar<2',
                'CMS, SSIR No. 42, 1984, page 23',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                184,
                'Water Retention, 0.33 Bar, clod',
                'Water Retention, clod, 0.06, 0.1, 0.33, or 1 bar, pressure-plate extraction',
                'H2O.33bclod',
                'CMS, SSIR No. 42, 1984, page 23',
                144,
                172,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=172',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                185,
                'Water Retention, 0.33 Bar, clod, rewet',
                'Water Retention, 0.33 Bar, Pressure-Plate, clod, rewet',
                'H2O.33bcrw',
                'CMS, SSIR No. 42, 1984, page 23',
                155,
                183,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=183',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                186,
                'Water Retention, 0.33 Bar, clod',
                'Water Retention, 0.33 Bar, Pressure-Plate, clod',
                'unknown',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                187,
                'Water Retention, Field State',
                'Water Retention, Field State, clod',
                'H2OFSclod',
                'CMS, SSIR No. 42, 1972, page 17',
                101,
                129,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=129',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                188,
                'Water Retention, Field State',
                'Water Retention, Field State, clod',
                'unknown',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                189,
                'Clay Mineralogy, X-ray Diffraction',
                'X-ray Diffraction, Thin Film on Glass, Resin Pretreatment I',
                'XRAY',
                'CMS 7A2b',
                982,
                1010,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=1010',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                190,
                'Clay Mineralogy, X-ray Diffraction',
                'X-ray Diffraction, Thin Film on Glass, Resin Pretreatment II',
                'XRAY',
                'CMS',
                801,
                829,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=829',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                191,
                'Index of Accumulation',
                'Index of Accumulation - 8D7',
                'IndxAcc',
                'CMS',
                824,
                852,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=852',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                192,
                'Derived',
                'Ratio, to Total Clay - 8D1',
                'none',
                'CMS',
                179,
                207,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=207',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                193,
                'Derived',
                'Ratio, to Total Clay - 8D1b',
                'none',
                'CMS',
                '',
                28,
                '',
                'crossed out by patty';
INSERT INTO lab_analysis_procedure
            SELECT
                194,
                'Calcium Carbonate Equivalent, 2-20mm',
                'Calcium Carbonate Equivalent, HCl, 2-20mm',
                'CACO3_20',
                'CMS',
                370,
                398,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=398',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                195,
                'KCl Extract, Al',
                'Cations, Potassium Chloride Extractable, 1 N, automatic extractor, ICP II (6G9c)',
                'AL_KCL',
                'CMS, SSIR No. 42, version 3, page 259',
                749,
                777,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=777',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                196,
                'KCl Extract, Al',
                'Cations, Potassium Chloride Extractable, 1N, automatic extractor, AA II (6G9d)',
                'AL_KCL',
                'CMS, SSIR No. 42, version 3, page 265',
                755,
                783,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=783',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                197,
                'KCl Extract, Al',
                'Cations, Potassium Chloride Extractable, 1 N, automatic extractor, ICP I (6G9b)',
                'AL_KCL',
                'CMS, SSIR No. 42, version 3, page 549',
                852,
                880,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=880',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                198,
                'CEC and Cations, Routine',
                'CEC and Cations, NH4OAc, 2M KCl displacement',
                'CECdNH4',
                'CMS, duplicate SSIR No. 42, version 4, page 173',
                230,
                258,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=258',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                199,
                'Na-Pyrophosphate Extract',
                'Cations, Pyrophosphate Extractable IV',
                'PYRO',
                'CMS',
                '',
                28,
                '',
                'Retired instrument, no method written';
INSERT INTO lab_analysis_procedure
            SELECT
                200,
                'Na-Pyrophosphate Extract',
                'Cations, Pyrophosphate Extractable V',
                'PYRO',
                'CMS',
                '',
                28,
                '',
                'Retired instrument, no method written';
INSERT INTO lab_analysis_procedure
            SELECT
                201,
                'Dithionite-Citrate Extract',
                'Cations, Dithionite-Citrate Extractable, AA VII',
                'DITH',
                'CMS',
                '',
                28,
                '',
                'Retired instrument, no method written';
INSERT INTO lab_analysis_procedure
            SELECT
                202,
                'Dithionite-Citrate Extract',
                'Cations, Dithionite-Citrate Extractable, AA VIII',
                'DITH',
                'CMS',
                '',
                28,
                '',
                'Retired instrument, no method written';
INSERT INTO lab_analysis_procedure
            SELECT
                203,
                'New Zealand Phosphorus Retention',
                'Phosphorus, New Zealand P Retention I',
                'NZPRET',
                'CMS',
                792,
                820,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=820',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                204,
                'New Zealand Phosphorus Retention',
                'Phosphorus, New Zealand P Retention II',
                'NZPRET',
                'CMS',
                792,
                820,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=820',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                205,
                'New Zealand Phosphorus Retention',
                'Phosphorus, New Zealand P Retention III',
                'NZPRET',
                'CMS',
                '',
                28,
                '',
                'no method code like this in manual, instrument changes';
INSERT INTO lab_analysis_procedure
            SELECT
                206,
                'New Zealand Phosphorus Retention',
                'Phosphorus, New Zealand P Retention IV',
                'NZPRET',
                'CMS',
                '',
                28,
                '',
                'no method code like this in manual, instrument changes';
INSERT INTO lab_analysis_procedure
            SELECT
                207,
                'New Zealand Phosphorus Retention',
                'Phosphorus, New Zealand P Retention V',
                'NZPRET',
                'CMS',
                '',
                28,
                '',
                'no method code like this in manual, instrument changes';
INSERT INTO lab_analysis_procedure
            SELECT
                208,
                'Phosphorus, Bray 1',
                'Phosphorus, Bray 1',
                'BRAYP',
                'CMS, duplicate',
                '',
                28,
                '',
                'not in manual';
INSERT INTO lab_analysis_procedure
            SELECT
                209,
                'Phosphorus, Bray 1',
                'Phosphorus, Bray 1',
                'BRAYP',
                'CMS',
                '',
                28,
                '',
                'not in manual';
INSERT INTO lab_analysis_procedure
            SELECT
                210,
                'Phosphorus, Bray 1',
                'Phosphorus, Bray 1',
                'BRAYP',
                'CMS',
                '',
                28,
                '',
                'not in manual';
INSERT INTO lab_analysis_procedure
            SELECT
                211,
                'Phosphorus, Bray 1',
                'Phosphorus, Bray 1',
                'BRAYP',
                'CMS',
                '',
                28,
                '',
                'not in manual';
INSERT INTO lab_analysis_procedure
            SELECT
                212,
                'Phosphorus, Bray 1',
                'Phosphorus, Bray 1',
                'BRAYP',
                'CMS',
                '',
                28,
                '',
                'not in manual';
INSERT INTO lab_analysis_procedure
            SELECT
                213,
                'pH, NaF',
                'pH, 1N NaF, moist',
                'PHNAF',
                'CMS, moist',
                '',
                28,
                '',
                'obsolete method code should appear on p. 992, but it isnt included.  Current method is 4C*, and appears on 267';
INSERT INTO lab_analysis_procedure
            SELECT
                214,
                'Clay Mineralogy, TGA',
                'Thermogravimetric Analysis, TGA III',
                'TGA51',
                'CMS 7A4c',
                '',
                28,
                '',
                'no method code like this in manual (current/obselete)';
INSERT INTO lab_analysis_procedure
            SELECT
                216,
                'Organic Carbon',
                'Organic Carbon, acid dichromate digestion, FeSO4 titration, automatic titrator, moist',
                'WBC2',
                'CMS',
                '',
                28,
                '',
                'not in manual';
INSERT INTO lab_analysis_procedure
            SELECT
                217,
                'Sulfur, Total',
                'Total Sulfur, SO2 evolution, infrared II',
                'TOTS',
                'SSIR No. 42, version 3, page 317',
                785,
                813,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=813',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                218,
                'Water Retention, 2 Bar, clod',
                'Water Retention, 2 Bar, Pressure-Plate, clod',
                'H2O2bclod',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                219,
                'Clay Mineralogy, DSC',
                'Differential Scanning Calorimetry, Thermal Analyzer II',
                'DSC910S',
                'CMS',
                882,
                910,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=910',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                220,
                'Clay Mineralogy, TGA',
                'Thermogravimetric Analysis',
                'TGA51',
                'CMS 7A4b',
                887,
                915,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=915',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                221,
                'Extractable Cations',
                'CEC and Cations, NH4OAc, pH 7.0, AA I',
                'ExCat1',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                222,
                'Extractable Cations',
                'CEC and Cations, NH4OAc, pH 7.0, AA II',
                'ExCat2',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                223,
                'Extractable Cations',
                'CEC and Cations, NH4OAc, pH 7.0, AA III',
                'ExCat3',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                224,
                'Extractable Cations',
                'CEC and Cations, NH4OAc, pH 7.0, AA IV',
                'ExCat4',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                225,
                'Extractable Cations',
                'CEC and Cations, NH4OAc, pH 7.0, AA V',
                'ExCat5',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                226,
                'Extractable Cations',
                'CEC and Cations, NH4OAc, pH 7.0, AA VI',
                'ExCat6',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                227,
                'Soluble Anions, CO3',
                'Carbonate, Saturated Paste and Soluble Salts, titration',
                'SatAn1',
                'CMS',
                415,
                443,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=443',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                228,
                'Soluble Anions',
                'Chloride, Saturation Extraction, Anion Chromatograph',
                'SatAn2',
                'CMS',
                864,
                892,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=892',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                229,
                'Soluble Anions',
                'Chloride, Saturation Extraction, Anion Chromatograph, Ionic Suppressor',
                'SatAn3',
                'CMS',
                760,
                788,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=788',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                230,
                'Soluble Anions',
                'Chloride, Saturation Extraction, Flow Injection, Automated Ion Analyzer',
                'SatAn4',
                'CMS',
                760,
                788,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=788',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                231,
                'Soluble Anions',
                'Chloride, Saturation Extraction, Anion Chromatograph, Electronic Ion Suppressor',
                'SatAn5',
                'CMS',
                760,
                788,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=788',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                232,
                'Saturated Paste and Soluble Salts',
                'Saturated Paste and Soluble Salts, EC',
                'SATPEC1',
                'CMS',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                233,
                'Saturated Paste and Soluble Salts',
                'Saturated Paste and Soluble Salts, EC cap rise',
                'SATPEC2',
                'CMS',
                989,
                1017,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=1017',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                234,
                'Saturated Paste and Soluble Salts',
                'Saturated Paste and Soluble Salts, AA I',
                'SatxAA1',
                'CMS',
                '',
                28,
                '',
                'retired instrument, no method written';
INSERT INTO lab_analysis_procedure
            SELECT
                235,
                'Saturated Paste and Soluble Salts',
                'Saturated Paste and Soluble Salts, AA II',
                'SatxAA2',
                'CMS',
                '',
                28,
                '',
                'retired instrument, no method written';
INSERT INTO lab_analysis_procedure
            SELECT
                236,
                'Saturated Paste and Soluble Salts',
                'Saturated Paste and Soluble Salts, ICP',
                'SatxICP',
                'CMS',
                '',
                28,
                '',
                'temporary method (3 months while AA was broken), not in manual';
INSERT INTO lab_analysis_procedure
            SELECT
                237,
                'Bulk Density, Reconstituted, Moist',
                'Bulk Density, Reconstituted, Moist',
                'DBRECON_M',
                'CMS',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                242,
                'Derived',
                'derived AL_SAT, 5G1b',
                'none',
                'CMS',
                '',
                28,
                '',
                'crossed out by patty';
INSERT INTO lab_analysis_procedure
            SELECT
                243,
                'Derived',
                'derived AL_SAT, 5G1',
                'none',
                'CMS',
                264,
                292,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=292',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                244,
                'Derived',
                'derived BSECAT, 5C3b',
                'none',
                'CMS',
                264,
                292,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=292',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                245,
                'Derived',
                'derived BSECAT, 5C3',
                'none',
                'CMS',
                '',
                28,
                '',
                'crossed out by patty';
INSERT INTO lab_analysis_procedure
            SELECT
                246,
                'Derived',
                'derived BSESAT, 5C1',
                'none',
                'CMS',
                262,
                290,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=290',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                247,
                'Derived',
                'derived CEC_SUM, 5A3c',
                'none',
                'CMS',
                '',
                28,
                '',
                'crossed out by patty';
INSERT INTO lab_analysis_procedure
            SELECT
                248,
                'Derived',
                'derived CEC_SUM, 5A3a',
                'none',
                'CMS',
                228,
                256,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=256',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                249,
                'Derived',
                'derived COLE, 4D1',
                'none',
                'CMS',
                175,
                203,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=203',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                250,
                'Derived',
                'derived ECEC, 5A3d',
                'none',
                'CMS',
                228,
                256,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=256',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                251,
                'Derived',
                'derived ECEC, 5A3b',
                'none',
                'CMS',
                '',
                28,
                '',
                'crossed out by patty';
INSERT INTO lab_analysis_procedure
            SELECT
                252,
                'Derived',
                'derived est total salts, 8D5',
                'none',
                'CMS',
                420,
                448,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=448',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                253,
                'Derived',
                'derived NA_EXCH, 5D2',
                'none',
                'CMS',
                418,
                446,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=446',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                254,
                'Derived',
                'derived SAR, 5E',
                'none',
                'CMS',
                419,
                447,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=447',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                255,
                'Derived',
                'derived WRD, 4C1b',
                'none',
                'CMS',
                '',
                28,
                '',
                'crossed out by patty';
INSERT INTO lab_analysis_procedure
            SELECT
                256,
                'Derived',
                'derived WRD, 4C1',
                'none',
                'CMS',
                117,
                145,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=145',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                257,
                'Unknown',
                'Unknown',
                'none',
                'CMS',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                258,
                'Acid Oxalate extraction',
                'Cations, Acid Oxalate Extractable, Aluminum',
                'OXAL',
                'CMS',
                742,
                770,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=770',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                259,
                'Acid Oxalate extraction',
                'Cations, Acid Oxalate Extractable, Iron',
                'OXAL',
                'CMS',
                846,
                874,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=874',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                260,
                'Acid Oxalate extraction',
                'Cations, Acid Oxalate Extractable, Silica',
                'OXAL',
                'CMS',
                742,
                770,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=770',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                261,
                'Acid Oxalate extraction',
                'Cations, Acid Oxalate Extractable, Aluminum',
                'OXAL',
                'CMS, SSIR No. 42, version 3, page ',
                742,
                770,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=770',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                262,
                'Acid Oxalate extraction',
                'Cations, Acid Oxalate Extractable, Iron',
                'OXAL',
                'CMS, SSIR No. 42, version 3, page ',
                742,
                770,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=770',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                263,
                'Acid Oxalate extraction',
                'Cations, Acid Oxalate Extractable, Silica',
                'OXAL',
                'CMS, SSIR No. 42, version 3, page ',
                742,
                770,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=770',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                264,
                'Acid Oxalate extraction',
                'Cations, Acid Oxalate Extractable, Aluminum',
                'OXAL',
                'CMS, SSIR No. 42, version 3, page 279',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                265,
                'Acid Oxalate extraction',
                'Cations, Acid Oxalate Extractable, Iron',
                'OXAL',
                'CMS, SSIR No. 42, version 3, page 279',
                '',
                28,
                '',
                'method code (6C9c) not in current or obsolete, there is no 6C9c, it stopped at b';
INSERT INTO lab_analysis_procedure
            SELECT
                266,
                'Acid Oxalate extraction',
                'Cations, Acid Oxalate Extractable, Silica',
                'OXAL',
                'CMS, SSIR No. 42, version 3, page 279 (should be 253?)',
                '',
                28,
                '',
                'not in current or obsolete';
INSERT INTO lab_analysis_procedure
            SELECT
                267,
                'Acid Oxalate extraction',
                'Cations, Acid Oxalate Extractable, Manganese',
                'OXAL',
                'CMS, SSIR No. 42, version 3, page 279',
                742,
                770,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=770',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                268,
                'Acid Oxalate extraction',
                'Cations, Acid Oxalate Extractable, Phosphorus',
                'OXAL',
                'CMS, SSIR No. 42, version 3, page 279',
                742,
                770,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=770',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                269,
                'Organic Carbon',
                'Organic Carbon, 6A1',
                'unknown',
                'CMS',
                652,
                680,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=680',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                270,
                'Organic Carbon',
                'Organic Carbon, Peroxide Digestion, Weight Loss',
                'unknown',
                'CMS, SSIR No. 1, 1972, page 29',
                917,
                945,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=945',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                271,
                'Bulk Density, <2mm Fraction, Air-dry',
                'Bulk Density, Air-Dry',
                'unknown',
                'SSIR No. 1, version 1974, page 15',
                899,
                927,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=927',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                272,
                'Bulk Density, <2mm Fraction, 1/3 Bar',
                'Bulk Density, 30-cm Absorption',
                'unknown',
                'SSIR No. 1, version 1974, page 15',
                899,
                927,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=927',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                273,
                'Bulk Density, <2mm Fraction, 1/3 Bar',
                'Bulk Density, 1/3-Bar Desorption I',
                'unknown',
                'SSIR No. 42, version 3, page 121',
                899,
                927,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=927',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                274,
                'Bulk Density, <2mm Fraction, 1/3 Bar',
                'Bulk Density, 1/3-Bar Desorption II',
                'unknown',
                'SSIR No. 1, version 1974, page 15',
                899,
                927,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=927',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                275,
                'Bulk Density, <2mm Fraction, 1/3 Bar',
                'Bulk Density, 1/3-Bar Desorption III',
                'unknown',
                'SSIR No. 1, version 1974, page 15',
                899,
                927,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=927',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                277,
                'Bulk Density, <2mm Fraction, Ovendry',
                'Bulk Density, Oven-Dry',
                'unknown',
                'SSIR No. 42, version 3, page 127',
                896,
                924,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=924',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                278,
                'Water Retention, 0.1 or 0.33 bar, soil pieces',
                'Water Retention, 0.1 or 0.33 bar, Soil Pieces',
                'unknown',
                'SSIR No. 1, version 1974, page 16',
                900,
                928,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=928',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                279,
                'Water Retention, cores, 0.06, 0.1, 0.33, or 1 Bar, pressure-plate extraction',
                'Water Retention, cores, 0.06, 0.1, 0.33, or 1 bar, pressure-plate extraction',
                'unknown',
                'SSIR No. 1, version 1974, page 17',
                150,
                178,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=178',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                280,
                'Water Retention, Water Content <2mm, 1 or 2 Bar, moist',
                'Water Retention, Water Content <2mm, 1 or 2 Bar, moist',
                'unknown',
                'no desc',
                '',
                28,
                '',
                'no code like that (4B1f) in obsolete or current';
INSERT INTO lab_analysis_procedure
            SELECT
                281,
                'Water Retention, Sand-Table Absorption',
                'Water Retention, Sand-Table Absorption',
                'unknown',
                'SSIR No. 1, version 1974, page 17',
                901,
                929,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=929',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                282,
                'Aggregate Stability, moist',
                'Aggregate Stability, Wet Sieving, 1-2 mm, moist',
                'unknown',
                'no desc',
                '',
                28,
                '',
                'method (4G1b) not in obsolete or current; no method for moist ag stab 1-2mm in manual';
INSERT INTO lab_analysis_procedure
            SELECT
                283,
                'Atterberg Limits moist',
                'Atterberg Limits, NSMC Lab, moist',
                'unknown',
                'no desc',
                218,
                246,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=246',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                284,
                'Calcium Carbonate Equivalent, <2mm',
                'Calcium Carbonate, HCl Treatment',
                'CACO3',
                'SSIR No. 42, version 3, page 271',
                929,
                957,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=957',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                285,
                'Calcium Carbonate Equivalent, <2mm',
                'Calcium Carbonate, Sensitive Qualitative Method, Visual, Gas Bubbles',
                'CACO3',
                'SSIR No. 1, version 1974, page 35',
                933,
                961,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=961',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                286,
                'Calcium Carbonate Equivalent, <2mm',
                'Calcium Carbonate, HCl Treatment, Titrimetric',
                'CACO3',
                'SSIR No. 1, version 1974, page 34',
                932,
                960,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=960',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                287,
                'Extractable Acidity, BaCl2-TEA',
                'Extractable Acidity, BaCl2-Triethanolamine II, Back-Titration with HCl',
                'EXTRACID',
                'CMS, SSIR No. 1, 1972, page 38',
                944,
                972,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=972',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                288,
                'Extractable Acidity, BaCl2-TEA',
                'Extractable Acidity, KCl-Triethanolamine II, Back-Titration with NaOH',
                'EXTRACID',
                'CMS, SSIR No. 1, 1972, page 38',
                945,
                973,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=973',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                289,
                'Total Elemental Analysis',
                'Total Analysis, Na2CO3 Fusion',
                'TOTANAL',
                'SSIR No. 42, version 3, page 667',
                987,
                1015,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=1015',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                290,
                'Mineral Content',
                'Mineral Content',
                'MINIGNITE',
                'SSIR No. 42, version 3, page 431',
                495,
                523,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=523',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                291,
                'pH, KCl',
                'pH, 1:1 1N KCl, moist',
                'PHKCL',
                'CMS, SSIR No. 42, version 3, page 419, moist',
                992,
                1020,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=1020',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                292,
                'pH, Routine',
                'pH, Routine, 1:1 Water and 1:2 0.01M CaCl2, moist',
                'PHROUT',
                'SSIR No. 42, version 3, page 415, moist',
                992,
                1020,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=1020',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                293,
                'CEC and Cations, NH4OAc, pH 7.0',
                'CEC, NH4OAc, pH 7.0, Buchner funnel, Displacement Distillation',
                'CECNH4b2',
                'CMS, SSIR No. 42, 1972, page 22',
                904,
                932,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=932',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                294,
                'CEC and Cations, NH4OAc, pH 7.0',
                'CEC, NH4OAc, pH 7.0,  automatic extractor, steam distillation II',
                'CECNH4aes2',
                'CMS, SSIR No. 42, 1984, page 30',
                700,
                728,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=728',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                295,
                'CEC and Cations, NH4OAc, pH 7.0',
                'CEC, NH4OAc, pH 7.0,  automatic extractor, steam distillation I, moist',
                'CECNH4aesm1',
                'CMS, SSIR No. 42, 1984, page 30',
                '',
                28,
                '',
                'code (5A8e) not in obsolete or current';
INSERT INTO lab_analysis_procedure
            SELECT
                296,
                'Extractable Cations, Ca',
                'Calcium, NH4OAc Extraction',
                'CaExCat1',
                'CMS, SSIR No. 1, 1972, page 42',
                776,
                804,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=804',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                297,
                'Extractable Cations, Ca',
                'Calcium, NH4OAc Extraction, EDTA-Alcohol Separation',
                'CaExCat2',
                'CMS, SSIR No. 1, 1972, page 42',
                953,
                981,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=981',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                298,
                'Extractable Cations, Ca',
                'Calcium, NH4OAc Extraction, Oxalate-Permanganate I',
                'CaExCat3',
                'CMS, SSIR No. 1, 1972, page 42',
                955,
                983,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=983',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                299,
                'Extractable Cations, Ca',
                'Calcium, NH4OAc Extraction, Oxalate-Permanganate II',
                'CaExCat4',
                'CMS, SSIR No. 1, 1972, page 43',
                956,
                984,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=984',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                300,
                'Extractable Cations, Ca',
                'Calcium, NH4OAc Extraction, Oxalate-Cerate',
                'CaExCat5',
                'CMS, SSIR No. 1, 1972, page 43',
                957,
                985,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=985',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                301,
                'Extractable Cations, Ca',
                'Calcium, NH4OAc Extraction, Atomic Absorption I',
                'CaExCat6',
                'CMS, SSIR No. 42, version 3, page 309',
                776,
                804,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=804',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                302,
                'Extractable Cations, Ca',
                'Calcium, NH4OAc Extraction, Atomic Absorption II',
                'CaExCat7',
                'CMS, SSIR No. 42, version 3, page 313',
                780,
                808,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=808',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                303,
                'Extractable Cations, Ca',
                'Calcium, NH4OAc Extraction, Atomic Absorption I, moist',
                'CaExCat8',
                'CMS, SSIR No. 42, version 3, page 309, moist',
                '',
                28,
                '',
                'not in manual';
INSERT INTO lab_analysis_procedure
            SELECT
                304,
                'Extractable Cations, Ca',
                'Calcium, NH4OAc Extraction, Atomic Absorption II, moist',
                'CaExCat9',
                'CMS, SSIR No. 42, version 3, page 313, moist',
                '',
                28,
                '',
                'not in manual';
INSERT INTO lab_analysis_procedure
            SELECT
                305,
                'Extractable Cations, Ca',
                'Calcium, NH4OAc Extraction, ICP I',
                'CaExCat10',
                'CMS, SSIR No. 42, version 3, page 313, ICP',
                '',
                28,
                '',
                'temporary method, not in manual';
INSERT INTO lab_analysis_procedure
            SELECT
                306,
                'Extractable Cations, Ca',
                'Calcium, NH4OAc Extraction, ICP I, moist',
                'CaExCat11',
                'CMS, SSIR No. 42, version 3, page 313, ICP, moist',
                '',
                28,
                '',
                'temporary method, not in manual';
INSERT INTO lab_analysis_procedure
            SELECT
                307,
                'Soluble Salts, Ca',
                'Calcium, Saturation Extraction, EDTA Titration',
                'CA_SAT1',
                'CMS, SSIR No. 1, 1972, page 41',
                953,
                981,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=981',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                308,
                'Soluble Salts, Ca',
                'Calcium, Saturation Extraction, Atomic Absorption I',
                'CA_SAT2',
                'CMS, SSIR No. 42, version 3, page 301',
                767,
                795,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=795',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                309,
                'Soluble Salts, Ca',
                'Calcium, Saturation Extraction, Atomic Absorption II',
                'CA_SAT3',
                'CMS, SSIR No. 42, version 3, page 305',
                771,
                799,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=799',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                310,
                'Soluble Salts, Ca',
                'Calcium, Saturation Extraction, Atomic Absorption III',
                'CA_SAT4',
                'CMS, SSIR No. 42, version 3, page 305, PE 300AA',
                '',
                28,
                '',
                'not in manual anywhere, instrument change (PE AA300)';
INSERT INTO lab_analysis_procedure
            SELECT
                311,
                'Cations, Neutral Salts, Ca',
                'Calcium, NH4Cl-EtOH Extraction, EDTA Titration',
                'CA_NH4CL1',
                'CMS, SSIR No. 1, 1972, page 44',
                959,
                987,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=987',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                312,
                'KCl Extract, Ca',
                'Calcium, KCl-TEA Extraction, Oxalate-Permanganate',
                'CA_KCL1',
                'CMS, SSIR No. 1, 1972, page 44',
                959,
                987,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=987',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                313,
                'KCl Extract, Ca',
                'Calcium, KCl-TEA Extraction, EDTA Titration',
                'CA_KCL2',
                'CMS, SSIR No. 1, 1972, page 44',
                959,
                987,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=987',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                314,
                'KCl Extract, Ca',
                'Calcium, KCl-TEA Extraction, Atomic Absorption',
                'CA_KCL3',
                'CMS, SSIR No. 1, 1972, page 45',
                960,
                988,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=988',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                315,
                'Soluble Salts, Mg',
                'Magnesium, Saturation Extraction, EDTA Titration',
                'MG_SAT1',
                'CMS, SSIR No. 1, 1972, page 45',
                961,
                989,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=989',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                316,
                'Soluble Salts, Mg',
                'Magnesium, Saturation Extraction, Atomic Absorption I',
                'MG_SAT2',
                'CMS, SSIR No. 1, 1972, page 45',
                767,
                795,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=795',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                317,
                'Soluble Salts, Mg',
                'Magnesium, Saturation Extraction, Atomic Absorption II',
                'MG_SAT3',
                'CMS, SSIR No. 42, version 3, page 305',
                771,
                799,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=799',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                318,
                'Soluble Salts, Mg',
                'Magnesium, Saturation Extraction, Atomic Absorption III',
                'MG_SAT4',
                'CMS, SSIR No. 42, version 3, page 305, PE 300AA',
                '',
                28,
                '',
                'not in manual anywhere, instrument change (PE AA300)';
INSERT INTO lab_analysis_procedure
            SELECT
                319,
                'Extractable Cations, Mg',
                'Magnesium, NH4OAc Extraction',
                'MgExCat1',
                'CMS, SSIR No. 1, 1972, page 45',
                961,
                989,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=989',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                320,
                'Extractable Cations, Mg',
                'Magnesium, NH4OAc Extraction, EDTA-Alcohol Separation',
                'MgExCat2',
                'CMS, SSIR No. 1, 1972, page 45',
                962,
                990,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=990',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                321,
                'Extractable Cations, Mg',
                'Magnesium, NH4OAc Extraction, Phosphate Titration',
                'MgExCat3',
                'CMS, SSIR No. 1, 1972, page 46',
                963,
                991,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=991',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                322,
                'Extractable Cations, Mg',
                'Magnesium, NH4OAc Extraction, Gravimetric',
                'MgExCat4',
                'CMS, SSIR No. 1, 1972, page 46',
                964,
                992,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=992',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                323,
                'Extractable Cations, Mg',
                'Magnesium, NH4OAc Extraction, Atomic Absorption I',
                'MgExCat6',
                'CMS, SSIR No. 42, version 3, page 309',
                776,
                804,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=804',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                324,
                'Extractable Cations, Mg',
                'Magnesium, NH4OAc Extraction, Atomic Absorption II',
                'MgExCat7',
                'CMS, SSIR No. 42, version 3, page 313',
                780,
                808,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=808',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                325,
                'Extractable Cations, Mg',
                'Magnesium, NH4OAc Extraction, Atomic Absorption II, moist',
                'MgExCat8',
                'CMS, SSIR No. 42, version 3, page 309, moist',
                '',
                28,
                '',
                'not in manual';
INSERT INTO lab_analysis_procedure
            SELECT
                326,
                'Extractable Cations, Mg',
                'Magnesium, NH4OAc Extraction, Atomic Absorption I, moist',
                'MgExCat9',
                'CMS, SSIR No. 42, version 3, page 313, moist',
                '',
                28,
                '',
                'not in manual';
INSERT INTO lab_analysis_procedure
            SELECT
                327,
                'Extractable Cations, Mg',
                'Magnesium, NH4OAc Extraction, ICP I',
                'MgExCat10',
                'CMS, SSIR No. 42, version 3, page 313, ICP',
                '',
                28,
                '',
                'not in manual, temporary method';
INSERT INTO lab_analysis_procedure
            SELECT
                328,
                'Extractable Cations, Mg',
                'Magnesium, NH4OAc Extraction, ICP I, moist',
                'MgExCat11',
                'CMS, SSIR No. 42, version 3, page 313, ICP, moist',
                '',
                28,
                '',
                'not in manual, temporary method';
INSERT INTO lab_analysis_procedure
            SELECT
                329,
                'Cations, Neutral Salts, Mg',
                'Magnesium, NH4Cl-EtOH Extraction, EDTA Titration',
                'MG_NH4CL1',
                'CMS, SSIR No. 1, 1972, page 47',
                965,
                993,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=993',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                330,
                'KCl Extract, Mg',
                'Magnesium, KCl-TEA Extraction, Phosphate Titration',
                'MGCA_KCL1',
                'CMS, SSIR No. 1, 1972, page 47',
                965,
                993,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=993',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                331,
                'KCl Extract, Mg',
                'Magnesium, KCl-TEA Extraction, EDTA Titration',
                'MG_KCL2',
                'CMS, SSIR No. 1, 1972, page 47',
                965,
                993,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=993',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                332,
                'KCl Extract, Mg',
                'Magnesium, KCl-TEA Extraction, Atomic Absorption',
                'MG_KCL3',
                'CMS, SSIR No. 1, 1972, page 47',
                966,
                994,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=994',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                333,
                'Soluble Salts, Na',
                'Sodium, Saturation Extraction, Flame Photometry',
                'NA_SAT1',
                'CMS, SSIR No. 1, 1972, page 47',
                967,
                995,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=995',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                334,
                'Soluble Salts, Na',
                'Sodium, Saturation Extraction, Atomic Absorption I',
                'NA_SAT2',
                'CMS, SSIR No. 1, 1972, page 47',
                767,
                795,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=795',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                335,
                'Soluble Salts, Na',
                'Sodium, Saturation Extraction, Atomic Absorption II',
                'NA_SAT3',
                'CMS, SSIR No. 42, version 3, page 305',
                771,
                799,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=799',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                336,
                'Soluble Salts, Na',
                'Sodium, Saturation Extraction, Atomic Absorption III',
                'NA_SAT4',
                'CMS, SSIR No. 42, version 3, page 305, PE 300AA',
                '',
                28,
                '',
                'not in manual anywhere, instrument change (PE AA300)';
INSERT INTO lab_analysis_procedure
            SELECT
                337,
                'Extractable Cations, Na',
                'Sodium, NH4OAc Extraction',
                'NaExCat4',
                'CMS, SSIR No. 1, 1972, page 47',
                967,
                995,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=995',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                338,
                'Extractable Cations, Na',
                'Sodium, NHOAc Extraction, Flame Photometry',
                'NaExCat5',
                'CMS, SSIR No. 1, 1972, page 47',
                967,
                995,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=995',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                339,
                'Extractable Cations, Na',
                'Sodium, NH4OAc Extraction, Atomic Absorption I',
                'NaExCat6',
                'CMS, SSIR No. 1, 1972, page 48',
                776,
                804,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=804',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                340,
                'Extractable Cations, Na',
                'Sodium, NH4OAc Extraction, Atomic Absorption II',
                'NaExCat7',
                'CMS, SSIR No. 42, version 3, page 313',
                780,
                808,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=808',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                341,
                'Extractable Cations, Na',
                'Sodium, NH4OAc Extraction, Atomic Absorption II, moist',
                'NaExCat8',
                'CMS, SSIR No. 42, version 3, page 309, moist',
                '',
                28,
                '',
                'not in manual';
INSERT INTO lab_analysis_procedure
            SELECT
                342,
                'Extractable Cations, Na',
                'Sodium, NH4OAc Extraction, Atomic Absorption I, moist',
                'NaExCat9',
                'CMS, SSIR No. 42, version 3, page 313, moist',
                '',
                28,
                '',
                'not in manual';
INSERT INTO lab_analysis_procedure
            SELECT
                343,
                'Extractable Cations, Na',
                'Sodium, NH4OAc Extraction, ICP I',
                'NaExCat10',
                'CMS, SSIR No. 42, version 3, page 313, ICP',
                '',
                28,
                '',
                'not in manual, temporary method';
INSERT INTO lab_analysis_procedure
            SELECT
                344,
                'Extractable Cations, Na',
                'Sodium, NH4OAc Extraction, ICP I, moist',
                'NaExCat11',
                'CMS, SSIR No. 42, version 3, page 313, ICP, moist',
                '',
                28,
                '',
                'not in manual, temporary method';
INSERT INTO lab_analysis_procedure
            SELECT
                345,
                'Soluble Salts, K',
                'Potassium, Saturation Extraction, Flame Photometry',
                'K_SAT1',
                'CMS, SSIR No. 1, 1972, page 48',
                968,
                996,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=996',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                346,
                'Soluble Salts, K',
                'Potassium, Saturation Extraction, Atomic Absorption I',
                'K_SAT2',
                'CMS, SSIR No. 1, 1972, page 48',
                767,
                795,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=795',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                347,
                'Soluble Salts, K',
                'Potassium, Saturation Extraction, Atomic Absorption II',
                'K_SAT3',
                'CMS, SSIR No. 42, version 3, page 305',
                771,
                799,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=799',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                348,
                'Soluble Salts, K',
                'Potassium, Saturation Extraction, Atomic Absorption III',
                'K_SAT4',
                'CMS, SSIR No. 42, version 3, page 305, PE 300AA',
                '',
                28,
                '',
                'not in manual anywhere, instrument change (PE AA300)';
INSERT INTO lab_analysis_procedure
            SELECT
                349,
                'Extractable Cations, K',
                'Potassium, NHOAc Extraction',
                'KExCat4',
                'CMS, SSIR No. 1, 1972, page 48',
                776,
                804,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=804',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                350,
                'Extractable Cations, K',
                'Potassium, NHOAc Extraction, Flame Photometry',
                'KExCat5',
                'CMS, SSIR No. 1, 1972, page 48',
                969,
                997,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=997',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                351,
                'Extractable Cations, K',
                'Potassium, NHOAc Extraction, Atomic Absorption I',
                'KExCat6',
                'CMS, SSIR No. 1, 1972, page 48',
                776,
                804,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=804',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                352,
                'Extractable Cations, K',
                'Potassium, NHOAc Extraction, Atomic Absorption II',
                'KExCat7',
                'CMS, SSIR No. 42, version 3, page 313',
                780,
                808,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=808',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                353,
                'Extractable Cations, K',
                'Potassium, NHOAc Extraction, Atomic Absorption II, moist',
                'KExCat8',
                'CMS, SSIR No. 42, version 3, page 309, moist',
                '',
                28,
                '',
                'not in manual';
INSERT INTO lab_analysis_procedure
            SELECT
                354,
                'Extractable Cations, K',
                'Potassium, NHOAc Extraction, Atomic Absorption I, moist',
                'KExCat9',
                'CMS, SSIR No. 42, version 3, page 313, moist',
                '',
                28,
                '',
                'not in manual';
INSERT INTO lab_analysis_procedure
            SELECT
                355,
                'Extractable Cations, K',
                'Potassium, NHOAc Extraction, ICP I',
                'KExCat10',
                'CMS, SSIR No. 42, version 3, page 313, ICP',
                '',
                28,
                '',
                'not in manual, temporary method';
INSERT INTO lab_analysis_procedure
            SELECT
                356,
                'Extractable Cations, K',
                'Potassium, NHOAc Extraction, ICP I, moist',
                'KExCat11',
                'CMS, SSIR No. 42, version 3, page 313, ICP, moist',
                '',
                28,
                '',
                'not in manual, temporary method';
INSERT INTO lab_analysis_procedure
            SELECT
                357,
                'KCl Extract, Al',
                'Aluminum, 1 N KCl Extractable, Automatic Extractor, ICP II, moist',
                'AL_KCL',
                'CMS, SSIR No. 42, version 3, page 259, moist',
                '',
                28,
                '',
                'no method was written for this or included in the manual';
INSERT INTO lab_analysis_procedure
            SELECT
                358,
                'KCl Extract, Al',
                'Aluminum, KCl Extraction I, 30 min., Fluoride Titration',
                'AL_KCL',
                'CMS, SSIR No. 1, 1972, page 37',
                939,
                967,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=967',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                359,
                'KCl Extract, Al',
                'Aluminum, KCl Extraction I, 30 min., Aluminon I',
                'AL_KCL',
                'CMS, SSIR No. 1, 1972, page 36',
                938,
                966,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=966',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                360,
                'KCl Extract, Al',
                'Aluminum, KCl Extraction I, 30 min., Atomic Absorption',
                'AL_KCL',
                'CMS, SSIR No. 1, 1972, page 37',
                940,
                968,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=968',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                361,
                'KCl Extract, Mn',
                'Manganese, 1 N KCl Extractable, Automatic Extractor, Inductively Coupled Plasma Spectrometry II',
                'MN_KCL',
                'CMS, SSIR No. 42, version 3, page 259',
                749,
                777,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=777',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                362,
                'KCl Extract, Mn',
                'Manganese, 1 N KCl Extractable, Automatic Extractor, Inductively Coupled Plasma Spectrometry I',
                'MN_KCL',
                'CMS, SSIR No. 42, version 3, page 549',
                '',
                28,
                '',
                'cant find method code in current or obsolete (6D3)';
INSERT INTO lab_analysis_procedure
            SELECT
                363,
                'KCl Extract, Mn',
                'Manganese, 1 N KCl Extractable, Automatic Extractor, Inductively Coupled Plasma Spectrometry II, moist',
                'MN_KCL',
                'CMS, SSIR No. 42, version 3, page 259, moist',
                '',
                28,
                '',
                'cant find method code in current or obsolete (6D3d)';
INSERT INTO lab_analysis_procedure
            SELECT
                364,
                'Dithionite Extract, Fe',
                'Iron, Dithionite Extraction, Dichromate Titration',
                'FE_DITH',
                'CMS, SSIR No. 1, 1972, page 30',
                921,
                949,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=949',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                365,
                'Dithionite Extract, Fe',
                'Iron, Dithionite Extraction, EDTA Titration',
                'FE_DITH',
                'CMS, SSIR No. 1, 1972, page 30',
                922,
                950,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=950',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                366,
                'Dithionite-Citrate Extract, Fe',
                'Iron, Dithionite-Citrate Extraction, Atomic Absorption I',
                'FE_DITH',
                'CMS, SSIR No. 1, 1972, page 31',
                721,
                749,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=749',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                367,
                'Dithionite-Citrate Extract, Fe',
                'Iron, Dithionite-Citrate Extraction, Atomic Absorption II',
                'FE_DITH',
                'CMS, SSIR No. 42, version 3, page 239',
                726,
                754,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=754',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                368,
                'Dithionite-Citrate Extract, Fe',
                'Iron, Dithionite-Citrate Extraction I, Atomic Absorption I, moist',
                'FE_DITH',
                'CMS, SSIR No. 1, 1972, page 31, moist',
                726,
                754,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=754',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                369,
                'Dithionite-Citrate Extract, Fe',
                'Iron, Dithionite-Citrate Extraction II, Atomic Absorption II',
                'FE_DITH',
                'NULL',
                726,
                754,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=754',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                370,
                'Dithionite-Citrate Extract, Fe',
                'Iron, Dithionite-Citrate Extraction II, Atomic Absorption II, moist',
                'FE_DITH',
                'CMS, SSIR No. 42, version 3, page 239, moist',
                726,
                754,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=754',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                371,
                'Dithionite-Citrate Extract, Fe',
                'Iron, Dithionite-Citrate Extraction II, Atomic Absorption III',
                'FE_DITH',
                'NULL',
                726,
                754,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=754',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                372,
                'Dithionite-Citrate Extract, Fe',
                'Iron, Dithionite-Citrate Extraction II, Atomic Absorption III, moist',
                'FE_DITH',
                'NULL',
                726,
                754,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=754',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                373,
                'Dithionite-Citrate Extract, Fe',
                'Iron, Dithionite-Citrate-Bicarbonate Extraction',
                'FE_DITH',
                'CMS, SSIR No. 1, 1972, page 31',
                924,
                952,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=952',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                374,
                'Dithionite Extract, Mn',
                'Manganese, Dithionite Extraction, Permanganate Colorimetry',
                'MN_DITH',
                'CMS, SSIR No. 1, 1972, page 33',
                928,
                956,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=956',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                375,
                'Dithionite-Citrate Extract, Mn',
                'Manganese, Dithionite-Citrate Extraction, Atomic Absorption I',
                'MN_DITH',
                'CMS, SSIR No. 1, 1984, page 38',
                721,
                749,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=749',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                376,
                'Dithionite-Citrate Extract, Mn',
                'Manganese, Dithionite-Citrate Extraction I, Atomic Absorption I, moist',
                'MN_DITH',
                'CMS, SSIR No. 1, 1984, page 38, moist',
                726,
                754,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=754',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                377,
                'Dithionite-Citrate Extract, Mn',
                'Manganese, Dithionite-Citrate Extraction II, Atomic Absorption II',
                'MN_DITH',
                'NULL',
                726,
                754,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=754',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                378,
                'Dithionite-Citrate Extract, Mn',
                'Manganese, Dithionite-Citrate Extraction II, Atomic Absorption II, moist',
                'MN_DITH',
                'NULL',
                726,
                754,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=754',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                379,
                'Dithionite-Citrate Extract, Mn',
                'Manganese, Dithionite-Citrate Extraction II, Atomic Absorption III',
                'MN_DITH',
                'NULL',
                726,
                754,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=754',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                380,
                'Dithionite-Citrate Extract, Mn',
                'Manganese, Dithionite-Citrate Extraction II, Atomic Absorption III, moist',
                'MN_DITH',
                'NULL',
                726,
                754,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=754',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                381,
                'Dithionite-Citrate Extract, Al',
                'Aluminum, Dithionite-Citrate Extraction, Atomic Absorption I',
                'AL_DITH',
                'CMS, SSIR No. 1, 1972, page 38',
                721,
                749,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=749',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                382,
                'Dithionite-Citrate Extract, Al',
                'Aluminum, Dithionite-Citrate Extraction, Atomic Absorption II',
                'AL_DITH',
                'CMS, SSIR No. 42, version 3, page 233',
                726,
                754,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=754',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                383,
                'Dithionite-Citrate Extract, Al',
                'Aluminum, Dithionite-Citrate Extraction I, Atomic Absorption I, moist',
                'AL_DITH',
                'CMS, SSIR No. 1, 1972, page 38, moist',
                '',
                28,
                '',
                'no code like that in obsolete or current (does not include moist in 6G7b)';
INSERT INTO lab_analysis_procedure
            SELECT
                384,
                'Dithionite-Citrate Extract, Al',
                'Aluminum, Dithionite-Citrate Extraction II, Atomic Absorption II',
                'AL_DITH',
                'NULL',
                726,
                754,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=754',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                385,
                'Dithionite-Citrate Extract, Al',
                'Aluminum, Dithionite-Citrate Extraction II, Atomic Absorption II, moist',
                'AL_DITH',
                'CMS, SSIR No. 42, version 3, page 233, moist',
                726,
                754,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=754',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                386,
                'Dithionite-Citrate Extract, Al',
                'Aluminum, Dithionite-Citrate Extraction II, Atomic Absorption III',
                'AL_DITH',
                'NULL',
                726,
                754,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=754',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                387,
                'Dithionite-Citrate Extract, Al',
                'Aluminum, Dithionite-Citrate Extraction II, Atomic Absorption III, moist',
                'AL_DITH',
                'NULL',
                726,
                754,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=754',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                388,
                'Acid Oxalate extraction',
                'Iron, Ammonium Oxalate Extraction, Atomic Absorption',
                'OXAL',
                'CMS, SSIR No. 1, 1972, page 33',
                941,
                969,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=969',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                389,
                'Acid Oxalate extraction',
                'Aluminum, Ammonium Oxalate Extraction, Atomic Absorption',
                'OXAL',
                'CMS, SSIR No. 1, 1972, page 37',
                941,
                969,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=969',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                390,
                'Na-Pyrophosphate Extract, Al',
                'Aluminum, Sodium Pyrophosphate Extraction I, Atomic Absorption',
                'PYRO',
                'CMS, SSIR No. 1, 1972, page 37',
                941,
                969,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=969',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                391,
                'Na-Pyrophosphate Extract, Al',
                'Aluminum, Sodium Pyrophosphate Extraction II',
                'PYRO',
                'CMS, SSIR No. 1, 1984, page 44',
                735,
                763,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=763',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                392,
                'Na-Pyrophosphate Extract, Al',
                'Aluminum, Sodium Pyrophosphate Extraction II, Atomic Absorption II',
                'PYRO',
                'CMS',
                '',
                28,
                '',
                'not in manual, instrument change (PE AA300)';
INSERT INTO lab_analysis_procedure
            SELECT
                393,
                'Na-Pyrophosphate Extract, Al',
                'Aluminum, Sodium Pyrophosphate Extraction II, Atomic Absorption II, moist',
                'PYRO',
                'CMS, moist',
                '',
                28,
                '',
                'not in manual, instrument change (PE AA300)';
INSERT INTO lab_analysis_procedure
            SELECT
                394,
                'Na-Pyrophosphate Extract, C',
                'Organic Carbon, Sodium Pyrophosphate Extraction II, Atomic Absorption',
                'PYRO',
                'CMS, SSIR No. 42, version 3, page 247',
                735,
                763,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=763',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                395,
                'Na-Pyrophosphate Extract, Fe',
                'Iron, Sodium Pyrophosphate Extraction I, Atomic Absorption',
                'PYRO',
                'CMS, SSIR No. 1, 1972, page 32',
                926,
                954,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=954',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                396,
                'Na-Pyrophosphate Extract, Fe',
                'Iron, Sodium Pyrophosphate Extraction II, Atomic Absorption',
                'PYRO',
                'CMS, SSIR No. 1, 1984, page 38',
                735,
                763,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=763',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                397,
                'Na-Pyrophosphate Extract, Fe',
                'Iron, Sodium Pyrophosphate Extraction II, Atomic Absorption II',
                'PYRO',
                'CMS',
                '',
                28,
                '',
                'cant find method code in current or obsolete';
INSERT INTO lab_analysis_procedure
            SELECT
                398,
                'Na-Pyrophosphate Extract, Fe',
                'Iron, Sodium Pyrophosphate Extraction II, Atomic Absorption II, moist',
                'PYRO',
                'CMS, moist',
                '',
                28,
                '',
                'cant find method code in current or obsolete';
INSERT INTO lab_analysis_procedure
            SELECT
                399,
                'Soluble Anions, CO2',
                'Carbonate, Saturation Extraction, Acid Titration',
                'SatAn6',
                'CMS, SSIR No. 1, 1972, page 39',
                946,
                974,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=974',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                400,
                'Soluble Anions, HCO3',
                'Bicarbonate, Saturation Extraction, Acid Titration',
                'SatAn6',
                'CMS, SSIR No. 1, 1972, page 39',
                947,
                975,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=975',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                401,
                'Soluble Anions, HCO3',
                'Bicarbonate, Saturation Extraction, Acid Titration, Automatic Extractor',
                'SatAn1',
                'CMS, SSIR No. 42, version 3, page 283',
                415,
                443,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=443',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                402,
                'Soluble Anions, Cl',
                'Chloride, Saturation Extraction, Mohr Titration',
                'SatAn7',
                'CMS, SSIR No. 1, 1972, page 39',
                948,
                976,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=976',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                403,
                'Soluble Anions, Cl',
                'Chloride, Saturation Extraction, Potentiometric Titration',
                'SatAn8',
                'CMS, SSIR No. 1, 1972, page 40',
                948,
                976,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=976',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                404,
                'Soluble Anions, SO4',
                'Sulfate, Saturation Extraction, Gravimetric, BaSO4',
                'SatAn9',
                'CMS, SSIR No. 1, 1972, page 40',
                949,
                977,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=977',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                405,
                'Soluble Anions, SO4',
                'Sulfate, Saturation Extraction, EDTA Titration',
                'SatAn10',
                'CMS, SSIR No. 1, 1972, page 40',
                950,
                978,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=978',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                406,
                'Soluble Anions, SO4',
                'Sulfate, Saturation Extraction, Anion Chromatograph',
                'SatAn2',
                'CMS, SSIR No. 1, 1984, page 48',
                864,
                892,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=892',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                407,
                'Soluble Anions, SO4',
                'Sulfate, Saturation Extraction, Anion Chromatograph, Ionic Suppressor',
                'SatAn3',
                'CMS, SSIR No. 42, version 3, page 287',
                760,
                788,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=788',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                408,
                'Soluble Anions, SO4',
                'Sulfate, Saturation Extraction, Flow Injection, Automated Ion Analyzer',
                'SatAn4',
                'CMS, SSIR No. 42, version 3, page 287, Flow injection',
                760,
                788,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=788',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                409,
                'Soluble Anions, SO4',
                'Sulfate, Saturation Extraction, Anion Chromatograph, Electronic Ion Suppressor',
                'SatAn5',
                'CMS, SSIR No. 42, version 3, page 287, Anion Chromatography, Electronc Ion Suppressor',
                760,
                788,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=788',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                410,
                'Soluble Anions, NO3',
                'Nitrate, Saturation Extraction, Anion Chromatograph',
                'SatAn2',
                'CMS, SSIR No. 1, 1984, page 48',
                864,
                892,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=892',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                411,
                'Soluble Anions, NO3',
                'Nitrate, Saturation Extraction, Anion Chromatograph, Ionic Suppressor',
                'SatAn3',
                'CMS, SSIR No. 42, version 3, page 287',
                760,
                788,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=788',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                412,
                'Soluble Anions, NO3',
                'Nitrate, Saturation Extraction, Flow Injection, Automated Ion Analyzer',
                'SatAn4',
                'CMS, SSIR No. 42, version 3, page 287, Flow injection',
                760,
                788,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=788',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                413,
                'Soluble Anions, NO3',
                'Nitrate, Saturation Extraction, Anion Chromatograph, Electronic Ion Suppressor',
                'SatAn5',
                'CMS, SSIR No. 42, version 3, page 287, Anion Chromatography, Electronc Ion Suppressor',
                760,
                788,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=788',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                414,
                'Soluble Anions, Fl',
                'Fluoride, Saturation Extraction, Anion Chromatograph',
                'SatAn2',
                'CMS, SSIR No. 42, version 3, page 559',
                864,
                892,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=892',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                415,
                'Soluble Anions, Fl',
                'Fluoride, Saturation Extraction, Anion Chromatograph, Ionic Suppressor',
                'SatAn3',
                'CMS, SSIR No. 42, version 3, page 287',
                760,
                788,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=788',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                416,
                'Soluble Anions, Fl',
                'Fluoride, Saturation Extraction, Flow Injection, Automated Ion Analyzer',
                'SatAn4',
                'CMS, SSIR No. 42, version 3, page 287, Flow injection',
                760,
                788,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=788',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                417,
                'Soluble Anions, Fl',
                'Fluoride, Saturation Extraction, Anion Chromatograph, Electronic Ion Suppressor',
                'SatAn5',
                'CMS, SSIR No. 42, version 3, page 287, Anion Chromatography, Electronc Ion Suppressor',
                760,
                788,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=788',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                418,
                'Soluble Anions, NO2',
                'Nitrite, Saturation Extraction, Anion Chromatograph',
                'SatAn2',
                'CMS, SSIR No. 42, version 3, page 559',
                864,
                892,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=892',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                419,
                'Soluble Anions, NO2',
                'Nitrite, Saturation Extraction, Anion Chromatograph, Ionic Suppressor',
                'SatAn3',
                'CMS, SSIR No. 42, version 3, page 287',
                760,
                788,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=788',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                420,
                'Soluble Anions, NO2',
                'Nitrite, Saturation Extraction, Flow Injection, Automated Ion Analyzer',
                'SatAn4',
                'CMS, SSIR No. 42, version 3, page 287, Flow injection',
                760,
                788,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=788',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                421,
                'Soluble Anions, NO2',
                'Nitrite, Saturation Extraction, Anion Chromatograph, Electronic Ion Suppressor',
                'SatAn5',
                'CMS, SSIR No. 42, version 3, page 287, Anion Chromatography, Electronc Ion Suppressor',
                760,
                788,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=788',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                422,
                'Soluble Anions, Br',
                'Bromide, Saturation Extraction, Anion Chromatograph, Electronic Ion Suppressor',
                'SatAn5',
                'CMS, SSIR No. 42, version 3, page 287, Anion Chromatography, Electronc Ion Suppressor',
                760,
                788,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=788',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                423,
                'Soluble Anions, OAc',
                'Acetate, Saturation Extraction, Anion Chromatograph, Electronic Ion Suppressor',
                'SatAn5',
                'CMS, SSIR No. 42, version 3, page 287, Anion Chromatography, Electronc Ion Suppressor',
                760,
                788,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=788',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                424,
                'Saturated Paste and Soluble Salts, EC',
                'Saturated Paste, Mixed, Saturation Extract, Automatic Extractor Conductivity, Digital Bridge',
                'SATP',
                'CMS, SSIR No. 42, version 3, page 407',
                397,
                425,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=425',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                425,
                'Soluble Anions, NO3',
                'Nitrate, Saturation Extraction, Phenyldisulfonic (PDS) Acid Colorimetry',
                'SatAn11',
                'CMS, SSIR No. 1, 1972, page 41',
                951,
                979,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=979',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                426,
                'Atterberg Limits, LL',
                'Plasticity Index, Liquid Limit',
                'AttBg0',
                'CMS, SSIR No. 42, version 3, page 193',
                218,
                246,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=246',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                427,
                'Atterberg Limits, PL',
                'Plasticity Index, Plastic Limit',
                'AttBg0',
                'CMS, SSIR No. 42, version 3, page 193',
                219,
                247,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=247',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                428,
                'Saturated Paste and Soluble Salts, H2O',
                'Water Content, Saturated Paste',
                'SATP',
                'CMS, SSIR No. 42, version 3, page 397',
                394,
                422,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=422',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                429,
                'Saturated Paste and Soluble Salts, pH',
                'Reaction (pH), Saturated Paste',
                'SATP',
                'CMS, SSIR No. 42, version 3, page 411',
                269,
                297,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=297',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                430,
                'Saturated Paste and Soluble Salts, resistivity',
                'Soil Resistivity, Saturated Paste',
                'SATP',
                'CMS, SSIR No. 42, version 3, page 427',
                399,
                427,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=427',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                431,
                'Soluble Anions, PO4',
                'Phosphate, Saturation Extraction, Anion Chromatograph, Electronic Ion Suppressor',
                'SatAn5',
                'CMS, SSIR No. 42, version 3, page 287, Anion Chromatography, Electronc Ion Suppressor',
                760,
                788,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=788',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                432,
                'Particles >2 mm, 75 mm Base',
                'Particles >2 mm, 75 mm Base',
                'CFRAG0',
                'CMS, SSIR No. 42, version 3, page 105',
                '',
                28,
                '',
                'unable to determine which method is referenced';
INSERT INTO lab_analysis_procedure
            SELECT
                433,
                'Water Retention, Field State',
                'Water Retention, Field State',
                'H2Ofield',
                'CMS, SSIR No. 42, version 3, page 169',
                169,
                197,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=197',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                434,
                'Extractable Cations, Ca',
                'Calcium, NH4OAc Extraction, Atomic Absorption III',
                'CaExCat12',
                'CMS, SSIR No. 42, version 3, page 313, AAIII',
                '',
                28,
                '',
                'Retired instrument, no method written';
INSERT INTO lab_analysis_procedure
            SELECT
                435,
                'Extractable Cations, Ca',
                'Calcium, NH4OAc Extraction, Atomic Absorption III, moist',
                'CaExCat13',
                'CMS, SSIR No. 42, version 3, page 313, AAIII, moist',
                '',
                28,
                '',
                'Retired instrument, no method written';
INSERT INTO lab_analysis_procedure
            SELECT
                436,
                'Extractable Cations, Mg',
                'Magnesium, NH4OAc Extraction, Atomic Absorption III',
                'MgExCat12',
                'CMS, SSIR No. 42, version 3, page 313, AAIII',
                '',
                28,
                '',
                'Retired instrument, no method written';
INSERT INTO lab_analysis_procedure
            SELECT
                437,
                'Extractable Cations, Mg',
                'Magnesium, NH4OAc Extraction, Atomic Absorption III, moist',
                'MgExCat13',
                'CMS, SSIR No. 42, version 3, page 313, AAIII, moist',
                '',
                28,
                '',
                'Retired instrument, no method written';
INSERT INTO lab_analysis_procedure
            SELECT
                438,
                'Extractable Cations, Na',
                'Sodium, NH4OAc Extraction, Atomic Absorption III',
                'NaExCat12',
                'CMS, SSIR No. 42, version 3, page 313, AAIII',
                '',
                28,
                '',
                'retired instrument, no method written';
INSERT INTO lab_analysis_procedure
            SELECT
                439,
                'Extractable Cations, Na',
                'Sodium, NH4OAc Extraction, Atomic Absorption III, moist',
                'NaExCat13',
                'CMS, SSIR No. 42, version 3, page 313, AAIII, moist',
                '',
                28,
                '',
                'retired instrument, no method written';
INSERT INTO lab_analysis_procedure
            SELECT
                440,
                'Extractable Cations, K',
                'Potassium, NH4OAc Extraction, Atomic Absorption III',
                'KExCat12',
                'CMS, SSIR No. 42, version 3, page 313, AAIII',
                '',
                28,
                '',
                'retired instrument, no method written';
INSERT INTO lab_analysis_procedure
            SELECT
                441,
                'Extractable Cations, K',
                'Potassium, NH4OAc Extraction, Atomic Absorption III, moist',
                'KExCat13',
                'CMS, SSIR No. 42, version 3, page 313, AAIII, moist',
                '',
                28,
                '',
                'retired instrument, no method written';
INSERT INTO lab_analysis_procedure
            SELECT
                442,
                'Dithionite-Citrate Extract, Fe',
                'Iron, Dithionite-Citrate Extraction, Orthophenanthroline Colorimetry',
                'FE_DITH',
                'CMS, SSIR No. 1, 1972, page 31',
                923,
                951,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=951',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                443,
                'Phosphorus, Bray 1',
                'Phosphorus, Bray P-1 Absorbed Phosphorus, Spectrophotometer',
                'BRAYP',
                'CMS, SSIR No. 42, version 3, page 323',
                788,
                816,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=816',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                444,
                'Particles >2 mm, 75 mm Base',
                'Particles >2 mm, Weight Estimates',
                'CFRAG1',
                'CMS, SSIR No. 42, version 3, page 105',
                91,
                119,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=119',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                445,
                'Derived',
                'derived BSESAT, 5C1b',
                'none',
                'CMS, moist',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                446,
                'Atterberg Limits, PI',
                'derived Plasticity Index',
                'AttBg0',
                'CMS, SSIR No. 42, version 3, page 193',
                219,
                247,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=247',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                447,
                'Na-Pyrophosphate Extract, Fe',
                'Iron, Sodium Pyrophosphate Extraction II, Atomic Absorption, moist',
                'PYRO',
                'CMS, SSIR No. 1, 1984, page 38, moist',
                '',
                28,
                '',
                'Retired instrument, no method written';
INSERT INTO lab_analysis_procedure
            SELECT
                448,
                'Calcium Carbonate Equivalent, <20mm',
                'Calcium Carbonate Equivalent, HCl, <20mm- 6E4b (derived)',
                'CACO3_20',
                'SSIR No. 42, version 3, page 271',
                370,
                398,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=398',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                449,
                'Calcium Carbonate Equivalent, <20mm',
                'Calcium Carbonate Equivalent, HCl, <20mm (derived)',
                'caco3l20',
                'CMS',
                370,
                398,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=398',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                450,
                'Gypsum, <20mm',
                'Gypsum, H2O Extraction, Acetone Precipitation, <20mm (derived)',
                'GYPL20',
                'SSIR No. 42, version 3, page 275',
                378,
                406,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=406',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                451,
                'Clay Mineralogy, X-ray Diffraction',
                'X-ray Diffraction, unspecified',
                'XRAY',
                'CMS',
                533,
                561,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=561',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                452,
                'Clay Mineralogy, DTA I',
                'Differential Thermal Analysis I',
                'DTA1',
                'CMS 7A3',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                453,
                'Clay Mineralogy, DTA',
                'Differential Thermal Analysis',
                'DTA2',
                'CMS 7A3b',
                '',
                28,
                '',
                'This method isnt in the manual, according to Jennifer DTA is a broader category, wouldnt be under 7A3';
INSERT INTO lab_analysis_procedure
            SELECT
                454,
                'Total Elemental Analysis, HF Dissolution',
                'Total Analysis, HF Dissolution',
                'TOTANAL',
                'CMS 7C3',
                886,
                914,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=914',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                455,
                'Optical Analysis, Mica Adjusted',
                'Optical Analysis, Full Grain Count, Mica Adjusted',
                'OPTICAL_Fm',
                'CMS',
                437,
                465,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=465',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                456,
                'Clay Mineralogy, X-ray Diffraction',
                'X-ray Diffraction, thin film on tile resin pretreatment',
                'XRAY',
                'CMS, 7A2e',
                983,
                1011,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=1011',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                457,
                'Acid Oxalate extraction',
                'Cations, Acid Oxalate Extractable, Optical Density',
                'OXAL',
                'CMS',
                846,
                874,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=874',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                458,
                'Estimated organic carbon',
                'Estimated Organic Carbon',
                'EOC',
                'NULL',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                460,
                'Fiber Analysis, pH CaCl2',
                'pH, 0.01M CaCl2, Histosol',
                'ph_hist',
                'SSIR No. 42, version 3, page 423',
                274,
                302,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=302',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                461,
                'Fiber Analysis, Pyrophosphate color',
                'Color, Pyrophosphate Extract',
                'pyr_col',
                'SSIR No. 42, version 3, page 437',
                497,
                525,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=525',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                465,
                'Biomass, Roots, C',
                'Biomass, Roots, C',
                'BIOROOT',
                'SSIR No. 42, version 4, page 394',
                671,
                699,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=699',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                466,
                'Biomass, POM, C',
                'Biomass, POM, C',
                'BIOPOM',
                'SSIR No. 42, version 4, page 385',
                660,
                688,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=688',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                467,
                'Biomass, Microbial, C',
                'Biomass, Microbial, C',
                'BIOMASS',
                'SSIR No. 42, version 4, page 388',
                664,
                692,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=692',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                468,
                'Biomass, CO3, C',
                'Biomass, CO3, C',
                'BIOCO3',
                'SSIR No. 42, version 4, page 381',
                655,
                683,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=683',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                469,
                'Extractable Acidity, BaCl2-TEA',
                'Extractable Acidity, BaCl2-Triethanolamine, Centrifuge',
                'EXTRACIDC',
                'SSIR No. 42, version 4, page 194',
                251,
                279,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=279',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                470,
                'Biomass, 0.02 M KMnO4 Extractable, C',
                'Biomass, 0.02 M KMnO4 Extractable, C',
                'BIOKMNO4',
                'SSIR No. 42, version 4, page 379',
                505,
                533,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=533',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                471,
                'Phosphorus, Anion Resin Extractable',
                'Anion Resin Extractable Phosphorus',
                'AnResP',
                'SSIR No. 42, version 4, page 219',
                287,
                315,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=315',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                472,
                'Electrical Conductivity, 1:20, <2 mm Particles',
                'Electrical Conductivity, 1:20 (w/v)',
                'EC20',
                'NULL',
                '',
                28,
                '',
                'not in manual';
INSERT INTO lab_analysis_procedure
            SELECT
                473,
                'Biomass, Glucose, C',
                'Biomass, Glucose, C',
                'BIOGLUCOSE',
                'SSIR No. 42, version 4, page 376',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                474,
                'Water Retention, 5 Bar, Pressure-Plate, <2mm',
                'Water Retention, 5 Bar, Pressure-Plate, <2mm',
                'H2O5Bar<2',
                'new method',
                '',
                28,
                '',
                'not in manual';
INSERT INTO lab_analysis_procedure
            SELECT
                475,
                'Phosphorus, Ground/Surface Water',
                'Phosphorus, Ground/Surface Water',
                'WatP',
                'SSIR No. 42, version 4, page 352',
                474,
                502,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=502',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                476,
                'Elements, Mehlich III',
                'Elements, Mehlich III',
                'ElMehl3',
                'SSIR No. 42, version 4, page 249',
                345,
                373,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=373',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                477,
                'Elements, Water Extract',
                'Elements, Water Extract',
                'ElWatExtr',
                'NULL',
                312,
                340,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=340',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                478,
                'Salts, Ground/Surface Water',
                'Salts, Ground/Surface Water',
                'WatSalts',
                'SSIR No. 42, version 4, page 352',
                472,
                500,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=500',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                479,
                'Elements, Ground/Surface Water',
                'Elements, Ground/Surface Water',
                'ElWat',
                'SSIR No. 42, version 4, page 365',
                649,
                677,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=677',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                480,
                'Phosphorus, Anion Resin Ground/Surface Water',
                'Anion Resin Water Phosphorus',
                'AnResPW',
                'SSIR No. 42, version 4, page 219',
                287,
                315,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=315',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                481,
                'Equivalent Gypsum Content',
                'Equivalent Gypsum Content',
                'EGC',
                'NULL',
                380,
                408,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=408',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                482,
                'PSDA, Water Disp, Moist, Ultrasonic, Pipet',
                'PSDA, Water Dispersible, Moist, Ultrasonic, Pipet',
                'H2OPSDAMU',
                'NULL',
                72,
                100,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=100',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                483,
                'PSDA, Water Disp, Air-Dry, Ultrasonic, Pipet',
                'PSDA, Water Dispersible, Air-Dry, Ultrasonic, Pipet',
                'H2OPSDAAU',
                'NULL',
                71,
                99,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=99',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                484,
                'Surface Area N2 Adsorption',
                'Surface Area N2 Adsorption',
                'SA_N2BET',
                'SSIR No. 42, version 4, page 418',
                540,
                568,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=568',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                485,
                'PSDA, Air-dry, <2 mm Particles',
                'PSDA, no pretreatment, Pipet',
                'PSDA1',
                'Soil Characterization in Indiana, page 13 3A1i',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                486,
                'Organic Carbon',
                'Organic Carbon, acid dichromate digestion, FeSO4 titration, Mebius',
                'WBC3',
                'Soil Characterization in Indiana, page 19 6A1e',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                487,
                'Organic Carbon',
                'Organic Carbon, acid dichromate digestion, FeSO4 titration, Nelson-Sommers',
                'WBC4',
                'Soil Characterization in Indiana, page 20 6A1f',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                488,
                'PSDA, Air-dry, <2 mm Particles',
                'PSDA, centrifuge',
                'PSDA2',
                'University of Idaho Laboratory Analysis 3A1j http://soils.ag.uidaho.edu/pedology/Analyses/index.htm',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                489,
                'Phosphorus Isotherm',
                'Phosphorus Isotherm',
                'PIsotherm',
                'University of Idaho Laboratory Analysis http://soils.ag.uidaho.edu/pedology/Analyses/index.htm',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                490,
                'Soluble Salts, Ca',
                'Calcium, 1:1 soil/water Extraction, EDTA Titration',
                'CA_11SWEX',
                'USDA Handbook 60, titration with EDTA (Versenate), 7',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                491,
                'Soluble Salts, Mg',
                'Magnesium, 1:1 soil/water Extraction, EDTA Titration',
                'MG_11SWEX',
                'USDA Handbook 60, titration with EDTA (Versenate), 7',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                492,
                'Soluble Salts, Na',
                'Sodium, 1:1 soil/water Extraction, Atomic Absorbtion',
                'NA_11SWEX',
                'USDA Handbook 60',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                493,
                'Soluble Salts, K',
                'Potassium, 1:1 soil/water Extraction, Atomic Absorbtion',
                'K_11SWEX',
                'USDA Handbook 60',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                494,
                'Soluble Anions, CO3',
                'Carbonate, 1:1 soil/water Extraction, acid titration',
                '11SWEXAn1',
                'USDA Handbook 60, titration with acid, 12',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                495,
                'Soluble Anions, HCO3',
                'Bicarbonate, 1:1 soil/water Extraction, acid titration',
                '11SWEXAn1',
                'USDA Handbook 60, titration with acid, 12',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                496,
                'Soluble Anions, Cl',
                'Chloride, 1:1 soil/water Extraction, Mohr titration',
                '11SWEXAn2',
                'USDA Handbook 60, titration with silver nitrate, 13',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                497,
                'Soluble Anions, SO4',
                'Sulfate, 1:1 soil/water Extraction, titration',
                '11SWEXAn3',
                'Fritz and Yamanura. 1955.',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                498,
                '1:1 Extract and Soluble Salts',
                '1:1 soil/water Extraction',
                '11SWEX',
                'USDA Handbook 60',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                499,
                'PSDA, hydrometer, Air-dry, <2 mm Particles',
                'PSDA, Hydrometer, sand fractions wet sieved',
                'PSDA_hyd1',
                'SSSA, Gee and Or, 2002, sand fractions wet sieved',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                500,
                'PSDA, coulter counter, Air-dry, <2 mm Particles',
                'PSDA, coulter counter',
                'PSDA3',
                'University of Idaho Laboratory Analysis http://soils.ag.uidaho.edu/pedology/Analyses/index.htm',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                501,
                'Mineralogy, X-ray Diffraction Powder Mount',
                'X-ray Diffraction, Powder Mount',
                'XRAYPM',
                'NULL',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                502,
                'P-Nitrophenol, �-Glucosidase',
                'P-Nitrophenol, �-Glucosidase',
                'BIOBGLUCO',
                'SSIR No. 42, version 4, page 640',
                513,
                541,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=541',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                503,
                'Biomass, Hyper POM, C',
                'Biomass, Hyper POM, C',
                'BIOHPOM',
                'SSIR No. 42, version 4, page 385',
                509,
                537,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=537',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                504,
                'Visible Near Infrared',
                'Visible Near Infrared',
                'VNIR',
                'NULL',
                545,
                573,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=573',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                505,
                'PSDA, Ethanol Disp, Air-Dry, Ultrasonic, Pipet',
                'PSDA, Ethanol Disp, Air-Dry, Ultrasonic, Pipet',
                'EthPSDAAU',
                'NULL',
                '',
                28,
                '',
                'no code like that?';
INSERT INTO lab_analysis_procedure
            SELECT
                506,
                'Soil Color, C standard light source',
                'Soil Color, C',
                'COLOR_C',
                'University of California at Davis analysis - measurement via CR-410',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                507,
                'Bulk Density, 3D laser scanner',
                'Bulk Density, 3D',
                'DB_3D',
                'University of California at Davis analysis - https://www.soils.org/publications/sssaj/pdfs/72/6/1591',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                508,
                'Dithionite-Citrate Extract, Al',
                'Aluminum, Dithionite-Citrate-Bicarbonate Extraction',
                'AL_DITH',
                'U of Florida - http://flsoils.ifas.ufl.edu/params/citrate-dithionate.asp',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                509,
                'Water Release Curve',
                'Water Release Curve',
                'Wat_Rel_Cur',
                'U of Florida - http://flsoils.ifas.ufl.edu/params/waterrelease.asp',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                510,
                'Mid Infrared',
                'Mid Infrared',
                'MIR',
                'NULL',
                551,
                579,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=579',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                511,
                'Dithionite-Citrate Extract, Al',
                'Aluminum, Dithionite-Citrate Extraction, Aluminon I',
                'AL_DITH',
                'University of Idaho',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                512,
                'Organic Carbon',
                'Organic Carbon, dry combustion, CO2 evolution, gravimetric',
                'OC',
                'University of Missouri, modified 6A2d',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                513,
                'Clay Mineralogy, X-ray Diffraction',
                'X-ray Diffraction, Thin Film on Glass, Filter Peel',
                'XRAY2',
                'NULL',
                520,
                548,
                'http://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1253872.pdf#page=584',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                514,
                'Elements, Xray Flourescence',
                'Elements, Xray Flourescence',
                'XRAYF',
                'University of California, Soils were ground overnight in a ball mill, to approximately flour-like consistency.  Ground samples where then placed into sample cups with a polypropylene cover. Samples were then scanned with a Niton portable X-Ray fluorescence device (N800 & N900) for 3 minutes.',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                515,
                'Calcium Carbonate Equivalent, <2mm',
                'Calcium Carbonate Equivalent, HCl, <2mm (23b Salinity Lab)',
                'CACO3',
                'CaCO3 equivalent, Procedure 23b, USDA Handbook 60, US. Salinity Lab. 1954.',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                516,
                'Phosphorus, Bray 1',
                'Phosphorus, Bray 1',
                'BRAYP',
                'Phosphorus, Extractable P, Bry No. 1, Soil Sci. 59:39-45, 1945.',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                517,
                'PSDA, pipette with silt by elutriation, Air-dry, <2 mm',
                'PSDA, pipette with silt by elutriation, Air-dry, <2 mm',
                'PSDA4',
                'Silt by elutriation, sand by sieving',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                518,
                'Water Retention, 0 Bar, Pressure-Plate, <2mm',
                'Water Retention, 0 Bar, Pressure-Plate, <2mm',
                'H2O0Bar<2',
                'Water Content at saturation',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                519,
                'Water Retention, 0.33 Bar, Centrifuge, <2mm',
                'Water Retention, 0.33 Bar, Centrifuge, <2mm',
                'H2O.33Br<2',
                'Centrifuge. Briggs, L.J. and J.W. McLane "The Moisture equivalent of soils". USDA Bureau of Soils Bulletin 45, pp 1-23.',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                520,
                'CEC and Cations, Routine',
                'CEC and Cations, NH4OAc',
                'CECNH4_TAMU',
                'modified USDA Handbook 60',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                521,
                'Saturated Paste and Soluble Salts',
                'Saturated Paste and Soluble Salts',
                'SATP_TAMU',
                'modified USDA Handbook 60',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                522,
                'Carbonate, Chittick',
                'Carbonate, Chittick gasometric apparatus',
                'CARB_TAMU',
                'Quantitative gasometric determination of calcite and dolomite by using Chittick apparatus (http://www.geotech.ou.edu/ART/research/ChittickProcedure.pdf)',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                523,
                'OM LOI',
                'Organic Matter by Loss on Ignition',
                'OM_LOI',
                'NULL',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                524,
                'Extractable Cations, Mg',
                'Magnesium, NH4OAc Extraction, Colorimetric',
                'MgExCat12',
                'Color was developed by successive additions of hydroxylamine chloride solution, gum Arabic solution, clayton yellow solution and NaOH solution.  Each addition is followed by shaking.  The color of the test solution is compared visually with the colors of prepared standard solutions.',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                '',
                'Bulk Density, <2 mm Fraction, 1/10 Bar',
                'Bulk Density, 1/10-Bar Desorption',
                'unknown',
                'SSIR No. 1, version 1974, page 15',
                '',
                28,
                '',
                '';
INSERT INTO lab_analysis_procedure
            SELECT
                '',
                'Sample Preparation',
                'Bulk Sample Preparation',
                'BlkSmpPrep',
                'SSIR No. 42, version 4, page 16',
                '',
                28,
                '',
                '';

go
