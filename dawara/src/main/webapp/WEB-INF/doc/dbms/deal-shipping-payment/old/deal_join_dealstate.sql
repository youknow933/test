-------------------------------------------------------------------------------------
1. 2개 이상의 테이블 연결 JOIN 
      - PK, FK 컬럼을 대상으로 합니다.
      
      
SELECT deal_no, usemileage, ddate, dmemo, mem_no, pr_no, buy_no, dway_no, dstate_no
FROM deal;

select dstate_no, dstate, dstate_date 
from dealstate;
      
select *
from deal d, dealstate ds
where d.dstate_no = ds.dstate_no; 
      
select d.deal_no "거래 번호", d.dmemo "거래 메모", d.mem_no "회원 번호", d.pr_no "상품 번호", d.buy_no "구매 번호", d.dway_no "거래방식 번호", 
      ds.dstate "거래 상태", ds.dstate_date "거래 상태 날짜" 
from deal d, dealstate ds
where d.dstate_no = ds.dstate_no; 

 DEAL_NO DMEMO MEM_NO PR_NO BUY_NO DWAY_NO 거래 상태 DSTATE_DATE
 ------- ----- ------ ----- ------ ------- --------- ---------------------
       1 메모       1     1      1       1 등록      2018-06-20 12:36:53.0
       
 거래 번호 거래 메모 회원 번호 상품 번호 구매 번호 거래방식 번호 거래 상태 거래 상태 날짜
 --------- --------- -------- ----- ----- ------- ----- ---------------------
     1     메모        1     1     1       1 등록    2018-06-20 12:36:53.0