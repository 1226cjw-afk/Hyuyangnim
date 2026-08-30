-- 자동 생성물. 직접 고치지 말고 tools/build-seed.js 를 고칠 것.
-- 생성일 2026-08-30
-- 출처 https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002

insert into forests (name, gubun, region, sigungu, hmpg_id) values ('유명산 자연휴양림', '국립', '서울인천경기', '가평군', '0101') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('아세안 자연휴양림', '국립', '서울인천경기', '양주시', '0104') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('산음 자연휴양림', '국립', '서울인천경기', '양평군', '0103') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('중미산 자연휴양림', '국립', '서울인천경기', '양평군', '0108') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('무의도 자연휴양림', '국립', '서울인천경기', '영종구', '0303') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('운악산 자연휴양림', '국립', '서울인천경기', '포천시', '0224') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('대관령 자연휴양림', '국립', '강원', '강릉시', '0111') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('진부령 자연휴양림', '국립', '강원', '고성군', '0306') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('검봉산 자연휴양림', '국립', '강원', '삼척시', '0244') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('미천골 자연휴양림', '국립', '강원', '양양군', '0112') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('백운산 자연휴양림', '국립', '강원', '원주시', '0223') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('방태산 자연휴양림', '국립', '강원', '인제군', '0109') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('용대 자연휴양림', '국립', '강원', '인제군', '0102') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('가리왕산 자연휴양림', '국립', '강원', '정선군', '0113') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('복주산 자연휴양림', '국립', '강원', '철원군', '0110') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('용화산 자연휴양림', '국립', '강원', '춘천시', '0222') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('두타산 자연휴양림(평창)', '국립', '강원', '평창군', '0243') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('삼봉 자연휴양림', '국립', '강원', '홍천군', '0107') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('화천숲속 야영장', '국립', '강원', '화천군', '0116') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('청태산 자연휴양림', '국립', '강원', '횡성군', '0106') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('황정산 자연휴양림', '국립', '충북', '단양군', '0242') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('속리산 말티재자연휴양림', '국립', '충북', '보은군', '0115') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('상당산성 자연휴양림', '국립', '충북', '청주시 청원구', '0300') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('금산 자연휴양림', '국립', '대전충남', '금산군', '0305') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('오서산 자연휴양림', '국립', '대전충남', '보령시', '0191') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('용현 자연휴양림', '국립', '대전충남', '서산시', '0220') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('희리산 자연휴양림', '국립', '대전충남', '서천군', '0187') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('신시도자연휴양림', '국립', '전북', '군산시', '0301') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('덕유산 자연휴양림', '국립', '전북', '무주군', '0141') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('변산 자연휴양림', '국립', '전북', '부안군', '0189') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('회문산 자연휴양림', '국립', '전북', '순창군', '0188') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('운장산 자연휴양림', '국립', '전북', '진안군', '0194') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('낙안민속 자연휴양림', '국립', '전남광주', '순천시', '0200') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('진도 자연휴양림', '국립', '전남광주', '순천시', '0201') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('방장산 자연휴양림', '국립', '전남광주', '장성군', '0181') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('천관산 자연휴양림', '국립', '전남광주', '장흥군', '0196') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('김천숲속야영장', '국립', '대구경북', '김천시', '0304') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('대야산 자연휴양림', '국립', '대구경북', '문경시', '0245') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('청옥산 자연휴양림', '국립', '대구경북', '봉화군', '0183') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('칠보산 자연휴양림', '국립', '대구경북', '영덕군', '0182') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('검마산 자연휴양림', '국립', '대구경북', '영양군', '0184') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('통고산 자연휴양림', '국립', '대구경북', '울진군', '0193') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('운문산 자연휴양림', '국립', '대구경북', '청도군', '0195') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('달음산 자연휴양림', '국립', '부산경남', '기장군', '0202') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('용지봉 자연휴양림', '국립', '부산경남', '김해시', '0302') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('남해편백 자연휴양림', '국립', '부산경남', '남해군', '0192') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('신불산 자연휴양림', '국립', '부산경남', '울주군', '0105') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('지리산 자연휴양림', '국립', '부산경남', '함양군', '0190') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('강씨봉자연휴양림', '공립', '서울인천경기', '가평군', 'ID02030019') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('칼봉산자연휴양림', '공립', '서울인천경기', '가평군', 'ID02030099') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('석모도자연휴양림', '공립', '서울인천경기', '강화군', 'ID02030071') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('축령산자연휴양림', '공립', '서울인천경기', '남양주시', 'ID02030050') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('수락산 동막골 자연휴양림', '공립', '서울인천경기', '노원구', 'ID02030129') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('동두천자연휴양림', '공립', '서울인천경기', '동두천시', 'ID02030023') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('서운산자연휴양림', '공립', '서울인천경기', '안성시', 'ID02030092') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('신암저수지 숲속야영장', '공립', '서울인천경기', '양주시', 'ID02030123') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('양평 백운봉 자연휴양림', '공립', '서울인천경기', '양평군', 'ID02030087') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('양평쉬자파크', '공립', '서울인천경기', '양평군', 'ID02030079') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('고대산 자연휴양림', '공립', '서울인천경기', '연천군', 'ID02030001') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('덕적도 자연휴양림', '공립', '서울인천경기', '옹진군', 'ID02030127') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('용인자연휴양림', '공립', '서울인천경기', '용인시 처인구', 'ID02030031') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('의왕바라산자연휴양림', '공립', '서울인천경기', '의왕시', 'ID02030065') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('천보산 자연휴양림', '공립', '서울인천경기', '포천시', 'CBMNT') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('무봉산 자연휴양림', '공립', '서울인천경기', '화성시 동탄구', 'ID02030118') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('임해자연휴양림', '공립', '강원', '강릉시', 'ID02030100') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('광치자연휴양림', '공립', '강원', '양구군', 'ID02030095') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('송이밸리자연휴양림', '공립', '강원', '양양군', 'ID02030049') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('영월망경대산자연휴양림', '공립', '강원', '영월군', 'ID02030067') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('치악산자연휴양림', '공립', '강원', '원주시', 'ID02030024') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('갯골자연휴양림', '공립', '강원', '인제군', 'ID02030120') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('하추자연휴양림', '공립', '강원', '인제군', 'ID02030018') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('철원 두루웰 숲속문화촌', '공립', '강원', '철원군', 'ID02030005') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('강원숲체험장', '공립', '강원', '춘천시', 'ID02030096') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('집다리골자연휴양림', '공립', '강원', '춘천시', 'ID02030043') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('춘천숲자연휴양림', '공립', '강원', '춘천시', 'ID02030125') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('태백고원자연휴양림', '공립', '강원', '태백시', 'ID02030022') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('평창자연휴양림', '공립', '강원', '평창군', 'ID02030003') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('가리산 자연휴양림', '공립', '강원', '홍천군', 'ID02030002') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('성불산자연휴양림', '공립', '충북', '괴산군', 'ID02030070') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('조령산 자연휴양림', '공립', '충북', '괴산군', 'ID02030008') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('소백산자연휴양림', '공립', '충북', '단양군', 'ID02030009') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('소선암자연휴양림', '공립', '충북', '단양군', 'ID02030041') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('속리산숲체험휴양마을', '공립', '충북', '보은군', 'ID02030035') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('충북알프스자연휴양림', '공립', '충북', '보은군', 'ID02030032') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('민주지산자연휴양림', '공립', '충북', '영동군', 'ID02030107') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('장령산자연휴양림', '공립', '충북', '옥천군', 'ID02030036') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('백야자연휴양림', '공립', '충북', '음성군', 'ID02030016') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('수레의산자연휴양림', '공립', '충북', '음성군', 'ID02030017') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('박달재자연휴양림', '공립', '충북', '제천시', 'ID02030062') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('옥전자연휴양림', '공립', '충북', '제천시', 'ID02030110') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('좌구산휴양랜드', '공립', '충북', '증평군', 'ID02030089') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('생거진천자연휴양림', '공립', '충북', '진천군', 'ID02030033') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('미원별빛자연휴양림', '공립', '충북', '청주시 상당구', 'ID02030132') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('옥화자연휴양림', '공립', '충북', '청주시 상당구', 'ID02030054') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('계명산자연휴양림', '공립', '충북', '충주시', 'ID02030042') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('문성자연휴양림', '공립', '충북', '충주시', 'ID02030055') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('봉황자연휴양림', '공립', '충북', '충주시', 'ID02030051') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('공주산림휴양마을', '공립', '대전충남', '공주시', 'ID02030011') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('금산산림문화타운(남이자연휴양림)', '공립', '대전충남', '금산군', 'ID02030063') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('양촌자연휴양림', '공립', '대전충남', '논산시', 'ID02030034') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('만인산자연휴양림', '공립', '대전충남', '동구', 'ID02030111') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('성주산자연휴양림', '공립', '대전충남', '보령시', 'ID02030078') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('원산도자연휴양림', '공립', '대전충남', '보령시', 'ID02030130') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('만수산자연휴양림', '공립', '대전충남', '부여군', 'ID02030007') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('장태산자연휴양림', '공립', '대전충남', '서구', 'ID02030106') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('영인산 자연휴양림', '공립', '대전충남', '아산시', 'ID02030012') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('봉수산자연휴양림', '공립', '대전충남', '예산군', 'ID02030028') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('태학산자연휴양림', '공립', '대전충남', '천안시 동남구', 'ID02030040') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('칠갑산자연휴양림', '공립', '대전충남', '청양군', 'ID02030044') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('안면도자연휴양림', '공립', '대전충남', '태안군', 'ID02030086') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('용봉산자연휴양림', '공립', '대전충남', '홍성군', 'ID02030080') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('김제 선암자연휴양림', '공립', '전북', '김제시', 'ID02030119') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('무주향로산자연휴양림', '공립', '전북', '무주군', 'ID02030108') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('고산자연휴양림', '공립', '전북', '완주군', 'ID02030025') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('성수산왕의숲자연휴양림', '공립', '전북', '임실군', 'ID02030122') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('방화동자연휴양림', '공립', '전북', '장수군', 'ID02030082') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('와룡자연휴양림', '공립', '전북', '장수군', 'ID02030084') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('내장산자연휴양림', '공립', '전북', '정읍시', 'ID02030131') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('데미샘자연휴양림', '공립', '전북', '진안군', 'ID02030074') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('주작산자연휴양림', '공립', '전남광주', '강진군', 'ID02030060') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('광양백운산자연휴양림', '공립', '전남광주', '광양시', 'ID02030061') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('팔영산자연휴양림', '공립', '전남광주', '광양시', 'ID02030069') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('산수유자연휴양림', '공립', '전남광주', '구례군', 'ID02030091') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('제암산자연휴양림', '공립', '전남광주', '보성군', 'ID02030090') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('순천자연휴양림', '공립', '전남광주', '순천시', 'ID02030058') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('여수봉황산자연휴양림', '공립', '전남광주', '여수시', 'ID02030097') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('기찬자연휴양림', '공립', '전남광주', '영암군', 'ID02030121') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('전라남도 완도자연휴양림', '공립', '전남광주', '완도군', 'ID02030021') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('흑석산자연휴양림', '공립', '전남광주', '해남군', 'ID02030045') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('백아산자연휴양림', '공립', '전남광주', '화순군', 'ID02030098') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('한천자연휴양림', '공립', '전남광주', '화순군', 'ID02030088') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('토함산자연휴양림', '공립', '대구경북', '경주시', 'ID02030027') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('미숭산자연휴양림', '공립', '대구경북', '고령군', 'ID02030026') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('옥성자연휴양림', '공립', '대구경북', '구미시', 'ID02030066') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('군위장곡자연휴양림', '공립', '대구경북', '군위군', 'ID02030064') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('수도산자연휴양림', '공립', '대구경북', '김천시', 'ID02030030') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('비슬산자연휴양림', '공립', '대구경북', '달성군', 'ID02030093') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('화원자연휴양림', '공립', '대구경북', '달성군', 'ID02030094') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('문수산자연휴양림', '공립', '대구경북', '봉화군', 'ID02030102') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('성주봉자연휴양림', '공립', '대구경북', '상주시', 'ID02030039') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('독용산성자연휴양림', '공립', '대구경북', '성주군', 'ID02030004') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('안동호반자연휴양림', '공립', '대구경북', '안동시', 'ID02030020') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('영양에코둥지', '공립', '대구경북', '영양군', 'ID02030057') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('보현산자연휴양림', '공립', '대구경북', '영천시', 'ID02030105') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('운주산승마자연휴양림', '공립', '대구경북', '영천시', 'ID02030081') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('구수곡자연휴양림', '공립', '대구경북', '울진군', 'ID02030073') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('금봉자연휴양림', '공립', '대구경북', '의성군', 'ID02030075') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('청도자연휴양림', '공립', '대구경북', '청도군', 'ID02030116') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('청송자연휴양림', '공립', '대구경북', '청송군', 'ID02030010') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('송정자연휴양림', '공립', '대구경북', '칠곡군', 'ID02030076') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('팔공산금화자연휴양림', '공립', '대구경북', '칠곡군', 'ID02030006') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('비학산자연휴양림', '공립', '대구경북', '포항시 북구', 'ID02030052') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('거제자연휴양림', '공립', '부산경남', '거제시', 'ID02030059') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('거창산림레포츠파크', '공립', '부산경남', '거창군', 'ID02030126') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('거창항노화힐링랜드', '공립', '부산경남', '거창군', 'ID02030109') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('금원산자연휴양림', '공립', '부산경남', '거창군', 'ID02030077') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('갈모봉 자연휴양림', '공립', '부산경남', '고성군', 'ID02030124') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('밀양 도래재자연휴양림', '공립', '부산경남', '밀양시', 'ID02030115') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('사천 케이블카 자연휴양림', '공립', '부산경남', '사천시', 'ID02030112') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('산청한방자연휴양림', '공립', '부산경남', '산청군', 'ID02030037') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('대운산자연휴양림', '공립', '부산경남', '양산시', 'ID02030038') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('자굴산 자연휴양림', '공립', '부산경남', '의령군', 'ID02030113') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('진주 월아산 자연휴양림', '공립', '부산경남', '진주시', 'ID02030114') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('화왕산자연휴양림', '공립', '부산경남', '창녕군', 'ID02030015') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('구재봉자연휴양림', '공립', '부산경남', '하동군', 'ID02030072') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('하동편백자연휴양림', '공립', '부산경남', '하동군', 'ID02030103') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('대봉산자연휴양림', '공립', '부산경남', '함양군', 'ID02030046') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('대봉캠핑랜드', '공립', '부산경남', '함양군', 'ID02030117') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('산삼자연휴양림', '공립', '부산경남', '함양군', 'ID02030048') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('용추자연휴양림', '공립', '부산경남', '함양군', 'ID02030047') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('오도산자연휴양림', '공립', '부산경남', '합천군', 'ID02030068') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('붉은오름자연휴양림', '공립', '제주', '서귀포시', 'ID02030014') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('서귀포자연휴양림', '공립', '제주', '서귀포시', 'ID02030013') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('교래자연휴양림', '공립', '제주', '제주시', 'ID02030056') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('제주절물자연휴양림', '공립', '제주', '제주시', 'ID02030053') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('청평자연휴양림', '사립', '서울인천경기', '가평군', 'ID04030007') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('강화자연휴양림', '사립', '서울인천경기', '강화군', 'ID04030105') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('양평설매재자연휴양림', '사립', '서울인천경기', '양평군', 'ID04030004') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('삼척활기자연휴양림', '사립', '강원', '삼척시', 'ID02030104') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('피노키오자연휴양림', '사립', '강원', '원주시', 'ID04030001') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('횡성자연휴양림', '사립', '강원', '횡성군', 'ID04030002') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('남원자연휴양림', '사립', '전북', '남원시', 'ID04030003') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('무등산편백자연휴양림', '사립', '전남광주', '화순군', 'ID04030010') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('학가산우래자연휴양림', '사립', '대구경북', '예천군', 'ID04030009') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);
insert into forests (name, gubun, region, sigungu, hmpg_id) values ('덕원자연휴양림', '사립', '부산경남', '하동군', 'ID04030008') on conflict (name) do update set gubun=excluded.gubun, region=excluded.region, sigungu=excluded.sigungu, hmpg_id=coalesce(excluded.hmpg_id, forests.hmpg_id);

