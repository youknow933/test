/**********************************/
/* Table Name: 회원 권한 */
/**********************************/
CREATE TABLE memberauth(
    authno                            NUMBER(10)     NOT NULL    PRIMARY KEY,
    name                              VARCHAR2(50)     NULL ,
    seq                               NUMBER(3)    DEFAULT 0     NOT NULL,
    etc                               VARCHAR2(50)     NULL 
);

COMMENT ON TABLE memberauth is '회원 권한';
COMMENT ON COLUMN memberauth.authno is '회원 권한 번호';
COMMENT ON COLUMN memberauth.name is '이름';
COMMENT ON COLUMN memberauth.seq is '순서';
COMMENT ON COLUMN memberauth.etc is '기타';

INSERT INTO memberauth(authno, name, seq, etc)
VALUES((SELECT NVL(MAX(authno), 0) + 1 as authno FROM memberauth), '마스터', 1, '');

INSERT INTO memberauth(authno, name, seq, etc)
VALUES((SELECT NVL(MAX(authno), 0) + 1 as authno FROM memberauth), '일반 회원', 2, '');

INSERT INTO memberauth(authno, name, seq, etc)
VALUES((SELECT NVL(MAX(authno), 0) + 1 as authno FROM memberauth), '탈퇴 회원', 10, '');

SELECT authno, name, seq, etc
FROM memberauth 
ORDER BY seq ASC;

 AUTHNO NAME  SEQ ETC
 ------ ----- --- ----
      1 마스터     1 NULL
      2 일반 회원   2 NULL
      3 탈퇴 회원  10 NULL

      
      







