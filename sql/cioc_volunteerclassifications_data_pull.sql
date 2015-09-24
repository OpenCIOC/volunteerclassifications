/*
SQL to Generate Open Data files for Volunteer Checklists from CIOC Database
*/

-- Interaction Level (interactionlevel.csv)
SELECT Code, [en-CA] AS [Name (en-CA)], [fr-CA] AS [Name (fr-CA)]
FROM (
	SELECT il.Code, il.DisplayOrder, sln.Culture, iln.Name
	FROM dbo.VOL_InteractionLevel il
	INNER JOIN dbo.VOL_InteractionLevel_Name iln ON iln.IL_ID = il.IL_ID
	INNER JOIN dbo.STP_Language sln ON sln.LangID = iln.LangID
	WHERE il.MemberID IS NULL
) src
PIVOT (
	MAX(Name)
	FOR Culture IN ([en-CA],[fr-CA])
) AS pvt
ORDER BY DisplayOrder, Code

-- Interests (interest.csv)
SELECT Code, [en-CA] AS [Name (en-CA)], [fr-CA] AS [Name (fr-CA)],
	STUFF((SELECT ' ; ' + ig.Code
		FROM dbo.VOL_InterestGroup ig
		INNER JOIN dbo.VOL_AI_IG igai ON igai.IG_ID = ig.IG_ID AND igai.AI_ID=AIID
		FOR XML PATH('')), 1,3,'') AS Groups
FROM (
	SELECT ai.Code, sln.Culture, ain.Name, ai.AI_ID AS AIID
	FROM dbo.VOL_Interest ai
	INNER JOIN dbo.VOL_Interest_Name ain ON ain.AI_ID = ai.AI_ID
	INNER JOIN dbo.STP_Language sln ON sln.LangID = ain.LangID
) src
PIVOT (
	MAX(Name)
	FOR Culture IN ([en-CA],[fr-CA])
) AS pvt
ORDER BY Code

-- Interest Groups (interestgroup.csv)

SELECT Code, [en-CA] AS [Name (en-CA)], [fr-CA] AS [Name (fr-CA)]
FROM (
	SELECT ig.Code, sln.Culture, ign.Name, ig.IG_ID AS IGID
	FROM dbo.VOL_InterestGroup ig
	INNER JOIN dbo.VOL_InterestGroup_Name ign ON ign.IG_ID = ig.IG_ID
	INNER JOIN dbo.STP_Language sln ON sln.LangID = ign.LangID
) src
PIVOT (
	MAX(Name)
	FOR Culture IN ([en-CA],[fr-CA])
) AS pvt
ORDER BY Code

-- Seasons (season.csv)
SELECT Code, [en-CA] AS [Name (en-CA)], [fr-CA] AS [Name (fr-CA)]
FROM (
	SELECT ssn.Code, ssn.DisplayOrder, sln.Culture, ssnn.Name
	FROM dbo.VOL_Seasons ssn
	INNER JOIN dbo.VOL_Seasons_Name ssnn ON ssnn.SSN_ID = ssn.SSN_ID
	INNER JOIN dbo.STP_Language sln ON sln.LangID = ssnn.LangID
	WHERE ssn.MemberID IS NULL
) src
PIVOT (
	MAX(Name)
	FOR Culture IN ([en-CA],[fr-CA])
) AS pvt
ORDER BY DisplayOrder, Code

-- Skills & Experience (skillexperience.csv)
SELECT Code, [en-CA] AS [Name (en-CA)], [fr-CA] AS [Name (fr-CA)]
FROM (
	SELECT sk.Code, sk.DisplayOrder, sln.Culture, skn.Name
	FROM dbo.VOL_Skill sk
	INNER JOIN dbo.VOL_Skill_Name skn ON skn.SK_ID = sk.SK_ID
	INNER JOIN dbo.STP_Language sln ON sln.LangID = skn.LangID
	WHERE sk.MemberID IS NULL
) src
PIVOT (
	MAX(Name)
	FOR Culture IN ([en-CA],[fr-CA])
) AS pvt
ORDER BY DisplayOrder, Code

-- Suitability (suitability.csv)
SELECT Code, [en-CA] AS [Name (en-CA)], [fr-CA] AS [Name (fr-CA)]
FROM (
	SELECT sb.Code, sb.DisplayOrder, sln.Culture, sbn.Name
	FROM dbo.VOL_Suitability sb
	INNER JOIN dbo.VOL_Suitability_Name sbn ON sbn.SB_ID = sb.SB_ID
	INNER JOIN dbo.STP_Language sln ON sln.LangID = sbn.LangID
	WHERE sb.MemberID IS NULL
) src
PIVOT
(
	MAX(Name)
	FOR Culture IN ([en-CA],[fr-CA])
) AS pvt
ORDER BY DisplayOrder, Code

-- Training (training.csv)
SELECT Code, [en-CA] AS [Name (en-CA)], [fr-CA] AS [Name (fr-CA)]
FROM (
	SELECT trn.Code, trn.DisplayOrder, sln.Culture, trnn.Name
	FROM dbo.VOL_Training trn
	INNER JOIN dbo.VOL_Training_Name trnn ON trnn.TRN_ID = trn.TRN_ID
	INNER JOIN dbo.STP_Language sln ON sln.LangID = trnn.LangID
	WHERE trn.MemberID IS NULL
) src
PIVOT (
	MAX(Name)
	FOR Culture IN ([en-CA],[fr-CA])
) AS pvt
ORDER BY DisplayOrder, Code

-- Transportation (transportation.csv)

SELECT Code, [en-CA] AS [Name (en-CA)], [fr-CA] AS [Name (fr-CA)]
FROM (
	SELECT trp.Code, trp.DisplayOrder, sln.Culture, trpn.Name
	FROM dbo.VOL_Transportation trp
	INNER JOIN dbo.VOL_Transportation_Name trpn ON trpn.TRP_ID = trp.TRP_ID
	INNER JOIN dbo.STP_Language sln ON sln.LangID = trpn.LangID
	WHERE trp.MemberID IS NULL
) src
PIVOT (
	MAX(Name)
	FOR Culture IN ([en-CA],[fr-CA])
) AS pvt
ORDER BY DisplayOrder, Code

