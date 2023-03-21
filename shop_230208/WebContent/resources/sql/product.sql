use jsp;
show tables;
create table product(
	p_id varchar(10) not null,
	p_name varchar(20),
	p_unitPrice integer,
	p_description text,
	p_category varchar(20),
	p_manufacturer varchar(20),
	p_unitsInStock long,
	p_condition varchar(20),
	p_fileName varchar(20),
	primary key (p_id)
);
create table member(
	id varchar(20) not null,
	pass varchar(20),
	name varchar(20),
	photo varchar(20),
	primary key (id)
);
create table board(
	num integer not null auto_increment,
	id varchar(20),
	name varchar(20),
    subject varchar(20),
	content varchar(200),
    regist_day varchar(30),
    hit integer,
    ip varchar(20),
	primary key(num)
);

insert into product values('P1234','iPhone 14promax',2000000,'6.7-inch, super-oled디스플레이,4800만 화소','스마트폰','애플',20000,'신상품','P1234.PNG');
insert into product values('P1235','LG 울트라기어',770000,'32inch, LED 디스플레이','모니터','LG',300,'중고품','P1235.PNG');
insert into product values('P1236','갤럭시탭S8',800000,'11-inch, 램8GB, 와이파이전용','태블릿','삼성',800,'재생품','P1236.PNG');

select * from product;
select * from board;
select * from member;

insert into board(id, name, subject, content, regist_day, hit, ip) values('manager','똘기','더미글 제목','더미글 내용','2023/02/08(10:07:50)',0,'127.0.0.1');
delete from board where num=11;

desc product;
desc board;
desc member;
