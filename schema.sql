-- Hyuyangnim 스키마. Supabase 대시보드 SQL Editor 에 그대로 붙여넣는다.
-- 출처: 숲나들e 휴양림별 예약정책안내 (2026-08-04 실측, 2026-08-05 재확인)
-- RLS 는 전부 열어둔다 — 로그인이 없고 개인정보가 없다(즐겨찾기 목록이 전부). Our_Budget 과 동일.
--
-- ⚠️ 이 스키마는 **Our_Budget 과 같은 Supabase 프로젝트**에 들어간다 (2026-08-06 결정).
--    무료 플랜 한도가 "본인이 Owner/Admin 인 모든 조직 합산 활성 프로젝트 2개" 라
--    새 조직을 만들어도 전용 프로젝트를 못 만든다. 그래서 가계부 프로젝트를 공유한다.
--    가계부 테이블(members·transactions·category_limits·master_data·app_settings·tax_map)과
--    이름이 하나도 겹치지 않는 것을 확인했다(2026-08-06).
--
-- ⚠️ 아래 가드를 지우지 말 것. `create table if not exists` 는 같은 이름의 **남의 테이블**이
--    있으면 조용히 건너뛰고, 그 뒤 seed.sql 이 남의 테이블에 insert/delete 를 한다.
--    한 DB 를 두 앱이 쓰는 이상 이 사고를 코드로 막아야 한다.
do $$
begin
  if to_regclass('public.forests') is not null and not exists (
       select 1 from information_schema.columns
       where table_schema='public' and table_name='forests' and column_name='hmpg_id') then
    raise exception '중단: public.forests 가 이미 있는데 휴양림 테이블이 아니다. 덮어쓰지 않는다.';
  end if;
  if to_regclass('public.rules') is not null and not exists (
       select 1 from information_schema.columns
       where table_schema='public' and table_name='rules' and column_name='source_url') then
    raise exception '중단: public.rules 가 이미 있는데 휴양림 테이블이 아니다. 덮어쓰지 않는다.';
  end if;
  if to_regclass('public.favorites') is not null and not exists (
       select 1 from information_schema.columns
       where table_schema='public' and table_name='favorites' and column_name='forest_id') then
    raise exception '중단: public.favorites 가 이미 있는데 휴양림 테이블이 아니다. 덮어쓰지 않는다.';
  end if;
  if to_regclass('public.policy_snapshots') is not null and not exists (
       select 1 from information_schema.columns
       where table_schema='public' and table_name='policy_snapshots' and column_name='body_hash') then
    raise exception '중단: public.policy_snapshots 가 이미 있는데 휴양림 테이블이 아니다.';
  end if;
end $$;

create table if not exists forests (
  id       serial primary key,
  name     text not null unique,        -- 축령산자연휴양림
  gubun    text not null,               -- 국립 / 공립 / 사립
  region   text not null,               -- 서울인천경기 / 강원 / 충북 / 대전충남 / 전북 / 전남광주 / 대구경북 / 부산경남 / 제주
  sigungu  text not null,               -- 남양주시
  hmpg_id  text,                        -- 숲나들e ID. 공립·사립은 'ID02030050', 국립은 4자리 '0304'
  tel      text
);

create table if not exists rules (
  id            serial primary key,
  forest_id     int  not null references forests(id) on delete cascade,
  kind          text not null check (kind in ('fcfs','lottery')),
  freq          text not null check (freq in ('monthly','weekly')),
  day_of_month  int  check (day_of_month between 1 and 31),
  weekday       int  check (weekday between 0 and 6),   -- 0=일요일 (Date.getDay() 와 동일)
  open_time     time not null default '09:00',
  note          text,                   -- 부모님께 그대로 보여드릴 한 줄
  source_url    text not null,          -- 조례로 바뀌므로 출처 필수
  verified_at   date not null,          -- 사람이 확인한 날
  conflict      text,                   -- 소스 간 불일치 기록.
                                        -- ⚠️ 사람이 판정하기 전이면 active=false 여야 한다.
                                        --    판정이 끝나면 conflict 를 남긴 채 active=true 가 될 수 있다
                                        --    (축령산 2026-08-05 가 그 사례 — 진 소스를 지우지 않는다)
  active        bool not null default false,   -- ⚠️ 기본 false. 사람이 검토해야 켜진다
  check ( (freq='monthly' and day_of_month is not null)
       or (freq='weekly'  and weekday      is not null) )
);
create index if not exists rules_forest_idx on rules(forest_id);

create table if not exists favorites (
  forest_id int primary key references forests(id) on delete cascade,
  added_at  timestamptz not null default now()
);

create table if not exists policy_snapshots (
  id         serial primary key,
  scope      text not null unique,      -- 'policy-table' — 통합표 한 장을 감시한다
  url        text not null,
  body_hash  text not null,
  body_text  text,                      -- diff 확인용 원문 보관
  checked_at timestamptz not null default now()
);

alter table forests          enable row level security;
alter table rules            enable row level security;
alter table favorites        enable row level security;
alter table policy_snapshots enable row level security;

drop policy if exists forests_all   on forests;
drop policy if exists rules_all     on rules;
drop policy if exists favorites_all on favorites;
drop policy if exists snapshots_all on policy_snapshots;

create policy forests_all   on forests          for all using (true) with check (true);
create policy rules_all     on rules            for all using (true) with check (true);
create policy favorites_all on favorites        for all using (true) with check (true);
create policy snapshots_all on policy_snapshots for all using (true) with check (true);
