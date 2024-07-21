--Count no. of students in each class
SELECT SC.CLASS_ID, COUNT(1) AS "No. of Students"
FROM STUDENT_CLASSES SC
GROUP BY SC.CLASS_ID
ORDER BY SC.CLASS_ID;

--More than 100 students in each class
SELECT SC.CLASS_ID, COUNT(1) AS "No. of students"
FROM STUDENT_CLASSES SC
GROUP BY SC.CLASS_ID
HAVING COUNT(1)>100
ORDER BY SC.CLASS_ID;

-- Parent with more than one kid in school
SELECT SP.Parent_Id, COUNT(1) as "No. of Kids"
FROM STUDENT_PARENT SP
GROUP BY PARENT_ID
HAVING COUNT(1) > 1;

SELECT * FROM STUDENT_PARENT where parent_id='P00002';

--Subqueries
--Fetch the details of parents having more than 1 kids going to this school

-- Aggregate Functions
--AVG
SELECT AVG(SS.SALARY) AS AVG_SALARY
FROM STAFF_SALARY SS
JOIN STAFF STF ON STF.STAFF_ID = SS.STAFF_ID
WHERE STF.STAFF_TYPE = 'Non-Teaching';
