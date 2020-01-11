-- -------------------------------------------------------------------
delimiter $$
create procedure GetAllUsers()
begin
    select * from user;
end $$
delimiter ;

-- -------------------------------------------------------------------
delimiter $$
create procedure GetUserById(in id bigint)
begin
    select 
		user0_.id as id,
        user0_.activation_code as activationCode,
        user0_.active as active,
        user0_.email as email,
        user0_.password as password,
        user0_.username as username
    from
        user user0_ where user0_.id = id;
end $$
delimiter ;

-- -------------------------------------------------------------------
delimiter $$
create procedure UpdateUser(in id bigint, in email varchar(255), in password varchar(255), in activationCode varchar(255))
begin
    update user set user.email = email, password = user.password, user.activation_code = activationCode where user.id = id;
end $$
delimiter ;

-- -------------------------------------------------------------------
delimiter $$
create procedure GetUserByActivationCode(in code varchar(255))
begin
    select 	user0_.id as id,
			user0_.activation_code as activationCode,
			user0_.active as active,
			user0_.email as email,
			user0_.password as password,
			user0_.username as username
            from user where user.activation_code = code;
end $$
delimiter ;

-- -------------------------------------------------------------------
delimiter $$
create procedure GetUserByUsername(in username varchar(255))
begin
    select * from user where user.username = username;
end $$
delimiter ;

-- -------------------------------------------------------------------
delimiter $$
create procedure AddUser(in activation_code varchar(255), in active bit, in email varchar(255), in password varchar(255), in username varchar(255))
begin
	declare c int unsigned default 0; 
    declare last_id int unsigned default 0;
	set c := (select count(*) from user where user.username = username);
    
    if (c != 0) then
		signal sqlstate '45001' set message_text = 'User already exists!'; 
	else
		insert into user(activation_code, active, email, password, username)
			values (activation_code, active, email, password, username);
		set last_id := last_insert_id();
		insert into user_role(user_id, roles) values (last_id, 'USER');
	end if;    
end $$
delimiter ;

-- -------------------------------------------------------------------
delimiter $$
create procedure ActivateUser(in id bigint)
begin
	update user set activation_code = null where user.id = id;
end $$
delimiter ;

-- -------------------------------------------------------------------
delimiter $$
create procedure GetAllSimilarUsersByUsername(in username varchar(255))
begin
	select
        user0_.id as id,
        user0_.activation_code as activationCode,
        user0_.active as active,
        user0_.email as email,
        user0_.password as password,
        user0_.username as username
    from
        user user0_  where match (user0_.username, user0_.email) against (username in boolean mode);
end $$
delimiter ;	

-- -------------------------------------------------------------------
delimiter $$
create procedure GetCountSubscriptions(in id bigint)
begin
	select count(*) from user_subscriptions where user_subscriptions.channel_id = id;
end $$
delimiter ;

-- -------------------------------------------------------------------
delimiter $$
create procedure GetCountSubscribers (in id bigint)
begin
	select count(*) from user_subscriptions where user_subscriptions.subscriber_id = id;
end $$
delimiter ;

-- -------------------------------------------------------------------
delimiter $$
create procedure GetCountOfMessage(in id bigint)
begin
	select count(*) from message where message.user_id = id;
end $$
delimiter ;

-- -------------------------------------------------------------------
delimiter $$
create procedure GetSubscribersByUserId(in id bigint)
begin
	select
        user0_.id as id,
        user0_.activation_code as activationCode,
        user0_.active as active,
        user0_.email as email,
        user0_.password as password,
        user0_.username as username,
        roles1_.roles as roles
    from
        user user0_ 
    left outer join
        user_role roles1_ 
            on user0_.id=roles1_.user_id where user0_.id in (select subscriber_id from user_subscriptions where channel_id  = id);
end $$
delimiter ;

-- -------------------------------------------------------------------
delimiter $$
create procedure GetSubscriptionsByUserId(in id bigint)
begin
	select
        user0_.id as id,
        user0_.activation_code as activationCode,
        user0_.active as active,
        user0_.email as email,
        user0_.password as password,
        user0_.username as username,
        roles1_.roles as roles
    from
        user user0_ 
    left outer join
        user_role roles1_ 
            on user0_.id=roles1_.user_id where user0_.id in (select channel_id from user_subscriptions where subscriber_id  = id);
end $$
delimiter ;
-- -------------------------------------------------------------------
delimiter $$
create procedure GetRolesByUserId(in id bigint)
begin
	select roles.roles as roles 
    from
        user_role roles 
    where
        roles.user_id= id;
end $$
delimiter ;
-- -------------------------------------------------------------------
