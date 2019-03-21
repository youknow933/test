댓글 +-- 등록
       +-- 조회
       +-- 댓글 수
       +-- 수정처리
       +-- 삭제
       +-- 답변
       +-- 신규 답변을 최우선으로 출력하기 위한 답변 순서 출력
 
/**********************************/
/* Table Name: 카테고리 */
/**********************************/
CREATE TABLE reply (
        rpl_no          NUMBER(7)        NOT NULL        PRIMARY KEY,
        pr_no         NUMBER(7)        NULL ,
        mem_no                  NUMBER(6)        NULL ,
        rpl_contents              VARCHAR2(4000)       NOT NULL,
        rpl_rdate                  DATE                                      NOT NULL,
        rpl_visible                 CHAR(1)            DEFAULT 'Y'      NOT NULL,    
        rpl_grpno                 NUMBER(7)                              NOT NULL,
        rpl_indent                NUMBER(2)        DEFAULT 0       NOT NULL,
        rpl_ansnum              NUMBER(5)        DEFAULT 0       NOT NULL,
  FOREIGN KEY (pr_no) REFERENCES product (pr_no),
  FOREIGN KEY (mem_no) REFERENCES member (mem_no)
);
 
select * from member;
select * from product;

2) 테이블 삭제
DROP TABLE reply; 

COMMENT ON TABLE reply is '댓글';
COMMENT ON COLUMN reply.rpl_no is '댓글 번호';
COMMENT ON COLUMN reply.pr_no is '카테고리번호';
COMMENT ON COLUMN reply.mem_no is '회원 번호';
COMMENT ON COLUMN reply.rpl_contents is '내용';
COMMENT ON COLUMN reply.rpl_rdate is '등록일';
COMMENT ON COLUMN reply.rpl_visible is '출력 여부';
COMMENT ON COLUMN reply.rpl_grpno is '그룹 번호';
COMMENT ON COLUMN reply.rpl_indent is '답변 차수';
COMMENT ON COLUMN reply.rpl_ansnum is '답변 번호';


1) 카테고리(ncategory) 참조 테이블 설정
-- 카테고리 테이블을 FK 컬럼으로 참조함으로 임시로 제작합니다.
-- 테이블명, PK 컬럼명은 설계시 지정된 것을 사용합니다.
INSERT INTO ncategory(pr_no) VALUES(1);
INSERT INTO ncategory(pr_no) VALUES(2);
INSERT INTO ncategory(pr_no) VALUES(3);

2) 회원(ncategory) 참조 테이블 설정
-- 회원 테이블을 FK 컬럼으로 참조함으로 임시로 제작합니다.
-- 테이블명, PK 컬럼명은 설계시 지정된 것을 사용합니다.
INSERT INTO member(mem_no) VALUES(1);
INSERT INTO member(mem_no) VALUES(2);
INSERT INTO member(mem_no) VALUES(3);

3) reply 등록             
-- reply 새글 등록
- 새로운 글, 답변 글에따라 등록 SQL차이가 있습니다.
- 새로운 글 등록은 새로운 그룹이 만들어지는 기능이 있습니다. MAX + 1
- pr_no 컬럼 1번 기준
- mem_no 컬럼 1번 기준


INSERT INTO reply(rpl_no,
                  pr_no, mem_no, rpl_contents, rpl_rdate, rpl_visible,
                  rpl_grpno, rpl_indent, rpl_ansnum)  
VALUES((SELECT NVL(MAX(rpl_no), 0) + 1 as rpl_no FROM reply),
            2, 1, '내용', sysdate, 'Y', 
           0, 0, 0);           
            
            
INSERT INTO reply(rpl_no,
                  pr_no, mem_no, rpl_contents, rpl_rdate, rpl_visible,
                  rpl_grpno, rpl_indent, rpl_ansnum)  
VALUES((SELECT NVL(MAX(rpl_no), 0) + 1 as rpl_no FROM reply),
           3, 1, '내용', sysdate, 'Y', 
            (SELECT NVL(MAX(rpl_grpno), 0) + 1 as rpl_grpno FROM reply), 0, 0);       
            
            

            
       
            
4) 전체 목록(댓글 구현)

SELECT rpl_no,
           pr_no, mem_no,   rpl_contents, rpl_rdate, rpl_visible, rpl_grpno, rpl_indent, rpl_ansnum
FROM reply
order by rpl_rdate;

 RPL_NO PR_NO MEM_NO RPL_CONTENTS RPL_RDATE             RPL_VISIBLE RPL_GRPNO RPL_INDENT RPL_ANSNUM
 ------ ----- ------ ------------ --------------------- ----------- --------- ---------- ----------
      1     2      1 내용           2018-06-29 15:14:19.0 Y                   1          0          0
      2     3      1 내용           2018-06-29 15:14:20.0 Y                   2          0          0


5) ncategory 별 목록(댓글 구현)
SELECT rpl_no,
           pr_no, mem_no,   rpl_contents, rpl_rdate, rpl_visible,  rpl_grpno, rpl_indent, rpl_ansnum
FROM reply
WHERE pr_no=1
ORDER BY rpl_no;


SELECT r.rpl_no, r.pr_no, r.mem_no, r.rpl_contents, r.rpl_rdate, r.rpl_visible,  
      r.rpl_grpno, r.rpl_indent, r.rpl_ansnum, m.mem_id
FROM reply r, member m
WHERE r.mem_no=m.mem_no
ORDER BY rpl_no;

SELECT c.cart_no, c.pr_no, c.mem_no, p.pr_title, p.pr_thumbs, p.pr_state, p.pr_price, p.pr_rdate,pr_transaction
FROM cart c, product p
WHERE  c.pr_no = p.pr_no and c.mem_no =1
      ORDER BY c.cart_no DESC;


 rpl_no pr_no mem_no rpl_contents rpl_rdate                 rpl_visible rpl_grpno rpl_indent rpl_ansnum
 ------- ---- ---- ------- --------------------- ------- ----- ------ ------
       1    1    1 내용      2018-06-11 15:12:38.0 Y           1      0      0



6) 전체 카운트
SELECT COUNT(*) as count
FROM reply;      

 COUNT
 -----
     1
     
7)조회
SELECT rpl_no,
           pr_no, mem_no,   rpl_contents, rpl_rdate, rpl_visible,  rpl_grpno, rpl_indent, rpl_ansnum
FROM reply
WHERE rpl_no=1; 

 RPL_NO PR_NO MEM_NO RPL_CONTENTS RPL_RDATE             RPL_VISIBLE RPL_GRPNO RPL_INDENT RPL_ANSNUM
 ------ ----- ------ ------------ --------------------- ----------- --------- ---------- ----------
      1     1      1 내용           2018-06-18 13:24:53.0 Y                   1          0          0



8)수정
UPDATE reply
SET  rpl_contents='손이시려워...', rpl_rdate=sysdate
WHERE rpl_no=1;

9) 삭제
DELETE FROM reply
WHERE rpl_no=1

10)pr_no 삭제
DELETE FROM reply
WHERE pr_no=1

select * From product;

10)답변
    UPDATE reply
    SET rpl_ansnum = rpl_ansnum + 1
    WHERE rpl_grpno = 0 AND rpl_ansnum >= 0







            
     



