/**********************************/
/* Table Name: ȸ�� */
/**********************************/
CREATE TABLE member(
    mem_no                            NUMBER(6)    NOT NULL    PRIMARY KEY
);

COMMENT ON TABLE member is 'ȸ��';
COMMENT ON COLUMN member.mem_no is 'ȸ����ȣ';

1) ȸ��(member) ���� ���̺� ����
-- ȸ�� ���̺��� FK �÷����� ���������� �ӽ÷� �����մϴ�.
-- ���̺��, PK �÷����� ����� ������ ���� ����մϴ�. 
INSERT INTO member(mem_no) VALUES(1);

SELECT * from member;