-- index for search by username or usermail
alter table sweater.user add fulltext index(username, email);

-- index for unsubscribe
create index channel_id_subscriber_id on user_subscriptions(channel_id, subscriber_id);

-- index for dislike
create index user_id_message_id on message_likes(user_id, message_id);

-- index for search users by id
create unique index user_id on user(id);

-- index for search users by username
create unique index username_only on user(username);

-- index for search users by activation code
create index activation_code on user(activation_code);

-- index for search by sub_id
create index channel_id on user_subscriptions(channel_id);

-- index for search by sub_id
create index sub_id on user_subscriptions(subscriber_id);

-- index for search by text
create index text_index on message(text);

-- index for search by text
create index tag_index on message(tag);

-- index for serach message by tag
alter table sweater.message add fulltext index(tag, text);

-- index for search message by user_id
create index message_user_id on message(user_id);


-- ------------------------------------------------- XML Import/Export -----------------------------------------------
use sweater;
set @xml = '<messages>
				<message tag="hiFromXml">           
					<text>This text took from xml</year>
					<userId>1</userId>
				</message>        
			</messages>';
    
select (select ExtractValue(@xml, '//message/@tag')) as tag;
select (select ExtractValue(@xml, '//message/text')) as text;
select (select ExtractValue(@xml, '//message/userId')) as user_id;

delimiter $$
create function GetLastInsertedMessageXML()
returns nvarchar(2048)
begin
	declare msg nvarchar(2048);
	set msg := (select concat('<message id="',m.id,'">','<filename>',ifnull(m.filename,'null'),'</filename><tag>',m.tag,'</tag><text>',m.text,'</text><userId>',m.user_id,'</userId></message>') from message m order by id desc limit 1);
    set msg := concat('<messages func="last">',msg,'</messages>');
    return msg;
end $$
delimiter ;

delimiter $$
create function GetOneMessagesWithTheMostLikes()
returns varchar(4096)
begin
	declare msg varchar(4096);
	declare likes bigint;
	set msg := (
		select concat(	'<message id="',m.id,'">',
						'<filename>',ifnull(m.filename,'null'),'</filename>',
                        '<tag>',m.tag,'</tag>',
                        '<text>',m.text,'</text>',
                        '<userId>',m.user_id,'</userId>',
                        '<likes>',count(ml.message_id),'</likes>',
                        '</message>')
                        from message m left outer join message_likes ml
                        on ml.message_id = m.id  group by m.id order by count(ml.message_id) desc  limit 2);
                        
    set msg := concat('<messages func="TheMostLikes">',msg,'</messages>');
    return msg;
end $$
delimiter ;

select GetLastInsertedMessageXML();
select GetOneMessagesWithTheMostLikes();
-- ------------------------------------------------- XML Import/Export END-----------------------------------------------