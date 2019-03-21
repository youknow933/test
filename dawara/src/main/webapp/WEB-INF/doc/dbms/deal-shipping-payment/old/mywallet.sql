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
/* Table Name: �� ���� */
/**********************************/
CREATE TABLE mywallet(
    mem_no                            NUMBER(6)    NOT NULL    PRIMARY KEY,
  FOREIGN KEY (mem_no) REFERENCES member (mem_no)
);

COMMENT ON TABLE mywallet is '�� ����';
COMMENT ON COLUMN mywallet.mem_no is 'ȸ����ȣ';

1) ȸ��(member) ���� ���̺� ����
-- ȸ�� ���̺��� FK �÷����� ���������� �ӽ÷� �����մϴ�.
-- ���̺��, PK �÷����� ����� ������ ���� ����մϴ�. 
INSERT INTO member(mem_no) VALUES(1);
 
-- member ȸ�� ���(���� 1)
SELECT mem_no
FROM member;
 
 mem_no
 ---
   1
   2
   3
  
-------------------------------------------------------------------------------------
1. �� ���� ���

INSERT INTO mywallet(mem_no)
VALUES ((SELECT nvl(MAX(mem_no), 0) + 1 as mem_no FROM mywallet), 1);



