-- Hospital_Operation_Analytics Project 
-- Patient
-- Doctor
-- Rooms
-- Appointments
-- Treatments

create database Hospital_Operation_Analytics;
use Hospital_Operation_Analytics;

# Patient

create table Patients(
patient_id varchar(20) primary key,
patient_name varchar(100),
age int not null,
gender varchar(10),
city varchar(50),
patient_type varchar(20),
preferred_time_slot varchar(20),
registration_date date
);

select * from patients;

# Doctors
create table Doctors(
doctor_id varchar(10) primary key,
doctor_name varchar(100),
speciality varchar(50),
hire_date Date,
rating Decimal(3,2),
employment_type varchar(20),
is_active varchar(3)
);
select * from doctors;


# Rooms
create table Rooms(
room_id varchar(10) primary key,
room_type varchar(30),
floor int,
equipment_type varchar(50),
capacity int,
last_maintenance_date date,
is_available varchar(3)
);

select * from rooms;

# Appointments

create table appointments(
appointment_id varchar(20) primary key,
patient_id varchar(20),
appointment_date date,
doctor_id varchar(10),
service_type varchar(30),
priority varchar(10),
estimated_Cost decimal(10,2),
booking_channel varchar(20),
foreign key (patient_id) references patients(patient_id),
foreign key (doctor_id) references doctors(doctor_id)
);

select * from appointments;

# Treatments
create table Treatments(
treatment_id varchar(20)primary key,
appointment_id varchar(20),
doctor_id varchar(10),
room_id varchar(10),
actual_treatment_date date,
status varchar(20),
treatment_attempt int,
treatment_duration_min int,
wiating_time_min int,
treatment_cost decimal(10,2),
foreign key (appointment_id) references appointments(appointment_id),
foreign key (doctor_id) references doctors(doctor_id),
foreign key (room_id) references rooms(room_id)
);

select * from treatments;

-- Sprint 3: Basic Analysis / Data Exploration

-- 1. What is the total number of patients?

select count(*) as Total_Patients from patients; 

-- 2. What is the total number of appointments?

select count(*) as Total_Appointkments from appointments; 

-- 3. What is the total number of treatment records?

select count(*) as treatments_records from treatments; 

-- 4. What are the different medical service types?

select distinct service_type from appointments;

-- 5. How many doctors are currently active?

select count(*) from doctors where is_active = "yes";

-- 6. What are the different room types?

select distinct room_type from rooms;

-- 7. What is the total estimated appointment value?

select sum(estimated_cost) from appointments;

-- 8. What is the average treatment duration?

select avg(treatment_duration_min) from treatments;


-- 1.4 Analytical Thinking from the ER Diagram

-- 1. Management wants to identify patients who have booked multiple appointments. Which table and columns are needed?

-- tables : Patients, appointments
-- columns : patient_id, patient_name, appointment_id, appointment_date


-- 2. Operations wants to identify appointments that required more than one treatment attempt. Where is this information found?

-- tables : appointments, treatments
-- columns : appointment_id, appointment_date, treatment_attempt


-- 3. Patient Services wants to compare General, Corporate, and Insurance patients based on appointment activity. Which tables must be connected?

-- tables : appointments, patients
-- columns : appointments_id, appointments_date,  patient_id, patient_type

-- 4. Operations wants to compare service types based on treatment duration and waiting time. Which tables are required?

-- tables : appointments, treatments
-- columns : appointments_id, service_type,  treatment_duration_min, wiating_time_min

-- 5. The team wants to identify which doctors handled treatments and examine their recorded ratings. What information is needed?

-- tables : doctors, treatments
-- columns : doctor_id, doctor_name, rating,  treatment_id

-- 6. Operations wants to understand whether different room/equipment types are used for different service types. Which tables and columns are required?

-- tables : rooms, appointments
-- columns : room_id, room_type, equipment_type,  appointment_id, service_type

-- 7. Management wants to compare treatment performance across cities. What information must be connected?

-- tables : patients, treatments
-- columns : patient_id, city, treatment_id, treatment_duration_min, wiating_time_min, treatment_attempt, status

-- 8. Operations wants to investigate whether higher-priority appointments have longer waiting times or different outcomes. What information is needed?

-- tables : appointments, treatments
-- columns : appointment_id, priority, status,  wiating_time_min

-- 9. Management wants to understand whether treatment outcomes differ across service types. What tables and fields should be combined?

-- tables : appointments, treatments
-- columns : appointment_id, service_type, status,  treatment_attempt


-- 10. The Patient Services team wants to connect each patient to their appointments and treatment outcomes. What relationships are required?

-- tables : patients, appointments, treatments
-- columns : patient_id, patient_name, appointment_id, appointment_date, treatment_id,  status


-- 4.1 Understand Patient and Appointment Demand

-- Q1. Which city has the highest number of appointments?

select p.city, count( a.appointment_id) as Highest_appointments from patients 
as p join appointments as a on p.patient_id = a.patient_id
group by p.city
order by Highest_appointments desc limit 1;


-- Q2. Which service type has the highest number of appointments?

select service_type, count(appointment_id) as Highest_appointments from appointments 
group by service_type order by Highest_appointments desc limit 1;

-- Q3. How are appointments distributed across different priority levels?

select priority, count(appointment_id) as Appointment_distribution from appointments 
group by priority 
order by Appointment_distribution desc;

-- Q4. How does the number of appointments change over time?

select date_format(appointment_date, "%y-%m") as appointment_month , 
count(appointment_id) as appointment_data from appointments 
group by appointment_month 
order by appointment_data;


-- Q5. Which booking channel contributes the highest number of appointments?


select booking_channel, count(appointment_id) as highest_appointment from appointments 
group by booking_channel order by highest_appointment desc limit 1;

