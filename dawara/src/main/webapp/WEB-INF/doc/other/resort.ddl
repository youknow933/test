/**********************************/
/* Table Name: ī�װ� �׷� */
/**********************************/
CREATE TABLE categrp(
		categrpno                     		NUMBER(10)		 NOT NULL		   PRIMARY KEY,
		classification                		CHAR(1)		     DEFAULT 1		 NOT NULL,
		name                      		    VARCHAR2(50)	 NOT NULL,
		seqno                         		NUMBER(7)		   DEFAULT 0		 NOT NULL,
		visible                       		CHAR(1)		     DEFAULT 'Y'  NOT NULL,
		rdate                         		DATE		       NOT NULL
);

COMMENT ON TABLE categrp is 'ī�װ� �׷�';
COMMENT ON COLUMN categrp.categrpno is 'ī�װ� �׷��ȣ';
COMMENT ON COLUMN categrp.classification is 'ī�װ� �׷�з�';
COMMENT ON COLUMN categrp.name is 'ī�װ���';
COMMENT ON COLUMN categrp.seqno is '��¼���';
COMMENT ON COLUMN categrp.visible is '��� ���';
COMMENT ON COLUMN categrp.rdate is '�׷� ������';


/**********************************/
/* Table Name: ī�װ� */
/**********************************/
CREATE TABLE name(
		categoryno                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		categrpno                     		NUMBER(10)		 NULL ,
  FOREIGN KEY (categrpno) REFERENCES categrp (categrpno)
);

COMMENT ON TABLE name is 'ī�װ�';
COMMENT ON COLUMN name.categoryno is 'ī�װ� ��ȣ';
COMMENT ON COLUMN name.categrpno is 'ī�װ��׷� ��ȣ';


/**********************************/
/* Table Name: ������ */
/**********************************/
CREATE TABLE contents(
		contentsno                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		categoryno                    		NUMBER(10)		 NULL ,
  FOREIGN KEY (categoryno) REFERENCES name (categoryno)
);

COMMENT ON TABLE contents is '������';
COMMENT ON COLUMN contents.contentsno is '������ ��ȣ';
COMMENT ON COLUMN contents.categoryno is 'ī�װ� ��ȣ';


/**********************************/
/* Table Name: ����(��å) */
/**********************************/
CREATE TABLE auth(
		authno                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY
);

COMMENT ON TABLE auth is '����(��å)';
COMMENT ON COLUMN auth.authno is '���� ��ȣ';


/**********************************/
/* Table Name: ȸ�� */
/**********************************/
CREATE TABLE member(
		memberno                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		authno                        		NUMBER(10)		 NULL ,
  FOREIGN KEY (authno) REFERENCES auth (authno)
);

COMMENT ON TABLE member is 'ȸ��';
COMMENT ON COLUMN member.memberno is 'ȸ�� ��ȣ';
COMMENT ON COLUMN member.authno is '���� ��ȣ';


/**********************************/
/* Table Name: ���, ��ǰ�� */
/**********************************/
CREATE TABLE reply(
		replyno                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		contentsno                    		NUMBER(10)		 NULL ,
		memberno                      		NUMBER(10)		 NULL ,
  FOREIGN KEY (contentsno) REFERENCES contents (contentsno),
  FOREIGN KEY (memberno) REFERENCES member (memberno)
);

COMMENT ON TABLE reply is '���, ��ǰ��';
COMMENT ON COLUMN reply.replyno is '��� ��ȣ';
COMMENT ON COLUMN reply.contentsno is '������ ��ȣ';
COMMENT ON COLUMN reply.memberno is 'ȸ�� ��ȣ';


/**********************************/
/* Table Name: ��� */
/**********************************/
CREATE TABLE admin(
		adminno                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		authno                        		NUMBER(10)		 NULL ,
  FOREIGN KEY (authno) REFERENCES auth (authno)
);

COMMENT ON TABLE admin is '���';
COMMENT ON COLUMN admin.adminno is '��� ��ȣ';
COMMENT ON COLUMN admin.authno is '���� ��ȣ';


/**********************************/
/* Table Name: ���� URL�ּ� */
/**********************************/
CREATE TABLE url(
		urlno                         		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		urlauthno                     		NUMBER(10)		 NULL 
);

COMMENT ON TABLE url is '���� URL�ּ�';
COMMENT ON COLUMN url.urlno is '���� URL�ּ� ��ȣ';
COMMENT ON COLUMN url.urlauthno is '���Ѻ� ���� URL ��ȣ';


/**********************************/
/* Table Name: ���Ѻ� ���� URL */
/**********************************/
CREATE TABLE urlauth(
		urlauthno                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		authno                        		NUMBER(10)		 NULL ,
		urlno                         		NUMBER(10)		 NULL ,
  FOREIGN KEY (authno) REFERENCES auth (authno),
  FOREIGN KEY (urlno) REFERENCES url (urlno)
);

COMMENT ON TABLE urlauth is '���Ѻ� ���� URL';
COMMENT ON COLUMN urlauth.urlauthno is '���Ѻ� ���� URL ��ȣ';
COMMENT ON COLUMN urlauth.authno is '���� ��ȣ';
COMMENT ON COLUMN urlauth.urlno is '���� URL�ּ� ��ȣ';


