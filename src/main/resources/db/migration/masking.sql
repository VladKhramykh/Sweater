INSTALL PLUGIN data_masking SONAME 'data_masking.dll';
CREATE FUNCTION gen_blacklist RETURNS STRING
  SONAME 'data_masking.dll';
CREATE FUNCTION gen_dictionary RETURNS STRING
  SONAME 'data_masking.dll';
CREATE FUNCTION gen_dictionary_drop RETURNS STRING
  SONAME 'data_masking.dll';
CREATE FUNCTION gen_dictionary_load RETURNS STRING
  SONAME 'data_masking.dll';
CREATE FUNCTION gen_range RETURNS INTEGER
  SONAME 'data_masking.dll';
CREATE FUNCTION gen_rnd_email RETURNS STRING
  SONAME 'data_masking.dll';
CREATE FUNCTION gen_rnd_pan RETURNS STRING
  SONAME 'data_masking.dll';
CREATE FUNCTION gen_rnd_ssn RETURNS STRING
  SONAME 'data_masking.dll';
CREATE FUNCTION gen_rnd_us_phone RETURNS STRING
  SONAME 'data_masking.dll';
CREATE FUNCTION mask_inner RETURNS STRING
  SONAME 'data_masking.dll';
CREATE FUNCTION mask_outer RETURNS STRING
  SONAME 'data_masking.dll';
CREATE FUNCTION mask_pan RETURNS STRING
  SONAME 'data_masking.dll';
CREATE FUNCTION mask_pan_relaxed RETURNS STRING
  SONAME 'data_masking.dll';
CREATE FUNCTION mask_ssn RETURNS STRING
  SONAME 'data_masking.dll';
  
  
delimiter $$
create procedure GetMaskingUsers()
begin
	select id, activation_code, email, mask_inner(password, 1, 5, '*'), username from user;
end $$
delimiter ;  
-- execute this from mysql command line
call GetMaskingUsers();


-- AES
create table user_encrypt (
    id bigint not null auto_increment,
    activation_code varchar(255),
    active bit not null,
    email varchar(255),
    password blob not null,
    username varchar(255) not null unique,
    primary key (id)
) engine=InnoDB;

delimiter $$
create procedure AddCrUser(in activation_code varchar(255), in active bit, in email varchar(255), in password varchar(255), in username varchar(255))
begin
	declare c int unsigned default 0; 
    declare last_id int unsigned default 0;
    declare shifr blob;
	set c := (select count(*) from user where user.username = username);
    set shifr := aes_encrypt(password, 's0M3_key');
    if (c != 0) then
		signal sqlstate '45001' set message_text = 'User already exists!'; 
	else
		insert into user_encrypt (activation_code, active, email, password, username)
			values (activation_code, active, email, shifr, username);
		set last_id := last_insert_id();
		insert into user_role(user_id, roles) values (last_id, 'USER');
	end if;    
end $$
delimiter ;

delimiter $$
create procedure GetUserCrByUsername(in username varchar(255))
begin
    select id, activation_code, email, aes_decrypt(password, 's0M3_key'), username  from user_encrypt where user_encrypt.username = username;
end $$
delimiter ;

drop procedure AddCrUser;
drop procedure GetUserCrByUsername;

call AddCrUser(null, 1, 'some@mail.ru', 'password', 'username');
call GetUserCrByUsername('username');