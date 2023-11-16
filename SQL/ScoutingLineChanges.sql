---------------------------------------------------
-- Mofification of scouting line that focuses on better accessibility to water tiles, embarking and fighting on difficult terrain
-- new promotions: Canoe, Floater;
-- Frogman moved in between to the new leaf; no tech requirement;
-- Traiblazer 3 lost Embarkation;
-- 
-- Canoe ────────────► Frogman ───────────────────────────► Floater
--
-- Survivalism I ─┬──► Survivalism II ─────────────────┬──► Survivalism III ──────────────────────────────┐
--                │                                    │                                                  │
--                │                                    ├──► Medic I ───► Medic II                         │
--                │                                    │                                                  ├──► Screening
--                │                                    ├──► Scouting I ───► Scouting II ───► Scouting III │
--                │                                    │                                                  │
-- Trailblazer I ─┴──► Trailblazer II ─────────────────┴──► Trailblazer III ──────────────────────────────┘
---------------------------------------------------
INSERT INTO Language_en_US 
			(Tag, Text)
VALUES		('TXT_KEY_PROMOTION_CANOE', 		'Canoe'),
			('TXT_KEY_PROMOTION_CANOE_HELP', 	'Allows Embarkation. +1 [ICON_MOVES] Movement Point and +25% [ICON_STRENGTH] Defensive CS while embarked.'),
			('TXT_KEY_PROMOTION_FLOATER', 		'Floater'),
			('TXT_KEY_PROMOTION_FLOATER_HELP', 	'Double [ICON_MOVES] Movement and Healing, and +10% [ICON_STRENGTH] Defensive CS on Marsh, Oasis and Flood Plains.');

UPDATE Language_en_US SET Text = REPLACE(Text, ' Embark,', '') WHERE Tag ='TXT_KEY_PROMOTION_WOODLAND_TRAILBLAZER_3_HELP';
---------------------------------------------------
INSERT INTO UnitPromotions 
			(Type, 					Description, 					Help, 								CannotBeChosen, Sound, 				PortraitIndex, 	IconAtlas, 				PediaType, 			PediaEntry)
VALUES 		('PROMOTION_CANOE', 	'TXT_KEY_PROMOTION_CANOE', 		'TXT_KEY_PROMOTION_CANOE_HELP', 	0, 				'AS2D_IF_LEVELUP', 	0, 				'AT_PROMOTION_ATLAS', 	'PEDIA_SCOUTING', 	'TXT_KEY_PROMOTION_CANOE'),
	 		('PROMOTION_FLOATER', 	'TXT_KEY_PROMOTION_FLOATER', 	'TXT_KEY_PROMOTION_FLOATER_HELP', 	0, 				'AS2D_IF_LEVELUP', 	1, 				'AT_PROMOTION_ATLAS', 	'PEDIA_SCOUTING', 	'TXT_KEY_PROMOTION_FLOATER');

UPDATE UnitPromotions SET AllowsEmbarkation = 0 WHERE Type = 'PROMOTION_WOODLAND_TRAILBLAZER_3';
UPDATE UnitPromotions SET TechPrereq = NULL WHERE Type = 'PROMOTION_FROGMAN';

UPDATE UnitPromotions SET AllowsEmbarkation = 1, ExtraNavalMovement = 1, EmbarkDefenseModifier = 25 WHERE Type = 'PROMOTION_CANOE';

UPDATE UnitPromotions SET PromotionPrereqOr1 = 'PROMOTION_CANOE', PromotionPrereqOr2 = NULL WHERE Type = 'PROMOTION_FROGMAN';
UPDATE UnitPromotions SET PromotionPrereqOr1 = 'PROMOTION_FROGMAN' WHERE Type = 'PROMOTION_FLOATER';

UPDATE UnitPromotions SET RankList = 'SCOUT_EMBARKATION', FlagPromoOrder = 103 WHERE Type IN ('PROMOTION_CANOE', 'PROMOTION_FROGMAN', 'PROMOTION_FLOATER');
UPDATE UnitPromotions SET RankNumber = 1 WHERE Type = 'PROMOTION_CANOE';
UPDATE UnitPromotions SET RankNumber = 2 WHERE Type = 'PROMOTION_FROGMAN';
UPDATE UnitPromotions SET RankNumber = 3 WHERE Type = 'PROMOTION_FLOATER';

INSERT INTO UnitPromotions_Features
			(PromotionType, 			FeatureType, 				DoubleMove, DoubleHeal,	Attack, Defense)
