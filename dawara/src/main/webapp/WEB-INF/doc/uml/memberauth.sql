/**********************************/
/* Table Name: ȸ�� ���� */
/**********************************/
CREATE TABLE memberauth(
    authno                            NUMBER(10)     NOT NULL    PRIMARY KEY,
    name                              VARCHAR2(50)     NULL ,
    seq                               NUMBER(3)    DEFAULT 0     NOT NULL,
    etc                               VARCHAR2(50)     NULL 
);

COMMENT ON TABLE memberauth is 'ȸ�� ����';
COMMENT ON COLUMN memberauth.authno is 'ȸ�� ���� ��ȣ';
COMMENT ON COLUMN memberauth.name is '�̸�';
COMMENT ON COLUMN memberauth.seq is '����';
COMMENT ON COLUMN memberauth.etc is '��Ÿ';

INSERT INTO memberauth(authno, name, seq, etc)
VALUES((SELECT NVL(MAX(authno), 0) + 1 as authno FROM memberauth), '������', 1, '');

INSERT INTO memberauth(authno, name, seq, etc)
VALUES((SELECT NVL(MAX(authno), 0) + 1 as authno FROM memberauth), '�Ϲ� ȸ��', 2, '');

INSERT INTO memberauth(authno, name, seq, etc)
VALUES((SELECT NVL(MAX(authno), 0) + 1 as authno FROM memberauth), 'Ż�� ȸ��', 10, '');

SELECT authno, name, seq, etc
FROM memberauth 
ORDER BY seq ASC;

 AUTHNO NAME  SEQ ETC
 ------ ----- --- ----
      1 ������     1 NULL
      2 �Ϲ� ȸ��   2 NULL
      3 Ż�� ȸ��  10 NULL

      
      







