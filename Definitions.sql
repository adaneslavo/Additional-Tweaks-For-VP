--==========================================================================================================================
-- COMPATIBILITY
--==========================================================================================================================	
/*
Custom Civilizations compatibility patches!
0 = Disabled disregarding if its detects new custom civilizations.
1 = Enabled if it detects new custom civilizations.
2 = Disabled until it detects something! (Default)
*/

INSERT INTO COMMUNITY	
		(Type,								Value)
VALUES	('AT-CIVILIZATION-AINU', 			2), -- @gwennog's part
		('AT-CIVILIZATION-CORSICA', 		2),
		('AT-CIVILIZATION-LOUISIANA', 		2);

UPDATE Community SET Value = '1' WHERE Type = 'AT-CIVILIZATION-AINU' AND EXISTS (SELECT * FROM Civilizations WHERE Type = 'CIVILIZATION_HININ_AINU') AND NOT EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'AT-CIVILIZATION-AINU' AND Value = 0);
UPDATE Community SET Value = '1' WHERE Type = 'AT-CIVILIZATION-CORSICA' AND EXISTS (SELECT * FROM Civilizations WHERE Type = 'CIVILIZATION_DMS_CORSICA') AND NOT EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'AT-CIVILIZATION-CORSICA' AND Value = 0);
UPDATE Community SET Value = '1' WHERE Type = 'AT-CIVILIZATION-LOUISIANA' AND EXISTS (SELECT * FROM Civilizations WHERE Type='CIVILIZATION_GH_LOUISIANA') AND NOT EXISTS (SELECT * FROM COMMUNITY WHERE Type='AT-CIVILIZATION-LOUISIANA' AND Value=0);
--==========================================================================================================================
-- ATLASES
--==========================================================================================================================	
INSERT INTO IconTextureAtlases 
			(Atlas, 					IconSize, 	Filename, 						IconsPerRow, 	IconsPerColumn)
VALUES 		('AT_PROMOTION_ATLAS', 		'256', 		'AT_Promotions_256.dds', 		8, 				1),
 			('AT_PROMOTION_ATLAS', 		'64', 		'AT_Promotions_64.dds', 		8, 				1),
 			('AT_PROMOTION_ATLAS', 		'45', 		'AT_Promotions_45.dds', 		8, 				1),
 			('AT_PROMOTION_ATLAS', 		'32', 		'AT_Promotions_32.dds', 		8, 				1),
 			('AT_PROMOTION_ATLAS', 		'16', 		'AT_Promotions_16.dds', 		8, 				1);
