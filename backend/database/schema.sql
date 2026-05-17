create table if not exists users (
    id integer primary key autoincrement,
    username text unique not null,
    password_hash text not null,
    admin boolean,
    created_at datetime default current_timestamp
);

create table if not exists entries (
    id integer primary key autoincrement,
    user_id integer not null,
    content text,
    created_at datetime default current_timestamp,
    updated_at datetime default current_timestamp,
    foreign key (user_id) references users(id)
);

create index if not exists index_entries_user_id on entries(user_id);

create table if not exists shares(
    id integer primary key autoincrement,
    entry_id integer not null,
    shared_by integer not null,
    shared_with integer not null,
    created_at datetime default current_timestamp,
    foreign key (entry_id) references entries(id),
    foreign key (shared_by) references users(id),
    foreign key (shared_with) references users(id),
    unique(entry_id, shared_with)
);
