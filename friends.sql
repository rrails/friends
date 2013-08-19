DROP DATABASE friends;
CREATE DATABASE friends;
\c friends
CREATE TABLE friendsdetails(
id serial8 primary key,
name varchar(50),
age varchar(5),
gender varchar(10),
photo varchar(500),
facebook varchar(500)
)