delete from rules;

insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '유명산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '아세안 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '산음 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '중미산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '무의도 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '운악산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '대관령 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '진부령 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '검봉산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '미천골 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '백운산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '방태산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '용대 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '가리왕산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '복주산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '용화산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '두타산 자연휴양림(평창)';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '삼봉 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '화천숲속 야영장';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '청태산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '황정산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '속리산 말티재자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '상당산성 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '금산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '오서산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '용현 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '희리산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '신시도자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '덕유산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '변산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '회문산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '운장산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '낙안민속 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '진도 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '방장산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '천관산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '김천숲속야영장';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '대야산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '청옥산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '칠보산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '검마산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '통고산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '운문산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '달음산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '용지봉 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '남해편백 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '신불산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '지리산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', '매월 1일 오전 9시부터', 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', '⚠️ 사용자 판정으로 통합표(매월 1일 09시)를 채택했다 (2026-08-05). 반대 소스: 개별 정책 페이지 ruleId=101 은 ''예약 신청은 매월 7일 전체 휴양림 객실 오전 9시부터, 다음달 말일까지 가능합니다'' (2026-08-05 실측). 축령산과 완전히 같은 사례 — 둘 다 경기도산림환경연구소 운영. hmpg_id 는 2026-08-05 목록 스크랩으로 확보 (설계서 §8 미해결 항목 해소)', true
from forests f where f.name = '강씨봉자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 10, null, '16:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '칼봉산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '석모도자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', '매월 1일 오전 9시부터', 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', '⚠️ 사용자 판정으로 통합표(매월 1일 09시)를 채택했다 (2026-08-05). 반대 소스: 개별 정책 페이지 ruleId=101 은 ''선착순 예약 신청은 월추첨 발표 후 매월 7일 오전9시부터 잔여객실에 한하여 다음달 말일까지 가능합니다'' (2026-08-03, 2026-08-05 재렌더 동일). 강씨봉도 똑같이 1일 vs 7일 로 어긋난다. 부모님이 1일에 접속해 예약이 안 되면 7일을 확인할 것. 문의 031-8008-6690 (개별 페이지 하단 실측값. CLAUDE.md 의 031-592-0681 과 다르다)', true
from forests f where f.name = '축령산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 10, null, '14:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '수락산 동막골 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 2, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '동두천자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 3, null, '14:00', '매월 3일 오후 2시부터', 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', '개별 정책 페이지(ruleId=101)에는 오픈 시점이 한 줄도 없다 — 통합표만이 소스다. 안면도와 같은 패턴이고, 통합표는 검증 가능한 5곳 중 5곳에서 정확했다. 문의 031-678-2913', true
from forests f where f.name = '서운산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '10:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '신암저수지 숲속야영장';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '10:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '양평 백운봉 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '10:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '양평쉬자파크';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '고대산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '덕적도 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 10, null, '13:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '용인자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 11, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '의왕바라산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '천보산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '무봉산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '임해자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '광치자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '송이밸리자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '영월망경대산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '치악산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 4, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '갯골자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 4, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '하추자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '철원 두루웰 숲속문화촌';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '강원숲체험장';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '집다리골자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 0, '14:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '춘천숲자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '태백고원자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '평창자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '가리산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 5, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '성불산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '조령산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '소백산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '소선암자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '속리산숲체험휴양마을';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '충북알프스자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '민주지산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '장령산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '10:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '백야자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '10:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '수레의산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '박달재자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '옥전자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '좌구산휴양랜드';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '13:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '생거진천자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 5, null, '10:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '미원별빛자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 5, null, '10:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '옥화자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 3, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '계명산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 3, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '문성자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 3, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '봉황자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '공주산림휴양마을';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '금산산림문화타운(남이자연휴양림)';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '10:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '양촌자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '만인산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '성주산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 6, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '원산도자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '만수산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '장태산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', '매주 수요일 오전 9시부터', 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, true
from forests f where f.name = '영인산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '봉수산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '태학산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '칠갑산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 6, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '안면도자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '용봉산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '김제 선암자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '무주향로산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 1, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '고산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 2, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '성수산왕의숲자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 1, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '방화동자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 1, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '와룡자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '내장산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '데미샘자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '10:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '주작산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '광양백운산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '팔영산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 2, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '산수유자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '10:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '제암산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '순천자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '여수봉황산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '기찬자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '전라남도 완도자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '흑석산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '백아산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '한천자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '토함산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '미숭산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '옥성자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '군위장곡자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '수도산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '비슬산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '화원자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 2, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '문수산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '성주봉자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '독용산성자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '10:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '안동호반자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 5, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '영양에코둥지';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '보현산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '13:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '운주산승마자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '구수곡자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '금봉자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '청도자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '청송자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '송정자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '10:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '팔공산금화자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '비학산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '거제자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '거창산림레포츠파크';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 1, '14:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '거창항노화힐링랜드';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '금원산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '갈모봉 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '밀양 도래재자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '사천 케이블카 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '산청한방자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '대운산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '자굴산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '진주 월아산 자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '화왕산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '구재봉자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '하동편백자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '대봉산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 1, '10:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '대봉캠핑랜드';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '산삼자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '용추자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '오도산자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '붉은오름자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '서귀포자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '교래자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '제주절물자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '00:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '청평자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '강화자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'monthly', 1, null, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '양평설매재자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '삼척활기자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '피노키오자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '횡성자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '남원자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '무등산편백자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '학가산우래자연휴양림';
insert into rules (forest_id, kind, freq, day_of_month, weekday, open_time, note, source_url, verified_at, conflict, active)
select f.id, 'fcfs', 'weekly', null, 3, '09:00', null, 'https://www.foresttrip.go.kr/pot/cc/bb/selectFripRsrvtPolcyView.do?hmpgId=FRIP&menuId=002002', '2026-08-05', null, false
from forests f where f.name = '덕원자연휴양림';

-- 관심 4곳 즐겨찾기 선등록 (이미 있으면 그대로 둔다)
insert into favorites (forest_id) select id from forests where name = '축령산자연휴양림' on conflict (forest_id) do nothing;
insert into favorites (forest_id) select id from forests where name = '영인산 자연휴양림' on conflict (forest_id) do nothing;
insert into favorites (forest_id) select id from forests where name = '서운산자연휴양림' on conflict (forest_id) do nothing;
insert into favorites (forest_id) select id from forests where name = '강씨봉자연휴양림' on conflict (forest_id) do nothing;