VALUES 		('PROMOTION_FLOATER', 		'FEATURE_MARSH', 			1, 			1,			0, 		10),
 			('PROMOTION_FLOATER', 		'FEATURE_OASIS', 			1, 			1,			0, 		10),
 			('PROMOTION_FLOATER', 		'FEATURE_FLOOD_PLAINS', 	1, 			1,			0, 		10);

UPDATE UnitPromotions SET OrderPriority = 102, FlagPromoOrder = 102 WHERE Type IN (
	'PROMOTION_CANOE',
	'PROMOTION_FROGMAN',
	'PROMOTION_FLOATER'
);

INSERT INTO UnitPromotions_UnitCombats 
			(PromotionType, 		UnitCombatType)
VALUES  	('PROMOTION_CANOE', 	'UNITCOMBAT_RECON'),
			('PROMOTION_FLOATER', 	'UNITCOMBAT_RECON');

---------------------------------------------------
-- Mofification of scouting line based on @ma_kuh's proposal from Congress #6
-- https://forums.civfanatics.com/threads/6-cp-recon-unit-line-swap-trailblazer-and-scouting-as-stem-leaf-promotions.686004/
--
-- Scouting replaced Trailblazer as a main stem; Scouting II and III swapped; added CS bonus outside friendly lands (same like for Trailblazer);
-- all Trailblazers (I-III) became tier 4 promotions with unique names; T2 lost ZOC;
-- Screening moved 1 tier back;
-- all units past Scout receive free "ignore ZOC";
-- reordered promotions in the flag menu
--
-- Canoe ────────────► Frogman ───────────► Floater
--
-- Survivalism I ────► Survivalism II ─┬──► Survivalism III ──────┐
--                                     │                          ├──► Trailblazer
--                                     ├──► Medic I ───► Medic II │
--                                     │                          ├──► Wayfarer
--                                     ├──► Screening             │
--                                     │                          ├──► Voyager
-- Scouting I ───────► Scouting II ────┴──► Scouting III ─────────┘
---------------------------------------------------
INSERT INTO Language_en_US 
			(Tag, Text)
VALUES		('TXT_KEY_PROMOTION_UNSTOPPABLE', 		'Unstoppable'),
			('TXT_KEY_PROMOTION_UNSTOPPABLE_HELP', 	'Ignores[COLOR_POSITIVE_TEXT] Zone of Control[ENDCOLOR].');

UPDATE Language_en_US SET Text = 'Trailblazer' WHERE Tag = 'TXT_KEY_PROMOTION_WOODLAND_TRAILBLAZER_1';
UPDATE Language_en_US SET Text = 'Wayfarer' WHERE Tag = 'TXT_KEY_PROMOTION_WOODLAND_TRAILBLAZER_2';
UPDATE Language_en_US SET Text = 'Voyager' WHERE Tag = 'TXT_KEY_PROMOTION_WOODLAND_TRAILBLAZER_3';

UPDATE Language_en_US SET Text = REPLACE(Text, '[NEWLINE]Ignores [COLOR_POSITIVE_TEXT]Zone of Control[ENDCOLOR].', '') WHERE Tag = 'TXT_KEY_PROMOTION_WOODLAND_TRAILBLAZER_2_HELP';
UPDATE Language_en_US SET Text = '+1 [ICON_MOVES] Movement.' WHERE Tag = 'TXT_KEY_PROMOTION_SCOUTING_2_HELP';
UPDATE Language_en_US SET Text = '+1 [ICON_SIGHT] Sight.' WHERE Tag = 'TXT_KEY_PROMOTION_SCOUTING_3_HELP';
UPDATE Language_en_US SET Text = Text||' +10% [ICON_STRENGTH] CS outside Friendly territory.' WHERE Tag IN ('TXT_KEY_PROMOTION_SCOUTING_1_HELP', 'TXT_KEY_PROMOTION_SCOUTING_3_HELP');
---------------------------------------------------
INSERT INTO UnitPromotions 
			(Type, 						Description, 						Help, 									CannotBeChosen, Sound, 				PortraitIndex, 	IconAtlas, 				PediaType, 			PediaEntry)
VALUES 		('PROMOTION_UNSTOPPABLE', 	'TXT_KEY_PROMOTION_UNSTOPPABLE', 	'TXT_KEY_PROMOTION_UNSTOPPABLE_HELP', 	1, 				'AS2D_IF_LEVELUP', 	2, 				'AT_PROMOTION_ATLAS', 	'PEDIA_SCOUTING', 	'TXT_KEY_PROMOTION_UNSTOPPABLE');

