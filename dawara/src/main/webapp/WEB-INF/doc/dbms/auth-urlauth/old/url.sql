drop table url;

delete from url;

/**********************************/
/* Table Name: ���� �ּ� */
/**********************************/
1. ���̺�
- ���� �ּ� ���̺�
- ���ѿ� ���� ���� �ּ� ����
CREATE TABLE url(
    url_no                         NUMBER(10)         NOT NULL    PRIMARY KEY,
    url_info                        VARCHAR2(200)    NOT NULL,
);


COMMENT ON TABLE url is '���� �ּ�';
COMMENT ON COLUMN url.url_no is '���� �ּ� ��ȣ';
COMMENT ON COLUMN url.url_info is '���� �ּ� ����';




