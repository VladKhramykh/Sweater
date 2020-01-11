-- -------------------------------------------------------------------
delimiter $$
create procedure UpdateMessage(in id bigint, in filename varchar(255), in tag varchar(255), in text varchar(255), in user_id bigint)
begin
	update sweater.message set message.filename = filename, message.tag = tag, message.text = text, message.user_id = user_id where message.id = id;
end $$
delimiter ;

-- -------------------------------------------------------------------
delimiter $$
create procedure DeleteMessage(in id bigint)
begin
	delete from sweater.message where message.id = id;
end $$
delimiter ;

-- -------------------------------------------------------------------
delimiter $$
create procedure AddMessage(in filename varchar(255), in tag varchar(255), in text varchar(255), in user_id bigint)
begin
	insert into message (message.filename, message.tag, message.text, message.user_id) values (filename, tag, text, user_id);
end $$
delimiter ;

-- -------------------------------------------------------------------
delimiter $$
create procedure GetAllMessageDto(in cur_id bigint)
begin
	declare id bigint default 0;
	declare filename varchar(255);
	declare tag varchar(255);
	declare text varchar(2048);
	declare author_id bigint;
	declare countOfLikes bigint;
	declare meLiked boolean;
    declare author_name varchar(255);
    
    DECLARE done INT DEFAULT 0;    
	
    declare cur cursor for select 
			m.id, m.filename, m.tag, m.text, m.user_id as author_id, 
            count(ml.user_id), u.username as author_name
            from message m left join message_likes ml on m.id = ml.message_id left join user u on m.user_id = u.id  group by m.id; 
	
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
	
    drop temporary table if exists `tmp`;
    create temporary table `tmp` (
		id bigint,
		filename varchar(255),
		tag varchar(255),
		text varchar(2048),
		author_id bigint,
		likes bigint,
        meLiked boolean,
        author_name varchar(255)
	);    
    open cur;
    
    read_loop:
		loop fetch cur into id, filename, tag, text, author_id, countOfLikes, author_name;
        if done = 1 then
			 leave read_loop;
		end if;
        set meLiked := meLiked(cur_id, id);
		insert into tmp (id, filename, tag, text, author_id, likes, meLiked, author_name) values 
						(id, filename, tag, text, author_id, countOfLikes, meLiked, author_name);   
	end loop;
    close cur;        
	select * from tmp;           
end $$
delimiter ;
-- -------------------------------------------------------------------
delimiter $$
create function meLiked(user_id bigint, message_id bigint)
returns int
begin
	declare result boolean;
    declare c int unsigned default 0;
    set c := (select count(*) from message_likes ml where ml.user_id = user_id and ml.message_id = message_id);
    if(c = 0) then
		set result := 0;
	else
		set result := 1;
	end if;
    return result;
end $$
delimiter ;

-- -------------------------------------------------------------------
delimiter $$
create procedure GetAllMessageBySubsAndTagDto(in cur_id bigint, in tag_in varchar(255))
begin
	declare id bigint default 0;
	declare filename varchar(255);
	declare tag varchar(255);
	declare text varchar(2048);
	declare author_id bigint;
	declare countOfLikes bigint;
	declare meLiked boolean;
    declare author_name varchar(255);
    
    DECLARE done INT DEFAULT 0;    
	
   declare cur cursor for select 
			m.id, m.filename, m.tag, m.text, m.user_id as author_id, 
            count(ml.user_id), u.username as author_name
            from message m left join message_likes ml on m.id = ml.message_id left join user u on m.user_id = u.id where m.user_id in (select channel_id from user_subscriptions where subscriber_id = cur_id) and match (m.tag, m.text) against (tag_in in boolean mode) group by m.id; 
	
	
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
	
    drop temporary table if exists `tmp`;
    create temporary table `tmp` (
		id bigint,
		filename varchar(255),
		tag varchar(255),
		text varchar(2048),
		author_id bigint,
		likes bigint,
        meLiked boolean,
        author_name varchar(255)
	);    
    open cur;
    
    read_loop:
		loop fetch cur into id, filename, tag, text, author_id, countOfLikes, author_name;
        if done = 1 then
			 leave read_loop;
		end if;
        set meLiked := meLiked(cur_id, id);
		insert into tmp (id, filename, tag, text, author_id, likes, meLiked, author_name) values 
						(id, filename, tag, text, author_id, countOfLikes, meLiked, author_name);   
	end loop;
    close cur;
	SELECT 
    *
FROM
    tmp;           
end $$
-- -------------------------------------------------------------------

