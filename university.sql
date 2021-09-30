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
--1(join) Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT `students`.`name`, `students`.`surname`
FROM `students`
JOIN `degrees`
ON `degree_id` = `degrees`.`id`
WHERE `degrees`.`name` = 'Corso di Laurea in Economia'
--2(join) Selezionare tutti i Corsi di Laurea del Dipartimento di Neuroscienze
SELECT `degrees`.`name`
FROM `degrees`
JOIN `departments`
ON `department_id` = `departments`.`id`
WHERE `departments`.`name` = 'Dipartimento di Neuroscienze'
--3(join) Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT `courses`.`name`
FROM `courses`
JOIN `course_teacher`
ON `courses`.`id` = `course_id`
JOIN `teachers`
on `teachers`.`id` = `course_teacher`.`teacher_id`
WHERE `teachers`.`name` = 'Fulvio' and `teachers`.`surname` = 'Amato'
--4(join) Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome
SELECT `students`.`name`, `students`.`surname`, `degrees`.`name`, `departments`.`name`
FROM `students`
JOIN `degrees`
ON `degrees`.`id` = `students`.`degree_id`
JOIN `departments`
ON `departments`.`id` = `degrees`.`department_id`
ORDER BY `students`.`surname`, `students`.`name`
--5(join) Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
SELECT `degrees`.*, `courses`.*, `teachers`.*
FROM `degrees`
JOIN `courses`
ON `degrees`.`id` = `courses`.`degree_id`
JOIN `course_teacher`
ON `courses`.`id` = `course_teacher`.`course_id`
JOIN `teachers` 
ON `teachers`.`id` = `course_teacher`.`teacher_id`
--6(join) Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)
SELECT DISTINCT `teachers`.`name`, `teachers`.`surname`, `departments`.`name`
FROM `teachers`
JOIN `course_teacher`
ON `teachers`.`id` = `course_teacher`.`teacher_id`
JOIN `courses`
ON `courses`.`id` = `course_teacher`.`course_id`
JOIN `degrees`
ON `degrees`.`id` = `courses`.`degree_id`
JOIN `departments`
ON `departments`.`id` = `degrees`.`department_id`
WHERE `departments`.`name` = 'Dipartimento di Matematica'
ORDER BY `teachers`.`name`, `teachers`.`surname`
--7(join bonus) Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per superare ciascuno dei suoi esami
SELECT `students`.`name`, `students`.`surname`, `courses`.`name`, COUNT(`exam_student`.`vote`) AS `numero_tentativi`, MAX(`exam_student`.`vote`) AS `voto_massimo`
FROM `students`
JOIN `exam_student`
ON `students`.`id` = `exam_student`.`student_id`
JOIN `exams`
ON `exams`.`id` = `exam_student`.`exam_id`
JOIN `courses`
ON `courses`.`id` = `exams`.`course_id`
GROUP BY `students`.`id`, `courses`.`id`
HAVING `voto_massimo` >= 18