-- 4.2 Understand Patient Appointment Behaviour

-- Q6. Which patients have booked the highest number of appointments?

select p.patient_id , count(appointment_id) as highest_appointments from patients as p join appointments as a
on p.patient_id = a.patient_id 
group by p.patient_id
order by highest_appointments desc limit 1;

-- Q7. Which patients have the highest cumulative estimated appointment value?

select p.patient_id, sum(estimated_Cost) as estimated_appointment_value 
from patients as p join appointments as a
on p.patient_id = a.patient_id
group by p.patient_id
order by estimated_appointment_value desc limit 1;

-- Q8. Which cities have the highest number of active patients?

select city, count(distinct patient_id) as active_patients from patients 
group by city order by active_patients desc;

-- Q9. How does appointment activity differ among General, Corporate, and Insurance patients?
select p.patient_type, count(a.appointment_id) as appointment_activity 
from patients as p join appointments as a
on p.patient_id = a.patient_id 
group by p.patient_type
order by appointment_activity;


-- Q10. How does patient booking activity change over time?

select date_format(appointment_date, "%y-%m") as booking_month, 
count(appointment_id) as booking_activity from appointments 
group by booking_month order by booking_month ;

-- 4.3 Evaluate Treatment Performance

-- Q11. Which city has the highest number of treatments?

select p.city, count(treatment_id) as highest_treatment 
from patients as p 
join appointments as a 
on p.patient_id = a.patient_id 
join treatments as t 
on a.appointment_id = t.appointment_id
group by p.city
order by highest_treatment desc limit 1;


-- Q12. What is the distribution of treatments across Completed, Cancelled, No-Show, Rescheduled, and In Progress outcomes?

select status, count(status) as treatment_distribution from treatments
 group by status order by treatment_distribution ;

-- Q13. Which treatments have the longest average treatment duration?

select treatment_id, avg(treatment_duration_min) 
as average_treatment_duration from treatments
group by treatment_id 
order by average_treatment_duration desc;

-- Q14. Which cities have the highest number of unsuccessful treatment outcomes such as Cancelled and No-Show?

select p.city, count(t.status) as Unsucessfull_treatment 
from patients as p join appointments as a on p.patient_id = a.patient_id 
join treatments as t on a.appointment_id = t.appointment_id  
where t.status in ('Cancelled', 'No-Show') 
group by p.city 
order by Unsucessfull_treatment desc;

-- Q15. How does treatment performance change over time?

select date_format(actual_treatment_date, "%Y-%m") as treatment_month,
 count(treatment_id) as treatment_performance from treatments
 group by treatment_month order by treatment_month ;


-- 4.4 Understand Doctor and Room Performance

-- Q16. Which doctors have handled the highest number of treatments?

select d.doctor_name, count(treatment_id) as Highest_treatments 
from doctors as d join appointments as a on d.doctor_id = a.doctor_id
join treatments as t on a.appointment_id = t.appointment_id
group by d.doctor_name 
order by Highest_treatments desc;

-- Q17. Which doctors have the highest number of completed treatments?

select d.doctor_Name, count(t.status) as completed_treatments 
from doctors as d join appointments as a on d.doctor_id = a.doctor_id
join treatments as t on a.appointment_id = t.appointment_id 
where status = "Completed"
group by d.doctor_Name
order by completed_treatments desc;

-- Q18. Which doctors have the highest average treatment duration?

select d.doctor_Name, avg(t.treatment_duration_min) as avg_treatment_duration 
from doctors as d join appointments as a on d.doctor_id = a.doctor_id
join treatments as t on a.appointment_id = t.appointment_id 
group by d.doctor_Name
order by avg_treatment_duration desc;

-- Q19. Which room types and equipment types are used most frequently?

select room_type, equipment_type, count(*) as uasage_count from rooms 
group by room_type, equipment_type 
order by uasage_count desc limit 1;

-- Q20. Which rooms have the highest treatment activity and what are their treatment outcomes?

select r.room_id,t.status, count(treatment_id) as Treatment_activity
from rooms as r join treatments as t on r.room_id = t.room_id
group by r.room_id, t.status
order by Treatment_activity desc;

-- 4.5 Identify Treatment and Appointment Problems

-- Q21. Which appointments required more than one treatment attempt?

select a.appointment_id, count(t.treatment_attempt) as treatment_attempt
from appointments as a join treatments as t 
on a.appointment_id = t.appointment_id
group by a.appointment_id having treatment_attempt > 1
order by treatment_attempt desc;

-- Q22. What are the most common problematic appointment statuses?

select Status, count(status) as Problematic_appointments from treatments 
where status in ("No-Show","Rescheduled","Cancelled")
group by status
order by Problematic_appointments desc;


-- Q23. Do appointments requiring multiple treatment attempts have longer waiting times?

select a.appointment_id, count(t.treatment_attempt) as Multiple_treatments,
max(t.wiating_time_min) as longer_waiting from appointments as a join treatments as t
on a.appointment_id = t.appointment_id
group by a.appointment_id having count(t.treatment_attempt) > 1
order by longer_waiting desc ;

-- Q24. Which cities or service types have the highest number of cancellations, no-shows, and rescheduled appointments?

select p.city, a.service_type, count(t.status) as Highest_status 
from patients as p join appointments as a 
on p.patient_id = a.patient_id
join treatments as t on a.appointment_id = t.appointment_id
where status in ("cancelled", "rescheduled", "No - Show")
group by p.city, a.service_type
order by Highest_status desc;

-- Q25. Is appointment priority associated with waiting time or treatment outcomes?

select a.priority, avg(t.wiating_time_min) as waiting_time, 
count(t.status) from  appointments as a join treatments as t
on a.appointment_id = t.appointment_id
group by a.priority
order by waiting_time desc;
