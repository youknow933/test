
DROP TABLE nsurf

CREATE TABLE nsurf (
        nsurfno              NUMBER(7)        NOT NULL        PRIMARY KEY,
        nsurfword          VARCHAR2(300)        NOT NULL,
        cnt                    NUMBER(7)        DEFAULT 0       NOT NULL,
        rdate                  DATE                                      NOT NULL,
        mem_no                  NUMBER(6)        NOT NULL ,
    
  FOREIGN KEY (mem_no) REFERENCES member (mem_no)
);

COMMENT ON TABLE nsurf is '검색어';
COMMENT ON COLUMN nsurf.nsurfno is '컨텐츠 번호';
COMMENT ON COLUMN nsurf.mem_no is '회원 번호';
COMMENT ON COLUMN nsurf.nsurfword is '검색어';
COMMENT ON COLUMN nsurf.cnt is '조회수';
COMMENT ON COLUMN nsurf.rdate is '등록일';

1) 등록(INSERT)            

INSERT INTO nsurf(nsurfno, nsurfword, cnt, rdate, mem_no)  
VALUES((SELECT NVL(MAX(nsurfno), 0) + 1 as nsurfno FROM nsurf),
            '삼성', 0, sysdate, 1);

2) 목록
SELECT nsurfno, nsurfword, cnt, rdate, mem_no
FROM nsurf

3) 전체 카운트
SELECT COUNT(*) as count
FROM nsurf;

4) 번호별 조회
SELECT nsurfno, nsurfword, cnt, rdate, mem_no
FROM nsurf
WHERE nsurfno=1; 

5) 수정(UPDATE)
UPDATE nsurf
SET nsurfword='삼성', nsurfno='1'
WHERE nsurfno=1;

6) 삭제(DELETE)
DELETE FROM nsurf
WHERE nsurfno=1

7) 검색(%: 없거나 하나 이상의 모든 문자)
-- word LIKE '스위스' → word = '스위스'
   ^스위스$
-- word LIKE '%스위스' → word = '잊지 못할 스위스'
   .*스위스$
-- word LIKE '스위스%' → word = '스위스에서~'
   ^스위스.*
-- word LIKE '%스위스%' → word = '유럽 여행은 스위스 꼭 방문해야~'
   .*스위스.*

-- '삼성' 컬럼으로 검색
SELECT nsurfno, nsurfword, cnt, rdate, mem_no
FROM nsurf
WHERE nsurfno=1 AND nsurfword LIKE '%삼성%';

8) 검색 및 전체 레코드 갯수
-- nsurfno 컬럼이 1번이며 검색하지 않는 경우 레코드 갯수
SELECT COUNT(*) as cnt
FROM nsurf
WHERE nsurfno=1;

-- '삼성' 검색 레코드 갯수
SELECT COUNT(*) as cnt
FROM nsurf
WHERE nsurfno=1 AND nsurfword LIKE '%삼성%';

9) 페이징 구현
-- step 1
SELECT nsurfno, nsurfword, cnt, rdate, mem_no
FROM nsurf
WHERE nsurfno=1
ORDER BY nsurfno DESC;
 
-- step 2         
SELECT nsurfno, nsurfword, cnt, rdate, mem_no, rownum as r
FROM(
         SELECT nsurfno, nsurfword, cnt, rdate, mem_no
         FROM nsurf
         WHERE nsurfno=1
         ORDER BY nsurfno DESC
);

-- step 3         
SELECT nsurfno, nsurfword, cnt, rdate, mem_no, r
FROM(
         SELECT nsurfno, nsurfword, cnt, rdate, mem_no, rownum as r
         FROM(
                  SELECT nsurfno, nsurfword, cnt, rdate, mem_no
                  FROM nsurf
                  WHERE nsurfno=1
                  ORDER BY nsurfno DESC
         )
)
WHERE r >=1 AND r <= 3;



-- 검색        
SELECT nsurfno, nsurfword, cnt, rdate, mem_no, r
FROM(
         SELECT nsurfno, nsurfword, cnt, rdate, mem_no, rownum as r
         FROM(
                  SELECT nsurfno, nsurfword, cnt, rdate, mem_no
                  FROM nsurf
                  WHERE nsurfno=1 AND nsurfword LIKE '%삼성%'
                  ORDER BY nsurfno DESC
         )
)
WHERE r >=1 AND r <= 3;
