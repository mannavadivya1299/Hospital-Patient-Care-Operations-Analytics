# Hospital Patient Care Operations Analytics

## Project Overview

**Hospital Patient Care Operations Analytics** is a MySQL-based data analytics project focused on understanding hospital operations through patient, appointment, treatment, doctor, and room data.

The project uses SQL to analyze operational patterns and generate insights related to appointment demand, patient behavior, treatment performance, doctor activity, and room utilization.

## Objective

The project aims to:

* Analyze patient appointment demand and behavior
* Identify appointment and booking patterns
* Evaluate treatment performance and outcomes
* Analyze doctor treatment activity
* Understand room and equipment utilization
* Identify operational issues related to waiting time, cancellations, no-shows, and multiple treatment attempts

## Database Structure

The database contains five interconnected tables:

* **Patients** – Patient information and registration details
* **Doctors** – Doctor details, specialization, ratings, and employment information
* **Appointments** – Appointment details, service type, priority, cost, and booking channel
* **Treatments** – Treatment status, duration, waiting time, attempts, and cost
* **Rooms** – Room type, equipment, capacity, and availability

Primary Keys and Foreign Keys are used to establish relationships between the tables and maintain data integrity.

## Analysis Performed

* City-wise appointment and treatment analysis
* Service type and priority analysis
* Patient appointment behavior
* Booking channel analysis
* Appointment trends over time
* Treatment status and outcome analysis
* Doctor-wise treatment performance
* Average treatment duration analysis
* Room and equipment usage analysis
* Multiple treatment attempt analysis
* Waiting time analysis
* Cancellation, no-show, and rescheduled appointment analysis

## SQL Concepts Applied

The project applies SQL concepts including **SELECT, DISTINCT, WHERE, JOINs, aggregate functions such as COUNT(), SUM(), and AVG(), GROUP BY, HAVING, ORDER BY, LIMIT, DATE_FORMAT(), the IN operator, and COUNT(DISTINCT)** for data exploration and analysis.


## Tools & Technologies

**MySQL | SQL | MySQL Workbench**

## Project Files

* `Hospital_Patient_Care_Operations_Analytics.sql` – Database creation, table structure, relationships, and analysis queries
* `ER_Diagram.png` – Entity Relationship Diagram