delimiter $$
create procedure GetAllMessageBySubsDto(in cur_id bigint)
begin
	declare id bigint default 0;
	declare filename varchar(255);
	declare tag varchar(255);
	declare text varchar(2048);
	declare author_id bigint;
	declare countOfLikes bigint;
	declare meLiked boolean;
    declare author_name varchar(255);
    
    DECLARE done INT DEFAULT 0;    
	
  declare cur cursor for select 
			m.id, m.filename, m.tag, m.text, m.user_id as author_id, 
            count(ml.user_id), u.username as author_name
            from message m left join message_likes ml on m.id = ml.message_id left join user u on m.user_id = u.id  where m.user_id in (select channel_id from user_subscriptions where subscriber_id = cur_id) group by m.id; 
	
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
	
    drop temporary table if exists `tmp`;
    create temporary table `tmp` (
		id bigint,
		filename varchar(255),
		tag varchar(255),
		text varchar(2048),
		author_id bigint,
		likes bigint,
        meLiked boolean,
        author_name varchar(255)
	);    
    open cur;
    
    read_loop:
		loop fetch cur into id, filename, tag, text, author_id, countOfLikes, author_name;
        if done = 1 then
			 leave read_loop;
		end if;
        set meLiked := meLiked(cur_id, id);
		insert into tmp (id, filename, tag, text, author_id, likes, meLiked, author_name) values 
						(id, filename, tag, text, author_id, countOfLikes, meLiked, author_name);   
	end loop;
    close cur;        
	select * from tmp;           
end $$
delimiter ;

-- -------------------------------------------------------------------
delimiter $$
create procedure GetAllMessageByTagDto(in cur_id bigint, tag_in varchar(255))
begin
	declare id bigint default 0;
	declare filename varchar(255);
	declare tag varchar(255);
	declare text varchar(2048);
	declare author_id bigint;
	declare countOfLikes bigint;
	declare meLiked boolean;
    declare author_name varchar(255);
    
    DECLARE done INT DEFAULT 0;    
	
  declare cur cursor for select 
			m.id, m.filename, m.tag, m.text, m.user_id as author_id, 
            count(ml.user_id), u.username as author_name
            from message m left join message_likes ml on m.id = ml.message_id left join user u on m.user_id = u.id where match (m.tag, m.text) against (tag_in in boolean mode) group by m.id; 
            
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
	
    drop temporary table if exists `tmp`;
    create temporary table `tmp` (
		id bigint,
		filename varchar(255),
		tag varchar(255),
		text varchar(2048),
		author_id bigint,
		likes bigint,
        meLiked boolean,
        author_name varchar(255)
	);    
    open cur;
    
    read_loop:
		loop fetch cur into id, filename, tag, text, author_id, countOfLikes, author_name;
        if done = 1 then
			 leave read_loop;
		end if;
        set meLiked := meLiked(cur_id, id);
		insert into tmp (id, filename, tag, text, author_id, likes, meLiked, author_name) values 
						(id, filename, tag, text, author_id, countOfLikes, meLiked, author_name);   
	end loop;
    close cur;        
	select * from tmp;           
end $$	
delimiter ;

-- -------------------------------------------------------------------
delimiter $$
create procedure GetAllMessageByUserDto(in user_id bigint, in cur_id bigint)
begin
	declare id bigint default 0;
	declare filename varchar(255);
	declare tag varchar(255);
	declare text varchar(2048);
	declare author_id bigint;
	declare countOfLikes bigint;
	declare meLiked boolean;
    declare author_name varchar(255);
    
    DECLARE done INT DEFAULT 0;    
	
	declare cur cursor for select 
			m.id, m.filename, m.tag, m.text, m.user_id as author_id,
            count(ml.user_id), u.username as author_name
            from message m left join message_likes ml on m.id = ml.message_id left join user u on m.user_id = u.id where m.user_id = user_id group by m.id;
            
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
	
    drop temporary table if exists `tmp`;
    create temporary table `tmp` (
		id bigint,
		filename varchar(255),
		tag varchar(255),
		text varchar(2048),
		author_id bigint,
		likes bigint,
        meLiked boolean,
        author_name varchar(255)
	);    
    open cur;
    
    read_loop:
		loop fetch cur into id, filename, tag, text, author_id, countOfLikes, author_name;
        if done = 1 then
			 leave read_loop;
		end if;
        set meLiked := meLiked(cur_id, id);
		insert into tmp (id, filename, tag, text, author_id, likes, meLiked, author_name) values 
						(id, filename, tag, text, author_id, countOfLikes, meLiked, author_name);   
	end loop;
    close cur;        
	select * from tmp;           
end $$
delimiter ;
-- -------------------------------------------------------------------
