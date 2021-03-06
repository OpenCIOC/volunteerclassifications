/*
Load interest.csv into cioc_data_loader database; switch to target CIOC DB
For best results, add/update Codes in existing opportunities prior to running this script.
Warning: Minimal error checking; no duplicate name checks. Will error on duplicate. No removals.

Currently does not do Interest Group mapping
 */

-- PREVIEW CHANGES
SELECT interest.Code, [Name (fr-CA)], ai.Code, ain.Name
  FROM cioc_data_loader.dbo.interest
  LEFT JOIN dbo.VOL_Interest ai ON ai.Code = interest.Code
  LEFT JOIN dbo.VOL_Interest_Name ain ON ain.AI_ID = ai.AI_ID AND ain.LangID=2
WHERE ain.Name<>[Name (fr-CA)] OR ain.Name IS NULL

SELECT interest.Code, [Name (en-CA)], ai.Code, ain.Name
  FROM cioc_data_loader.dbo.interest
  LEFT JOIN dbo.VOL_Interest ai ON ai.Code = interest.Code
  LEFT JOIN dbo.VOL_Interest_Name ain ON ain.AI_ID = ai.AI_ID AND ain.LangID=0
WHERE ain.Name<>[Name (en-CA)] OR ain.Name IS NULL

-- DO UPDATES
INSERT INTO dbo.VOL_Interest (Code)
SELECT Code FROM cioc_data_loader.dbo.interest
WHERE NOT EXISTS(SELECT * FROM dbo.VOL_Interest ai WHERE ai.Code=interest.Code)

UPDATE ain 
	SET ain.Name=[Name (fr-CA)]
  FROM dbo.VOL_Interest ai
  INNER JOIN cioc_data_loader.dbo.interest ON ai.Code = interest.Code
  INNER JOIN dbo.VOL_Interest_Name ain ON ain.AI_ID = ai.AI_ID AND ain.LangID=2
WHERE ain.Name<>[Name (fr-CA)]
	AND [Name (fr-CA)] IS NOT NULL

INSERT INTO dbo.VOL_Interest_Name
        ( AI_ID, LangID, Name )
SELECT ai.AI_ID, 2, [Name (fr-CA)]
  FROM dbo.VOL_Interest ai
  INNER JOIN cioc_data_loader.dbo.interest ON ai.Code = interest.Code
WHERE NOT EXISTS(SELECT * FROM	dbo.VOL_Interest_Name ain WHERE	ain.AI_ID = ai.AI_ID AND ain.LangID=2)
	AND [Name (fr-CA)] IS NOT NULL

UPDATE ain
	SET ain.Name=[Name (en-CA)]
  FROM dbo.VOL_Interest ai
  INNER JOIN cioc_data_loader.dbo.interest ON ai.Code = interest.Code
  INNER JOIN dbo.VOL_Interest_Name ain ON ain.AI_ID = ai.AI_ID AND ain.LangID=0
WHERE ain.Name<>[Name (en-CA)]

INSERT INTO dbo.VOL_Interest_Name
        ( AI_ID, LangID, Name )
SELECT ai.AI_ID, 0, [Name (en-CA)]
  FROM dbo.VOL_Interest ai
  INNER JOIN cioc_data_loader.dbo.interest ON ai.Code = interest.Code
WHERE NOT EXISTS(SELECT * FROM	dbo.VOL_Interest_Name ain WHERE	ain.AI_ID = ai.AI_ID AND ain.LangID=0)
	AND [Name (en-CA)] IS NOT NULL
