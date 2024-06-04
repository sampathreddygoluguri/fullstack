create database tourism;
use tourism;
create table usersinfo(Cus_Name varchar(20) NOT NULL, user_name varchar(10) NOT NULL, user_pass varchar(10) NOT NULL, Email varchar(20) NOT NULL);
desc usersinfo;
drop table usersinfo;
select * from usersinfo;

CREATE TABLE bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    guests INT NOT NULL,
    departure_date DATE NOT NULL,
    return_date DATE NOT NULL
);
select * from bookings;