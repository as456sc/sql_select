create table if not exists genres  (
  genres_id serial primary key,
  name varchar(60) not null
  );
  
 create table if not exists performer  (
  performer_id serial primary key,
  name  varchar(60) not null
  );
  
 
 create table  if not exists genres_performer (
  genres_id integer references genres (genres_id),
  performer_id integer references performer (perfomer_id),
  constraint generes_performer_id  primary key (genres_id, performer_id)
  );

 create table  if not exists album (
  album_id serial primary key,
  name  varchar(60) not null,
  year integer not null
  );
  
 create table  if not exists album_performer (
  album_id integer references album (album_id),
  performer_id integer references performer (perfomer_id),
  constraint album_performer_id primary key (album_id, performer_id )
  );
 
 create table  if not exists track (
  track_id serial primary key,
  name  varchar(60) not null,
  time_play integer not null,
  album_id integer references album (album_id)
  );

 create table  if not exists compilation (
  сompilation_id  serial primary key,
  name  varchar(60) not null,
  release_date date not null
  );
 
 create table  if not exists compilation_track (
  сompilation_id integer references compilation (сompilation_id),
  track_id integer references track (track_id),
  constraint compilation_track_id primary key (сompilation_id,track_id )
  );
  


insert into performer (name) values
 ('Daniel Reynolds'),
 ('Adriano Celentano'),
 ('Marshall Bruce Mathers III (Eminem)'),
 ('Grace Sewell (SayGrace )'),
 ('Yulia Dmitrievna Sievert (Zivert)'),
 ('Andre Romelle Young ( Dr. Dre)'),
 ('Calvin Cordozar Broadus (Snoop Dogg)'),
 ('Curtis James Jackson III (50 Cent)');



insert into genres  (name) values
 ('jazz'),
 ('pop'),
 ('electronics'),
 ('rap'),
 ('hip-hop');

insert into album  (name, year) values
 ('Origins', '2018'),
 ('Soli', '1979'),
 ('Music to Be Murdered By', '2020'),
 ('The Defining Moments of SAYGRACE', '2020'),
 ('Shine on', '2018'),
 ('snoop doggy dogg & dr. dre: from compton to long beach', '2005'),
 ('High', '2016'),
 ('Gon Pay Me?', '2020');
 
insert into track (name, time_play, album_id) values
 ('Natural', '189', 1 ),
 ('Soli', '245', 2 ),
 ('People', '327', 2 ),
 ('Godxilla', '211', 3 ),
 ('Those Kinda Nights', '178', 3),
 ('Let Me Ride', '242', 6 ),
 ('Gin and Juice', '212', 6),
 ('Murder Was The Case', '217', 6 ),
 ('Rat-Tat-Tat-Tat', '229', 6 ),
 ('Respect', '246', 7 ),
 ('Back up', '269', 7),
 ('Grew up', '121', 8),
 ('Gon Pay me', '219', 8),
 ('Southside', '181', 8),
 ('Simply the best', '83', 8);


insert into compilation (name, release_date) values
 ('Daniel Reynolds compilation','2017/12/10'),
 ('Adriano Celentano compilation','2018/10/14'),
 ('Marshall Bruce Mathers III (Eminem) compilation','2022/1/17'),
 ('Grace Sewell (SayGrace ) compilation','2018/12/14'),
 ('Yulia Dmitrievna Sievert (Zivert) compilation','2015/12/22' ),
 ('Andre Romelle Young ( Dr. Dre) compilation','2011/8/30'),
 ('Calvin Cordozar Broadus (Snoop Dogg) compilation','2005/5/18'),
 ('Curtis James Jackson III (50 Cent) compilation','2003/1/27');


insert into compilation_track values (1, 1), (8, 12), (8, 13), (8, 14), (8, 15);
 
insert into album_performer values (1,1), (4,4), (5,5), (6,6), (7,7);

insert into genres_performer values(5, 1), (5,6), (5,7), (2, 3), (2, 4), (4, 8);
 

select  name, year from album 
where year = 2018 ;
 
select name, time_play
from track
where  time_play = (SELECT MAX(time_play) FROM track);

select name, time_play from track 
where time_play >= 210;

select name, release_date  from compilation 
where release_date between '2018-01-01' and '2020-12-31';


select name from performer
where name split_part(*, ' ',  '1' ) ;

select  split_part(name, ' ',1) from performer where performer_id >= 1;


select name from track 
where name like '%me%';





select album_id, count(performer_id) from album_performer 
group by album_id;                        

select year, count(name) from album
where year between '2019' and '2020'
group by year;


select   album_id , avg(time_play) from track
group by  album_id;


--4
select album_id,album.name,year,performer_id,performer.name from album 
join performer on performer.performer_id = album_id
group by album_id, performer_id
having year:: text  not like '2020' ;



--5
select name, compilation.сompilation_id, compilation_track.сompilation_id  from compilation 
join compilation_track on compilation.сompilation_id =  compilation_track.сompilation_id
group by name,compilation.сompilation_id,compilation_track.сompilation_id
having name like '%Jackson%'; 



select count(genres_id) , genres_performer.performer_id, album_id from genres_performer
join album_performer on genres_performer.performer_id = album_performer.album_id
group by genres_performer.performer_id, album_performer.album_id
having count(genres_id) > 1;



select name,  track.track_id,compilation_track.сompilation_id from track
full outer join compilation_track on track.track_id = compilation_track.track_id
where compilation_track.сompilation_id is  null;







--8


--select name, time_play, track.album_id, performer_id from track
--join album_performer on track.album_id = album_performer.album_id
--group by name,track.album_id,performer_id,time_play
--order by time_play asc
--FETCH first 1 row WITH ties;  



select name,time_play,track.album_id, performer_id from track
join album_performer  on album_performer.performer_id = track.album_id
group by name,time_play,track.album_id,performer_id
having time_play <= 200;


--9

--select count(name),album_id from track
--group by album_id
--order by count(name) asc
--limit 1 ;

select count(track.name),track.album_id, album.name, album.album_id from track
join album on album.album_id = track.album_id 
group by track.album_id,album.name,album.album_id
order by count(track.name) asc
limit 1 ;
 



