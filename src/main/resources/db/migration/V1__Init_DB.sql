use sweater;
create table hibernate_sequence (next_val bigint) engine=MyISAM;
insert into hibernate_sequence values ( 1 );

create table user (
    id bigint not null auto_increment,
    activation_code varchar(255),
    active bit not null,
    email varchar(255),
    password varchar(255) not null,
    username varchar(255) not null unique,
    primary key (id)
) engine=InnoDB;

create table message (
    id bigint not null auto_increment,
    filename varchar(255),
    tag varchar(255),
    text varchar(2048),
    user_id bigint,
    primary key (id)
) engine=InnoDB;
alter table message
  add constraint message_user_fk
  foreign key (user_id) references user (id);

create table user_role (
    user_id bigint not null,
    roles varchar(255)
) engine=InnoDB;
alter table user_role
  add constraint user_role_user_fk
  foreign key (user_id) references user (id);

create table `log_user` (
    `id` int( 11 ) not null auto_increment primary key,
    `message` varchar (255) not null,
    `time` timestamp not null default CURRENT_TIMESTAMP,
    `row_id` bigint not null,
    foreign key (row_id)  references user (id)
) ENGINE = InnoDB;

create table `log_message` (
    `id` int( 11 ) not null auto_increment primary key,
    `message` varchar (255) not null,
    `time` timestamp not null default CURRENT_TIMESTAMP,
    `row_id` bigint not null
) ENGINE = InnoDB;

create table `log_subs` (
    `id` int( 11 ) not null auto_increment primary key,
    `message` varchar (255) not null,
    `time` timestamp not null default CURRENT_TIMESTAMP
) ENGINE = InnoDB;

alter table `sweater`.`message`
change column `tag` `tag` varchar(255) character set 'cp1251' null default null ;

alter table `sweater`.`message`
change column `text` `text` varchar(2048) character set 'cp1251' null default null ;

alter table `sweater`.`message`
change column `filename` `filename` varchar (255) character set 'cp1251' null default null ;


