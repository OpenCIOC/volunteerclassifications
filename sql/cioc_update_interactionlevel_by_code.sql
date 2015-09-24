/*
Load interactionlevel.csv into cioc_data_loader database; switch to target CIOC DB
For best results, add/update Codes in existing opportunities prior to running this script.
Warning: Minimal error checking; no duplicate name checks. Will error on duplicate. No removals.
 */

-- PREVIEW CHANGES
SELECT interactionlevel.Code, [Name (fr-CA)], il.Code, iln.Name
  FROM cioc_data_loader.dbo.interactionlevel
  LEFT JOIN dbo.VOL_InteractionLevel il ON il.Code = interactionlevel.Code
  LEFT JOIN dbo.VOL_InteractionLevel_Name iln ON iln.IL_ID = il.IL_ID AND iln.LangID=2
WHERE iln.Name<>[Name (fr-CA)] OR iln.Name IS NULL

SELECT interactionlevel.Code, [Name (en-CA)], il.Code, iln.Name
  FROM cioc_data_loader.dbo.interactionlevel
  LEFT JOIN dbo.VOL_InteractionLevel il ON il.Code = interactionlevel.Code
  LEFT JOIN dbo.VOL_InteractionLevel_Name iln ON iln.IL_ID = il.IL_ID AND iln.LangID=0
WHERE iln.Name<>[Name (en-CA)] OR iln.Name IS NULL

-- DO UPDATES
INSERT INTO dbo.VOL_InteractionLevel (Code)
SELECT Code FROM cioc_data_loader.dbo.interactionlevel
WHERE NOT EXISTS(SELECT * FROM dbo.VOL_InteractionLevel il WHERE il.Code=interactionlevel.Code)

UPDATE iln 
	SET iln.Name=[Name (fr-CA)]
  FROM dbo.VOL_InteractionLevel il
  INNER JOIN cioc_data_loader.dbo.interactionlevel ON il.Code = interactionlevel.Code
  INNER JOIN dbo.VOL_InteractionLevel_Name iln ON iln.IL_ID = il.IL_ID AND iln.LangID=2
WHERE iln.Name<>[Name (fr-CA)]
	AND [Name (fr-CA)] IS NOT NULL

INSERT INTO dbo.VOL_InteractionLevel_Name
        ( IL_ID, LangID, Name )
SELECT il.IL_ID, 2, [Name (fr-CA)]
  FROM dbo.VOL_InteractionLevel il
  INNER JOIN cioc_data_loader.dbo.interactionlevel ON il.Code = interactionlevel.Code
WHERE NOT EXISTS(SELECT * FROM	dbo.VOL_InteractionLevel_Name iln WHERE	iln.IL_ID = il.IL_ID AND iln.LangID=2)
	AND [Name (fr-CA)] IS NOT NULL

UPDATE iln
	SET iln.Name=[Name (en-CA)]
  FROM dbo.VOL_InteractionLevel il
  INNER JOIN cioc_data_loader.dbo.interactionlevel ON il.Code = interactionlevel.Code
  INNER JOIN dbo.VOL_InteractionLevel_Name iln ON iln.IL_ID = il.IL_ID AND iln.LangID=0
WHERE iln.Name<>[Name (en-CA)]

INSERT INTO dbo.VOL_InteractionLevel_Name
        ( IL_ID, LangID, Name )
SELECT il.IL_ID, 0, [Name (en-CA)]
  FROM dbo.VOL_InteractionLevel il
  INNER JOIN cioc_data_loader.dbo.interactionlevel ON il.Code = interactionlevel.Code
WHERE NOT EXISTS(SELECT * FROM	dbo.VOL_InteractionLevel_Name iln WHERE	iln.IL_ID = il.IL_ID AND iln.LangID=0)
	AND [Name (en-CA)] IS NOT NULL
