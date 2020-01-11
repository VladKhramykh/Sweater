-- -------------------------------------------------------------------
delimiter $$
create procedure Subscribe(in id bigint, in sub_id bigint)
begin
	insert into user_subscriptions(channel_id, subscriber_id) values (id, sub_id);
end $$
delimiter ;

-- -------------------------------------------------------------------
delimiter $$
create procedure Unsubscribe(in id bigint, in sub_id bigint)
begin
	delete from user_subscriptions where channel_id = id and subscriber_id = sub_id;
end $$
delimiter ;

-- -------------------------------------------------------------------
delimiter $$
create procedure LikeMessage(in user_id bigint, in message_id bigint)
begin
	insert into message_likes(user_id, message_id) values (user_id, message_id);
end $$
delimiter ;

-- -------------------------------------------------------------------
delimiter $$
create procedure DislikeMessage(in u_id bigint, in m_id bigint)
begin
	delete from message_likes where user_id = u_id and message_id = m_id;
end $$
delimiter ;

-- -------------------------------------------------------------------
