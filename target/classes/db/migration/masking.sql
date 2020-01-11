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