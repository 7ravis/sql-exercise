drop database if exists challenge1;
create database challenge1;
use challenge1;

create table `User`(
UserId int unsigned not null auto_increment,
FirstName varchar(45),
LastName varchar(45),
primary key (UserID)
);

create table Meetup (
MeetupId int unsigned not null auto_increment,
`Name` varchar(45),
MainTopic varchar(45),
primary key (MeetupId)
);

create table UserMeetup (
UserId int unsigned not null,
MeetupId int unsigned not null,
primary key (UserId, MeetupId),
foreign key (UserId)
references `User` (UserId),
foreign key (MeetupId)
references Meetup (MeetupId)
);

insert into `User` (FirstName, LastName) values ('Mary', 'Poppins'), ('Easter', 'Bunny'), ('Wonder', 'Woman');
insert into Meetup (`Name`, MainTopic) values ('JavaScript-MN', 'coding in JS and related topics'), ('Board Game NIght', 'play board games and meet new people'), ('Biking Group', 'go on bike rides around the twin cities area');
insert into UserMeetup (UserId, MeetupId) values (1, 2), (1,3), (2,2);

select * from Meetup;
select * from `User`;
select * from UserMeetup;

-- Given three tables:
-- User [UserId (PK), FirstName, LastName]
-- Meetup [MeetupId (PK), Name, MainTopic]
-- UserMeetup [UserId (FK -> User.UserId), MeetupId (FK -> Meetup.MeetupId)]

-- Write these queries:

-- Get all Users who are not part of any Meetups.
select * from `User` 
left join UserMeetup on `User`.UserId = UserMeetup.UserId
where UserMeetup.MeetupId is null;

-- Get all Users and the number (count) of Meetups they belong to.
select `User`.*, count(UserMeetup.MeetupId) as `NumGroups` from `User` left join UserMeetup on `User`.UserId = UserMeetup.UserId group by `User`.UserId;

-- Get all Users who belong to more than 5 Meetups.
select `User`.*, count(UserMeetup.MeetupId) as `NumGroups` from `User` inner join UserMeetup on `User`.UserId = UserMeetup.UserId group by `User`.UserId having NumGroups > 1;

-- Produce a list of abbreviated names in the format 'J.Smith' for anyone that is a member for a particular group.
select concat(substring(`User`.FirstName,1,1), '.', `User`.LastName) as `Name` from `User` inner join UserMeetup on `User`.UserId = UserMeetup.UserId inner join Meetup on UserMeetup.MeetupId = Meetup.MeetupId where Meetup.`Name` = 'Board Game NIght';