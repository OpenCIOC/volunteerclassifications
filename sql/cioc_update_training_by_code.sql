/*
Load training.csv into cioc_data_loader database; switch to target CIOC DB
For best results, add/update Codes in existing opportunities prior to running this script.
Warning: Minimal error checking; no duplicate name checks. Wtrnl error on duplicate. No removals.
 */

-- PREVIEW CHANGES
SELECT training.Code, [Name (fr-CA)], trn.Code, trnn.Name
  FROM cioc_data_loader.dbo.training
  LEFT JOIN dbo.VOL_Training trn ON trn.Code = training.Code
  LEFT JOIN dbo.VOL_Training_Name trnn ON trnn.TRN_ID = trn.TRN_ID AND trnn.LangID=2
WHERE trnn.Name<>[Name (fr-CA)] OR trnn.Name IS NULL

SELECT training.Code, [Name (en-CA)], trn.Code, trnn.Name
  FROM cioc_data_loader.dbo.training
  LEFT JOIN dbo.VOL_Training trn ON trn.Code = training.Code
  LEFT JOIN dbo.VOL_Training_Name trnn ON trnn.TRN_ID = trn.TRN_ID AND trnn.LangID=0
WHERE trnn.Name<>[Name (en-CA)] OR trnn.Name IS NULL

-- DO UPDATES
INSERT INTO dbo.VOL_Training (Code)
SELECT Code FROM cioc_data_loader.dbo.training
WHERE NOT EXISTS(SELECT * FROM dbo.VOL_Training trn WHERE trn.Code=training.Code)

UPDATE trnn 
	SET trnn.Name=[Name (fr-CA)]
  FROM dbo.VOL_Training trn
  INNER JOIN cioc_data_loader.dbo.training ON trn.Code = training.Code
  INNER JOIN dbo.VOL_Training_Name trnn ON trnn.TRN_ID = trn.TRN_ID AND trnn.LangID=2
WHERE trnn.Name<>[Name (fr-CA)]
	AND [Name (fr-CA)] IS NOT NULL

INSERT INTO dbo.VOL_Training_Name
        ( TRN_ID, LangID, Name )
SELECT trn.TRN_ID, 2, [Name (fr-CA)]
  FROM dbo.VOL_Training trn
  INNER JOIN cioc_data_loader.dbo.training ON trn.Code = training.Code
WHERE NOT EXISTS(SELECT * FROM	dbo.VOL_Training_Name trnn WHERE	trnn.TRN_ID = trn.TRN_ID AND trnn.LangID=2)
	AND [Name (fr-CA)] IS NOT NULL

UPDATE trnn
	SET trnn.Name=[Name (en-CA)]
  FROM dbo.VOL_Training trn
  INNER JOIN cioc_data_loader.dbo.training ON trn.Code = training.Code
  INNER JOIN dbo.VOL_Training_Name trnn ON trnn.TRN_ID = trn.TRN_ID AND trnn.LangID=0
WHERE trnn.Name<>[Name (en-CA)]

INSERT INTO dbo.VOL_Training_Name
        ( TRN_ID, LangID, Name )
SELECT trn.TRN_ID, 0, [Name (en-CA)]
  FROM dbo.VOL_Training trn
  INNER JOIN cioc_data_loader.dbo.training ON trn.Code = training.Code
WHERE NOT EXISTS(SELECT * FROM	dbo.VOL_Training_Name trnn WHERE	trnn.TRN_ID = trn.TRN_ID AND trnn.LangID=0)
	AND [Name (en-CA)] IS NOT NULL
