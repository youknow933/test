2) �α��� ���� ���̺� ����

CREATE TABLE login(
  login_no NUMBER(10)  NOT NULL,
  mem_no NUMBER(6) NOT NULL,
  login_ip  VARCHAR(15) NOT NULL,
  login_date DATE  NOT NULL,
  PRIMARY KEY (login_no),
  FOREIGN KEY(mem_no)  REFERENCES member(mem_no)
);

drop table login;
  
COMMENT ON TABLE login is '�α���';
COMMENT ON COLUMN login.login_NO is '�α��ι�ȣ';
COMMENT ON COLUMN login.mem_no is 'ȸ����ȣ';
COMMENT ON COLUMN login.login_ip is 'login_ip';
COMMENT ON COLUMN login.login_date is '�α��γ�¥';