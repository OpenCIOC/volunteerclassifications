/*
Load interestgroup.csv into cioc_data_loader database; switch to target CIOC DB
For best results, add/update Codes in existing opportunities prior to running this script.
Warning: Minimal error checking; no duplicate name checks. Will error on duplicate. No removals.
 */

-- PREVIEW CHANGES
SELECT interestgroup.Code, [Name (fr-CA)], ig.Code, ign.Name
  FROM cioc_data_loader.dbo.interestgroup
  LEFT JOIN dbo.VOL_InterestGroup ig ON ig.Code = interestgroup.Code
  LEFT JOIN dbo.VOL_InterestGroup_Name ign ON ign.IG_ID = ig.IG_ID AND ign.LangID=2
WHERE ign.Name<>[Name (fr-CA)] OR ign.Name IS NULL

SELECT interestgroup.Code, [Name (en-CA)], ig.Code, ign.Name
  FROM cioc_data_loader.dbo.interestgroup
  LEFT JOIN dbo.VOL_InterestGroup ig ON ig.Code = interestgroup.Code
  LEFT JOIN dbo.VOL_InterestGroup_Name ign ON ign.IG_ID = ig.IG_ID AND ign.LangID=0
WHERE ign.Name<>[Name (en-CA)] OR ign.Name IS NULL

-- DO UPDATES
INSERT INTO dbo.VOL_InterestGroup (Code)
SELECT Code FROM cioc_data_loader.dbo.interestgroup
WHERE NOT EXISTS(SELECT * FROM dbo.VOL_InterestGroup ig WHERE ig.Code=interestgroup.Code)

UPDATE ign 
	SET ign.Name=[Name (fr-CA)]
  FROM dbo.VOL_InterestGroup ig
  INNER JOIN cioc_data_loader.dbo.interestgroup ON ig.Code = interestgroup.Code
  INNER JOIN dbo.VOL_InterestGroup_Name ign ON ign.IG_ID = ig.IG_ID AND ign.LangID=2
WHERE ign.Name<>[Name (fr-CA)]
	AND [Name (fr-CA)] IS NOT NULL

INSERT INTO dbo.VOL_InterestGroup_Name
        ( IG_ID, LangID, Name )
SELECT ig.IG_ID, 2, [Name (fr-CA)]
  FROM dbo.VOL_InterestGroup ig
  INNER JOIN cioc_data_loader.dbo.interestgroup ON ig.Code = interestgroup.Code
WHERE NOT EXISTS(SELECT * FROM	dbo.VOL_InterestGroup_Name ign WHERE	ign.IG_ID = ig.IG_ID AND ign.LangID=2)
	AND [Name (fr-CA)] IS NOT NULL

UPDATE ign
	SET ign.Name=[Name (en-CA)]
  FROM dbo.VOL_InterestGroup ig
  INNER JOIN cioc_data_loader.dbo.interestgroup ON ig.Code = interestgroup.Code
  INNER JOIN dbo.VOL_InterestGroup_Name ign ON ign.IG_ID = ig.IG_ID AND ign.LangID=0
WHERE ign.Name<>[Name (en-CA)]

INSERT INTO dbo.VOL_InterestGroup_Name
        ( IG_ID, LangID, Name )
SELECT ig.IG_ID, 0, [Name (en-CA)]
  FROM dbo.VOL_InterestGroup ig
  INNER JOIN cioc_data_loader.dbo.interestgroup ON ig.Code = interestgroup.Code
WHERE NOT EXISTS(SELECT * FROM	dbo.VOL_InterestGroup_Name ign WHERE	ign.IG_ID = ig.IG_ID AND ign.LangID=0)
	AND [Name (en-CA)] IS NOT NULL
