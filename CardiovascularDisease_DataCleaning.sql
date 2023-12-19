SELECT *
FROM CardiovascularDisease_DataCleaning..HealthAge_Data

-- Convert Age 

ALTER TABLE CardiovascularDisease_DataCleaning..HealthAge_Data
ADD AgeConverted FLOAT

UPDATE CardiovascularDisease_DataCleaning..HealthAge_Data
SET AgeConverted = age / 365
WHERE age IS NOT NULL;

SELECT *
FROM CardiovascularDisease_DataCleaning..HealthAge_Data


-- 1 = female, 0 = male
-- convert gender

SELECT DISTINCT(gender), COUNT(gender)
FROM HealthAge_Data
GROUP BY gender

SELECT gender, 
CASE WHEN gender = 0 THEN 'male'
	WHEN gender = 1 THEN 'female'
	ELSE CAST(gender AS varchar(20))
END
FROM CardiovascularDisease_DataCleaning..HealthAge_Data


ALTER TABLE CardiovascularDisease_DataCleaning..HealthAge_Data
ADD GenderConverted varchar(20)

UPDATE CardiovascularDisease_DataCleaning..HealthAge_Data
SET GenderConverted = CASE WHEN gender = 0 THEN 'male'
	WHEN gender = 1 THEN 'female'
	ELSE CAST(gender AS varchar(20))
END

SELECT *
FROM CardiovascularDisease_DataCleaning..HealthAge_Data

-- 1 = 'yes', 0 = 'no'
-- smoke, alco, active

-- smoke
SELECT smoke,
CASE WHEN smoke = 1 THEN 'yes'
	WHEN smoke = 0 THEN 'no'
	ELSE  CAST(smoke AS varchar(20))
END
FROM CardiovascularDisease_DataCleaning..HealthAge_Data

ALTER TABLE CardiovascularDisease_DataCleaning..HealthAge_Data
ADD SmokeConverted varchar(20)

UPDATE CardiovascularDisease_DataCleaning..HealthAge_Data
SET SmokeConverted = CASE WHEN smoke = 1 THEN 'yes'
	WHEN smoke = 0 THEN 'no'
	ELSE  CAST(smoke AS varchar(20))
END

-- alco
SELECT alco,
CASE WHEN alco = 1 THEN 'yes'
	WHEN alco = 0 THEN 'no'
	ELSE CAST(alco AS varchar(20))
END
FROM CardiovascularDisease_DataCleaning..HealthAge_Data

ALTER TABLE CardiovascularDisease_DataCleaning..HealthAge_Data
ADD AlcoConverted varchar (20)

UPDATE CardiovascularDisease_DataCleaning..HealthAge_Data
SET AlcoConverted = CASE WHEN alco = 1 THEN 'yes'
	WHEN alco = 0 THEN 'no'
	ELSE CAST(alco AS varchar(20))
END

-- active

SELECT active,
CASE WHEN active = 1 THEN 'active'
	WHEN active = 0 THEN 'no'
	ELSE CAST(active AS varchar(20))
END
FROM CardiovascularDisease_DataCleaning..HealthAge_Data

ALTER TABLE CardiovascularDisease_DataCleaning..HealthAge_Data
ADD Physical_Activity varchar (20)

UPDATE CardiovascularDisease_DataCleaning..HealthAge_Data
SET Physical_Activity = CASE WHEN active = 1 THEN 'active'
	WHEN active = 0 THEN 'no'
	ELSE CAST(active AS varchar(20))
END

-- cardio
SELECT cardio,
CASE WHEN cardio = 1 THEN 'yes'
	WHEN cardio = 0 THEN 'no'
	ELSE CAST(cardio AS varchar(20))
END
FROM CardiovascularDisease_DataCleaning..HealthAge_Data

ALTER TABLE CardiovascularDisease_DataCleaning..HealthAge_Data
ADD Presence_CardioDisease varchar(20)

UPDATE CardiovascularDisease_DataCleaning..HealthAge_Data
SET Presence_CardioDisease = CASE WHEN cardio = 1 THEN 'yes'
	WHEN cardio = 0 THEN 'no'
	ELSE CAST(cardio AS varchar(20))
END

-- cholesterol 
-- 1: normal 2: above normal 3: well above normal
SELECT cholesterol,
CASE WHEN cholesterol = 0 THEN 'normal'
	WHEN cholesterol = 1 THEN 'above normal'
	WHEN cholesterol = 2 THEN 'well above normal'
	ELSE CAST(cholesterol AS varchar (30))
END
FROM CardiovascularDisease_DataCleaning..HealthAge_Data
--GROUP BY cholesterol

ALTER TABLE CardiovascularDisease_DataCleaning..HealthAge_Data
ADD Cholesterol_State varchar(30)

UPDATE CardiovascularDisease_DataCleaning..HealthAge_Data
SET Cholesterol_State =CASE WHEN cholesterol = 0 THEN 'normal'
	WHEN cholesterol = 1 THEN 'above normal'
	WHEN cholesterol = 2 THEN 'well above normal'
	ELSE CAST(cholesterol AS varchar (30))
END

--SELECT *
--FROM HealthAge_Data


-- glucose
-- 1: normal 2: above normal 3: well above normal
SELECT gluc,
CASE WHEN gluc = 0 THEN 'normal'
	WHEN gluc = 1 THEN 'above normal'
	WHEN gluc = 2 THEN 'well above normal'
	ELSE CAST(gluc AS varchar (30))
END
FROM CardiovascularDisease_DataCleaning..HealthAge_Data
--GROUP BY gluc

ALTER TABLE CardiovascularDisease_DataCleaning..HealthAge_Data
ADD Glucose_State varchar (30)

UPDATE CardiovascularDisease_DataCleaning..HealthAge_Data
SET Glucose_State = CASE WHEN gluc = 0 THEN 'normal'
	WHEN gluc = 1 THEN 'above normal'
	WHEN gluc = 2 THEN 'well above normal'
	ELSE CAST(gluc AS varchar (30))
END

SELECT *
FROM CardiovascularDisease_DataCleaning..HealthAge_Data


-- Creating temp table for more organize data
DROP TABLE IF EXISTS #temp_HealthAge

CREATE TABLE #temp_HealthAge(
id float,
AgeConverted float,
GenderConverted varchar(20),
height float,
weight float,
ap_hi float,
ap_lo float,
Cholesterol_State varchar(30),
Glucose_State varchar(30),
SmokeConverted varchar(20),
AlcoConverted varchar(20),
Physical_Activity varchar(20),
Presence_CardioDisease varchar(20)
)

INSERT INTO #temp_HealthAge
SELECT id, AgeConverted, GenderConverted, height, weight, ap_hi, ap_lo, Cholesterol_State, Glucose_State, SmokeConverted, AlcoConverted, Physical_Activity, Presence_CardioDisease
FROM CardiovascularDisease_DataCleaning..HealthAge_Data

SELECT *
FROM #temp_HealthAge