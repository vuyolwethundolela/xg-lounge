-- XG Lounge: run this whole file once in Supabase > SQL Editor
create table visits(id bigint generated always as identity primary key,created_at timestamptz default now(),path text,device text,referrer text);
create table enquiries(id bigint generated always as identity primary key,created_at timestamptz default now(),
 kind text not null check(kind in('lounge','stay','order')),type text,room text,event_date date,check_in date,check_out date,
 guests int,total int,items jsonb,status text not null default 'new' check(status in('new','confirmed','cancelled')));
create table reviews(id bigint generated always as identity primary key,created_at timestamptz default now(),
 name text not null check(length(name)<=60),rating int not null check(rating between 1 and 5),
 comment text not null check(length(comment)<=500),approved boolean not null default false);
create table admins(email text primary key);
create function is_admin() returns boolean language sql security definer stable set search_path=public
as $$ select exists(select 1 from admins where email=(auth.jwt()->>'email')) $$;
alter table visits enable row level security;alter table enquiries enable row level security;
alter table reviews enable row level security;alter table admins enable row level security;
-- visitors may only ADD rows
create policy v_ins on visits for insert to anon,authenticated with check(true);
create policy e_ins on enquiries for insert to anon,authenticated with check(status='new');
create policy r_ins on reviews for insert to anon,authenticated with check(approved=false);
-- public may read approved reviews only
create policy r_sel on reviews for select using(approved or is_admin());
-- only the admin can read/change everything else
create policy v_sel on visits for select to authenticated using(is_admin());
create policy e_sel on enquiries for select to authenticated using(is_admin());
create policy e_upd on enquiries for update to authenticated using(is_admin()) with check(is_admin());
create policy r_upd on reviews for update to authenticated using(is_admin()) with check(is_admin());
create policy r_del on reviews for delete to authenticated using(is_admin());
-- CHANGE THIS to the owner's email (the same one you create in Authentication > Users)
insert into admins values('owner@example.com');
