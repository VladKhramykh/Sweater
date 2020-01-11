use sweater;

delimiter $$
create trigger insert_user after insert on sweater.user
for each row begin
	insert into `log_user` set message = concat('INSERTED (user_id/username): ', new.id, '/', new.username, ', usename: ', new.email), row_id = new.id;
end;

delimiter $$
create trigger subscribe after insert on sweater.user_subscriptions
for each row begin
	insert into `log_subs` set message = concat('SUBSCRIBED (user_id): ', new.subscriber_id, ', up for (user_id): ', new.channel_id);
end;

delimiter $$
create trigger add_message after insert on sweater.message
for each row begin
	insert into `log_message` set message = concat('ADDED: message_id: ', new.id, ', by whom (user_id): ', new.user_id), row_id = new.id;
end;

delimiter $$
create trigger update_user before update on sweater.user
for each row begin
	insert into `log_user` set message = concat('UPDATED (user_id/username): ', new.id, '/', new.username, ',old email:',old.email,' -> new email: ', new.email), row_id = new.id;
end;

delimiter $$
create trigger unsubscribe before delete on sweater.user_subscriptions
for each row begin
	insert into `log_subs` set message = concat('UNSUBSCRIBED (user_id): ', old.subscriber_id, ', up for (user_id): ', old.channel_id);
end;

delimiter $$
create trigger update_message after update on sweater.message
for each row begin
	insert into `log_message` set message = concat('UPDATED: message_id: ', new.id, ', by whom (user_id): ', new.user_id), row_id = new.id;
end;

delimiter $$
create trigger delete_message before delete on sweater.message
for each row begin
	insert into `log_message` set message = concat('DELETED: message_id: ', old.id, ', by whom (user_id): ', old.user_id), row_id = old.id;
end;