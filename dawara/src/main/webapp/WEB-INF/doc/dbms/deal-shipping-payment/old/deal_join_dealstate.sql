-------------------------------------------------------------------------------------
1. 2�� �̻��� ���̺� ���� JOIN 
      - PK, FK �÷��� ������� �մϴ�.
      
      
SELECT deal_no, usemileage, ddate, dmemo, mem_no, pr_no, buy_no, dway_no, dstate_no
FROM deal;

select dstate_no, dstate, dstate_date 
from dealstate;
      
select *
from deal d, dealstate ds
where d.dstate_no = ds.dstate_no; 
      
select d.deal_no "�ŷ� ��ȣ", d.dmemo "�ŷ� �޸�", d.mem_no "ȸ�� ��ȣ", d.pr_no "��ǰ ��ȣ", d.buy_no "���� ��ȣ", d.dway_no "�ŷ���� ��ȣ", 
      ds.dstate "�ŷ� ����", ds.dstate_date "�ŷ� ���� ��¥" 
from deal d, dealstate ds
where d.dstate_no = ds.dstate_no; 

 DEAL_NO DMEMO MEM_NO PR_NO BUY_NO DWAY_NO �ŷ� ���� DSTATE_DATE
 ------- ----- ------ ----- ------ ------- --------- ---------------------
       1 �޸�       1     1      1       1 ���      2018-06-20 12:36:53.0
       
 �ŷ� ��ȣ �ŷ� �޸� ȸ�� ��ȣ ��ǰ ��ȣ ���� ��ȣ �ŷ���� ��ȣ �ŷ� ���� �ŷ� ���� ��¥
 --------- --------- -------- ----- ----- ------- ----- ---------------------
     1     �޸�        1     1     1       1 ���    2018-06-20 12:36:53.0