UPDATE UnitPromotions SET MovesChange = 1, VisibilityChange = 0, PortraitIndex = 38 WHERE Type = 'PROMOTION_SCOUTING_2';
UPDATE UnitPromotions SET MovesChange = 0, VisibilityChange = 1, PortraitIndex = 39 WHERE Type = 'PROMOTION_SCOUTING_3';
UPDATE UnitPromotions SET OutsideFriendlyLandsModifier = 10 WHERE Type IN ('PROMOTION_SCOUTING_1', 'PROMOTION_SCOUTING_3');
UPDATE UnitPromotions SET IgnoreZOC = 0 WHERE Type = 'PROMOTION_WOODLAND_TRAILBLAZER_2';

UPDATE UnitPromotions SET IgnoreZOC = 1 WHERE Type = 'PROMOTION_UNSTOPPABLE';

UPDATE UnitPromotions SET PromotionPrereqOr1 = NULL, PromotionPrereqOr2 = NULL WHERE Type = 'PROMOTION_SCOUTING_1';
UPDATE UnitPromotions SET PromotionPrereqOr1 = 'PROMOTION_SURVIVALISM_3', PromotionPrereqOr2 = 'PROMOTION_SCOUTING_3' WHERE Type = 'PROMOTION_WOODLAND_TRAILBLAZER_1';
UPDATE UnitPromotions SET PromotionPrereqOr1 = 'PROMOTION_SURVIVALISM_3', PromotionPrereqOr2 = 'PROMOTION_SCOUTING_3' WHERE Type = 'PROMOTION_WOODLAND_TRAILBLAZER_2';
UPDATE UnitPromotions SET PromotionPrereqOr1 = 'PROMOTION_SURVIVALISM_3', PromotionPrereqOr2 = 'PROMOTION_SCOUTING_3' WHERE Type = 'PROMOTION_WOODLAND_TRAILBLAZER_3';
UPDATE UnitPromotions SET PromotionPrereqOr1 = 'PROMOTION_SURVIVALISM_2', PromotionPrereqOr2 = 'PROMOTION_SCOUTING_2' WHERE Type = 'PROMOTION_SCREENING';
UPDATE UnitPromotions SET PromotionPrereqOr4 = 'PROMOTION_SCOUTING_2' WHERE Type = 'PROMOTION_MEDIC';

UPDATE UnitPromotions SET OrderPriority = 301, FlagPromoOrder = 301 WHERE Type = 'PROMOTION_SCREENING';
UPDATE UnitPromotions SET RankList = NULL, OrderPriority = 312, FlagPromoOrder = 312 WHERE Type IN ('PROMOTION_WOODLAND_TRAILBLAZER_1', 'PROMOTION_WOODLAND_TRAILBLAZER_2', 'PROMOTION_WOODLAND_TRAILBLAZER_3');
UPDATE UnitPromotions SET OrderPriority = 101, FlagPromoOrder = 101 WHERE Type IN ('PROMOTION_SCOUTING_1', 'PROMOTION_SCOUTING_2', 'PROMOTION_SCOUTING_3');

UPDATE UnitPromotions SET OrderPriority = 105, FlagPromoOrder = 105 WHERE Type = 'PROMOTION_UNSTOPPABLE';

INSERT INTO Unit_FreePromotions 
			(UnitType, 						PromotionType)
VALUES		('UNIT_SCOUT', 					'PROMOTION_UNSTOPPABLE'),
			('UNIT_EXPLORER', 				'PROMOTION_UNSTOPPABLE'),
			('UNIT_COMMANDO', 				'PROMOTION_UNSTOPPABLE'),
			('UNIT_PARATROOPER', 			'PROMOTION_UNSTOPPABLE'),
			('UNIT_MARINE', 				'PROMOTION_UNSTOPPABLE'),
			('UNIT_XCOM_SQUAD', 			'PROMOTION_UNSTOPPABLE'),
			('UNIT_SPANISH_CONQUISTADOR', 	'PROMOTION_UNSTOPPABLE'),
			('UNIT_BANDEIRANTES', 			'PROMOTION_UNSTOPPABLE');

INSERT INTO Unit_FreePromotions 
			(UnitType, 						PromotionType)
SELECT		'UNIT_HININ_AINU_MATAGI', 		'PROMOTION_UNSTOPPABLE'  WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='AT-CIVILIZATION-AINU' AND Value=1) UNION ALL
SELECT		'UNIT_DMS_MACCHIERI', 			'PROMOTION_UNSTOPPABLE'  WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='AT-CIVILIZATION-CORSICA' AND Value=1) UNION ALL
SELECT		'UNIT_GH_LOUISIANA_GVOYAGEUR', 	'PROMOTION_UNSTOPPABLE'  WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='AT-CIVILIZATION-LOUISIANA' AND Value=1);