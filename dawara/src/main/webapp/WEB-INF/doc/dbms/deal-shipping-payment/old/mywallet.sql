drop table mywallet;
drop table mycash;
drop table mycard;
drop table member;
drop table dealsort;
drop table dealway;
drop table deal;
drop table buysell;

delete from member;
delete from mywallet;

/**********************************/
/* Table Name: 내 지갑 */
/**********************************/
CREATE TABLE mywallet(
    mem_no                            NUMBER(6)    NOT NULL    PRIMARY KEY,
  FOREIGN KEY (mem_no) REFERENCES member (mem_no)
);

COMMENT ON TABLE mywallet is '내 지갑';
COMMENT ON COLUMN mywallet.mem_no is '회원번호';

1) 회원(member) 참조 테이블 설정
-- 회원 테이블을 FK 컬럼으로 참조함으로 임시로 제작합니다.
-- 테이블명, PK 컬럼명은 설계시 지정된 것을 사용합니다. 
INSERT INTO member(mem_no) VALUES(1);
 
-- member 회원 목록(팀원 1)
SELECT mem_no
FROM member;
 
 mem_no
 ---
   1
   2
   3
  
-------------------------------------------------------------------------------------
1. 내 지갑 등록

INSERT INTO mywallet(mem_no)
VALUES ((SELECT nvl(MAX(mem_no), 0) + 1 as mem_no FROM mywallet), 1);