/**********************************/
/* Table Name: ����(����) */
/**********************************/
CREATE TABLE reservation(
		reservationno                 		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		contentsno                    		NUMBER(10)		 NULL ,
		memberno                      		NUMBER(10)		 NULL ,
  FOREIGN KEY (contentsno) REFERENCES contents (contentsno),
  FOREIGN KEY (memberno) REFERENCES member (memberno)
);

COMMENT ON TABLE reservation is '����(����)';
COMMENT ON COLUMN reservation.reservationno is '���� ��ȣ';
COMMENT ON COLUMN reservation.contentsno is '������ ��ȣ';
COMMENT ON COLUMN reservation.memberno is 'ȸ�� ��ȣ';


/**********************************/
/* Table Name: ���� īƮ(���� ����) */
/**********************************/
CREATE TABLE cart(
		cartno                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		contentsno                    		NUMBER(10)		 NULL ,
		memberno                      		NUMBER(10)		 NULL ,
  FOREIGN KEY (contentsno) REFERENCES contents (contentsno),
  FOREIGN KEY (memberno) REFERENCES member (memberno)
);

COMMENT ON TABLE cart is '���� īƮ(���� ����)';
COMMENT ON COLUMN cart.cartno is '����īƮ ��ȣ';
COMMENT ON COLUMN cart.contentsno is '������ ��ȣ';
COMMENT ON COLUMN cart.memberno is 'ȸ�� ��ȣ';


/**********************************/
/* Table Name: ����Ʈ */
/**********************************/
CREATE TABLE point(
		pointno                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		memberno                      		NUMBER(10)		 NULL ,
  FOREIGN KEY (memberno) REFERENCES member (memberno)
);

COMMENT ON TABLE point is '����Ʈ';
COMMENT ON COLUMN point.pointno is '����Ʈ ��ȣ';
COMMENT ON COLUMN point.memberno is 'ȸ�� ��ȣ';


/**********************************/
/* Table Name: ���� �׸� */
/**********************************/
CREATE TABLE resitem(
		reitemno                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		reservationno                 		NUMBER(10)		 NULL ,
  FOREIGN KEY (reservationno) REFERENCES reservation (reservationno)
);

COMMENT ON TABLE resitem is '���� �׸�';
COMMENT ON COLUMN resitem.reitemno is '�����׸� ��ȣ';
COMMENT ON COLUMN resitem.reservationno is '���� ��ȣ';


/**********************************/
/* Table Name: �������� ���� */
/**********************************/
CREATE TABLE surveyparti(
		surveypartino                 		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		memberno                      		NUMBER(10)		 NULL ,
  FOREIGN KEY (memberno) REFERENCES member (memberno)
);

COMMENT ON TABLE surveyparti is '�������� ����';
COMMENT ON COLUMN surveyparti.surveypartino is '�������� ������ȣ';
COMMENT ON COLUMN surveyparti.memberno is 'ȸ�� ��ȣ';


/**********************************/
/* Table Name: �������� */
/**********************************/
CREATE TABLE survey(
		surveyno                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		surveypartino                 		NUMBER(10)		 NULL ,
  FOREIGN KEY (surveypartino) REFERENCES surveyparti (surveypartino)
);

COMMENT ON TABLE survey is '��������';
COMMENT ON COLUMN survey.surveyno is '��������';
COMMENT ON COLUMN survey.surveypartino is '�������� ������ȣ';


/**********************************/
/* Table Name: �������� �׸� */
/**********************************/
CREATE TABLE surveyitem(
		surveyitemno                  		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		surveyno                      		NUMBER(10)		 NULL ,
  FOREIGN KEY (surveyno) REFERENCES survey (surveyno)
);

COMMENT ON TABLE surveyitem is '�������� �׸�';
COMMENT ON COLUMN surveyitem.surveyitemno is '�������� �׸� ��ȣ';
COMMENT ON COLUMN surveyitem.surveyno is '��������';


/**********************************/
/* Table Name: �α� */
/**********************************/
CREATE TABLE log(
		logno                         		NUMBER(10)		 NOT NULL		 PRIMARY KEY
);

COMMENT ON TABLE log is '�α�';
COMMENT ON COLUMN log.logno is '�α� ��ȣ';


/**********************************/
/* Table Name: ������ */
/**********************************/
CREATE TABLE gallery(
		galleryno                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		categoryno                    		NUMBER(10)		 NULL ,
  FOREIGN KEY (categoryno) REFERENCES name (categoryno)
);

COMMENT ON TABLE gallery is '������';
COMMENT ON COLUMN gallery.galleryno is '������ ��ȣ';
COMMENT ON COLUMN gallery.categoryno is 'ī�װ� ��ȣ';


/**********************************/
/* Table Name: �����亯 */
/**********************************/
CREATE TABLE qna(
		qnano                         		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		categoryno                    		NUMBER(10)		 NULL ,
  FOREIGN KEY (categoryno) REFERENCES name (categoryno)
);

COMMENT ON TABLE qna is '�����亯';
COMMENT ON COLUMN qna.qnano is '�����亯 ��ȣ';
COMMENT ON COLUMN qna.categoryno is 'ī�װ� ��ȣ';


