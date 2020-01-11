create table message_likes (
    user_id bigint not null,
    message_id bigint not null,
    primary key(user_id, message_id)
);

alter table message_likes
  add constraint message_likes_message_fk
  foreign key (message_id) references message (id);