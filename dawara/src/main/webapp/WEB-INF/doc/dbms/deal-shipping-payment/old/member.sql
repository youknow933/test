/**********************************/
/* Table Name: 회원 */
/**********************************/
CREATE TABLE member(
    mem_no                            NUMBER(6)    NOT NULL    PRIMARY KEY
);

COMMENT ON TABLE member is '회원';
COMMENT ON COLUMN member.mem_no is '회원번호';

1) 회원(member) 참조 테이블 설정
-- 회원 테이블을 FK 컬럼으로 참조함으로 임시로 제작합니다.
-- 테이블명, PK 컬럼명은 설계시 지정된 것을 사용합니다. 
INSERT INTO member(mem_no) VALUES(1);

SELECT * from member;