/*
Load transportation.csv into cioc_data_loader database; switch to target CIOC DB
For best results, add/update Codes in existing opportunities prior to running this script.
Warning: Minimal error checking; no duplicate name checks. Wtrpl error on duplicate. No removals.
 */

-- PREVIEW CHANGES
SELECT transportation.Code, [Name (fr-CA)], trp.Code, trpn.Name
  FROM cioc_data_loader.dbo.transportation
  LEFT JOIN dbo.VOL_Transportation trp ON trp.Code = transportation.Code
  LEFT JOIN dbo.VOL_Transportation_Name trpn ON trpn.TRP_ID = trp.TRP_ID AND trpn.LangID=2
WHERE trpn.Name<>[Name (fr-CA)] OR trpn.Name IS NULL

SELECT transportation.Code, [Name (en-CA)], trp.Code, trpn.Name
  FROM cioc_data_loader.dbo.transportation
  LEFT JOIN dbo.VOL_Transportation trp ON trp.Code = transportation.Code
  LEFT JOIN dbo.VOL_Transportation_Name trpn ON trpn.TRP_ID = trp.TRP_ID AND trpn.LangID=0
WHERE trpn.Name<>[Name (en-CA)] OR trpn.Name IS NULL

-- DO UPDATES
INSERT INTO dbo.VOL_Transportation (Code)
SELECT Code FROM cioc_data_loader.dbo.transportation
WHERE NOT EXISTS(SELECT * FROM dbo.VOL_Transportation trp WHERE trp.Code=transportation.Code)

UPDATE trpn 
	SET trpn.Name=[Name (fr-CA)]
  FROM dbo.VOL_Transportation trp
  INNER JOIN cioc_data_loader.dbo.transportation ON trp.Code = transportation.Code
  INNER JOIN dbo.VOL_Transportation_Name trpn ON trpn.TRP_ID = trp.TRP_ID AND trpn.LangID=2
WHERE trpn.Name<>[Name (fr-CA)]
	AND [Name (fr-CA)] IS NOT NULL

INSERT INTO dbo.VOL_Transportation_Name
        ( TRP_ID, LangID, Name )
SELECT trp.TRP_ID, 2, [Name (fr-CA)]
  FROM dbo.VOL_Transportation trp
  INNER JOIN cioc_data_loader.dbo.transportation ON trp.Code = transportation.Code
WHERE NOT EXISTS(SELECT * FROM	dbo.VOL_Transportation_Name trpn WHERE	trpn.TRP_ID = trp.TRP_ID AND trpn.LangID=2)
	AND [Name (fr-CA)] IS NOT NULL

UPDATE trpn
	SET trpn.Name=[Name (en-CA)]
  FROM dbo.VOL_Transportation trp
  INNER JOIN cioc_data_loader.dbo.transportation ON trp.Code = transportation.Code
  INNER JOIN dbo.VOL_Transportation_Name trpn ON trpn.TRP_ID = trp.TRP_ID AND trpn.LangID=0
WHERE trpn.Name<>[Name (en-CA)]

INSERT INTO dbo.VOL_Transportation_Name
        ( TRP_ID, LangID, Name )
SELECT trp.TRP_ID, 0, [Name (en-CA)]
  FROM dbo.VOL_Transportation trp
  INNER JOIN cioc_data_loader.dbo.transportation ON trp.Code = transportation.Code
WHERE NOT EXISTS(SELECT * FROM	dbo.VOL_Transportation_Name trpn WHERE	trpn.TRP_ID = trp.TRP_ID AND trpn.LangID=0)
	AND [Name (en-CA)] IS NOT NULL
