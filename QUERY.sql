
create database Ticket_Booking_System;



create table if not exists users(
  user_id serial primary key,
  full_name varchar(100),
  email varchar(50) unique not null,
  role varchar(20) CHECK (role IN ('Ticket Manager', 'Football Fan')),
  phone_number varchar(20)
)



create table if not exists matches(
  match_id serial primary key,
  fixture varchar(200),
  tournament_category varchar(100),
  base_ticket_price decimal(10,2),
  match_status varchar(20) CHECK (match_status IN ('Available', 'Selling Fast', 'Sold Out', 'Postponed'))
)



create table if not exists bookings(
  booking_id serial primary key,
  user_id int references users(user_id),
  match_id int references matches(match_id),
  seat_number varchar(50),
  payment_status varchar(20) CHECK (payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded')),
  total_cost decimal(10,2)
)










INSERT INTO Users (user_id, full_name, email, role, phone_number)
VALUES
(11, 'Jannat Sora', 'sora@mail.com', 'Football Fan', NULL),
(1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
(2, 'Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
(3, 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
(4, 'Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL),
(5, 'Nadim Hasan', 'nadim@mail.com', 'Football Fan', '+8801744444444'),
(6, 'Mahfuj Hussain', 'mahfuj@mail.com', 'Football Fan', '+8801755555555'),
(7, 'Rakib Ahmed', 'rakib@mail.com', 'Football Fan', '+8801766666666'),
(8, 'Farzana Akter', 'farzana@mail.com', 'Football Fan', null),
(9, 'Shakil Khan', 'shakil@mail.com', 'Ticket Manager', '+8801788888888'),
(10, 'Mim Akter', 'mim@mail.com', 'Football Fan', '+8801799999999');




INSERT INTO Matches (
    match_id,
    fixture,
    tournament_category,
    base_ticket_price,
    match_status
)
VALUES
(101, 'Real Madrid vs Barcelona', 'Champions League', 150.00, 'Available'),
(102, 'Man City vs Liverpool', 'Premier League', 120.00, 'Selling Fast'),
(103, 'Bayern Munich vs PSG', 'Champions League', 130.00, 'Available'),
(104, 'AC Milan vs Inter Milan', 'Serie A', 90.00, 'Sold Out'),
(105, 'Juventus vs Roma', 'Serie A', 80.00, 'Available'),
(106, 'Arsenal vs Chelsea', 'Premier League', 110.00, 'Available'),
(107, 'Borussia Dortmund vs RB Leipzig', 'Bundesliga', 100.00, 'Selling Fast'),
(108, 'Atletico Madrid vs Sevilla', 'La Liga', 95.00, 'Available'),
(109, 'Napoli vs Lazio', 'Serie A', 85.00, 'Available'),
(110, 'Tottenham vs Newcastle', 'Premier League', 115.00, 'Sold Out');






INSERT INTO bookings (
    booking_id,
    user_id,
    match_id,
    seat_number,
    payment_status,
    total_cost
)
VALUES
(501, 1, 101, 'A-12', 'Confirmed', 150.00),
(502, 1, 102, 'B-04', 'Confirmed', 120.00),
(503, 2, 101, 'A-13', 'Confirmed', 150.00),
(504, 2, 103, NULL, null, 130.00),
(505, 3, 102, 'C-20', 'Pending', 120.00),
(506, 4, 104, 'D-08', 'Confirmed', 90.00),
(507, 5, 105, 'E-15', 'Confirmed', 80.00),
(508, 6, 106, 'F-10', 'Confirmed', 110.00),
(509, 7, 107, 'G-22', 'Pending', 100.00),
(510, 8, 108, 'H-05', 'Confirmed', 95.00),
(511, 9, 109, null, null, 85.00),
(512, 10, 110, 'J-18', 'Pending', 115.00);




-- Query 1: Retrieve all upcoming football matches belonging to the 'Champions League' where the match status is 'Available'.

select match_id,fixture,base_ticket_price from matches where tournament_category = 'Champions League' and match_status = 'Available';


-- Query 2: Search for all users whose full names start with 'Tanvir' or contain the phrase 'Haque' (case-insensitive).

select user_id,full_name,email from users where full_name ilike('Tanvir%') or full_name ilike('%Haque%');


-- Query 3: Retrieve all booking records where the payment status is missing (NULL), replacing the empty result with 'Action Required'.

select *,booking_id,user_id,match_id,coalesce(payment_status,'Action Required') as systematic_status from bookings where payment_status is null;


-- Query 4: Retrieve match booking details along with the User's full name and the scheduled Match fixture teams.

select booking_id,full_name,fixture,total_cost from bookings as b join users as u on b.user_id = u.user_id join matches as m on b.match_id = m.match_id;


-- Query 5: Display a comprehensive list of all users and their booking IDs, ensuring that fans who have never bought a ticket are still listed.

select u.user_id,full_name,booking_id from users as u left join bookings as b on b.user_id = u.user_id;



-- Query 6: Find all ticket bookings where the total cost is strictly higher than the average cost of all ticket bookings.

SELECT booking_id,match_id ,total_cost
FROM bookings 
WHERE total_cost > (SELECT AVG(total_cost) FROM bookings);


-- Query 7: Retrieve the top 2 most expensive matches sorted by base ticket price, skipping the absolute highest premium match.

SELECT *
FROM matches
WHERE base_ticket_price != (
    SELECT max(base_ticket_price)
    FROM matches
)
  order by base_ticket_price desc limit 2;
