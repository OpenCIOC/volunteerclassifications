/*
Load skillexperience.csv into cioc_data_loader database; switch to target CIOC DB
For best results, add/update Codes in existing opportunities prior to running this script.
Warning: Minimal error checking; no duplicate name checks. Wskl error on duplicate. No removals.
 */

-- PREVIEW CHANGES
SELECT skillexperience.Code, [Name (fr-CA)], sk.Code, skn.Name
  FROM cioc_data_loader.dbo.skillexperience
  LEFT JOIN dbo.VOL_Skill sk ON sk.Code = skillexperience.Code
  LEFT JOIN dbo.VOL_Skill_Name skn ON skn.SK_ID = sk.SK_ID AND skn.LangID=2
WHERE skn.Name<>[Name (fr-CA)] OR skn.Name IS NULL

SELECT skillexperience.Code, [Name (en-CA)], sk.Code, skn.Name
  FROM cioc_data_loader.dbo.skillexperience
  LEFT JOIN dbo.VOL_Skill sk ON sk.Code = skillexperience.Code
  LEFT JOIN dbo.VOL_Skill_Name skn ON skn.SK_ID = sk.SK_ID AND skn.LangID=0
WHERE skn.Name<>[Name (en-CA)] OR skn.Name IS NULL

-- DO UPDATES
INSERT INTO dbo.VOL_Skill (Code)
SELECT Code FROM cioc_data_loader.dbo.skillexperience
WHERE NOT EXISTS(SELECT * FROM dbo.VOL_Skill sk WHERE sk.Code=skillexperience.Code)

UPDATE skn 
	SET skn.Name=[Name (fr-CA)]
  FROM dbo.VOL_Skill sk
  INNER JOIN cioc_data_loader.dbo.skillexperience ON sk.Code = skillexperience.Code
  INNER JOIN dbo.VOL_Skill_Name skn ON skn.SK_ID = sk.SK_ID AND skn.LangID=2
WHERE skn.Name<>[Name (fr-CA)]
	AND [Name (fr-CA)] IS NOT NULL

INSERT INTO dbo.VOL_Skill_Name
        ( SK_ID, LangID, Name )
SELECT sk.SK_ID, 2, [Name (fr-CA)]
  FROM dbo.VOL_Skill sk
  INNER JOIN cioc_data_loader.dbo.skillexperience ON sk.Code = skillexperience.Code
WHERE NOT EXISTS(SELECT * FROM	dbo.VOL_Skill_Name skn WHERE	skn.SK_ID = sk.SK_ID AND skn.LangID=2)
	AND [Name (fr-CA)] IS NOT NULL

UPDATE skn
	SET skn.Name=[Name (en-CA)]
  FROM dbo.VOL_Skill sk
  INNER JOIN cioc_data_loader.dbo.skillexperience ON sk.Code = skillexperience.Code
  INNER JOIN dbo.VOL_Skill_Name skn ON skn.SK_ID = sk.SK_ID AND skn.LangID=0
WHERE skn.Name<>[Name (en-CA)]

INSERT INTO dbo.VOL_Skill_Name
        ( SK_ID, LangID, Name )
SELECT sk.SK_ID, 0, [Name (en-CA)]
  FROM dbo.VOL_Skill sk
  INNER JOIN cioc_data_loader.dbo.skillexperience ON sk.Code = skillexperience.Code
WHERE NOT EXISTS(SELECT * FROM	dbo.VOL_Skill_Name skn WHERE	skn.SK_ID = sk.SK_ID AND skn.LangID=0)
	AND [Name (en-CA)] IS NOT NULL
