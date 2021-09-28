--1(group by) Contare quanti iscritti ci sono stati ogni anno
SELECT COUNT(`name`), YEAR(`enrolment_date`)
FROM `students`
GROUP BY YEAR(`enrolment_date`)
--2(group by) Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT COUNT(`id`), `office_address`
FROM `teachers`
GROUP BY `office_address`
--1(select) Selezionare tutti gli studenti nati nel 1990 (160)
SELECT * FROM `students`
WHERE YEAR(`date_of_birth`) = 1990  
--2(select) Selezionare tutti i corsi che valgono più di 10 crediti (479)
SELECT * FROM `courses`
WHERE `cfu` > 10
--3 (select) Selezionare tutti gli studenti che hanno più di 30 anni
SELECT * FROM `students`
WHERE YEAR(`date_of_birth`) > 1991
--4(select) Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea (286)
SELECT * FROM `courses`  
WHERE `year`= 1 AND `period` = 'I semestre'