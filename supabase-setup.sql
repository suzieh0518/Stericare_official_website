-- 스테리케어 홈페이지 문의 양식용 테이블
-- Supabase 대시보드 > SQL Editor 에 붙여넣고 Run 하세요.

create table if not exists public.inquiries (
  id          bigint generated always as identity primary key,
  created_at  timestamptz not null default now(),
  org         text,
  name        text not null check (char_length(name) <= 50),
  tel         text not null check (char_length(tel) <= 30),
  type        text check (char_length(type) <= 30),
  message     text check (char_length(message) <= 3000)
);

-- 보안: 홈페이지 방문자는 "문의 넣기"만 가능하고, 남의 문의를 읽거나 지울 수 없게 합니다.
alter table public.inquiries enable row level security;

create policy "website visitors can submit inquiries"
  on public.inquiries for insert
  to anon
  with check (true);

-- 읽기 정책은 만들지 않습니다. 접수된 문의는 Supabase 대시보드 > Table Editor > inquiries 에서 확인하세요.
