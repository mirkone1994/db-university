--1(group by) Contare quanti iscritti ci sono stati ogni anno
SELECT COUNT(`name`), YEAR(`enrolment_date`)
FROM `students`
GROUP BY YEAR(`enrolment_date`)
--2(group by) Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT COUNT(`id`), `office_address`
FROM `teachers`
GROUP BY `office_address`
--3(group by) Calcolare la media dei voti di ogni appello d'esame
SELECT ROUND(AVG(`vote`), 2), `exam_id`
FROM `exam_student`
GROUP BY `exam_id`
--4(group by) Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT COUNT(*), `department_id`
FROM `degrees`
GROUP BY `department_id`
--1(select) Selezionare tutti gli studenti nati nel 1990 (160)
SELECT * FROM `students`
WHERE YEAR(`date_of_birth`) = 1990  
--2(select) Selezionare tutti i corsi che valgono più di 10 crediti (479)
SELECT * FROM `courses`
WHERE `cfu` > 10
--3 (select) Selezionare tutti gli studenti che hanno più di 30 anni
SELECT * FROM  `students` 
WHERE TIMESTAMPDIFF(YEAR, `date_of_birth`, CURDATE()) >= 30  
ORDER BY `students`.`date_of_birth` DESC
--4(select) Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea (286)
SELECT * FROM `courses`  
WHERE `year`= 1 AND `period` = 'I semestre'
--5(select) Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020 (21)
SELECT * FROM `exams`
WHERE `hour` > '14:00:00' and `date` = '2020-06-20'
--6 Selezionare tutti i corsi di laurea magistrale (38)
SELECT * FROM `degrees`
where `level` = 'magistrale'
--7 Da quanti dipartimenti è composta l'università? (12)
SELECT COUNT(`name`) FROM `departments`
--8 Quanti sono gli insegnanti che non hanno un numero di telefono? (50)
SELECT COUNT(*) FROM `teachers`
WHERE `phone` IS NULL
--1(join)
SELECT `students`.`name`, `students`.`surname`
FROM `students`
JOIN `degrees`
ON `degree_id` = `degrees`.`id`
WHERE `degrees`.`name` = 'Corso di Laurea in Economia'