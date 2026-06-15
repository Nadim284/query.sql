# Football Ticket Booking System - SQL Assignment

## Project Overview

This project demonstrates the design and implementation of a relational database for a Football Ticket Booking System using PostgreSQL.

The system manages:

* Users (Football Fans and Ticket Managers)
* Football Matches
* Ticket Bookings

The assignment focuses on applying SQL concepts such as:

* Filtering records
* Pattern matching
* Handling NULL values
* Aggregate functions
* Subqueries
* JOIN operations
* Sorting and limiting results

---

# Database Tables

## 1. Users Table

Stores information about all registered users.

| Field Name   | Description                               |
| ------------ | ----------------------------------------- |
| user_id      | Unique user identifier                    |
| full_name    | Full name of the user                     |
| email        | Email address                             |
| role         | User role (Football Fan / Ticket Manager) |
| phone_number | Contact number                            |

---

## 2. Matches Table

Stores information about football matches.

| Field Name          | Description             |
| ------------------- | ----------------------- |
| match_id            | Unique match identifier |
| fixture             | Match fixture           |
| tournament_category | Tournament name         |
| base_ticket_price   | Ticket price            |
| match_status        | Availability status     |

---

## 3. Bookings Table

Stores ticket booking records.

| Field Name     | Description               |
| -------------- | ------------------------- |
| booking_id     | Unique booking identifier |
| user_id        | References Users table    |
| match_id       | References Matches table  |
| seat_number    | Seat allocation           |
| payment_status | Payment status            |
| total_cost     | Total booking cost        |

---

# Relationships

### Users → Bookings

One user can make multiple bookings.

### Matches → Bookings

One match can have multiple ticket bookings.

### Foreign Keys

* `Bookings.user_id` → `Users.user_id`
* `Bookings.match_id` → `Matches.match_id`

These relationships ensure referential integrity and prevent bookings from being created for non-existing users or matches.

---

# SQL Queries

## Query 1

### Retrieve all upcoming Champions League matches that are available.

**Concepts Used:**

* WHERE
* AND

### Expected Output

| match_id | fixture                  | base_ticket_price |
| -------- | ------------------------ | ----------------- |
| 101      | Real Madrid vs Barcelona | 150               |
| 103      | Bayern Munich vs PSG     | 130               |

---

## Query 2

### Search users whose name starts with 'Tanvir' or contains 'Haque'.

**Concepts Used:**

* LIKE
* ILIKE

### Expected Output

| user_id | full_name     | email                                     |
| ------- | ------------- | ----------------------------------------- |
| 1       | Tanvir Rahman | [tanvir@mail.com](mailto:tanvir@mail.com) |
| 2       | Asif Haque    | [asif@mail.com](mailto:asif@mail.com)     |

---

## Query 3

### Find bookings with missing payment status and replace NULL with 'Action Required'.

**Concepts Used:**

* IS NULL
* COALESCE

### Expected Output

| booking_id | user_id | match_id | systematic_status |
| ---------- | ------- | -------- | ----------------- |
| 504        | 2       | 101      | Action Required   |

---

## Query 4

### Display booking details with customer name and match fixture.

**Concepts Used:**

* INNER JOIN

### Expected Output

| booking_id | full_name     | fixture                  | total_cost |
| ---------- | ------------- | ------------------------ | ---------- |
| 501        | Tanvir Rahman | Real Madrid vs Barcelona | 150        |
| 502        | Tanvir Rahman | Man City vs Liverpool    | 120        |
| 503        | Asif Haque    | Real Madrid vs Barcelona | 150        |
| 504        | Asif Haque    | Real Madrid vs Barcelona | 150        |
| 505        | Sajjad Rahman | Man City vs Liverpool    | 120        |

---

## Query 5

### Show all users and their booking IDs, including users with no bookings.

**Concepts Used:**

* LEFT JOIN

### Expected Output

| user_id | full_name     | booking_id |
| ------- | ------------- | ---------- |
| 1       | Tanvir Rahman | 501        |
| 1       | Tanvir Rahman | 502        |
| 2       | Asif Haque    | 503        |
| 2       | Asif Haque    | 504        |
| 3       | Sajjad Rahman | 505        |
| 4       | Jannat Ara    | NULL       |

---

## Query 6

### Find bookings with total cost higher than the average booking cost.

**Concepts Used:**

* Aggregate Functions
* AVG()
* Subquery

### Expected Output

| booking_id | match_id | total_cost |
| ---------- | -------- | ---------- |
| 501        | 101      | 150        |
| 503        | 101      | 150        |
| 504        | 101      | 150        |

---

## Query 7

### Retrieve the top 2 most expensive matches while skipping the highest-priced match.

**Concepts Used:**

* ORDER BY
* LIMIT
* OFFSET

### Expected Output

| match_id | fixture               | base_ticket_price |
| -------- | --------------------- | ----------------- |
| 103      | Bayern Munich vs PSG  | 130               |
| 102      | Man City vs Liverpool | 120               |

---

# Learning Outcomes

After completing this assignment, students will be able to:

* Design relational databases.
* Create primary and foreign key relationships.
* Use SQL filtering techniques.
* Apply JOIN operations.
* Handle NULL values efficiently.
* Use aggregate functions and subqueries.
* Retrieve sorted and limited datasets.
* Maintain referential integrity using foreign keys.

---

# Technologies Used

* PostgreSQL
* SQL
* pgAdmin (Optional)

---

# Author

Football Ticket Booking System Database Assignment
Software Engineering / Database Management Systems
