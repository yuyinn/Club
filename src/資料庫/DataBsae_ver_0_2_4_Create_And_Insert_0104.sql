---SportyGo_ver_0_2_2_create_and_insert_0103------
-----insert into venue 249data only 桃園市

---SportyGo_ver_0_2_2_create_0103------
--------------------------
------drop sequence-------
--------------------------
DROP SEQUENCE member_seq;
DROP SEQUENCE SPORT_SEQ;
DROP SEQUENCE VENUETYPE_SEQ;
DROP SEQUENCE VENUE_SEQ;
DROP SEQUENCE SG_INFO_SEQ;
DROP SEQUENCE SG_MSG_SEQ;
DROP SEQUENCE SG_REP_SEQ;
DROP SEQUENCE EVAOFMEM_SEQ;
DROP SEQUENCE club_seq;
DROP SEQUENCE club_member_LIST_seq;
DROP SEQUENCE MULTIMEDIA_SEQ;
DROP SEQUENCE post_info_seq;
DROP SEQUENCE post_like_seq;
DROP SEQUENCE respones_seq;
DROP SEQUENCE respones_like_seq;
DROP SEQUENCE ORD_SEQ;
DROP SEQUENCE PRODUCTCLASS_SEQ; 
DROP SEQUENCE PRODUCT_SEQ;
DROP SEQUENCE PROMOTION_SEQ; 
DROP SEQUENCE address_seq;
DROP SEQUENCE NEWSTYPE_SEQ; 
DROP SEQUENCE NEWS_SEQ;
DROP SEQUENCE EMP_SEQ;
DROP SEQUENCE COMPETITION_SEQ;
--------------------------------------
-----DROP TABLE-----------------------
--------------------------------------
DROP TABLE COMPETITION;
DROP TABLE EMP;
DROP TABLE NEWS;
DROP TABLE NEWSTYPE;
DROP TABLE ADDRESS;
DROP TABLE PRO_DETAIL_PROM;
DROP TABLE GYM;
DROP TABLE PROMOTION;
DROP TABLE SHOPPINGCART;
DROP TABLE PRODUCT_LIKE;
DROP TABLE ORDDETAILS;
DROP TABLE PRODUCT;
DROP TABLE PRODUCTCLASS;
DROP TABLE ORD;
DROP TABLE RESPONES_LIKE;
DROP TABLE RESPONES;
DROP TABLE POST_LIKE;
DROP TABLE POST_INFO;
DROP TABLE MULTIMEDIA;
DROP TABLE CLUB_MEMBERLIST;
----
DROP TABLE CLUB;
DROP table SG_LIKE;
DROP TABLE EVAOFMEM;
DROP table SG_REP;
DROP table SG_MEM;
DROP table SG_MSG;
DROP TABLE SG_INFO;
DROP TABLE V_EVALUATION;
DROP TABLE VENUE;
DROP TABLE REGION;
DROP TABLE VENUETYPE;
DROP table SPORT;
DROP TABLE FRIEND;
DROP TABLE MEMBERLIST;
------------01---------------------------
------------MEMBERLIST TABL-------------
---------------------------------20181208
CREATE TABLE MEMBERLIST(
    MEM_NO VARCHAR2(7),
    MEM_NAME VARCHAR2(45) NOT NULL,
    MEM_NICK VARCHAR2(45),
    MEM_ACCOUNT VARCHAR2(15) NOT NULL UNIQUE,
    MEM_PSWD VARCHAR2(12) NOT NULL,
    MEM_EMAIL VARCHAR2(60) NOT NULL,
    MEM_PHONE VARCHAR2(13) NOT NULL,
    MEM_EMGC VARCHAR2(15),
    MEM_EMGCPHONE VARCHAR2(13),
    MEM_STATUS VARCHAR2(15) DEFAULT '未驗證' NOT NULL,
    MEM_CARD NUMBER(16),
    MEM_EXPIRY VARCHAR2(7),
    MEM_PIC BLOB,
    MEM_PICKIND VARCHAR2(10),
    CONSTRAINT MEMBERLIST_PK PRIMARY KEY (MEM_NO)
);
CREATE SEQUENCE member_seq
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 999
    NOCYCLE
    NOCACHE;
------------02---------------------------
------------FRIEND-----------------------
---------------------------------20181208
CREATE TABLE FRIEND(
    MEM1_NO VARCHAR2(7),
    MEM2_NO VARCHAR2(7),
    RELATIONSHIP VARCHAR2(45),
    FRIEND_STATUS VARCHAR2(9) DEFAULT '申請中' NOT NULL,
    MEM_CHAT CLOB,
    CONSTRAINT FRIEND_PK PRIMARY KEY (MEM1_NO,MEM2_NO),
    CONSTRAINT PRIENDSHIP_FK1 FOREIGN KEY (MEM1_NO) REFERENCES MEMBERLIST (MEM_NO),
    CONSTRAINT PRIENDSHIP_FK2 FOREIGN KEY (MEM2_NO) REFERENCES MEMBERLIST (MEM_NO)
);
------------03---------------------------
------------SPORT------------------------
---------------------------------20181208
create table SPORT(
    SP_NO varchar2(7),
    SP_NAME varchar2(15) not null,
    
    constraint SPORT_PK primary key(SP_NO)
);
create sequence SPORT_SEQ
    increment by 1
    start with 1
    MAXVALUE 999
    NOCYCLE
    NOCACHE;
------------04---------------------------
------------VENUETYPE--------------------
---------------------------------20181208
CREATE TABLE VENUETYPE (
    VT_NO       VARCHAR2(7)     PRIMARY KEY, 
    VT_NAME     VARCHAR2(30)    NOT NULL
);  
CREATE SEQUENCE VENUETYPE_SEQ
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 999
    NOCYCLE
    NOCACHE;
------------05---------------------------
------------REGION-----------------------
---------------------------------20181208
CREATE TABLE REGION (
    REG_NO       NUMBER(5)      PRIMARY KEY, 
    REG_NAME     VARCHAR2(45)   NOT NULL,
	REG_DIST     VARCHAR2(45)   NOT NULL -----分開鄉鎮市區
);
------------06---------------------------
------------VENUE------------------------
---------------------------------20181224
Create table venue(
    v_no varchar2(7) PRIMARY KEY, --PK--V0000001
    v_name varchar2(500) NOT NULL,
    v_weburl varchar2(1500),
    v_parktype varchar2(500), -- 停車類型
    v_introduction   CLOB, ---場館簡介
    vt_no varchar2(7),
    v_inout varchar2(500), ---設施室內外類型
    reg_no NUMBER(5),
    v_address varchar2(500),
    v_phoneno varchar2(50),
    V_LAT       NUMBER(17,14),  ---- 修改欄位 (Number可存浮點數 17長度,小數點14位)
    V_LONG      NUMBER(17,14),  ---- 修改欄位 (Number可存浮點數 17長度,小數點14位)
    -----v_public_transport CLOB, ---交通資訊---因為部分有Array所以就這時放棄
    v_fitall varchar2(1) check( v_fitall in('Y','N')), ---適用對象-民眾
    v_fitinter varchar2(1) check (v_fitinter in('Y','N')),---適用對象-所屬單位人員(如校內師生)
    open_state varchar2(100), --開放情況
    open_time varchar2(500), --開放時間
    openday_mon varchar2(1) check (openday_mon in ('Y','N')),    
    openday_tue varchar2(1) check (openday_tue in ('Y','N')),
    openday_wed varchar2(1) check (openday_wed in ('Y','N')),
    openday_thu varchar2(1) check (openday_thu in ('Y','N')),
    openday_fri varchar2(1) check (openday_fri in ('Y','N')),
    openday_sat varchar2(1) check (openday_sat in ('Y','N')),
    openday_sun varchar2(1) check (openday_sun in ('Y','N')),
    v_photo1 BLOB,
    v_photo1_ext varchar2(10),
    v_photo2 BLOB,
    v_photo2_ext varchar2(10),        
    v_photo1_url varchar2(2000),
    v_photo2_url varchar2(2000),
	v_display varchar2(50) DEFAULT '顯示', ---else is '不顯示'
    CONSTRAINT VENUE_VENUETYPE_FK                    ----單字FK放後面
    FOREIGN KEY(VT_NO) REFERENCES VENUETYPE(VT_NO),  
    CONSTRAINT VENUE_REGION_FK                       ----單字FK放後面
    FOREIGN KEY(REG_NO) REFERENCES REGION(REG_NO)
);


CREATE SEQUENCE VENUE_SEQ
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE
    order;


------------07---------------------------
------------V_EVALUATION------------------------
---------------------------------20181208
CREATE TABLE V_EVALUATION (
    MEM_NO VARCHAR2(7),
    V_NO VARCHAR2(7), 
    SCORE NUMBER(1) ,
    CONSTRAINT V_EVALUATION_PK PRIMARY KEY(MEM_NO,V_NO),
    CONSTRAINT V_EVALUATION_MEMBER_FK FOREIGN KEY(MEM_NO) REFERENCES MEMBERLIST(MEM_NO),
    CONSTRAINT V_EVALUATION_VENUE_FK FOREIGN KEY(V_NO) REFERENCES VENUE(V_NO)
);  
------------08---------------------------
------------SG_INFO----------------------
---------------------------------20181208
CREATE TABLE SG_INFO(
    SG_NO varchar2(7),
    MEM_NO varchar2(7) not null,
    SG_NAME varchar2(50) not null,
    SG_DATE timestamp not null,
    APL_START timestamp not null,
    APL_END timestamp not null,
    SG_FEE number(6,0),
    SG_PIC blob,
    SG_PIC_EXT varchar2(10),
    SG_PER varchar2(10) not null,
    SP_NO varchar2(7) not null,
    V_NO varchar2(7),
    SG_MAXNO number(2,0),
    SG_MINNO number(2,0),
    SG_TTLAPL number(2,0),
    SG_CHKNO number(2,0),
    SG_EXTRAINFO clob,
    SG_STATUS varchar2(10) default '揪團中' not null,
    --LOC_START_LAT DECIMAL(9,6),
    --LOC_START_LNG DECIMAL(8,6),
    --LOC_END_LAT DECIMAL(9,6),
    --LOC_END_LNG DECIMAL(8,6),
	LOC_START varchar2(50),
	LOC_END varchar2(50),
    
    constraint SG_INFO_PK primary key (SG_NO),
    constraint FK1_SG_INFO_MEM foreign key (MEM_NO) references MEMBERLIST(MEM_NO),
    constraint FK2_SG_INFO_SPORT foreign key (SP_NO) references SPORT(SP_NO),
    constraint FK3_SG_INFO_VEMUE foreign key (V_NO) references VENUE(V_NO)
);
create sequence SG_INFO_SEQ
    start with 1
    increment by 1
    MAXVALUE 999
    nocycle
    nocache;
------------09---------------------------
------------SG_MSG-----------------------
---------------------------------20181208
create table SG_MSG(
    MSG_NO varchar2(7),
    SG_NO varchar2(7),
    MEM_NO varchar2(7),
    MSG_CONT clob,
    MSG_TIME timestamp,
    
    constraint SG_MSG_PK primary key(SG_NO,MEM_NO),
    constraint FK1_SG_MSG_INFO foreign key (SG_NO) references SG_INFO(SG_NO),
    constraint FK2_SG_MSG_MEM foreign key (MEM_NO) references MEMBERLIST(MEM_NO)
);
create sequence SG_MSG_SEQ
    increment by 1
    start with 1
    MAXVALUE 999
    NOCYCLE
    NOCACHE;



------------10---------------------------
------------SG_MEM----------------------
---------------------------------20181208
create table SG_MEM(
    SG_NO varchar2(7) not null,
    MEM_NO varchar2(7) not null,
    CH_STATUS varchar2(10) default '未報到' not null,
    
    constraint SG_MEM_PK primary key (SG_NO,MEM_NO),
    constraint FK1_SG_MEM_INFO foreign key (SG_NO) references SG_INFO(SG_NO),
    constraint FK2_SG_MEM_MEMLIST foreign key (MEM_NO) references MEMBERLIST(MEM_NO)
);

------------11---------------------------
------------SG_REP----------------------
---------------------------------20181208
create table SG_REP(
    REP_NO varchar2(7),
    SG_NO varchar2(7),
    MEM_NO varchar2(7),
    REP_TYPE varchar2(30) not null,
    REP_CONT clob,
    REP_STATUS varchar2(30) default '待審核' not null,
    
    constraint SG_REP_PK primary key(REP_NO),
    constraint FK1_SG_REP_INFO foreign key (SG_NO) references SG_INFO(SG_NO),
    constraint FK2_SG_REP_MEM foreign key (MEM_NO) references MEMBERLIST(MEM_NO)
);
create sequence SG_REP_SEQ
    increment by 1
    start with 1
    MAXVALUE 999
    NOCYCLE
    NOCACHE;

------------12---------------------------
------------EVAOFMEM----------------------
---------------------------------20181208
CREATE TABLE EVAOFMEM(
    SG_NO VARCHAR2(7),
    EVALUATE_NO VARCHAR2(7),
    EVALUATED_NO VARCHAR2(7),
    EVA_SCORE NUMBER(3),
    CONSTRAINT EVAOFMAM_PK PRIMARY KEY (SG_NO,EVALUATE_NO,EVALUATED_NO),
    CONSTRAINT EVAOFMEM_SGINFO_FK1 FOREIGN KEY (SG_NO) REFERENCES SG_INFO (SG_NO),
    CONSTRAINT EVAOFMAM_MEMBER_FK2 FOREIGN KEY (EVALUATE_NO) REFERENCES MEMBERLIST (MEM_NO),
    CONSTRAINT EVAOFMAM_MEMBER_FK3 FOREIGN KEY (EVALUATED_NO) REFERENCES MEMBERLIST (MEM_NO)
);
create sequence EVAOFMEM_SEQ
    increment by 1
    start with 1
    MAXVALUE 999
    NOCYCLE
    NOCACHE;

------------13---------------------------
------------SG_LIKE----------------------
---------------------------------20181208
create table SG_LIKE(
    SG_NO varchar2(7),
    MEM_NO varchar2(7),
    
    constraint SG_LIKE_PK primary key(SG_NO,MEM_NO),
    constraint SG_LIKE_FK1 foreign key (SG_NO) references SG_INFO(SG_NO),
    constraint SG_LIKE_FK2 foreign key (MEM_NO) references MEMBERLIST(MEM_NO)
);

------------14---------------------------
------------CLUB-------------------------
---------------------------------20181208
CREATE TABLE CLUB (
  CLUB_NO       VARCHAR2(7), 
  SP_NO         VARCHAR2(7)  NOT NULL, 
  PHOTO         BLOB,
  PHOTO_EXT     VARCHAR2(10),
  CLUB_STATUS   VARCHAR2(10) DEFAULT '正常' NOT NULL,
  CLUB_NAME     VARCHAR2(20) NOT NULL,
  CLUB_INTRO    CLOB,
  
  CONSTRAINT CLUB_PK PRIMARY KEY (CLUB_NO),
  CONSTRAINT CLUB_FK FOREIGN KEY (SP_NO) REFERENCES SPORT (SP_NO)
);
CREATE SEQUENCE club_seq
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 9999
    NOCYCLE
    NOCACHE;

------------15---------------------------
------------CLUB_MEMBERLIST------------------
---------------------------------20181208
CREATE TABLE CLUB_MEMBERLIST (
    CLUB_NO       VARCHAR2(7)  NOT NULL, 
    MEM_NO        VARCHAR2(7)  NOT NULL, 
    CMEM_STATUS   VARCHAR2(20) DEFAULT '待審核' NOT NULL,
    CMEM_CLASS    VARCHAR2(15) DEFAULT '一般成員' NOT NULL,
    SILENCE_TIME  TIMESTAMP,

    CONSTRAINT CLUB_MEMBER_LIST_PK PRIMARY KEY(CLUB_NO,MEM_NO),
    CONSTRAINT CLUB_MEMBER_LIST_FK1 FOREIGN KEY (CLUB_NO) REFERENCES CLUB (CLUB_NO),
    CONSTRAINT CLUB_MEMBER_LIST_FK2 FOREIGN KEY (MEM_NO) REFERENCES MEMBERLIST (MEM_NO)
);
---why need it, club_member_list_seq ?
CREATE SEQUENCE club_member_list_seq
   INCREMENT BY 1
   START WITH 1
   MAXVALUE 999
   NOCYCLE
   NOCACHE;

------------16---------------------------
------------MULTIMEDIA--------------------
---------------------------------20181208
CREATE TABLE MULTIMEDIA(
    MEDIA_NO VARCHAR2(7) PRIMARY KEY,
    FILE_EXTENSION VARCHAR2(10),
    MEDIA_CONTENT BLOB,
    CLUB_NO VARCHAR2(7),
    MEM_NO VARCHAR2(7),
    MEDIA_RELEASEDATE TIMESTAMP NOT NULL,
    MEDIA_TITLE VARCHAR2(30)
);
CREATE SEQUENCE MULTIMEDIA_SEQ
   INCREMENT BY 1
   START WITH 1
   MAXVALUE 99999
   NOCYCLE
   NOCACHE;

------------17---------------------------
------------POST_INFO------------------
---------------------------------20181208
CREATE TABLE POST_INFO (
    POST_NO       VARCHAR2(7)  NOT NULL, 
    CLUB_NO       VARCHAR2(7)  NOT NULL, 
    MEM_NO        VARCHAR2(7)  NOT NULL,
    POST_TOPIC    VARCHAR2(60),
    POST_CONTENT  CLOB  NOT NULL,
    POST_DATE		TIMESTAMP  NOT NULL,
  
    CONSTRAINT POST_INFO_PK PRIMARY KEY (POST_NO),
    CONSTRAINT POST_INFO_FK1 FOREIGN KEY (CLUB_NO) REFERENCES CLUB (CLUB_NO),
    CONSTRAINT POST_INFO_FK2 FOREIGN KEY (MEM_NO) REFERENCES MEMBERLIST (MEM_NO)
);
CREATE SEQUENCE post_info_seq
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 9999
    NOCYCLE
    NOCACHE;

------------18---------------------------
------------POST_LIKE-------------------------
---------------------------------20181208
CREATE TABLE POST_LIKE (
    POST_NO       VARCHAR2(7), 
    MEM_NO        VARCHAR2(7),
    LIKE_TYPE     VARCHAR2(10) default '讚',

    CONSTRAINT POST_LIKE_PK PRIMARY KEY(POST_NO,MEM_NO),
    CONSTRAINT POST_LIKE_FK1 FOREIGN KEY (POST_NO) REFERENCES POST_INFO(POST_NO),
    CONSTRAINT POST_LIKE_FK2 FOREIGN KEY (MEM_NO) REFERENCES MEMBERLIST (MEM_NO)
);
-----THIS SEQUENCE DON'T NEEDED
CREATE SEQUENCE post_like_seq
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 999
    NOCYCLE
    NOCACHE;

------------19---------------------------
------------RESPONES---------------------
---------------------------------20181208
CREATE TABLE RESPONES (
    RES_NO        VARCHAR2(7), 
    POST_NO       VARCHAR2(7) NOT NULL, 
    MEM_NO        VARCHAR2(7) NOT NULL,
    RES_CONTENT   CLOB  NOT NULL,
    RES_DATE	  TIMESTAMP  NOT NULL,
  
    CONSTRAINT RESPONES_PK  PRIMARY KEY (RES_NO),
    CONSTRAINT RESPONES_FK1 FOREIGN KEY (POST_NO) REFERENCES POST_INFO (POST_NO),
    CONSTRAINT RESPONES_FK2 FOREIGN KEY (MEM_NO) REFERENCES MEMBERLIST (MEM_NO)
);    
CREATE SEQUENCE respones_seq
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 9999
    NOCYCLE
    NOCACHE;


------------20---------------------------
------------RESPONES_LIKE----------------
---------------------------------20181209
CREATE TABLE RESPONES_LIKE (
    RES_NO        VARCHAR2(7), 
    MEM_NO        VARCHAR2(7),
    LIKE_TYPE     VARCHAR2(10) DEFAULT '讚',
    CONSTRAINT RESPONES_LIKE_PK PRIMARY KEY (RES_NO,MEM_NO),
    CONSTRAINT FK1_RESPONES_LIKE_RES FOREIGN KEY (RES_NO) REFERENCES RESPONES (RES_NO),
    CONSTRAINT FK2_RESPONES_LIKE_MEM FOREIGN KEY (MEM_NO) REFERENCES MEMBERLIST (MEM_NO)
);  
---THIS SEQUENCE DON'T NEEDED
CREATE SEQUENCE respones_like_seq
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 999
    NOCYCLE
    NOCACHE
    ORDER;

------------21---------------------------
------------ORD--------------------------
---------------------------------20181209
CREATE TABLE ORD (
    ORD_NO	        	VARCHAR2(20),
    MEM_NO	        	VARCHAR2(7)     NOT NULL,   
    ORD_DATE	        TIMESTAMP       NOT NULL,	
    ORD_DELDATE	        TIMESTAMP,	
    ORD_STATUS	        VARCHAR2(10)    NOT NULL,
    ORD_BACKDELDATE	    TIMESTAMP,	
    ORD_AMOUNT	        NUMBER(7)       NOT NULL,
    ORD_BACKAMOUNT	    NUMBER(7),
    CONSTRAINT fk1_ord_memberlist FOREIGN KEY (MEM_NO) REFERENCES MEMBERLIST(MEM_NO),
    CONSTRAINT ORD_PK PRIMARY KEY (ORD_NO)
);
CREATE SEQUENCE ORD_SEQ 
    INCREMENT BY 1 
    START WITH 1
    NOMAXVALUE 
    NOCYCLE
    NOCACHE
    ORDER;

------------22---------------------------
------------PRODUCTCLASS-----------------
---------------------------------20181209
CREATE TABLE PRODUCTCLASS(
    PRO_CLASSID		    VARCHAR2(7),
    PRO_CLASSNAME		VARCHAR2(100) NOT NULL,
    CONSTRAINT PRODUCTCLASS_PK PRIMARY KEY (PRO_CLASSID)
);
CREATE SEQUENCE PRODUCTCLASS_SEQ 
    INCREMENT BY 1 
    START WITH 1
    MAXVALUE 999
    NOCYCLE
    NOCACHE
    ORDER;

------------23---------------------------
------------PRODUCT----------------------
---------------------------------20181209
CREATE TABLE PRODUCT(
    PRO_NO		            VARCHAR2(7),
    PRO_CLASSID		        VARCHAR2(7)     NOT NULL,
    PRO_NAME		        VARCHAR2(100)   NOT NULL,
    PRO_PIC		            BLOB,
    PRO_PIC_EXT	        	VARCHAR2(10),
    PRO_FORMAT		        VARCHAR2(100)   NOT NULL,
    PRO_BONUS		        NUMBER(7)       NOT NULL,
    PRO_STOCK		        NUMBER(7)       NOT NULL,
    PRO_SAFESTOCK	        NUMBER(7)       NOT NULL,
    PRO_DETAILS		        VARCHAR2(1500),
    PRO_SHELVE		        VARCHAR2(10)    NOT NULL,
    PRO_ALL_ASSESS		    NUMBER(7),
    PRO_ALL_ASSESSMAN		NUMBER(7),
    CONSTRAINT FK1_PRODUCT_PRODUCTCLASS FOREIGN KEY (PRO_CLASSID) REFERENCES PRODUCTCLASS (PRO_CLASSID),
    CONSTRAINT PRODUCT_PK PRIMARY KEY (PRO_NO)
);

CREATE SEQUENCE PRODUCT_SEQ 
    INCREMENT BY 1 
    START WITH 1
    MAXVALUE 999
    NOCYCLE
    NOCACHE
    ORDER;
------------24---------------------------
------------ORDDETAILS-------------------
---------------------------------20181209
CREATE TABLE ORDDETAILS(
    ORD_NO		        VARCHAR2(20) NOT NULL,
    PRO_NO		        VARCHAR2(7) NOT NULL,
    ORD_PROBONUNS		NUMBER(7) NOT NULL,
    PRO_COUNT		    NUMBER(7) NOT NULL,
    CONSTRAINT FK1_ORDDETAILS_ORD FOREIGN KEY (ORD_NO) REFERENCES ORD (ORD_NO),
    CONSTRAINT FK2_ORDDETAILS_PRO FOREIGN KEY (PRO_NO) REFERENCES PRODUCT (PRO_NO),
    CONSTRAINT ORDDETAILS_PK PRIMARY KEY (ORD_NO , PRO_NO)
);

------------25---------------------------
------------PRODUCTLIKE------------------
---------------------------------20181209
CREATE TABLE PRODUCT_LIKE(
    PRODUCT_NO  VARCHAR2(7),
    MEM_NO      VARCHAR2(7),
    CONSTRAINT PRODUCT_LIKE_PK PRIMARY KEY (PRODUCT_NO,MEM_NO),
    CONSTRAINT PRODUCT_LIKE_MEMBER_FK1 FOREIGN KEY (PRODUCT_NO) REFERENCES PRODUCT (PRO_NO),
    CONSTRAINT PRODUCT_LIKE_MEMBER_FK2 FOREIGN KEY (MEM_NO) REFERENCES MEMBERLIST (MEM_NO)
);
------------26---------------------------
------------SHOPPINGCART---Redis---------
---------------------------------20181209
CREATE TABLE SHOPPINGCART(
    MEM_NO		    VARCHAR2(7)     NOT NULL,
    PRO_NO		    VARCHAR2(7)     NOT NULL,
    PRO_COUNT		NUMBER(7)       NOT NULL,
    CONSTRAINT FK1_SHOPPINGCART_MEMBERLIST FOREIGN KEY (MEM_NO) REFERENCES MEMBERLIST(MEM_NO),
    CONSTRAINT SHOPPINGCART_PK PRIMARY KEY (MEM_NO , PRO_NO)
);



------------27---------------------------
------------PROMOTION--------------------
---------------------------------20181209
CREATE TABLE PROMOTION(
    PROM_PROJECT_ID		    VARCHAR2(7),
    PROM_PROJECT_NAME		VARCHAR2(100)   NOT NULL,
    PROM_PROJECT_SDATE		TIMESTAMP       NOT NULL,	
    PROM_PROJECT_EDATE		TIMESTAMP       NOT NULL,	
    CONSTRAINT PROMOTION_PK PRIMARY KEY (PROM_PROJECT_ID)
);

CREATE SEQUENCE PROMOTION_SEQ 
    INCREMENT BY 1 
    START WITH 1
    MAXVALUE 999
    NOCYCLE
    NOCACHE
    ORDER;
------------28---------------------------
------------PRO_DETAIL_PROMO--------------
---------------------------------20181209
CREATE TABLE PRO_DETAIL_PROM(
    PROM_PROJECT_ID		VARCHAR2(7) NOT NULL,
    PRO_NO		        VARCHAR2(7) NOT NULL,
    PRO_SALE		    NUMBER(7)   NOT NULL,
    CONSTRAINT PRODUCT_DETAILPROMOTION_PK 
    PRIMARY KEY (PROM_PROJECT_ID , PRO_NO),
    CONSTRAINT FK1_PRO_DELTAIL_PROM_PROBUCT FOREIGN KEY (PRO_NO) REFERENCES PRODUCT(PRO_NO),
    CONSTRAINT FK2_PRO_DETAIL_PROM_PROMOTION FOREIGN KEY (PROM_PROJECT_ID) REFERENCES PROMOTION(PROM_PROJECT_ID)
);

------------29---------------------------
------------ADDRESS----------------------
---------------------------------20181209
CREATE TABLE ADDRESS(
    ADDR_NO         VARCHAR2(7),
    MEM_NO          VARCHAR2(7),
    RECEIVER         VARCHAR2(15)    NOT NULL,
    RECEIVER_PHONE   VARCHAR2(13)    NOT NULL,
    COUNTRY         VARCHAR2(45)    NOT NULL,
    CITY            VARCHAR2(45)    NOT NULL,
    ADDR_DETAIL     VARCHAR2(60)    NOT NULL,
    ADDR_ZIP        NUMBER(5)       NOT NULL,
    CONSTRAINT ADDRESS_PK PRIMARY KEY (ADDR_NO),
    CONSTRAINT ADDRESS_MEMBER_FK FOREIGN KEY (MEM_NO) REFERENCES MEMBERLIST(MEM_NO)    
);
CREATE SEQUENCE address_seq
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 999
    NOCYCLE
    NOCACHE
    ORDER;
------------30---------------------------
------------NEWSTYPE---------------------
---------------------------------20181209
CREATE TABLE NEWSTYPE
    (NEWSTYPE_NO    VARCHAR2(7)     PRIMARY KEY,
    NEWSTYPE_NAME   VARCHAR2(30)    NOT NULL
);
CREATE SEQUENCE NEWSTYPE_SEQ 
    INCREMENT BY 1 
    START WITH 1
    MAXVALUE 999
    NOCACHE
    NOCYCLE
    ORDER;
------------31---------------------------
------------NEWS-------------------------
---------------------------------20181209
CREATE TABLE NEWS
    (NEWS_NO        VARCHAR2(7)     PRIMARY KEY,
    NEWS_TYPENO     VARCHAR2(7),
    NEWS_SCRIPT     CLOB,
    PIC_EXTENSION   VARCHAR2(30),
    NEWS_PICTURE    BLOB,
    NEWS_STUTAS     VARCHAR2(12)    DEFAULT '未發布',
    NEWS_RELEASE_DATE TIMESTAMP,
    NEWS_LAST_DATE  TIMESTAMP,
    FOREIGN KEY (NEWS_TYPENO) REFERENCES NEWSTYPE(NEWSTYPE_NO)
);
CREATE SEQUENCE NEWS_SEQ 
    INCREMENT BY 1 
    START WITH 1
    MAXVALUE 999
    NOCACHE
    NOCYCLE
    ORDER;
------------32---------------------------
------------EMP--------------------------
---------------------------------20181209
CREATE TABLE EMP 
    (EMP_NO VARCHAR2(7) PRIMARY KEY, 
    EMP_NAME VARCHAR2(255) NOT NULL, 
    EMP_AUTH VARCHAR2(255) DEFAULT '一般管理員', 
    EMP_PHONE VARCHAR2(13), 
    EMP_EMAIL VARCHAR2(255) NOT NULL UNIQUE, 
    EMP_ACCOUNT VARCHAR2(50) NOT NULL UNIQUE, 
    EMP_PSW VARCHAR2(20), 
    HIREDATE DATE, 
    LEAVEDATE DATE
);
CREATE SEQUENCE EMP_SEQ 
    INCREMENT BY 1 
    START WITH 1
    MAXVALUE 999
    NOCACHE
    NOCYCLE
    ORDER;

------------33---------------------------
------------COMPETITION------------------
---------------------------------20181209
CREATE TABLE COMPETITION
    (COMP_NO        VARCHAR2(7)     PRIMARY KEY,
    COMP_NAME       VARCHAR2(255)   NOT NULL,
    COMP_STARTDATE  TIMESTAMP       NOT NULL,
    COMP_ENDDATE    TIMESTAMP       NOT NULL,
    COMP_CONT       CLOB            NOT NULL
);
CREATE SEQUENCE COMPETITION_SEQ 
    INCREMENT BY 1 
    START WITH 1
    MAXVALUE 999
    NOCACHE
    NOCYCLE
    ORDER;
------------33---------------------------
------------GYM--------------------------
---------------------------------20181224
---------------------為了抓場地的ID值使用
Create table gym(
	gym_id varchar2(500) primary key,
	gym_name varchar2(500),
	gym_funclist varchar2(1500)
);
-------



COMMIT;


-------------------
---SportyGo_ver_0_2_0rv_insert_1227-------
------------01-INSERT--------------------
------------MEMBERLIST-------------------
---------------------------------20181210
INSERT INTO MEMBERLIST(MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE,MEM_STATUS)
VALUES('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),'大衛海鮮','a001','123456','s9821100@gm.pu.edu.tw','0937351931','正式會員');

INSERT INTO MEMBERLIST(MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE,MEM_STATUS)
VALUES('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),'Peter1','a002','123456','s9821100@gm.pu.edu.tw','0937351931','正式會員');

INSERT INTO MEMBERLIST(MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE,MEM_STATUS)
VALUES('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),'大崛彩','a003','123456','s9821100@gm.pu.edu.tw','0937351931','正式會員');

INSERT INTO MEMBERLIST(MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE,MEM_STATUS)
VALUES('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),'松井稼頭央','a004','123456','s9821100@gm.pu.edu.tw','0937351931','正式會員');

INSERT INTO MEMBERLIST(MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE,MEM_STATUS)
VALUES('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),'櫻木花道','a005','123456','s9821100@gm.pu.edu.tw','0937351931','正式會員');

INSERT INTO MEMBERLIST(MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE,MEM_STATUS)
VALUES('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),'流川楓','a006','123456','s9821100@gm.pu.edu.tw','0937351931','正式會員');

INSERT INTO MEMBERLIST(MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE,MEM_STATUS)
VALUES('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),'茂野吾郎','a007','123456','s9821100@gm.pu.edu.tw','0937351931','正式會員');

INSERT INTO MEMBERLIST(MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE,MEM_STATUS)
VALUES('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),'運動明星','a008','123456','s9821100@gm.pu.edu.tw','0937351931','正式會員');

INSERT INTO MEMBERLIST(MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE,MEM_STATUS)
VALUES('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),'酷斃','a009','123456','s9821100@gm.pu.edu.tw','0937351931','正式會員');

INSERT INTO MEMBERLIST(MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE,MEM_STATUS)
VALUES('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),'ROLE1','a010','123456','s9821100@gm.pu.edu.tw','0937351931','正式會員');

INSERT INTO MEMBERLIST(MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE,MEM_STATUS)
VALUES('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),'手臂強','a011','123456','s9821100@gm.pu.edu.tw','0937351931','正式會員');

INSERT INTO MEMBERLIST(MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE,MEM_STATUS)
VALUES('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),'漢米爾頓','a012','123456','s9821100@gm.pu.edu.tw','0937351931','正式會員');

INSERT INTO MEMBERLIST(MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE,MEM_STATUS)
VALUES('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),'野原家','a013','123456','s9821100@gm.pu.edu.tw','0937351931','正式會員');

INSERT INTO MEMBERLIST(MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE,MEM_STATUS)
VALUES('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),'勘吉','a014','123456','s9821100@gm.pu.edu.tw','0937351931','正式會員');

INSERT INTO MEMBERLIST(MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE,MEM_STATUS)
VALUES('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),'恰吉','a015','123456','s9821100@gm.pu.edu.tw','0937351931','正式會員');

INSERT INTO MEMBERLIST(MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE,MEM_STATUS)
VALUES('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),'安西教練','a016','123456','s9821100@gm.pu.edu.tw','0937351931','正式會員');

INSERT INTO MEMBERLIST(MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE,MEM_STATUS)
VALUES('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),'三井','a017','123456','s9821100@gm.pu.edu.tw','0937351931','正式會員');

INSERT INTO MEMBERLIST(MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE,MEM_STATUS)
VALUES('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),'戴資穎','a018','123456','s9821100@gm.pu.edu.tw','0937351931','正式會員');

INSERT INTO MEMBERLIST(MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE,MEM_STATUS)
VALUES('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),'周天成','a019','123456','s9821100@gm.pu.edu.tw','0937351931','正式會員');

INSERT INTO MEMBERLIST(MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE,MEM_STATUS)
VALUES('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),'李宗偉','a020','123456','s9821100@gm.pu.edu.tw','0937351931','正式會員');

INSERT INTO MEMBERLIST(MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE,MEM_STATUS)
VALUES('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),'OHTANI','a021','123456','s9821100@gm.pu.edu.tw','0937351931','正式會員');

INSERT INTO MEMBERLIST(MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE,MEM_STATUS)
VALUES('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),'厄文','a022','123456','s9821100@gm.pu.edu.tw','0937351931','正式會員');

INSERT INTO MEMBERLIST(MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE,MEM_STATUS)
VALUES('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),'大猩猩','a023','123456','s9821100@gm.pu.edu.tw','0937351931','正式會員');

INSERT INTO MEMBERLIST(MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE,MEM_STATUS)
VALUES('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),'晴子','a024','123456','s9821100@gm.pu.edu.tw','0937351931','正式會員');

INSERT INTO MEMBERLIST(MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE,MEM_STATUS)
VALUES('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),'杜蘭朵','a025','123456','s9821100@gm.pu.edu.tw','0937351931','正式會員');

INSERT INTO MEMBERLIST(MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE,MEM_STATUS)
VALUES('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),'咖哩','a026','123456','s9821100@gm.pu.edu.tw','0937351931','正式會員');

INSERT INTO MEMBERLIST(MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE,MEM_STATUS)
VALUES('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),'勒布朗','a027','123456','s9821100@gm.pu.edu.tw','0937351931','正式會員');

INSERT INTO MEMBERLIST(MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE,MEM_STATUS)
VALUES('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),'AARON','a028','123456','s9821100@gm.pu.edu.tw','0937351931','正式會員');


commit;


------------02-INSERT--------------------
------------FRIEND-----------------------
---------------------------------20181210
INSERT INTO FRIEND (MEM1_NO,MEM2_NO,FRIEND_STATUS) VALUES ('M001','M002','好友');
INSERT INTO FRIEND (MEM1_NO,MEM2_NO,FRIEND_STATUS) VALUES ('M001','M003','好友');
INSERT INTO FRIEND (MEM1_NO,MEM2_NO,FRIEND_STATUS) VALUES ('M001','M004','好友');
INSERT INTO FRIEND (MEM1_NO,MEM2_NO,FRIEND_STATUS) VALUES ('M001','M005','好友');
INSERT INTO FRIEND (MEM1_NO,MEM2_NO,FRIEND_STATUS) VALUES ('M002','M003','好友');
INSERT INTO FRIEND (MEM1_NO,MEM2_NO,FRIEND_STATUS) VALUES ('M002','M004','好友');
INSERT INTO FRIEND (MEM1_NO,MEM2_NO,FRIEND_STATUS) VALUES ('M002','M006','好友');
INSERT INTO FRIEND (MEM1_NO,MEM2_NO,FRIEND_STATUS) VALUES ('M003','M004','好友');
INSERT INTO FRIEND (MEM1_NO,MEM2_NO,FRIEND_STATUS) VALUES ('M004','M006','好友');
INSERT INTO FRIEND (MEM1_NO,MEM2_NO,FRIEND_STATUS) VALUES ('M010','M001','好友');
INSERT INTO FRIEND (MEM1_NO,MEM2_NO) VALUES ('M015','M001');
INSERT INTO FRIEND (MEM1_NO,MEM2_NO) VALUES ('M016','M001');
INSERT INTO FRIEND (MEM1_NO,MEM2_NO) VALUES ('M017','M001');
INSERT INTO FRIEND (MEM1_NO,MEM2_NO) VALUES ('M001','M007');
INSERT INTO FRIEND (MEM1_NO,MEM2_NO) VALUES ('M001','M008');
INSERT INTO FRIEND (MEM1_NO,MEM2_NO) VALUES ('M001','M009');

------------03-INSERT--------------------
------------SPORT------------------------
---------------------------------20181210insert into SPORT values('SP' || LPAD(SPORT_SEQ.nextval, 3, 0), '棒球');
insert into SPORT values('SP' || LPAD(SPORT_SEQ.nextval, 3, 0), '棒球');
insert into SPORT values('SP' || LPAD(SPORT_SEQ.nextval, 3, 0), '排球');
insert into SPORT values('SP' || LPAD(SPORT_SEQ.nextval, 3, 0), '籃球');
insert into SPORT values('SP' || LPAD(SPORT_SEQ.nextval, 3, 0), '網球');
insert into SPORT values('SP' || LPAD(SPORT_SEQ.nextval, 3, 0), '羽球');
insert into SPORT values('SP' || LPAD(SPORT_SEQ.nextval, 3, 0), '慢跑');
insert into SPORT values('SP' || LPAD(SPORT_SEQ.nextval, 3, 0), '自行車');



------------04-INSERT--------------------
------------VENUETYPE--------------------
---------------------------------20181210
Insert into VENUETYPE (VT_NO, VT_NAME) values ('VT'||LPAD(to_char(VENUETYPE_SEQ.NEXTVAL), 3, '0'), '籃球場');
Insert into VENUETYPE (VT_NO, VT_NAME) values ('VT'||LPAD(to_char(VENUETYPE_SEQ.NEXTVAL), 3, '0'), '排球場');
Insert into VENUETYPE (VT_NO, VT_NAME) values ('VT'||LPAD(to_char(VENUETYPE_SEQ.NEXTVAL), 3, '0'), '網球場');
Insert into VENUETYPE (VT_NO, VT_NAME) values ('VT'||LPAD(to_char(VENUETYPE_SEQ.NEXTVAL), 3, '0'), '棒球場');
Insert into VENUETYPE (VT_NO, VT_NAME) values ('VT'||LPAD(to_char(VENUETYPE_SEQ.NEXTVAL), 3, '0'), '羽球場');


------------05-INSERT--------------------
------------REGION-----------------------
---------------------------------20181210
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (100,'台北市','中正區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (103,'台北市','大同區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (104,'台北市','中山區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (105,'台北市','松山區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (106,'台北市','大安區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (108,'台北市','萬華區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (110,'台北市','信義區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (111,'台北市','士林區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (112,'台北市','北投區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (114,'台北市','內湖區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (115,'台北市','南港區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (116,'台北市','文山區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (200,'基隆市','仁愛區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (201,'基隆市','信義區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (202,'基隆市','中正區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (203,'基隆市','中山區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (204,'基隆市','安樂區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (205,'基隆市','暖暖區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (206,'基隆市','七堵區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (207,'新北市','萬里區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (208,'新北市','金山區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (209,'連江縣','南竿鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (210,'連江縣','北竿鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (211,'連江縣','莒光鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (212,'連江縣','東引鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (220,'新北市','板橋區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (221,'新北市','汐止區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (222,'新北市','深坑區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (223,'新北市','石碇區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (224,'新北市','瑞芳區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (226,'新北市','平溪區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (227,'新北市','雙溪區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (228,'新北市','貢寮區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (231,'新北市','新店區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (232,'新北市','坪林區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (233,'新北市','烏來區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (234,'新北市','永和區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (235,'新北市','中和區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (236,'新北市','土城區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (237,'新北市','三峽區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (238,'新北市','樹林區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (239,'新北市','鶯歌區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (241,'新北市','三重區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (242,'新北市','新莊區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (243,'新北市','泰山區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (244,'新北市','林口區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (247,'新北市','蘆洲區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (248,'新北市','五股區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (249,'新北市','八里區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (251,'新北市','淡水區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (252,'新北市','三芝區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (253,'新北市','石門區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (260,'宜蘭縣','宜蘭市');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (261,'宜蘭縣','頭城鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (262,'宜蘭縣','礁溪鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (263,'宜蘭縣','壯圍鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (264,'宜蘭縣','員山鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (265,'宜蘭縣','羅東鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (266,'宜蘭縣','三星鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (267,'宜蘭縣','大同鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (268,'宜蘭縣','五結鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (269,'宜蘭縣','冬山鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (270,'宜蘭縣','蘇澳鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (272,'宜蘭縣','南澳鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (290,'宜蘭縣','釣魚台列嶼');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (300,'新竹市','東區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (3001,'新竹市','北區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (3002,'新竹市','香山區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (302,'新竹縣','竹北市');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (303,'新竹縣','湖口鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (304,'新竹縣','新豐鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (305,'新竹縣','新埔鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (306,'新竹縣','關西鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (307,'新竹縣','芎林鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (308,'新竹縣','寶山鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (310,'新竹縣','竹東鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (311,'新竹縣','五峰鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (312,'新竹縣','橫山鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (313,'新竹縣','尖石鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (314,'新竹縣','北埔鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (315,'新竹縣','峨嵋鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (320,'桃園市','中壢區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (324,'桃園市','平鎮區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (325,'桃園市','龍潭區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (326,'桃園市','楊梅區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (327,'桃園市','新屋區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (328,'桃園市','觀音區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (330,'桃園市','桃園區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (333,'桃園市','龜山區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (334,'桃園市','八德區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (335,'桃園市','大溪區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (336,'桃園市','復興區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (337,'桃園市','大園區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (338,'桃園市','蘆竹區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (350,'苗栗縣','竹南鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (351,'苗栗縣','頭份鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (352,'苗栗縣','三灣鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (353,'苗栗縣','南庄鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (354,'苗栗縣','獅潭鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (356,'苗栗縣','後龍鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (357,'苗栗縣','通霄鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (358,'苗栗縣','苑裡鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (360,'苗栗縣','苗栗市');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (361,'苗栗縣','造橋鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (362,'苗栗縣','頭屋鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (363,'苗栗縣','公館鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (364,'苗栗縣','大湖鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (365,'苗栗縣','泰安鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (366,'苗栗縣','銅鑼鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (367,'苗栗縣','三義鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (368,'苗栗縣','西湖鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (369,'苗栗縣','卓蘭鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (400,'台中市','中區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (401,'台中市','東區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (402,'台中市','南區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (403,'台中市','西區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (404,'台中市','北區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (406,'台中市','北屯區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (407,'台中市','西屯區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (408,'台中市','南屯區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (411,'台中市','太平區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (412,'台中市','大里區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (413,'台中市','霧峰區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (414,'台中市','烏日區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (420,'台中市','豐原區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (421,'台中市','后里區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (422,'台中市','石岡區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (423,'台中市','東勢區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (424,'台中市','和平區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (426,'台中市','新社區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (427,'台中市','潭子區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (428,'台中市','大雅區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (429,'台中市','神岡區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (432,'台中市','大肚區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (433,'台中市','沙鹿區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (434,'台中市','龍井區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (435,'台中市','梧棲區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (436,'台中市','清水區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (437,'台中市','大甲區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (438,'台中市','外埔區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (439,'台中市','大安區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (500,'彰化縣','彰化市');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (502,'彰化縣','芬園鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (503,'彰化縣','花壇鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (504,'彰化縣','秀水鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (505,'彰化縣','鹿港鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (506,'彰化縣','福興鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (507,'彰化縣','線西鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (508,'彰化縣','和美鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (509,'彰化縣','伸港鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (510,'彰化縣','員林鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (511,'彰化縣','社頭鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (512,'彰化縣','永靖鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (513,'彰化縣','埔心鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (514,'彰化縣','溪湖鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (515,'彰化縣','大村鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (516,'彰化縣','埔鹽鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (520,'彰化縣','田中鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (521,'彰化縣','北斗鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (522,'彰化縣','田尾鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (523,'彰化縣','埤頭鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (524,'彰化縣','溪州鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (525,'彰化縣','竹塘鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (526,'彰化縣','二林鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (527,'彰化縣','大城鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (528,'彰化縣','芳苑鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (530,'彰化縣','二水鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (540,'南投縣','南投市');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (541,'南投縣','中寮鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (542,'南投縣','草屯鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (544,'南投縣','國姓鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (545,'南投縣','埔里鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (546,'南投縣','仁愛鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (551,'南投縣','名間鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (552,'南投縣','集集鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (553,'南投縣','水里鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (555,'南投縣','魚池鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (556,'南投縣','信義鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (557,'南投縣','竹山鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (558,'南投縣','鹿谷鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (6001,'嘉義市','東區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (6002,'嘉義市','西區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (602,'嘉義縣','番路鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (603,'嘉義縣','梅山鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (604,'嘉義縣','竹崎鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (605,'嘉義縣','阿里山');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (606,'嘉義縣','中埔鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (607,'嘉義縣','大埔鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (608,'嘉義縣','水上鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (611,'嘉義縣','鹿草鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (612,'嘉義縣','太保市');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (613,'嘉義縣','朴子市');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (614,'嘉義縣','東石鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (615,'嘉義縣','六腳鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (616,'嘉義縣','新港鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (621,'嘉義縣','民雄鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (622,'嘉義縣','大林鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (623,'嘉義縣','溪口鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (624,'嘉義縣','義竹鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (625,'嘉義縣','布袋鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (630,'雲林縣','斗南鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (631,'雲林縣','大埤鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (632,'雲林縣','虎尾鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (633,'雲林縣','土庫鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (634,'雲林縣','褒忠鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (635,'雲林縣','東勢鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (636,'雲林縣','臺西鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (637,'雲林縣','崙背鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (638,'雲林縣','麥寮鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (640,'雲林縣','斗六市');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (643,'雲林縣','林內鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (646,'雲林縣','古坑鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (647,'雲林縣','莿桐鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (648,'雲林縣','西螺鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (649,'雲林縣','二崙鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (651,'雲林縣','北港鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (652,'雲林縣','水林鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (653,'雲林縣','口湖鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (654,'雲林縣','四湖鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (655,'雲林縣','元長鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (700,'台南市','中西區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (701,'台南市','東區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (702,'台南市','南區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (704,'台南市','北區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (708,'台南市','安平區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (709,'台南市','安南區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (710,'台南市','永康區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (711,'台南市','歸仁區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (712,'台南市','新化區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (713,'台南市','左鎮區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (714,'台南市','玉井區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (715,'台南市','楠西區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (716,'台南市','南化區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (717,'台南市','仁德區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (718,'台南市','關廟區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (719,'台南市','龍崎區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (720,'台南市','官田區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (721,'台南市','麻豆區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (722,'台南市','佳里區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (723,'台南市','西港區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (724,'台南市','七股區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (725,'台南市','將軍區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (726,'台南市','學甲區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (727,'台南市','北門區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (730,'台南市','新營區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (731,'台南市','後壁區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (732,'台南市','白河區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (733,'台南市','東山區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (734,'台南市','六甲區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (735,'台南市','下營區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (736,'台南市','柳營區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (737,'台南市','鹽水區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (741,'台南市','善化區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (742,'台南市','大內區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (743,'台南市','山上區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (744,'台南市','新市區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (745,'台南市','安定區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (800,'高雄市','新興區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (801,'高雄市','前金區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (802,'高雄市','苓雅區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (803,'高雄市','鹽埕區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (804,'高雄市','鼓山區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (805,'高雄市','旗津區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (806,'高雄市','前鎮區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (807,'高雄市','三民區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (811,'高雄市','楠梓區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (812,'高雄市','小港區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (813,'高雄市','左營區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (814,'高雄市','仁武區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (815,'高雄市','大社區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (820,'高雄市','岡山區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (821,'高雄市','路竹區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (822,'高雄市','阿蓮區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (823,'高雄市','田寮鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (824,'高雄市','燕巢區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (825,'高雄市','橋頭區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (826,'高雄市','梓官區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (827,'高雄市','彌陀區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (828,'高雄市','永安區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (829,'高雄市','湖內鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (830,'高雄市','鳳山區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (831,'高雄市','大寮區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (832,'高雄市','林園區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (833,'高雄市','鳥松區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (840,'高雄市','大樹區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (842,'高雄市','旗山區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (843,'高雄市','美濃區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (844,'高雄市','六龜區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (845,'高雄市','內門區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (846,'高雄市','杉林區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (847,'高雄市','甲仙區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (848,'高雄市','桃源區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (849,'高雄市','那瑪夏區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (851,'高雄市','茂林區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (852,'高雄市','茄萣區');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (880,'澎湖縣','馬公市');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (881,'澎湖縣','西嶼鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (882,'澎湖縣','望安鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (883,'澎湖縣','七美鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (884,'澎湖縣','白沙鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (885,'澎湖縣','湖西鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (890,'金門縣','金沙鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (891,'金門縣','金湖鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (892,'金門縣','金寧鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (893,'金門縣','金城鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (894,'金門縣','烈嶼鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (896,'金門縣','烏坵鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (900,'屏東縣','屏東市');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (901,'屏東縣','三地門');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (902,'屏東縣','霧臺鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (903,'屏東縣','瑪家鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (904,'屏東縣','九如鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (905,'屏東縣','里港鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (906,'屏東縣','高樹鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (907,'屏東縣','鹽埔鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (908,'屏東縣','長治鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (909,'屏東縣','麟洛鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (911,'屏東縣','竹田鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (912,'屏東縣','內埔鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (913,'屏東縣','萬丹鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (920,'屏東縣','潮州鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (921,'屏東縣','泰武鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (922,'屏東縣','來義鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (923,'屏東縣','萬巒鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (924,'屏東縣','崁頂鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (925,'屏東縣','新埤鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (926,'屏東縣','南州鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (927,'屏東縣','林邊鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (928,'屏東縣','東港鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (929,'屏東縣','琉球鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (931,'屏東縣','佳冬鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (932,'屏東縣','新園鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (940,'屏東縣','枋寮鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (941,'屏東縣','枋山鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (942,'屏東縣','春日鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (943,'屏東縣','獅子鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (944,'屏東縣','車城鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (945,'屏東縣','牡丹鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (946,'屏東縣','恆春鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (947,'屏東縣','滿州鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (950,'台東縣','臺東市');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (951,'台東縣','綠島鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (952,'台東縣','蘭嶼鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (953,'台東縣','延平鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (954,'台東縣','卑南鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (955,'台東縣','鹿野鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (956,'台東縣','關山鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (957,'台東縣','海端鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (958,'台東縣','池上鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (959,'台東縣','東河鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (961,'台東縣','成功鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (962,'台東縣','長濱鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (963,'台東縣','太麻里鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (964,'台東縣','金峰鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (965,'台東縣','大武鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (966,'台東縣','達仁鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (970,'花蓮縣','花蓮市');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (971,'花蓮縣','新城鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (972,'花蓮縣','秀林鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (973,'花蓮縣','吉安鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (974,'花蓮縣','壽豐鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (975,'花蓮縣','鳳林鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (976,'花蓮縣','光復鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (977,'花蓮縣','豐濱鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (978,'花蓮縣','瑞穗鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (979,'花蓮縣','萬榮鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (981,'花蓮縣','玉里鎮');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (982,'花蓮縣','卓溪鄉');
Insert into REGION (REG_NO,REG_NAME,REG_DIST) values (983,'花蓮縣','富里鄉');

commit;
------------06-INSERT--------------------
------------VENUE------------------------
---------------------------------20181210
--中央大學附屬中壢高中自強館
--中央大學附屬中壢高中籃球場
--中央大學依仁堂
--中央大學籃球場

Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000001','中央大學附屬中壢高中籃球場','http://www.clhs.tyc.edu.tw',null,'VT001','室外設施',320,'桃園市中壢區三光路115號','03-4932181#34',24.9638709920322,121.210166931414,'Y','Y','免費對外開放使用','5:30-7:30','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140613120609_籃球場1.JPG','https://az804957.vo.msecnd.net/photofunc/20140613120609_籃球場2.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000002','中央大學羽球場(館)','http://www.ncu.edu.tw','無停車場','VT005','室內設施',320,'桃園市中壢區中大路300號','03-4267128',24.969189318918,121.190893650055,'Y','Y','付費對外開放使用','6:30-23:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140709162829_羽球館全景.JPG','https://az804957.vo.msecnd.net/photofunc/20140709162829_羽球館1.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000003','中央大學附屬中壢高中自強館','http://www.clhs.tyc.edu.tw','無停車場','VT005','室內設施',320,'桃園市中壢區三光路115號','03-4932181#34',24.9625795754056,121.211014509136,'Y','Y','付費對外開放使用','0:0-0:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140609115615_自強館1.JPG','https://az804957.vo.msecnd.net/photofunc/20140609115615_自強館2.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000004','中央大學依仁堂','http://140.115.117.199/ncupe/web/main/index.php','無停車場','VT002','室內設施',320,'桃園市中壢區中大路300號','03-4267128',24.9682993807963,121.190807819366,'Y','Y','付費對外開放使用','8:0-21:0','Y','Y','Y','Y','Y','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140715072039_排球館全景.JPG','https://az804957.vo.msecnd.net/photofunc/20140715072039_排球館1.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000005','中央大學附屬中壢高中網球場(館)','http://www.clhs.tyc.edu.tw',null,'VT003','室外設施',320,'桃園市中壢區三光路115號','03-4932181#34',24.9628377431009,121.211016654706,'Y','Y','付費對外開放使用','0:0-0:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140613121356_網球場3.JPG','https://az804957.vo.msecnd.net/photofunc/20140613121356_網球場1.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000006','中央大學籃球場','http://www.ncu.edu.tw','無停車場','VT001','室外設施',320,'桃園市中壢區中大路300號','03-4227151#57251',24.9697339773255,121.189337968826,'Y','Y','免費對外開放使用','6:0-23:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140711154826_籃球場全景.JPG','https://az804957.vo.msecnd.net/photofunc/20140711154826_籃球場2.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000007','中央大學附屬中壢高中自強館','http://www.clhs.tyc.edu.tw','無停車場','VT001','室內設施',320,'桃園市中壢區三光路115號','03-4932181#34',24.9625795754056,121.211014509136,'Y','Y','付費對外開放使用','8:0-22:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140609101726_自強館1.JPG','https://az804957.vo.msecnd.net/photofunc/20140609101726_自強館2.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000008','中央大學依仁堂','http://140.115.117.199/ncupe/web/main/index.php','無停車場','VT001','室內設施',320,'桃園市中壢區中大路300號','03-4267128',24.9682993807963,121.190807819366,'Y','Y','付費對外開放使用','8:0-21:0','Y','Y','Y','Y','Y','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140714165230_籃球館全景.JPG','https://az804957.vo.msecnd.net/photofunc/20140714165230_籃球館1.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000009','中央大學排球場','http://www.ncu.edu.tw','無停車場','VT002','室外設施',320,'桃園市中壢區中大路300號','03-4227151#57251',24.9676282756607,121.190947294235,'Y','Y','免費對外開放使用','8:0-22:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140714150418_球場全景.JPG','https://az804957.vo.msecnd.net/photofunc/20140714150418_排球場1.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000010','中央大學簡易棒球場','http://www.ncu.edu.tw','無停車場','VT004','室外設施',320,'桃園市中壢區中大路300號','03-4267128',24.9692574013508,121.191403269768,'Y','Y','付費對外開放使用','8:0-17:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140711093606_棒球場1.JPG','https://az804957.vo.msecnd.net/photofunc/20140711093606_棒球場2.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000011','中央大學附屬中壢高中田徑場','http://www.clhs.tyc.edu.tw',null,'VT002','室外設施',320,'桃園市中壢區三光路115號','03-4932181#34',24.9637841830203,121.210422277254,'Y','Y','免費對外開放使用','5:30-7:30','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140610135904_DSC03028.JPG','https://az804957.vo.msecnd.net/photofunc/20140610135904_排球場1.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000012','長庚大學體育館','http://www.cgu.edu.tw','一般及無障礙停車場','VT001','室內設施',333,'桃園市龜山區文化一路259號','03-2118800#2107',25.0326018950035,121.390291213957,'N','Y','不開放對外使用','8:30-21:30','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20160923112859_1DSCF0032.JPG','https://az804957.vo.msecnd.net/photofunc/20160923112859_20090618 (6).JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000013','長庚大學體育館','http://www.cgu.edu.tw','一般及無障礙停車場','VT002','室內設施',333,'桃園市龜山區文化一路259號','03-2118800#2107',25.0326018950035,121.390291213957,'N','Y','不開放對外使用','8:30-21:30','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20160923112416_20090618 (9).JPG','https://az804957.vo.msecnd.net/photofunc/20160923112416_1.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000014','崙坪國小風雨教室','http://www.lpes.tyc.edu.tw','無停車場','VT005','室內設施',328,'桃園市觀音區崙坪村297之1號','03-4981286#32',25.0002358608677,121.162006258965,'Y','Y','付費對外開放使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140609151445_DSCN5723.JPG','https://az804957.vo.msecnd.net/photofunc/20140609151445_DSCN5724.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000015','月眉環保公園籃球場','http://www.junglicity.gov.tw/','無停車場','VT001','室外設施',320,' 桃園市中壢區月眉里 環保路 月眉一路 交叉口','03-4271801#4105',25.0128953474756,121.189670562744,'Y','Y','免費對外開放使用','0:0-0:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140701174522_468_2.jpg','https://az804957.vo.msecnd.net/photofunc/20140701174522_468_3.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000016','仁善籃球場','http://www.dashi.gov.tw/tw/',null,'VT001','室外設施',335,'桃園市大溪區普濟路11號','03-3882201分機102',24.9093254338874,121.279063224792,'Y','N','免費對外開放使用','0:0-0:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20141203194930_IMG_3751.JPG','https://az804957.vo.msecnd.net/photofunc/20141203194930_IMG_3752.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000017','華美公園籃球場 ','http://192.168.100.30/Home.aspx','無停車場','VT001','室外設施',333,'桃園市龜山區文七一街67號旁','03-3203711#316',25.0524745586839,121.360328793526,'Y','Y','免費對外開放使用','0:0-0:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20141028134314_1.jpg','https://az804957.vo.msecnd.net/photofunc/20141028134314_2.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000018','龜山鄉棒球場','http://192.168.100.30/Home.aspx',null,'VT004','室外設施',333,'桃園市龜山區下湖街','03-3203711#316',25.0354205609693,121.351976394653,'N','Y','不開放對外使用','0:0-0:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140618173752_龜山鄉棒球場.jpg','https://az804957.vo.msecnd.net/photofunc/20140618173752_龜山鄉棒球場2.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000019','大安國小活動中心','http://www.daes.tyc.edu.tw','無停車場','VT005','室內設施',334,'桃園市八德區大安里和平路638號','03-3661419',24.9563405169791,121.314800977707,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140611115419_羽球場1.JPG','https://az804957.vo.msecnd.net/photofunc/20140611115419_羽球場2.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000020','北門國小籃球場','http://www.pmes.tyc.edu.tw',null,'VT001','室外設施',330,'桃園市桃園區正康三街139號','03-3250959#310',25.0077228116633,121.307172775269,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140627151745_DSC04443.JPG','https://az804957.vo.msecnd.net/photofunc/20140627151745_DSC04444.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000021','瑞豐國小半場籃球場','http://www.rfes.tyc.edu.tw','無停車場','VT001','室外設施',334,'桃園市八德區介壽路二段933巷40號','03-3682787',24.9366270118161,121.29880964756,'Y','Y','免費對外開放使用','17:30-18:30','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140620090404_半場全景.JPG','https://az804957.vo.msecnd.net/photofunc/20140620090404_操場平面.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000022','新興國小田徑場','http://www.ssps.tyc.edu.tw','無停車場','VT001','室外設施',338,'桃園市蘆竹區新興村新興街355號','03-3602448',25.0083304986862,121.264555156231,'Y','N','免費對外開放使用','17:0-18:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140627160753_IMG_2356.JPG','https://az804957.vo.msecnd.net/photofunc/20140627160753_DSCN2914 (1).JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000023','新屋國小活動中心','http://www.snwes.tyc.edu.tw','一般及無障礙停車場','VT005','室內設施',327,'桃園市新屋區新生村中正路196號','03-4772016',24.9737069929445,121.10274553299,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140620114003_7018.jpg','https://az804957.vo.msecnd.net/photofunc/20140620114003_7019.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000024','仁和國中體育館','http://www.jhjhs.tyc.edu.tw',null,'VT005','室內設施',335,'桃園市大溪區仁和里仁和七街55號','03-3906626#512',24.8944510232028,121.273097991943,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140616085702_P1040229_調整大小.JPG','https://az804957.vo.msecnd.net/photofunc/20140616085702_P1040232_調整大小.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000025','華勛國小籃球場','http://www.hses.tyc.edu.tw','無停車場','VT001','室外設施',320,'桃園市中壢區榮民南路205號','03-4661587#211',24.9533737218613,121.257991790771,'Y','Y','免費對外開放使用','17:0-19:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140610164704_C:\Users\user\Google 雲端硬碟\20140612_085725.jpg','https://az804957.vo.msecnd.net/photofunc/20140610164704_C:\Users\user\Google 雲端硬碟\20140611_140656.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000026','桃園高中排球場(館)','http://www.tysh.tyc.edu.tw',null,'VT001','室外設施',330,'桃園市桃園區成功路三段38號','03-3946001#6024',24.9991868734776,121.327509927723,'Y','Y','免費對外開放使用','8:0-17:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140805094124_IMG_1888.jpg','https://az804957.vo.msecnd.net/photofunc/20140805094124_IMG_1889.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000027','龍壽國小活動中心','http://www.lnses.tyc.edu.tw',null,'VT005','室內設施',333,'桃園市龜山區龍壽村龍校街30號','03-3296554#610',25.0109605334558,121.388057470322,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20180316103643_S__20955139.jpg','https://az804957.vo.msecnd.net/photofunc/20180316103643_S__20955139.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000029','義盛國小籃球場','http://www.ysps.tyc.edu.tw','無停車場','VT001','室外設施',336,'桃園市復興區義盛村1鄰11號','03-3822787#31',24.790720751959,121.378986239433,'Y','Y','免費對外開放使用','8:30-17:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140611131833_DSC01967(001).jpg','https://az804957.vo.msecnd.net/photofunc/20140611131833_DSC01968(001).jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000030','高榮國小體育場','http://163.30.192.129/xoops/',null,'VT001','室外設施',326,'桃園市楊梅區高上里高上路一段1號','03-4782314#511',24.9366464690883,121.16370677948,'Y','Y','免費對外開放使用','16:0-18:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140620122316_DSC09601.JPG','https://az804957.vo.msecnd.net/photofunc/20140620122316_DSC09602.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000031','大安國小活動中心','http://www.daes.tyc.edu.tw','無停車場','VT002','室內設施',334,'桃園市八德區大安里和平路638號','03-3661419',24.9563405169791,121.314800977707,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140611120725_排球場1.JPG','https://az804957.vo.msecnd.net/photofunc/20140611120725_排球場2.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000032','中原國小籃球場','http://www.cyes.tyc.edu.tw',null,'VT001','室外設施',320,'桃園市中壢區中北路88號','03-4385257',24.9563599711374,121.238722801209,'Y','Y','免費對外開放使用','16:0-19:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140616092739__MG_3021.JPG','https://az804957.vo.msecnd.net/photofunc/20140616092739__MG_3022.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000033','青溪國中田徑場','http://www.chjh.tyc.edu.tw','一般及無障礙停車場','VT001','室外設施',330,'桃園市桃園區中山東路124號','03-3392400#316',24.997215427699,121.319853588939,'Y','Y','免費對外開放使用','17:30-18:30','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140627102837_田徑場1.JPG','https://az804957.vo.msecnd.net/photofunc/20140627102837_田徑場.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000034','大溪高中體育館','http://www.dssh.tyc.edu.tw','無停車場','VT002','室內設施',335,'桃園市大溪區康莊路641號','03-3878628#512',24.8695736180943,121.285452246666,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140605151236_P1080757.JPG','https://az804957.vo.msecnd.net/photofunc/20140605151236_P1080240.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000035','雙龍國小龍騰館','http://www.shlps.tyc.edu.tw',null,'VT001','室內設施',325,'桃園市龍潭區神龍路346號','03-4991888#31',24.8563785800033,121.215639710426,'Y','N','免費對外開放使用','17:0-18:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20160504121542_4.jpg','https://az804957.vo.msecnd.net/photofunc/20160504121542_6.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000036','大溪高中體育館','http://www.dssh.tyc.edu.tw','無停車場','VT001','室內設施',335,'桃園市大溪區康莊路641號','03-3878628#512',24.8695736180943,121.285452246666,'Y','Y','付費對外開放使用','17:30-18:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140605150631_體育館.jpg','https://az804957.vo.msecnd.net/photofunc/20140605150631_P1080241-min.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000037','福安國小健體館','http://host.faes.tyc.edu.tw/joomla',null,'VT005','室內設施',335,'桃園市大溪區福安里十六鄰復興路一段755號','03-3882374',24.8501869886746,121.289126873016,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140610181303_C:\Documents and Settings\User\桌面\2013\P1040147.jpg','https://az804957.vo.msecnd.net/photofunc/20140610181303_C:\Documents and Settings\User\桌面\2013\P1040148.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000038','大溪高中體育館','http://www.dssh.tyc.edu.tw','無停車場','VT005','室內設施',335,'桃園市大溪區康莊路641號','03-3878628#512',24.8695736180943,121.285452246666,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140605143955_體育館.jpg','https://az804957.vo.msecnd.net/photofunc/20140605143955_P1080241-min.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000039','大有國中活動中心','http://www.dyjhs.tyc.edu.tw','無停車場','VT005','室內設施',330,'桃園市桃園區大有路215號','03-2613298#312',25.0099590850816,121.319414377213,'Y','Y','付費對外開放使用','18:30-22:0','N','N','N','Y','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140702103721_IMG_0573.jpg','https://az804957.vo.msecnd.net/photofunc/20140702103721_IMG_0574 (2).jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000040','大潭國小田徑場','http://www.tates.tyc.edu.tw',null,'VT001','室外設施',328,'桃園市觀音區大潭村濱海路大潭段687號','03-4732087',25.0219175952082,121.058778762817,'Y','N','免費對外開放使用','16:0-18:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20180502103721_20180502_102217.jpg','https://az804957.vo.msecnd.net/photofunc/20180502103721_20180502_102148.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000041','慈文國小籃球場','http://www.twes.tyc.edu.tw','無停車場','VT001','室外設施',330,'桃園市桃園區新埔六街2號','03-3175755#303',25.012302267021,121.303750276566,'Y','Y','免費對外開放使用','17:0-18:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140627092020_IMG_20140626_150152.jpg','https://az804957.vo.msecnd.net/photofunc/20140627092020_IMG_20140626_143749.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000042','竹圍國小田徑場','http://www.jwes.tyc.edu.tw/','無停車場','VT001','室外設施',337,'桃園市大園區竹圍村二鄰竹圍街3號','03-3835079#330',25.1037801883168,121.244368851185,'Y','Y','免費對外開放使用','16:0-21:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140609092911_DSC02752.JPG','https://az804957.vo.msecnd.net/photofunc/20140609092911_3球場跑道1.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000043','竹圍國小田徑場','http://www.jwes.tyc.edu.tw/','無停車場','VT002','室外設施',337,'桃園市大園區竹圍村二鄰竹圍街3號','03-3835079#330',25.1037801883168,121.244368851185,'Y','Y','免費對外開放使用','16:0-21:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140609093701_DSC02752.JPG','https://az804957.vo.msecnd.net/photofunc/20140609093701_3球場跑道1.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000044','田徑場','http://www.ymhs.tyc.edu.tw','一般及無障礙停車場','VT001','室外設施',326,'桃園市楊梅區高獅路5號','03-4789618',24.9215467021952,121.148943901062,'Y','Y','免費對外開放使用','6:0-7:30','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140617150823_IMG_0611.JPG','https://az804957.vo.msecnd.net/photofunc/20140617150823_IMG_0612.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000045','田徑場','http://www.ymhs.tyc.edu.tw','一般及無障礙停車場','VT002','室外設施',326,'桃園市楊梅區高獅路5號','03-4789618',24.9215467021952,121.148943901062,'Y','Y','免費對外開放使用','6:0-7:30','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140617154422_IMG_0613.JPG','https://az804957.vo.msecnd.net/photofunc/20140617154422_IMG_0614.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000046','新屋國小網球場(館)','http://www.snwes.tyc.edu.tw','無停車場','VT003','室外設施',327,'桃園市新屋區新生村中正路196號','03-4772016',24.974301475372,121.102256029844,'Y','N','免費對外開放使用','16:0-18:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140620115609_7020.jpg','https://az804957.vo.msecnd.net/photofunc/20140620115609_7021.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000047','運動公園籃球場','http://www.dashi.gov.tw/tw/',null,'VT001','室外設施',335,'桃園市大溪區登龍路','03-3882201',24.8844072279336,121.287142038345,'Y','Y','免費對外開放使用','0:0-0:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20141031052902_IMG_3763.JPG','https://az804957.vo.msecnd.net/photofunc/20141031052902_IMG_3762.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000048','學生活動中心','http://www.ttjh.tyc.edu.tw','一般及無障礙停車場','VT001','室內設施',328,'桃園市觀音區草新里28鄰四維路73號','03-4830146#340',25.0443439516442,121.140414476395,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20170630085535_學生活動中心.JPG','https://az804957.vo.msecnd.net/photofunc/20170630085535_IMG_0065.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000049','大崙國中排球場(館)','http://www.dljh.tyc.edu.tw','無停車場','VT002','室外設施',320,'桃園市中壢區月眉路一段50號','03-4982840#310',24.9923351745781,121.180052161217,'N','Y','不開放對外使用','17:0-17:30','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140619141428_IMG_0997.JPG','https://az804957.vo.msecnd.net/photofunc/20140619141428_1013937_520095494711495_10602151_n.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000050','清華高中學生活動中心','http://www.chvs.tyc.edu.tw',null,'VT001','室內設施',327,'桃園市新屋區中華路658號','(03)4771196',24.9817670062138,121.107777357101,'Y','Y','付費對外開放使用','8:0-16:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140612170302_運動館2.gif','https://az804957.vo.msecnd.net/photofunc/20140612170302_運動館.gif','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000051','富岡國中籃球場','http://www.fkjh.tyc.edu.tw',null,'VT001','室外設施',326,'桃園市楊梅區豐野里中正路456號','03-4721113#510',24.941997102335,121.073262691498,'Y','N','免費對外開放使用','8:0-16:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140613151546_DSC06850.JPG','https://az804957.vo.msecnd.net/photofunc/20140613151546_DSC06851.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000052','平興國小田徑場','http://www.psees.tyc.edu.tw',null,'VT001','室外設施',324,'桃園市平鎮區廣泰路168號','03-4029323',24.9439621856567,121.202802658081,'Y','Y','免費對外開放使用','18:0-19:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140611172916_DSCF4423.jpg','https://az804957.vo.msecnd.net/photofunc/20140611172916_DSCF4422.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000053','南勢國小活動中心','http://www.nsps.tyc.edu.tw',null,'VT005','室內設施',324,'桃園市平鎮區中豐路南勢二段223號','03-4393724#313',24.9135728511216,121.21083855629,'Y','Y','不開放對外使用','0:0-0:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140609110644_IMAG0120.jpg','https://az804957.vo.msecnd.net/photofunc/20140609110644_IMAG0753_BURST003.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000054','大坑國小活動中心','http://www.dkes.tyc.edu.tw','無停車場','VT005','室內設施',333,'桃園市龜山區大坑路一段850號','03-3252430#510',25.0445005572204,121.314747821216,'N','Y','不開放對外使用','8:0-17:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140619170010_IMG_9164.jpg','https://az804957.vo.msecnd.net/photofunc/20140619170010_0000001.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000055','元智大學體育館','http://www.yzu.edu.tw','無停車場','VT001','室內設施',320,'桃園市中壢區遠東路135號','03-4638800#2342',24.966295780703,121.267347335815,'Y','Y','付費對外開放使用','8:0-21:30','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140709095826_IMG_0583.jpg','https://az804957.vo.msecnd.net/photofunc/20140709095826_IMG_0587.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000056','龍壽國小田徑場','http://www.lnses.tyc.edu.tw',null,'VT001','室外設施',333,'桃園市龜山區龍壽村龍校街30號','03-3296554#310',25.010797677116,121.387679278851,'Y','Y','免費對外開放使用','17:30-19:30','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140619140227_DSC04868.jpg','https://az804957.vo.msecnd.net/photofunc/20140619140227_DSC04869.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000057','大業國小活動中心','http://www.dayes.tyc.edu.tw','無停車場','VT005','室內設施',330,'桃園市桃園區大業路一段135號','03-3337771#310',25.006726198437,121.315670013428,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20151119111205_1.jpg','https://az804957.vo.msecnd.net/photofunc/20151119111205_2.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000058','體育大學網球館(室內)','http://www.ntsu.edu.tw',null,'VT003','室外設施',333,'桃園市龜山區文化一路250號','03-3283201#3138',25.0336610794357,121.382687687874,'Y','Y','付費對外開放使用','8:0-21:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140624102702_IMG_0036.JPG','https://az804957.vo.msecnd.net/photofunc/20140624102702_IMG_0031.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000059','平鎮國中田徑場','http://home.pjjh.tyc.edu.tw','一般及無障礙停車場','VT001','室外設施',324,'桃園市平鎮區新富里振興路2號','03-4572150#328',24.9444840138127,121.218246817589,'Y','Y','免費對外開放使用','17:0-18:0','Y','Y','Y','Y','Y','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140616115409_10464052_10202512077228811_936294471509006369_n.jpg','https://az804957.vo.msecnd.net/photofunc/20140616115409_20131209_151226.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000060','平鎮國中田徑場','http://home.pjjh.tyc.edu.tw','一般及無障礙停車場','VT002','室外設施',324,'桃園市平鎮區新富里振興路2號','03-4572150#328',24.9444840138127,121.218246817589,'Y','Y','免費對外開放使用','17:0-18:0','Y','Y','Y','Y','Y','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140616114622_10464052_10202512077228811_936294471509006369_n.jpg','https://az804957.vo.msecnd.net/photofunc/20140616114622_10464052_10202512077228811_936294471509006369_n (960x720).jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000061','大溪國中籃球場','http://www.dsjh.tyc.edu.tw','一般及無障礙停車場','VT001','室外設施',335,'桃園市大溪區民權東路210號','03-3882024#314',24.8787669673557,121.296100616455,'Y','Y','免費對外開放使用','17:0-19:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140620110645_DSC05394.JPG','https://az804957.vo.msecnd.net/photofunc/20140620110645_DSC05398.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000062','三民國小田徑場','http://www.sames.tyc.edu.tw','無停車場','VT001','室外設施',336,'桃園市復興區三民村十一鄰57號','03-3825294',24.8325450955591,121.331720352173,'Y','Y','免費對外開放使用','17:0-21:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140620162143_C:\Documents and Settings\三民國小\桌面\國有公用財產管理情形檢核實地訪查\IMG_0282.JPG','https://az804957.vo.msecnd.net/photofunc/20140620162143_C:\Documents and Settings\三民國小\桌面\國有公用財產管理情形檢核實地訪查\IMG_0283.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000063','頭洲籃球場','http://www.shinwu.gov.tw','無停車場','VT001','室外設施',327,'桃園市新屋區頭洲里福洲一街與中山東路二段713巷轉角處','03-4772111#232',24.9630686138198,121.14550164436,'Y','N','免費對外開放使用','6:0-10:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140917145907_DSC02380.JPG','https://az804957.vo.msecnd.net/photofunc/20140917145907_DSC01271.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000064','大竹國中活動中心','http://www.dcjh.tyc.edu.tw','無停車場','VT005','室內設施',338,'桃園市蘆竹區大竹村四鄰國中巷35號','03-3232764',25.0225745807145,121.257359376177,'Y','Y','付費對外開放使用','8:0-20:30','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20180322140605_','https://az804957.vo.msecnd.net/photofunc/20180322140605_','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000065','大成國中網球場(館)','http://www.tcjhs.tyc.edu.tw','無停車場','VT003','室外設施',334,'桃園市八德區大勇村忠勇街12號','(03)3625633',24.9590202983293,121.304941177368,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140611200445_DSCI0632.JPG','https://az804957.vo.msecnd.net/photofunc/20140611200445_DSCI0633.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000066','迴龍國中小體育館','http://www.hles.tyc.edu.tw',null,'VT001','室外設施',333,'桃園市龜山區萬壽路一段168號','02-82096088#311',25.019333975096,121.404700577259,'Y','Y','免費對外開放使用','17:0-19:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140609113027_DSC08755.JPG','https://az804957.vo.msecnd.net/photofunc/20140609113027_DSC08799.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000067','會稽國中田徑場','http://www.kjjhs.tyc.edu.tw','一般及無障礙停車場','VT001','室外設施',330,'桃園市桃園區大興路222號','03-3551496#511',25.0168864127571,121.313245296478,'Y','Y','免費對外開放使用','0:0-0:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140626154207_IMG_0190.JPG','https://az804957.vo.msecnd.net/photofunc/20140626154207_IMG_0085.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000068','中壢高商游藝館','http://www.clvsc.tyc.edu.tw/bin/home.php',null,'VT001','室內設施',320,'桃園市中壢區中央西路二段141巷100號','03-4929871#1601',24.9636137261199,121.214738488197,'N','Y','不開放對外使用','8:0-18:0','Y','Y','Y','Y','Y','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140604114947_DSC06174.JPG','https://az804957.vo.msecnd.net/photofunc/20140604114947_DSC06257.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000069','會稽國中田徑場','http://www.kjjhs.tyc.edu.tw','一般及無障礙停車場','VT002','室外設施',330,'桃園市桃園區大興路222號','03-3551496#511',25.0168864127571,121.313245296478,'Y','Y','免費對外開放使用','0:0-0:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140626154723_IMG_0083.JPG','https://az804957.vo.msecnd.net/photofunc/20140626154723_IMG_0084.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000070','中壢高商游藝館','http://www.clvsc.tyc.edu.tw/bin/home.php',null,'VT005','室內設施',320,'桃園市中壢區中央西路二段141巷100號','03-4929871#1601',24.9636137261199,121.214738488197,'N','Y','不開放對外使用','8:0-18:0','Y','Y','Y','Y','Y','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140604111217_111.JPG','https://az804957.vo.msecnd.net/photofunc/20140604111217_1111.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000071','新興高級中學田徑場','http://www.hshs.tyc.edu.tw','無停車場','VT002','室外設施',334,'桃園市八德區永豐路563號','(03)3796996',24.973986606714,121.271652281284,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140604153046_IMG_2290-1.jpg','https://az804957.vo.msecnd.net/photofunc/20140604153046_排球場.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000072','頂社國小活動中心','http://www.dises.tyc.edu.tw',null,'VT005','室內設施',338,'桃園市蘆竹區山林路三段232號','03-3241182#510',25.0775579455513,121.319492161274,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140710124159_PhotoCap_01.jpg','https://az804957.vo.msecnd.net/photofunc/20140710124159_PhotoCap_04.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000073','新興高級中學田徑場','http://www.hshs.tyc.edu.tw','無停車場','VT001','室外設施',334,'桃園市八德區永豐路563號','(03)3796996',24.973986606714,121.271652281284,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140604152950_IMG_2290-1.jpg','https://az804957.vo.msecnd.net/photofunc/20140604152950_IMG_2293-1.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000074','東安國中田徑場','http://www.tajh.tyc.edu.tw','無停車場','VT001','室外設施',324,'桃園市平鎮區平東路168號','03-4601407#311',24.9176157894012,121.24911904335,'Y','Y','免費對外開放使用','17:0-18:30','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140618112020_IMG_4697.JPG','https://az804957.vo.msecnd.net/photofunc/20140618112020_IMG_20140515_110641.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000075','仁美國中籃球場','http://www.zmjhs.tyc.edu.tw','無停車場','VT001','室外設施',326,'桃園市楊梅區高榮里梅獅路539巷1號','03-4641123#310',24.9243488605567,121.184091567993,'Y','Y','免費對外開放使用','17:0-18:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140612105618_籃球場1.jpg','https://az804957.vo.msecnd.net/photofunc/20140612105618_籃球場2.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000076','中央警察大學體育館','http://www.cpu.edu.tw/bin/home.php','無停車場','VT001','室內設施',333,'桃園市龜山區大崗村樹人路56號 ','03-3273544',25.0471627527443,121.35351061821,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140715192652_123456.jpg','https://az804957.vo.msecnd.net/photofunc/20140715192652_1234567.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000077','大有國小環形/直線慢跑道(非田徑場型)','http://www.dyes.tyc.edu.tw',null,'VT001','室外設施',330,'桃園市桃園區大有路220號','03-3577715#311',25.0094182509497,121.320921778679,'Y','Y','免費對外開放使用','16:0-18:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140623143700_操場2.jpg','https://az804957.vo.msecnd.net/photofunc/20140623143700_操場3.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000079','大竹國中活動中心','http://www.dcjh.tyc.edu.tw','無停車場','VT001','室內設施',338,'桃園市蘆竹區大竹村四鄰國中巷35號','03-3232764',25.0225745807145,121.257359376177,'Y','Y','付費對外開放使用','8:0-20:30','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140627154636_P6108525-1.JPG','https://az804957.vo.msecnd.net/photofunc/20140627154636_P6108523-1.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000080','文欣國小田徑場附設籃球場','http://www.weses.tyc.edu.tw','一般及無障礙停車場','VT001','室外設施',333,'桃園市龜山區文昌五街95號','03-3974893#311',25.0574654053909,121.372232437134,'Y','Y','免費對外開放使用','18:30-19:30','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140627102843_DSC_1016.JPG','https://az804957.vo.msecnd.net/photofunc/20140627102843_DSC_1066.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000081','三和國小田徑場','http://163.30.184.1','無停車場','VT001','室外設施',325,'桃園市龍潭區龍新路三和段1356號','03-4792154',24.8477141596292,121.167418956757,'Y','N','免費對外開放使用','17:0-18:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20160701095014_操場照片2.jpg','https://az804957.vo.msecnd.net/photofunc/20160701095014_操場照片3.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000082','振聲高中操場','http://www.fxsh.tyc.edu.tw','無停車場','VT001','室外設施',330,'桃園市桃園區復興路439號','03-3322605#1351',24.9906091108976,121.301298737526,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140619144433_53623.jpg','https://az804957.vo.msecnd.net/photofunc/20140619144433_53798.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000083','振聲高中操場','http://www.fxsh.tyc.edu.tw','無停車場','VT002','室外設施',330,'桃園市桃園區復興路439號','03-3322605#1351',24.9906091108976,121.301298737526,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140619144500_53876.jpg','https://az804957.vo.msecnd.net/photofunc/20140619144500_53889.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000084','東興國民中學自強樓四樓活動中心','http://www.dsjhs.tyc.edu.tw','無停車場','VT005','室內設施',320,'桃園市中壢區廣州路25號','03-4583500#315',24.9493125011718,121.228809356689,'N','Y','不開放對外使用','8:0-22:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140613133616_自強活動中心1.jpg','https://az804957.vo.msecnd.net/photofunc/20140613133616_自強活動中心2.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000085','桃園農工活動中心','http://www.tyai.tyc.edu.tw',null,'VT001','室內設施',330,'桃園市桃園區成功路二段144號','03-3333921#350',24.9942167994831,121.320712566376,'N','Y','不開放對外使用','8:0-17:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140711115027_IMAG2172.jpg','https://az804957.vo.msecnd.net/photofunc/20140711115027_IMAG2177.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000086','福豐國中活動中心','http://www.ffjh.tyc.edu.tw',null,'VT001','半室內設施(有頂蓋但外牆未密封)',330,'桃園市桃園區延平路326號','03-3669547#314',24.976841062225,121.312920749187,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140611164420_IMG_20150303_102139.jpg','https://az804957.vo.msecnd.net/photofunc/20140611164420_IMG_20150303_102133.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000087','北門國小活動中心','http://www.pmes.tyc.edu.tw',null,'VT001','室內設施',330,'桃園市桃園區正康三街139號','03-3177006',25.007499182082,121.307081580162,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140627145714_DSC04435.JPG','https://az804957.vo.msecnd.net/photofunc/20140627145714_DSC04434.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000088','龍山國小田徑場','http://www.loses.tyc.edu.tw','無停車場','VT001','室外設施',330,'桃園市桃園區龍泉二街36號','03-3691253',24.9806460894335,121.270022839308,'Y','Y','免費對外開放使用','16:0-21:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140612113021_DSC03061.JPG','https://az804957.vo.msecnd.net/photofunc/20140612113021_DSC03062.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000089','福豐國中活動中心','http://www.ffjh.tyc.edu.tw',null,'VT002','半室內設施(有頂蓋但外牆未密封)',330,'桃園市桃園區延平路326號','03-3669547#314',24.976841062225,121.312920749187,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20180102085928_2.jpg','https://az804957.vo.msecnd.net/photofunc/20180102085928_1.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000090','大有國中活動中心','http://www.dyjhs.tyc.edu.tw','無停車場','VT001','室內設施',330,'桃園市桃園區大有路215號','03-2613298#312',25.0099590850816,121.319414377213,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140702102825_IMG_0574 (2).jpg','https://az804957.vo.msecnd.net/photofunc/20140702102825_IMG_0573.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000091','中正公園籃球場','http://www.junglicity.gov.tw/','無停車場','VT001','室外設施',320,'桃園市中壢區元化路159號','03-4271801#4113',24.9601236849934,121.227951720357,'Y','Y','免費對外開放使用','0:0-0:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140620093926_th.jpg','https://az804957.vo.msecnd.net/photofunc/20140620093926_402_2.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000092','上田國小田徑場','http://www.stps.tyc.edu.tw','無停車場','VT001','室外設施',326,'桃園市楊梅區上田里九鄰和平路98號','03-4782544#310',24.9372691001754,121.126756668091,'Y','Y','免費對外開放使用','17:0-19:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140619092426_IMG_20140619_090829.jpg','https://az804957.vo.msecnd.net/photofunc/20140619092426_IMG_20140619_090930_1.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000093','建德國小田徑場(附設躲避球場、排球場、籃球場)','http://www.jdps.tyc.edu.tw','一般及無障礙停車場','VT002','室外設施',330,'桃園市桃園區延平路265號','03-3660688#340',24.9764982392965,121.315562725067,'Y','Y','免費對外開放使用','8:0-16:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140616155147_運動場1 - 複製4.jpg','https://az804957.vo.msecnd.net/photofunc/20140616155147_運動場4.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000094','建德國小田徑場(附設躲避球場、排球場、籃球場)','http://www.jdps.tyc.edu.tw','一般及無障礙停車場','VT001','室外設施',330,'桃園市桃園區延平路265號','03-3660688#340',24.9764982392965,121.315562725067,'Y','Y','免費對外開放使用','8:0-16:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140616165029_運動場30.jpg','https://az804957.vo.msecnd.net/photofunc/20140616165029_運動場5.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000095','會稽國小體育館','http://www.gjes.tyc.edu.tw','無停車場','VT005','室內設施',330,'桃園市桃園區春日路1080號','03-3252982#351',25.0203961096077,121.309200525284,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140617130611_P1130267.JPG','https://az804957.vo.msecnd.net/photofunc/20140617130611_P1130268.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000096','觀音國中活動中心','http://www.gijh.tyc.edu.tw',null,'VT001','室內設施',328,'桃園市觀音區白玉村下庄子53之1號','03-4732034#511',25.0400290192167,121.080197971824,'Y','Y','免費對外開放使用','0:0-0:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20161005150845_IMAG1323.jpg','https://az804957.vo.msecnd.net/photofunc/20161005150845_IMAG0999.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000097','龍潭國中活動中心','http://www.ltjhs.tyc.edu.tw','一般及無障礙停車場','VT005','室內設施',325,'桃園市龍潭區中正村龍華路460號','03-4792075#350',24.8554586225936,121.217200756073,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140701145534_IMG_0001.jpg','https://az804957.vo.msecnd.net/photofunc/20140701145534_IMG_0002.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000098','龍岡國中田徑場','http://www.lkjh.tyc.edu.tw','一般及無障礙停車場','VT001','室外設施',320,'桃園市中壢區龍東路147號','03-4562137',24.9295368886201,121.251827001506,'Y','Y','免費對外開放使用','17:0-19:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140627150208_CIMG3815_副本.jpg','https://az804957.vo.msecnd.net/photofunc/20140627150208_CIMG3817_副本.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000099','南興國民小學風雨球場','http://www.nses.tyc.edu.tw','一般及無障礙停車場','VT001','半室內設施(有頂蓋但外牆未密封)',335,'桃園市大溪區仁和路二段135號','03-3801721#510',24.9019833335165,121.266590952873,'Y','Y','免費對外開放使用','16:0-18:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20160510110022_IMG_7880.JPG','https://az804957.vo.msecnd.net/photofunc/20160510110022_IMG_7879.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000100','操場','http://www.fles.tyc.edu.tw','一般及無障礙停車場','VT001','室外設施',328,'桃園市觀音區富林里五鄰8號之2','03-4839049#33',25.0367558523431,121.120600715628,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20170413120404_20170413_104525.jpg','https://az804957.vo.msecnd.net/photofunc/20170413120404_20170413_104525.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000101','瑞豐國小籃球場','http://www.rfes.tyc.edu.tw','無停車場','VT001','室外設施',334,'桃園市八德區介壽路二段933巷40號','03-3682787',24.9364373032515,121.300118565559,'Y','Y','免費對外開放使用','17:30-18:30','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140620085115_籃球場全景.JPG','https://az804957.vo.msecnd.net/photofunc/20140620085115_籃球場平面.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000102','觀音國中活動中心','http://www.gijh.tyc.edu.tw',null,'VT005','室內設施',328,'桃園市觀音區白玉村下庄子53之1號','03-4732034#511',25.0400290192167,121.080197971824,'Y','Y','免費對外開放使用','0:0-0:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140619085014_IMG_0743.jpg','https://az804957.vo.msecnd.net/photofunc/20140619085014_IMG_0745.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000103','同德國中田徑場','http://www.tdjhs.tyc.edu.tw','無停車場','VT001','室外設施',330,'桃園市桃園區南平路487號','03-2628955',25.0151704164202,121.293407678604,'Y','Y','免費對外開放使用','17:30-18:30','Y','Y','Y','Y','Y','N','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20160930091454_40152.jpg','https://az804957.vo.msecnd.net/photofunc/20160930091454_40152.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000104','大園國小籃球場','http://www.dyps.tyc.edu.tw',null,'VT001','室外設施',337,'桃園市大園區橫峰村中正東路160號','03-3862030#313',25.0595549887331,121.201815605164,'Y','N','免費對外開放使用','8:0-18:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140619095450_IMAG1308.jpg','https://az804957.vo.msecnd.net/photofunc/20140619095450_IMAG1296.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000105','至善高中室內體育場','http://www.lovejs.tw','一般及無障礙停車場','VT005','室內設施',335,'桃園市大溪區康莊路645號','03-3887528#502',24.8662591725419,121.285672187805,'N','Y','不開放對外使用','8:0-16:0','Y','Y','Y','Y','Y','Y','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140625091133_mobilef6fe758b-be28-420b-86eb-19ddb5b7a79c.jpg','https://az804957.vo.msecnd.net/photofunc/20140625091133_mobileecd660ff-8b0f-4893-92b5-5bb712b1da7d.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000106','過嶺國中田徑場','http://www.gljh.tyc.edu.tw','無停車場','VT002','室外設施',320,'桃園市中壢區松智路2號','03-4200026#314',24.960532817039,121.173947453499,'Y','N','免費對外開放使用','17:0-19:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140618085447_DSCN0007.JPG','https://az804957.vo.msecnd.net/photofunc/20140618085447_DSCN0009.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000107','新生醫護管理專科學校撞球場','http://www.web.hsc.edu.tw/bin/home.php','無停車場','VT005','室內設施',325,'桃園市龍潭區中豐路高平段418號','(03)4117578*340',24.8325584837106,121.206510812044,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20170707104048_IMG_3486.jpg','https://az804957.vo.msecnd.net/photofunc/20170707104048_IMG_3485.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000108','慈文國中操場附設籃球場與排球場及網球場','http://163.30.29.14/','一般及無障礙停車場','VT001','室外設施',330,'桃園市桃園區中正路835號','03-3269340#313',25.0090451347784,121.301336288452,'Y','Y','免費對外開放使用','17:0-18:30','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140617121810_20180508_IMG_8200.JPG','https://az804957.vo.msecnd.net/photofunc/20140617121810_20180508_IMG_8201.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000109','過嶺國中田徑場','http://www.gljh.tyc.edu.tw','無停車場','VT001','室外設施',320,'桃園市中壢區松智路2號','03-4200026#314',24.960532817039,121.173947453499,'Y','N','免費對外開放使用','17:0-19:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140618085138_IMG_0849.JPG','https://az804957.vo.msecnd.net/photofunc/20140618085138_DSCN9368.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000110','至善高中室內體育場','http://www.lovejs.tw','一般及無障礙停車場','VT001','室內設施',335,'桃園市大溪區康莊路645號','03-3887528#502',24.8662591725419,121.285672187805,'N','Y','不開放對外使用','8:0-16:0','Y','Y','Y','Y','Y','Y','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140625091028_mobile4c04503d-097c-491d-b93e-c97270a3ae92.jpg','https://az804957.vo.msecnd.net/photofunc/20140625091028_mobile57fbe8db-e840-40dd-8153-f28dd1bfb690.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000111','慈文國中操場附設籃球場與排球場及網球場','http://163.30.29.14/','一般及無障礙停車場','VT002','室外設施',330,'桃園市桃園區中正路835號','03-3269340#313',25.0090451347784,121.301336288452,'Y','Y','免費對外開放使用','17:0-18:30','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140617121536_DSC05692.JPG','https://az804957.vo.msecnd.net/photofunc/20140617121536_DSC05694.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000112','介壽國小羽球場(館)','http://www.jses.tyc.edu.tw','無障礙停車場','VT005','室內設施',336,'桃園市復興區澤仁里中正路33號','03-3822364#51',24.8167030787113,121.351152956486,'N','Y','不開放對外使用','16:30-18:0','Y','Y','Y','Y','Y','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140627101433_DSCI0176.jpg','https://az804957.vo.msecnd.net/photofunc/20140627101433_DSCI04444.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000113','慈文國中操場附設籃球場與排球場及網球場','http://163.30.29.14/','一般及無障礙停車場','VT003','室外設施',330,'桃園市桃園區中正路835號','03-3269340#313',25.0090451347784,121.301336288452,'Y','Y','免費對外開放使用','17:0-18:30','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140617121719_DSC05692.JPG','https://az804957.vo.msecnd.net/photofunc/20140617121719_20180508_IMG_8185.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000114','社子國小田徑場','http://www.szes.tyc.edu.tw','無停車場','VT001','室外設施',327,'桃園市新屋區社子里社福路235號','03-4772444#52',24.9563648346765,121.082103252411,'Y','Y','免費對外開放使用','17:0-18:30','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20180727085905_DSC06194.JPG','https://az804957.vo.msecnd.net/photofunc/20180727085905_DSC06195.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000115','桃園國中田徑場','http://www.tyjh.tyc.edu.tw','一般及無障礙停車場','VT001','室外設施',330,'桃園市桃園區莒光街2號','03-3344440',24.9960060181507,121.304876804352,'Y','Y','免費對外開放使用','16:0-18:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140630171550_D:\1030508體育班訪視\環境設施\CIMG0459.JPG','https://az804957.vo.msecnd.net/photofunc/20140630171550_D:\1030508體育班訪視\環境設施\CIMG0458.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000116','上湖國小活動中心','http://163.30.193.3/main/index.html',null,'VT005','室內設施',326,'桃園市楊梅區上湖里十四鄰60之1號','03-4728925',24.9089751249077,121.085000038147,'Y','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140630101524_IMG_0440.JPG','https://az804957.vo.msecnd.net/photofunc/20140630101524_IMG_0444.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000117','萬能科技大學田徑場','http://www.vnu.edu.tw/',null,'VT001','室外設施',320,'桃園市中壢區萬能路1號','03-4515811#22400',24.9937460471199,121.228949181896,'Y','Y','免費對外開放使用','0:0-0:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140807162357_室外籃球場 (Large).JPG','https://az804957.vo.msecnd.net/photofunc/20140807162357_室外籃球場2 (Large).JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000118','內柵國小田徑場','http://www.njes.tyc.edu.tw','無停車場','VT001','室外設施',335,'桃園市大溪區義和里三鄰安和路38號','03-3882461#210',24.855609515548,121.282236278057,'Y','Y','免費對外開放使用','17:0-18:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20180503094202_IMG_0343.JPG','https://az804957.vo.msecnd.net/photofunc/20180503094202_IMG_2835.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000119','光明國小田徑場','http://www.gmes.tyc.edu.tw','無停車場','VT001','室外設施',338,'桃園市蘆竹區南興里三鄰南昌路255號','03-3127066#310',25.0412893672993,121.290575265884,'Y','Y','免費對外開放使用','16:0-19:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140613160929_46677.jpg','https://az804957.vo.msecnd.net/photofunc/20140613160929_IMG_0004.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000120','興仁國小南側門籃球場','http://www.sres.tyc.edu.tw','無停車場','VT001','室外設施',320,'桃園市中壢區遠東路210號','03-4355753#513',24.9671176497361,121.261720061302,'Y','Y','免費對外開放使用','16:30-18:30','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140617154610_DSC08758.JPG','https://az804957.vo.msecnd.net/photofunc/20140617154610_DSC08761.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000121','崙坪國小運動場','http://www.lpes.tyc.edu.tw','無停車場','VT001','室外設施',328,'桃園市觀音區崙坪村297之1號','03-4981286#32',24.9997010612088,121.162231564522,'Y','Y','免費對外開放使用','16:0-20:0','Y','Y','Y','Y','Y','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140619145611_DSCN5736.JPG','https://az804957.vo.msecnd.net/photofunc/20140619145611_DSCN5738.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000122','中壢區光明公園籃球場','http://www.junglicity.gov.tw/','無停車場','VT001','室外設施',320,' 桃園市中壢區三光路.民權路及中壢高商旁','03-4271801#2222',24.9643626647413,121.216785684228,'Y','Y','免費對外開放使用','0:0-0:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140627134457_412_3.jpg','https://az804957.vo.msecnd.net/photofunc/20140627134457_412_4.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000123','山腳國中活動中心','http://www.sjjh.tyc.edu.tw',null,'VT001','室內設施',338,'桃園市蘆竹區海山路319號','03-3241995#316',25.0869203805512,121.278558969498,'N','Y','不開放對外使用','8:30-17:0','Y','Y','Y','Y','Y','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140620162253_DSC_2770a.jpg','https://az804957.vo.msecnd.net/photofunc/20140620162253_DSC_2772a.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000124','大坑國小田徑場','http://www.dkes.tyc.edu.tw','無停車場','VT001','室外設施',333,'桃園市龜山區大坑路一段850號','03-3252430#510',25.0445347778786,121.314903877028,'Y','Y','免費對外開放使用','16:0-19:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140619172033_IMG_9162.jpg','https://az804957.vo.msecnd.net/photofunc/20140619172033_IMG_9165.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000125','觀音國小活動中心','http://www.gies.tyc.edu.tw','一般及無障礙停車場','VT005','室內設施',328,'桃園市觀音區觀音村四鄰文化路2號','03-4732009',25.0348567519547,121.083366572857,'Y','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140620134835_DSC_0033.JPG','https://az804957.vo.msecnd.net/photofunc/20140620134835_DSC_0032.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000126','大溪高中田徑場','http://www.dssh.tyc.edu.tw','無停車場','VT001','室外設施',335,'桃園市大溪區康莊路641號','03-3878628#512',24.8685612858544,121.285538077354,'Y','Y','免費對外開放使用','17:30-18:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140605163535_P1080137.jpg','https://az804957.vo.msecnd.net/photofunc/20140605163535_P1080225.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000127','石門國中羽球場(館)','http://www.smjh.tyc.edu.tw','一般及無障礙停車場','VT005','室內設施',325,'桃園市龍潭區佳安村文化路137號','03-4713610#510',24.8411448589825,121.239758133888,'N','Y','不開放對外使用','8:0-17:0','Y','Y','Y','Y','Y','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140630155355_tn_IMG_0226.jpg','https://az804957.vo.msecnd.net/photofunc/20140630155355_tn_活動中心.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000128','大溪高中田徑場','http://www.dssh.tyc.edu.tw','無停車場','VT002','室外設施',335,'桃園市大溪區康莊路641號','03-3878628#512',24.8685612858544,121.285538077354,'Y','Y','免費對外開放使用','17:30-18:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140605163632_P1080137.jpg','https://az804957.vo.msecnd.net/photofunc/20140605163632_P1080225.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000129','楊心國小活動中心','http://www.yses.tyc.edu.tw','一般及無障礙停車場','VT001','室內設施',326,'桃園市楊梅區金華街100號','03-4758680',24.9121376004879,121.143987178802,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140627150226_P2240028.JPG','https://az804957.vo.msecnd.net/photofunc/20140627150226_DSC02825.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000130','楊心國小活動中心','http://www.yses.tyc.edu.tw','一般及無障礙停車場','VT005','室內設施',326,'桃園市楊梅區金華街100號','03-4758680',24.9121376004879,121.143987178802,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140627150429_P2240028.JPG','https://az804957.vo.msecnd.net/photofunc/20140627150429_DSC02826.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000131','新屋高中學生活動中心','http://www.swjh.tyc.edu.tw',null,'VT001','室內設施',327,'桃園市新屋區中興路111號','03-4772029#311',24.9705460974376,121.101720929146,'Y','Y','付費對外開放使用','8:0-17:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20180726110710_IMG_6059.JPG','https://az804957.vo.msecnd.net/photofunc/20180726110710_DSC_0969.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000132','宋屋國小籃球場','http://www.swes.tyc.edu.tw','無停車場','VT001','室外設施',324,'桃園市平鎮區延平路二段389號','03-4933654#511',24.9417733532364,121.206713318825,'N','Y','不開放對外使用','16:0-18:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140701135805_DSC00950.jpg','https://az804957.vo.msecnd.net/photofunc/20140701135805_DSC00987.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000133','圳頭國小籃球場','http://www.jtes.tyc.edu.tw','無停車場','VT001','室外設施',337,'桃園市大園區圳頭里4鄰圳頭路850巷30號','03-3862504',25.0724610206479,121.205098628998,'Y','Y','免費對外開放使用','6:30-18:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20180402145609_IMAG2676.jpg','https://az804957.vo.msecnd.net/photofunc/20180402145609_IMAG2677.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000134','八德國中活動中心','http://www.ptjh.tyc.edu.tw','無停車場','VT002','室內設施',334,'桃園市八德區興豐路321號','03-3685322#510',24.9294665270797,121.286702156067,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20170711103209_IMG_9384.JPG','https://az804957.vo.msecnd.net/photofunc/20170711103209_2017-01-02 16.39.53.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000135','龍星國小健身房(含重量訓練室)','http://www.lsps.tyc.edu.tw','無停車場','VT005','室內設施',325,'桃園市龍潭區中正路269號','03-4797299#311',24.8627548162825,121.217812299728,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20170831160028_DSC07438.JPG','https://az804957.vo.msecnd.net/photofunc/20170831160028_DSC00723.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000136','大園區籃網球場','http://www.dayuan.tycg.gov.tw/',null,'VT001','室外設施',337,'桃園市大園區中華路234巷17號','03-3861124',25.0694532981343,121.20374143123615,'Y','N','免費對外開放使用','0:0-0:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140623100225_C:\Documents and Settings\user\桌面\IMG_0303.JPG','https://az804957.vo.msecnd.net/photofunc/20140623100225_C:\Documents and Settings\user\桌面\IMG_0301.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000137','中興國中田徑場','http://www.chjhs.tyc.edu.tw','一般及無障礙停車場','VT001','室外設施',330,'桃園市桃園區文中路122號','03-3600145',24.9974889106201,121.290650367737,'Y','N','免費對外開放使用','17:0-19:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140611171117_20140610_161006.jpg','https://az804957.vo.msecnd.net/photofunc/20140611171117_20140611_165158.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000138','中興國中田徑場','http://www.chjhs.tyc.edu.tw','一般及無障礙停車場','VT002','室外設施',330,'桃園市桃園區文中路122號','03-3600145',24.9974889106201,121.290650367737,'Y','N','免費對外開放使用','17:0-19:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140611171257_20140610_161006.jpg','https://az804957.vo.msecnd.net/photofunc/20140611171257_20140611_165158.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000139','果林國小田徑場','http://www.kles.tyc.edu.tw','無停車場','VT001','室外設施',337,'桃園市大園區果林村12鄰崁下41號','03-3835096#310',25.0770089066396,121.256618499756,'Y','Y','免費對外開放使用','0:0-0:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140612213059_IMG_1354.JPG','https://az804957.vo.msecnd.net/photofunc/20140612213059_IMG_1355.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000140','八德國小活動中心','http://www.bdes.tyc.edu.tw',null,'VT005','室內設施',334,'桃園市八德區興仁里興豐路222號','03-3682943#511',24.9282601001173,121.282898783684,'Y','Y','付費對外開放使用','18:0-0:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140627095101_L:\DCIM\101MSDCF\DSC05893.JPG','https://az804957.vo.msecnd.net/photofunc/20140627095101_L:\DCIM\101MSDCF\DSC05894.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000141','巴崚國小籃球場','http://www.bles.tyc.edu.tw',null,'VT001','室外設施',336,'桃園市復興區華陵村九鄰75號','03-3912131#511',24.6853439393848,121.397359371185,'Y','Y','免費對外開放使用','16:30-18:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140616180429_IMAG3161.jpg','https://az804957.vo.msecnd.net/photofunc/20140616180429_IMAG3159.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000142','八德國小活動中心','http://www.bdes.tyc.edu.tw',null,'VT001','室外設施',334,'桃園市八德區興仁里興豐路222號','03-3682943#511',24.9282601001173,121.282898783684,'Y','Y','免費對外開放使用','18:0-19:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140626130101_L:\DCIM\101MSDCF\DSC05895.JPG','https://az804957.vo.msecnd.net/photofunc/20140626130101_L:\DCIM\101MSDCF\DSC05896.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000143','南門國小活動中心','http://www.nmes.tyc.edu.tw','一般及無障礙停車場','VT005','室內設施',330,'桃園市桃園區復興路303號','03-33705763#511',24.9886253232677,121.304396688938,'Y','Y','付費對外開放使用','17:0-20:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140611153441_桃園縣南門國小禮堂大樓正面照片.JPG','https://az804957.vo.msecnd.net/photofunc/20140611153441_桃園縣南門國小禮堂大樓背面照片.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000144','山腳國小田徑場','http://www.sajes.tyc.edu.tw','無障礙停車場','VT001','室外設施',338,'桃園市蘆竹區南山路三段440號','03-3241884',25.0886790974711,121.28835439682,'Y','N','免費對外開放使用','5:0-18:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140617112357_DSC_0208.jpg','https://az804957.vo.msecnd.net/photofunc/20140617112357_DSC_0209.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000146','田徑場內壢國中','http://www.nljh.tyc.edu.tw','一般及無障礙停車場','VT001','室外設施',320,'桃園市中壢區復華里復華一街108號','03-4522494',24.9718445058816,121.249886155128,'Y','Y','免費對外開放使用','8:0-18:0','Y','Y','Y','Y','Y','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140623121845_IMG_0823.jpg','https://az804957.vo.msecnd.net/photofunc/20140623121845_IMG_0813.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000147','百吉國小風雨教室','http://www.pces.tyc.edu.tw','無停車場','VT005','室內設施',335,'桃園市大溪區復興里3鄰環湖路二段845號','03-3883956#510',24.8233823920621,121.310498714447,'Y','Y','免費對外開放使用','16:0-18:0','Y','Y','Y','Y','Y','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140616153158_圖片2.jpg','https://az804957.vo.msecnd.net/photofunc/20140616153158_圖片1.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000148','南勢國小運動場','http://www.nsps.tyc.edu.tw',null,'VT001','室外設施',324,'桃園市平鎮區中豐路南勢二段223號','03-4393724#313',24.913587446805,121.211305260658,'Y','Y','免費對外開放使用','16:0-18:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140609105922_IMAG0121.jpg','https://az804957.vo.msecnd.net/photofunc/20140609105922_IMAG0545.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000149','大坡國中遊藝館（風雨教室）','http://www.dpjhs.tyc.edu.tw','無停車場','VT005','室內設施',327,'桃園市新屋區大坡村五鄰156號','03-4768350#311',24.9572572908475,121.041569709778,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140619140343_DSC03974.JPG','https://az804957.vo.msecnd.net/photofunc/20140619140343_DSC03995.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000150','光華國小籃球場','http://www.khes.tyc.edu.tw',null,'VT001','室外設施',336,'桃園市復興區華陵村四鄰12號','03-3912325',24.6552738679946,121.399633213878,'Y','N','免費對外開放使用','7:0-18:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140617201142_nEO_IMG_PAN_1080.jpg','https://az804957.vo.msecnd.net/photofunc/20140617201142_DSCN2763.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000151','中興國中羽球場(館)','http://www.chjhs.tyc.edu.tw','一般及無障礙停車場','VT005','室內設施',330,'桃園市桃園區文中路122號','03-3600145',24.9969881325414,121.29042506218,'Y','Y','付費對外開放使用','7:0-21:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140612135056_20140611_160411.jpg','https://az804957.vo.msecnd.net/photofunc/20140612135056_20140611_161450.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000152','第二運動公園籃球場 ','http://192.168.100.30/Home.aspx','無停車場','VT001','室外設施',333,'桃園市龜山區文東五街','03-3203711#316',25.0497093380178,121.365473270416,'Y','Y','免費對外開放使用','0:0-0:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20141028141855_1.jpg','https://az804957.vo.msecnd.net/photofunc/20141028141855_2.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000153','開南大學永裕體育館','http://physical.knu.edu.tw/bin/home.php',null,'VT001','室內設施',338,'桃園市蘆竹區開南路1號','03-3412500#2503',25.0118841921925,121.268784999847,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140715080801_永裕體育館.gif','https://az804957.vo.msecnd.net/photofunc/20140715080801_體育館.gif','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000154','武陵高中活動中心','http://www.wlsh.tyc.edu.tw',null,'VT005','室內設施',330,'桃園市桃園區中山路889號','03-3698170#340',24.9876641411233,121.285698071106,'Y','Y','付費對外開放使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140604113006_222 001.JPG','https://az804957.vo.msecnd.net/photofunc/20140604113006_33 001.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000155','南崁國小籃球場','http://www.nkes.tyc.edu.tw',null,'VT001','室外設施',338,'桃園市蘆竹區羊稠村吉林路160號','03-3115578#512',25.0507639198654,121.300826668739,'Y','Y','免費對外開放使用','6:0-18:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140620091647_01.jpg','https://az804957.vo.msecnd.net/photofunc/20140620091647_02.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000156','楊梅國小活動中心','http://www.ymes.tyc.edu.tw',null,'VT005','室內設施',326,'桃園市楊梅區校前路1號','03-4782016',24.90600718947726,121.14466309547424,'Y','Y','付費對外開放使用','18:0-22:0','Y','Y','Y','Y','Y','Y','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140616144935_羽球隊3.JPG','https://az804957.vo.msecnd.net/photofunc/20140616144935_羽球3.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000157','新明國小環形/直線慢跑道(非田徑場型)','http://www.simps.tyc.edu.tw',null,'VT001','室外設施',320,'桃園市中壢區中央西路二段97號','03-4933262#317',24.9589230296091,121.215848922729,'Y','Y','免費對外開放使用','6:0-18:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140616130905_IMG_0238.JPG','https://az804957.vo.msecnd.net/photofunc/20140616130905_IMG_0239.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000158','富林國小活動中心','http://www.fles.tyc.edu.tw',null,'VT005','室內設施',328,'桃園市觀音區富林村五鄰8號之2','03-4839049#33',25.0367525089955,121.120817922056,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140625141633_DSC01471.JPG','https://az804957.vo.msecnd.net/photofunc/20140625141633_DSC01475.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000159','健行科技大學體育館','http://www.uch.edu.tw','一般及無障礙停車場','VT001','室內設施',320,'桃園市中壢區健行路229號','03-4581196#3531',24.947576106065,121.231357455254,'Y','Y','免費對外開放使用','17:0-18:30','Y','Y','Y','Y','Y','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140616120208_IMAG0752.jpg','https://az804957.vo.msecnd.net/photofunc/20140616120208_體育館.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000160','宋屋國小活動中心禮堂','http://www.swes.tyc.edu.tw',null,'VT005','室內設施',324,'桃園市平鎮區延平路二段389號','03-4933654#315',24.9421624818423,121.206579208374,'Y','Y','付費對外開放使用','19:0-21:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140701135028_DSC00977.jpg','https://az804957.vo.msecnd.net/photofunc/20140701135028_DSC00978.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000161','新明國中活動中心','http://www.hmjh.tyc.edu.tw',null,'VT001','室外設施',320,'桃園市中壢區中正路487巷18號','03-4936194',24.9564912866254,121.212522983551,'Y','Y','免費對外開放使用','17:0-19:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140611112435_H:\呂理昌資料庫\體育行政\場地照片\籃球場空趙.JPG','https://az804957.vo.msecnd.net/photofunc/20140611112435_H:\呂理昌資料庫\體育行政\場地照片\籃球場.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000162','樹林國小田徑場','http://www.sles.tyc.edu.tw',null,'VT001','室外設施',328,'桃園市觀音區樹林村新村路二段12號','03-4830414#31',25.0614987552013,121.127786636353,'Y','Y','免費對外開放使用','17:30-19:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20161003172607_籃球場.jpg','https://az804957.vo.msecnd.net/photofunc/20161003172607_籃球場.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000163','內壢高中體育館','http://www.nlhs.tyc.edu.tw','一般及無障礙停車場','VT002','室內設施',320,'桃園市中壢區成章四街120號','03-4528080#233',24.9768872581494,121.25658094883,'Y','Y','付費對外開放使用','8:0-21:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140606133958_IMG_0555.jpg','https://az804957.vo.msecnd.net/photofunc/20140606133958_排球比賽 (2).jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000164','內壢高中體育館','http://www.nlhs.tyc.edu.tw','一般及無障礙停車場','VT001','室內設施',320,'桃園市中壢區成章四街120號','03-4528080#233',24.9768872581494,121.25658094883,'Y','Y','付費對外開放使用','8:0-21:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140604144154_IMG_0555.jpg','https://az804957.vo.msecnd.net/photofunc/20140604144154_IMG_0551.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000165','內壢高中體育館','http://www.nlhs.tyc.edu.tw','一般及無障礙停車場','VT005','室內設施',320,'桃園市中壢區成章四街120號','03-4528080#233',24.9768872581494,121.25658094883,'Y','Y','付費對外開放使用','8:0-21:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140606140243_IMG_0551.jpg','https://az804957.vo.msecnd.net/photofunc/20140606140243_羽球比賽.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000166','大竹國小活動中心','http://www.dces.tyc.edu.tw','無停車場','VT005','室內設施',338,'桃園市蘆竹區大竹路556號','03-3232917',25.0245035913633,121.258807182312,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140630122345_01.jpg','https://az804957.vo.msecnd.net/photofunc/20140630122345_20140609085415_CIMG5053.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000167','瑞祥國小田徑場','http://www.rhes.tyc.edu.tw','一般及無障礙停車場','VT001','室外設施',335,'桃園市大溪區石園路760巷120號','03-3801197',24.868038082048,121.252959296107,'Y','Y','免費對外開放使用','7:30-17:30','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140626152536_P1060141.jpg','https://az804957.vo.msecnd.net/photofunc/20140626152536_P1060148.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000168','建國國中活動中心','http://www.ckjhs.tyc.edu.tw','無停車場','VT001','室內設施',330,'桃園市桃園區介新街20號','03-3630081#340',24.9773249028882,121.306529045105,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140619163517_DSC03187(1).jpg','https://az804957.vo.msecnd.net/photofunc/20140619163517_DSC03189(1).jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000169','龍源國小活動中心','http://www.lyes.tyc.edu.tw',null,'VT005','室內設施',325,'桃園市龍潭區高平村深窩子16之1號','03-4717149#510',24.8265567954191,121.212195754051,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140610093440_P1090858_resize.JPG','https://az804957.vo.msecnd.net/photofunc/20140610093440_P1130174_resize.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000170','祥安國小活動中心','http://www.saes.tyc.edu.tw',null,'VT005','室內設施',324,'桃園市平鎮區湧安路45號','03-4192136#510',24.8933013485268,121.202845573425,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140627142303_IMG548.jpg','https://az804957.vo.msecnd.net/photofunc/20140627142303_IMG549.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000171','祥安國小活動中心','http://www.saes.tyc.edu.tw',null,'VT001','室內設施',324,'桃園市平鎮區湧安路45號','03-4192136#510',24.8933013485268,121.202845573425,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140627141823_IMG548.jpg','https://az804957.vo.msecnd.net/photofunc/20140627141823_IMG549.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000172','興南國中活動中心','http://163.30.149.133','無停車場','VT005','室內設施',320,'桃園市中壢區育英路55號','03-4629991#310',24.9738931823836,121.226732023592,'Y','Y','付費對外開放使用','7:30-21:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20180316131041_12974283_1192572774087839_3154321343374428252_n.jpg','https://az804957.vo.msecnd.net/photofunc/20180316131041_12919724_1192572744087842_1723866327906675343_n.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000173','興南國中活動中心','http://163.30.149.133','無停車場','VT001','室內設施',320,'桃園市中壢區育英路55號','03-4629991#310',24.9738931823836,121.226732023592,'Y','Y','付費對外開放使用','7:30-21:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140610083419_IMG_9594.JPG','https://az804957.vo.msecnd.net/photofunc/20140610083419_IMG_9597.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000174','龜山國小中正堂','http://www.kses.tyc.edu.tw',null,'VT001','室內設施',333,'桃園市龜山區萬壽路二段933巷14號','03-3203571',24.9941633170024,121.339799165726,'Y','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140610121250_IMG_0691.JPG','https://az804957.vo.msecnd.net/photofunc/20140610121250_IMG_0692.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000175','華勛國小活動中心','http://www.hses.tyc.edu.tw','無停車場','VT005','室內設施',320,'桃園市中壢區榮民南路205號','03-4661587#311',24.9534709949658,121.258364617825,'Y','Y','不開放對外使用','16:0-0:0','Y','Y','Y','Y','Y','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140609160225_C:\Users\user\Google 雲端硬碟\活動中心室內.jpg','https://az804957.vo.msecnd.net/photofunc/20140609160225_C:\Users\user\Google 雲端硬碟\羽球場.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000177','青溪國小運動中心','http://www.csps.tyc.edu.tw',null,'VT005','室內設施',330,'桃園市桃園區自強路80號','03-3347883#511',24.999963599514,121.318330764771,'N','Y','不開放對外使用','8:0-16:0','Y','Y','Y','Y','Y','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140616132550_IMG_7425.JPG','https://az804957.vo.msecnd.net/photofunc/20140616132550_IMG_7427.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000178','大成國中活動中心','http://www.tcjhs.tyc.edu.tw','一般及無障礙停車場','VT001','室內設施',334,'桃園市八德區大勇村忠勇街12號','(03)3625633',24.958388050274,121.306121349335,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140611194656_活動中心.JPG','https://az804957.vo.msecnd.net/photofunc/20140611194656_室內球場.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000179','龍岡森林公園籃球場','http://www.junglicity.gov.tw/','一般及無障礙停車場','VT001','室外設施',320,' 桃園市中壢區龍岡路三段 龍岡路262巷 交叉口','03-4271801#4105',24.9325749679516,121.235230565071,'Y','Y','免費對外開放使用','8:0-22:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140701173226_570_6.jpg','https://az804957.vo.msecnd.net/photofunc/20140701173226_570_2.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000180','楊梅高中活動中心','http://www.ymhs.tyc.edu.tw',null,'VT001','室外設施',326,'桃園市楊梅區高獅路5號','03-4789618',24.9215467021952,121.148943901062,'Y','Y','免費對外開放使用','8:0-17:0','Y','Y','Y','Y','Y','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140617161801_IMG_0606.JPG','https://az804957.vo.msecnd.net/photofunc/20140617161801_IMG_0607.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000181','楊梅高中活動中心','http://www.ymhs.tyc.edu.tw',null,'VT005','室內設施',326,'桃園市楊梅區高獅路5號','03-4789618',24.9215467021952,121.148943901062,'Y','Y','免費對外開放使用','8:0-17:0','Y','Y','Y','Y','Y','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140617161907_IMG_0606.JPG','https://az804957.vo.msecnd.net/photofunc/20140617161907_IMG_0607.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000182','龍岡國小環形/直線慢跑道(非田徑場型)','http://www.lges.tyc.edu.tw','無停車場','VT001','室外設施',320,'桃園市中壢區龍岡路二段232號','03-4588582#513',24.9420068305474,121.229313611984,'Y','Y','免費對外開放使用','17:0-18:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140618082719_1.JPG','https://az804957.vo.msecnd.net/photofunc/20140618082719_2.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000183','大有國小活動中心','http://www.dyes.tyc.edu.tw',null,'VT001','室內設施',330,'桃園市桃園區大有路220號','03-3577715#311',25.0090791649648,121.321222186089,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140623144028_活動中心2.jpg','https://az804957.vo.msecnd.net/photofunc/20140623144028_活動中心1.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000184','龜山國小田徑場','http://www.kses.tyc.edu.tw',null,'VT004','室外設施',333,'桃園市龜山區萬壽路二段933巷14號','03-3203571#312',24.9940369037738,121.340241730213,'N','Y','不開放對外使用','18:0-19:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20160930164811_IMG_2528.JPG','https://az804957.vo.msecnd.net/photofunc/20160930164811_IMG_2530.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000185','龍岡萬坪公園籃球場','http://www.junglicity.gov.tw/',null,'VT001','室外設施',320,'桃園市中壢區龍岡里 龍門街 龍昌路 交叉口','03-4271801#4105',24.9293813965321,121.245157420635,'Y','Y','免費對外開放使用','8:0-22:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140701171802_564_8.jpg','https://az804957.vo.msecnd.net/photofunc/20140701171802_564_1.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000186','振聲高中振聲堂','http://www.fxsh.tyc.edu.tw','無停車場','VT001','室內設施',330,'桃園市桃園區復興路439號','03-3322605',24.9901763756397,121.301116347313,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140619143055_53879.jpg','https://az804957.vo.msecnd.net/photofunc/20140619143055_53794.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000187','大成國小活動中心','http://www.dches.tyc.edu.tw',null,'VT002','室內設施',334,'桃園市八德區廣福路31號','03-3661155#313',24.9576585292522,121.297999620438,'N','Y','不開放對外使用','0:0-0:0','Y','Y','Y','Y','Y','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140617093955_IMG_1379.JPG','https://az804957.vo.msecnd.net/photofunc/20140617093955_IMG_1269.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000188','快樂國小活力館','http://www.happy.tyc.edu.tw','一般及無障礙停車場','VT005','室內設施',330,'桃園市桃園區大有路789號','03-3580001',25.0190204370647,121.315431296825,'Y','Y','付費對外開放使用','8:0-21:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140627142208_20140620135024_IMG_3205.jpg','https://az804957.vo.msecnd.net/photofunc/20140627142208_IMG_2669.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000189','振聲高中振聲堂','http://www.fxsh.tyc.edu.tw','無停車場','VT005','室內設施',330,'桃園市桃園區復興路439號','03-3322605',24.9901763756397,121.301116347313,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140619143151_53879.jpg','https://az804957.vo.msecnd.net/photofunc/20140619143151_53886.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000190','陽明高中知行樓','http://www.pymhs.tyc.edu.tw',null,'VT001','室內設施',330,'桃園市桃園區德壽街8號','03-3672706#512',24.9808454550257,121.303203105927,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140703101200_P1200066.jpg','https://az804957.vo.msecnd.net/photofunc/20140703101200_DSC00875.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000191','凌雲國中活動中心','http://www.lyjh.tyc.edu.tw','無停車場','VT001','室內設施',325,'桃園市龍潭區中豐路上林段418號','03-4792604',24.8590800026874,121.201874613762,'N','Y','不開放對外使用','8:0-20:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140630145631_1021211015.jpg','https://az804957.vo.msecnd.net/photofunc/20140630145631_1021211017.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000192','有得國民中小學活動中心','http://www.yoder.tyc.edu.tw','無停車場','VT005','室內設施',320,'桃園市中壢區內壢長春一路288號','(03)4522789#311',24.9805054627508,121.251282404701,'N','Y','不開放對外使用','8:0-13:0','Y','Y','Y','Y','Y','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140718165020_DSCF1553 (800x600).jpg','https://az804957.vo.msecnd.net/photofunc/20140718165020_DSCF1530 (800x600).jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000193','大溪國小操場','http://www.dsps.tyc.edu.tw','無停車場','VT001','室外設施',335,'桃園市大溪區登龍路19號','03-3882040#511',24.884511855011,121.286157667637,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140616101819_籃球場1.JPG','https://az804957.vo.msecnd.net/photofunc/20140616101819_籃球場3.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000194','治平高中德光堂','http://web.cpshs.tyc.edu.tw','無停車場','VT005','室內設施',326,'桃園市楊梅區埔心中興路137號','03-4823636',24.9154982501087,121.188038438559,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140714104556_CIMG1293.JPG','https://az804957.vo.msecnd.net/photofunc/20140714104556_CIMG1294.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000195','中平國小田徑場','http://www.cpes.tyc.edu.tw','無停車場','VT001','室外設施',320,'桃園市中壢區過嶺里一鄰雙福路12號','03-4902025#510',24.9601097027449,121.177740097046,'Y','Y','免費對外開放使用','6:0-7:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140609103814_IMG_2954.jpg','https://az804957.vo.msecnd.net/photofunc/20140609103814_IMG_2956.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000196','龍岡國小龍騰館','http://www.lges.tyc.edu.tw',null,'VT005','室內設施',320,'桃園市中壢區龍岡路二段232號','03-4588582#512',24.9420360151802,121.229581832886,'N','Y','不開放對外使用','7:0-18:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140616095415_DSC08525.JPG','https://az804957.vo.msecnd.net/photofunc/20140616095415_DSC08528.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000197','萬能科技大學體育館','http://www.vnu.edu.tw/','一般及無障礙停車場','VT001','室內設施',320,'桃園市中壢區萬能路1號','03-4515811#22401',24.9916799489907,121.230880721414,'N','Y','不開放對外使用','12:0-13:0','Y','N','N','N','Y','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140807155451_室內籃球1 (Large).JPG','https://az804957.vo.msecnd.net/photofunc/20140807155451_室內籃球2 (Large).JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000198','治平高中德光堂','http://web.cpshs.tyc.edu.tw','無停車場','VT001','室內設施',326,'桃園市楊梅區埔心中興路137號','03-4823636',24.9154982501087,121.188038438559,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140714104500_CIMG1293.JPG','https://az804957.vo.msecnd.net/photofunc/20140714104500_CIMG1294.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000199','快樂國小活力館','http://www.happy.tyc.edu.tw','一般及無障礙停車場','VT002','室內設施',330,'桃園市桃園區大有路789號','03-3580001',25.0190204370647,121.315431296825,'Y','Y','付費對外開放使用','8:0-21:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140701082848_IMG_3204.jpg','https://az804957.vo.msecnd.net/photofunc/20140701082848_IMG_3205.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000200','快樂國小活力館','http://www.happy.tyc.edu.tw','一般及無障礙停車場','VT001','室內設施',330,'桃園市桃園區大有路789號','03-3580001',25.0190204370647,121.315431296825,'Y','Y','付費對外開放使用','8:0-21:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140701082528_IMG_3182.jpg','https://az804957.vo.msecnd.net/photofunc/20140701082528_IMG_3175.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000201','萬能科技大學體育館','http://www.vnu.edu.tw/','一般及無障礙停車場','VT005','室內設施',320,'桃園市中壢區萬能路1號','03-4515811#22401',24.9916799489907,121.230880721414,'N','Y','不開放對外使用','12:0-13:0','N','Y','Y','Y','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140807155118_DSC_0987 (Large).JPG','https://az804957.vo.msecnd.net/photofunc/20140807155118_DSC_0005 (Large).JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000202','富台國小操場','http://www.ftes.tyc.edu.tw/indexc.htm','無停車場','VT001','室外設施',320,'桃園市中壢區中山東路三段369號','03-4563335',24.9402460115786,121.252284049988,'Y','Y','免費對外開放使用','17:0-19:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20170724101632_DSC_2363.JPG','https://az804957.vo.msecnd.net/photofunc/20170724101632_DSC_2364.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000203','八德區青少年活動中心','http://sung1217@yahoo.com.tw',null,'VT005','室內設施',334,'桃園市八德區興豐路2207號','03-2180252',24.9533639945466,121.325406432152,'Y','Y','免費對外開放使用','13:0-21:0','N','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140619091923_C:\Documents and Settings\user\桌面\201209012227266162.jpg','https://az804957.vo.msecnd.net/photofunc/20140619091923_C:\Documents and Settings\user\桌面\201209012228552596.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000204','光啟高中田徑場','http://www.phsh.tyc.edu.tw',null,'VT005','室外設施',333,'桃園市龜山區自由街40號','02-82098313#501',25.0201627810747,121.402986645699,'Y','Y','付費對外開放使用','17:0-18:30','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140604084527_IMG_0863.jpg','https://az804957.vo.msecnd.net/photofunc/20140604084527_調整大小 P1030521.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000205','光啟高中田徑場','http://www.phsh.tyc.edu.tw',null,'VT002','室外設施',333,'桃園市龜山區自由街40號','02-82098313#501',25.0201627810747,121.402986645699,'Y','Y','付費對外開放使用','17:0-18:30','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140604084829_IMG_0863.jpg','https://az804957.vo.msecnd.net/photofunc/20140604084829_IMG_4187.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000206','華勛公園籃球場','http://www.junglicity.gov.tw/','無停車場','VT001','室外設施',320,' 桃園市中壢區華勛街363巷','03-4271801#4105',24.9465011825405,121.262412071228,'Y','Y','免費對外開放使用','0:0-0:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140620134602_432_6.jpg','https://az804957.vo.msecnd.net/photofunc/20140620134602_432_4.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000207','八德區青少年活動中心','http://sung1217@yahoo.com.tw',null,'VT001','室外設施',334,'桃園市八德區興豐路2207號','03-2180252',24.9533639945466,121.325406432152,'Y','Y','免費對外開放使用','13:0-21:0','N','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140619092214_C:\Documents and Settings\user\桌面\8193.jpg','https://az804957.vo.msecnd.net/photofunc/20140619092214_C:\Documents and Settings\user\桌面\8194.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000208','光啟高中田徑場','http://www.phsh.tyc.edu.tw',null,'VT001','室外設施',333,'桃園市龜山區自由街40號','02-82098313#501',25.0201627810747,121.402986645699,'Y','Y','付費對外開放使用','17:0-18:30','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140604083927_IMG_0863.jpg','https://az804957.vo.msecnd.net/photofunc/20140604083927_IMG_1556.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000209','桃園市立仁和國民中學田徑場','http://www.jhjhs.tyc.edu.tw',null,'VT001','室外設施',335,'桃園市大溪區仁和里仁和七街55號','03-3906626#512',24.8944279097862,121.274661719799,'Y','N','免費對外開放使用','6:0-18:30','N','N','N','N','N','N','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20160511101136_P5110091.JPG','https://az804957.vo.msecnd.net/photofunc/20160511101136_P5110088.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000210','武漢國小體操館','http://www.whps.tyc.edu.tw','無停車場','VT005','室內設施',325,'桃園市龍潭區武漢路100號','03-4792873',24.8700238112587,121.233862638474,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20180316103148_IMG_2790.JPG','https://az804957.vo.msecnd.net/photofunc/20180316103148_IMG_2790.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000211','大安國小田徑場','http://www.daes.tyc.edu.tw','無停車場','VT001','室外設施',334,'桃園市八德區大安里和平路638號','03-3661419',24.9558274124445,121.315270364285,'Y','Y','免費對外開放使用','17:30-19:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140618091907_IMAG0001.jpg','https://az804957.vo.msecnd.net/photofunc/20140618091907_IMAG0005.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000212','田徑場附設籃球場等','http://www.dches.tyc.edu.tw','一般及無障礙停車場','VT001','室外設施',334,'桃園市八德區廣福路31號','03-3661155#313',24.958145257039,121.298179076985,'Y','N','免費對外開放使用','17:0-19:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20180316135012_籃球場_180316_0001.jpg','https://az804957.vo.msecnd.net/photofunc/20180316135012_籃球場_180316_0002.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000213','楊梅國中籃球場','http://www.ymjhs.tyc.edu.tw','無停車場','VT001','室內設施',326,'桃園市楊梅區校前路149號','03-4782024#311',24.9049045589098,121.147408604884,'N','Y','不開放對外使用','8:0-16:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140617160937_DSC03637.JPG','https://az804957.vo.msecnd.net/photofunc/20140617160937_DSC03636.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000214','籃球場(半場)','http://www.kses.tyc.edu.tw','無停車場','VT001','室外設施',333,'桃園市龜山區萬壽路二段933巷14號','03-3203571#311',24.9940758001656,121.340955197811,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20170411110200_IMG_9246.JPG','https://az804957.vo.msecnd.net/photofunc/20170411110200_IMG_9251.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000215','信義國小半場籃球場','http://www.hyes.tyc.edu.tw','無停車場','VT001','室外設施',320,'桃園市中壢區信義里成都路55號','03-4573780',24.9509175505048,121.232709288597,'Y','Y','免費對外開放使用','18:0-22:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140619200715_6.jpg','https://az804957.vo.msecnd.net/photofunc/20140619200715_5.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000216','平鎮國中羽球場(館)','http://home.pjjh.tyc.edu.tw','一般及無障礙停車場','VT005','室內設施',324,'桃園市平鎮區新富里振興路2號','03-4572150#328',24.9446931659889,121.217747926712,'Y','Y','付費對外開放使用','17:0-18:30','Y','N','N','Y','Y','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140616112134_羽球場照片 003.jpg','https://az804957.vo.msecnd.net/photofunc/20140616112134_羽球場照片 005.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000217','觀音國中籃球場','http://www.gijh.tyc.edu.tw',null,'VT001','室外設施',328,'桃園市觀音區白玉村下庄子53之1號','03-4732034#511',25.0400864671428,121.080086231232,'Y','Y','免費對外開放使用','0:0-0:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140619080937_IMG_0744.jpg','https://az804957.vo.msecnd.net/photofunc/20140619080937_IMG_0746.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000218','內海國小田徑場','http://163.30.68.5/xoops/',null,'VT001','室外設施',337,'桃園市大園區內海村一鄰18之1號','(03)3862844',25.0864977017234,121.19147837162,'Y','Y','免費對外開放使用','8:0-18:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140611103625_C:\Documents and Settings\Administrator\桌面\163___09\IMG_2112.JPG','https://az804957.vo.msecnd.net/photofunc/20140611103625_C:\Documents and Settings\Administrator\桌面\163___09\IMG_2115.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000219','自強國小活動中心','http://www.zqes.tyc.edu.tw',null,'VT001','室內設施',333,'桃園市龜山區自強東路269號','03-3590758#511',24.9972798481752,121.345303058624,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140612154428_20140612_152317[1].jpg','https://az804957.vo.msecnd.net/photofunc/20140612154428_20140612_152421[1].jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000220','瑞埔國小活動中心','http://www.rpes.tyc.edu.tw',null,'VT005','室內設施',326,'桃園市楊梅區埔心里中興路133號','03-4822018',24.9165746603231,121.186419725418,'Y','Y','付費對外開放使用','0:0-0:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140628175020_DSC06733.JPG','https://az804957.vo.msecnd.net/photofunc/20140628175020_DSC06736.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000221','新街國小羽球場(館)','http://www.sjes.tyc.edu.tw','一般及無障礙停車場','VT005','室內設施',320,'桃園市中壢區新街里延平路176號','03-4523202',24.9629985231286,121.227999329567,'Y','Y','付費對外開放使用','8:0-21:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140630150303_20140630_143351.jpg','https://az804957.vo.msecnd.net/photofunc/20140630150303_20140630_143402.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000222','南崁高中活動中心','http://www.nkjh.tyc.edu.tw',null,'VT005','室內設施',338,'桃園市蘆竹區五福村仁愛路2段1號','03-3525580#303',25.0532715527086,121.297023296356,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140611085813_DSC01493.JPG','https://az804957.vo.msecnd.net/photofunc/20140611085813_DSC01497.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000223','綜合性球類場地','http://163.30.174.141/GTHs/gths/','一般及無障礙停車場','VT001','室內設施',328,'桃園市觀音區新坡村中山路2段519號','03-4981464#315',25.0163857137543,121.136283874512,'N','Y','不開放對外使用','8:0-16:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20180421164312_70211.jpg','https://az804957.vo.msecnd.net/photofunc/20180421164312_72032.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000224','沙崙國小籃球場','http://www.sales.tyc.edu.tw','一般及無障礙停車場','VT001','室外設施',337,'桃園市大園區沙崙村九鄰75號之2','03-3835072#510',25.0927405681366,121.221846342087,'Y','Y','免費對外開放使用','17:0-7:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140610095347_IMG20160505093335.jpg','https://az804957.vo.msecnd.net/photofunc/20140610095347_IMG20160504130424.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000225','潮音國小籃球場(田徑場)','http://www.cies.tyc.edu.tw',null,'VT001','室外設施',337,'桃園市大園區南港里潮音路一段188號','03-3862834',25.0652695742122,121.172590255737,'Y','Y','免費對外開放使用','16:0-18:30','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140627145453_CIMG9478.JPG','https://az804957.vo.msecnd.net/photofunc/20140627145453_CIMG9477.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000226','新屋國中活動中心','http://www.swjh.tyc.edu.tw','一般及無障礙停車場','VT001','室內設施',327,'桃園市新屋區中興路111號','03-4772029#311',24.9711977348489,121.101323962212,'Y','Y','付費對外開放使用','8:0-17:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140701093953_DSC_3264_調整大小.JPG','https://az804957.vo.msecnd.net/photofunc/20140701093953_DSC_3265.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000227','東興國民中學籃球場','http://www.dsjhs.tyc.edu.tw','無停車場','VT001','室外設施',320,'桃園市中壢區廣州路25號','03-4583500#315',24.9504603567649,121.228873729706,'Y','Y','付費對外開放使用','8:0-21:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140613143732_籃球場1.jpg','https://az804957.vo.msecnd.net/photofunc/20140613143732_籃球場2.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000228','祥安國小操場','http://www.saes.tyc.edu.tw','無停車場','VT001','室外設施',324,'桃園市平鎮區湧安路45號','03-4192136#510',24.8937910320924,121.202673912048,'Y','Y','免費對外開放使用','17:0-19:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140627140946_IMG546.jpg','https://az804957.vo.msecnd.net/photofunc/20140627140946_IMG547.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000229','桃園農工風雨操場(館)','http://www.tyai.tyc.edu.tw','無停車場','VT002','半室內設施(有頂蓋但外牆未密封)',330,'桃園市桃園區成功路二段144號','03-3333921#350',24.9916885113061,121.319929361343,'Y','Y','付費對外開放使用','8:0-17:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140717093041_IMG_20140716_134500.jpg','https://az804957.vo.msecnd.net/photofunc/20140717093041_IMG_20140716_134730.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000230','永安國小活動中心','http://www.yaes.tyc.edu.tw','一般及無障礙停車場','VT005','室內設施',327,'桃園市新屋區中山西路二段1320號','03-4862224#511',24.9878546520374,121.046805381775,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140612151546_IMG_20131025_145245.jpg','https://az804957.vo.msecnd.net/photofunc/20140612151546_IMG_20140612_144242.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000231','大成國中籃球場','http://www.tcjhs.tyc.edu.tw','無停車場','VT001','室外設施',334,'桃園市八德區大勇村忠勇街12號','(03)3625633',24.9590835229562,121.306400299072,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140611211849_DSC_9885.JPG','https://az804957.vo.msecnd.net/photofunc/20140611211849_DSC_9890.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000232','陳康國小籃球場','http://www.ckps.tyc.edu.tw',null,'VT001','室外設施',337,'桃園市大園區建國八村151號','03-3811092#510',25.0603130613234,121.230381131172,'Y','Y','免費對外開放使用','16:0-21:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140627154039_2014-06-01.jpg','https://az804957.vo.msecnd.net/photofunc/20140627154039_2014-06-02.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000233','上大國小籃球場','http://www.stes.tyc.edu.tw',null,'VT001','室外設施',328,'桃園市觀音區上大村大湖路一段540號','03-4901174',24.9793234607358,121.147023439407,'Y','N','免費對外開放使用','8:0-17:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140616164719_P6120463.JPG','https://az804957.vo.msecnd.net/photofunc/20140616164719_P6120465.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000234','中壢國中活動中心','http://www.cljhs.tyc.edu.tw',null,'VT001','室內設施',324,'桃園市平鎮區延平路一段115號','03-4223214#313',24.9509272780128,121.218745708466,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140611145315_C360_2014-06-11-14-28-37-696.jpg','https://az804957.vo.msecnd.net/photofunc/20140611145315_DSC01509.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000235','幸福國小學生活動中心','http://www.hfps.tyc.edu.tw',null,'VT001','室內設施',333,'桃園市龜山區頂興路115巷20號','03-3194072',24.9892233802622,121.330298781395,'Y','Y','免費對外開放使用','8:0-21:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140630170237_WP_20140630_15_49_42_Pro.jpg','https://az804957.vo.msecnd.net/photofunc/20140630170237_WP_20140630_16_17_20_Pro.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000236','西門國小活動中心','http://www.simes.tyc.edu.tw',null,'VT005','室內設施',330,'桃園市桃園區莒光街15號','03-3342351#31',24.9950822400259,121.304093599319,'Y','Y','付費對外開放使用','0:0-0:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140702152917_s001.jpg','https://az804957.vo.msecnd.net/photofunc/20140702152917_s003.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000237','六和高中羽球場(館)','http://www.lioho.tw/tw/','無停車場','VT005','室內設施',324,'桃園市平鎮區陸光路180號','03-4204000',24.94534842607403,121.18589401245117,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140605103040_DSCN0018.jpg','https://az804957.vo.msecnd.net/photofunc/20140605103040_DSCN0019.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000238','體育大學羽球場(館)','http://www.ntsu.edu.tw',null,'VT005','室外設施',333,'桃園市龜山區文化一路250號','03-3283201#2204',25.0304725624149,121.387617588043,'Y','Y','付費對外開放使用','8:0-21:0','Y','Y','Y','Y','Y','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140715113422_IMG_9850.JPG','https://az804957.vo.msecnd.net/photofunc/20140715113422_IMG_9849.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000239','桃園市立平鎮高中體育館','http://www.pjhs.tyc.edu.tw','無停車場','VT005','室內設施',324,'桃園市平鎮區環南路三段100號','03-4287288#511',24.939662309129,121.219078302383,'N','Y','不開放對外使用','0:0-0:0','N','N','N','N','N','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140630150444_image003 (2).jpg','https://az804957.vo.msecnd.net/photofunc/20140630150444_image004.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000240','新屋區籃球場(新屋國小旁)','http://www.shinwu.gov.tw','無停車場','VT001','室外設施',327,'桃園市新屋區新屋國民小學對面','03-4772111#232',24.9733520041127,121.101806759834,'Y','N','免費對外開放使用','7:0-21:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140916151908_IMG_0407.jpg','https://az804957.vo.msecnd.net/photofunc/20140916151908_IMG_0406.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000241','大勇國小田徑場','http://www.typs.tyc.edu.tw',null,'VT004','室外設施',334,'桃園市八德區大勇里自強街60號','03-3622017#312',24.9681972563379,121.303879022598,'Y','Y','免費對外開放使用','5:0-7:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20170904093553_圓夢計劃 (1).JPG','https://az804957.vo.msecnd.net/photofunc/20170904093553_18221799_345920295805113_3400577522642631570_n.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000242','文化公園籃球場','http://www.junglicity.gov.tw/','無停車場','VT001','室外設施',320,'桃園市中壢區文化路438號 ','03-4271801#4113',24.9804047836961,121.249716505408,'Y','Y','免費對外開放使用','0:0-0:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140620111739_未命名.JPG','https://az804957.vo.msecnd.net/photofunc/20140620111739_395_2.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000243','新坡國小活動中心','http://www.spes.tyc.edu.tw',null,'VT005','室內設施',328,'桃園市觀音區新坡村中山路二段717號','03-4981534#511',25.0132404995364,121.137313842773,'N','Y','不開放對外使用','17:0-19:0','N','N','Y','N','Y','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140619154210_DSC02628.JPG','https://az804957.vo.msecnd.net/photofunc/20140619154210_DSC02482.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000244','桃園高中中山堂','http://www.tysh.tyc.edu.tw','一般及無障礙停車場','VT005','室內設施',330,'桃園市桃園區成功路三段38號','03-3946001#6024',24.9993083710131,121.327442603688,'Y','N','付費對外開放使用','8:0-22:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140530115026_DSCN0019.jpg','https://az804957.vo.msecnd.net/photofunc/20140530115026_DSCN0021.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000245','桃園高中中山堂','http://www.tysh.tyc.edu.tw','一般及無障礙停車場','VT001','室內設施',330,'桃園市桃園區成功路三段38號','03-3946001#6024',24.9993083710131,121.327442603688,'Y','Y','付費對外開放使用','8:0-22:0','N','N','N','N','N','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140530114624_DSCN0019.jpg','https://az804957.vo.msecnd.net/photofunc/20140530114624_DSCN0021.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000246','銘傳大學體育二館','http://www.mcu.edu.tw',null,'VT002','室內設施',333,'桃園市龜山區大同村德明路5號','03-3507001#3523',24.9880329278217,121.34169280529,'Y','Y','付費對外開放使用','8:0-22:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140611164325_圖片8.jpg','https://az804957.vo.msecnd.net/photofunc/20140611164325_圖片7.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000247','中山公園網球場','http://www.junglicity.gov.tw/','無停車場','VT003','室外設施',320,' 桃園市中壢區吉林北路5號','03-4271801#4113',24.9853955221037,121.251057609916,'Y','Y','免費對外開放使用','4:0-22:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140627095719_397_4.jpg','https://az804957.vo.msecnd.net/photofunc/20140627095719_網球場.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000248','銘傳大學體育二館','http://www.mcu.edu.tw',null,'VT001','室內設施',333,'桃園市龜山區大同村德明路5號','03-3507001#3523',24.9880329278217,121.34169280529,'Y','Y','付費對外開放使用','8:0-22:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140611144929_圖片7.jpg','https://az804957.vo.msecnd.net/photofunc/20140611144929_圖片8.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000249','成功國小活動中心','http://www.cges.tyc.edu.tw',null,'VT005','室內設施',330,'桃園市桃園區三民路三段22號','03-3322772#334',24.9982133335499,121.30714058876,'N','Y','不開放對外使用','7:0-21:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20140610120408_外面.jpg','https://az804957.vo.msecnd.net/photofunc/20140610120408_裡面.jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000250','仁愛籃球場','http://www.dashi.gov.tw/tw/',null,'VT001','室外設施',335,'  桃園市大溪區普濟路11號','03-3882201',24.9064548170972,121.279621124268,'Y','N','免費對外開放使用','0:0-0:0','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20141203194146_IMG_3751.JPG','https://az804957.vo.msecnd.net/photofunc/20141203194146_IMG_3752.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000251','光明國中活動中心','http://www.gmjh.tyc.edu.tw','無停車場','VT001','室內設施',338,'桃園市蘆竹區光明路一段123號','03-3114355#316',25.0448736967957,121.290239989758,'Y','Y','付費對外開放使用','18:30-21:30','Y','Y','Y','Y','Y','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140620082141_活動中心外觀照片.JPG','https://az804957.vo.msecnd.net/photofunc/20140620082141_活動中心內部照片.JPG','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000252','長庚大學籃球場','http://www.cgu.edu.tw','一般及無障礙停車場','VT001','室外設施',333,'桃園市龜山區文化一路259號','(03)2118800*2107',25.0330875413276,121.392141938341,'Y','Y','免費對外開放使用','8:30-21:30','Y','Y','Y','Y','Y','N','N',null,null,'https://az804957.vo.msecnd.net/photofunc/20140610163048_P6130661 (800x547).jpg','https://az804957.vo.msecnd.net/photofunc/20140610163048_P6130663 (800x440).jpg','顯示');
Insert into VENUE (V_NO,V_NAME,V_WEBURL,V_PARKTYPE,VT_NO,V_INOUT,REG_NO,V_ADDRESS,V_PHONENO,V_LAT,V_LONG,V_FITALL,V_FITINTER,OPEN_STATE,OPEN_TIME,OPENDAY_MON,OPENDAY_TUE,OPENDAY_WED,OPENDAY_THU,OPENDAY_FRI,OPENDAY_SAT,OPENDAY_SUN,V_PHOTO1_EXT,V_PHOTO2_EXT,V_PHOTO1_URL,V_PHOTO2_URL,V_DISPLAY) values ('V000253','笨港國小田徑場','http://www.bges.tyc.edu.tw',null,'VT001','室外設施',327,'桃園市新屋區笨港村二鄰文學路2號','03-4769113#510',24.9748800534528,121.026114821434,'Y','Y','免費對外開放使用','5:0-17:30','Y','Y','Y','Y','Y','Y','Y',null,null,'https://az804957.vo.msecnd.net/photofunc/20170703214913_P_20170705_140104.jpg','https://az804957.vo.msecnd.net/photofunc/20170703214913_P_20170705_140108.jpg','顯示');




------------07-INSERT--------------------
------------V_EVALUATION------------------------
---------------------------------20181210
Insert into V_EVALUATION values ('M001', 'V000001', 3);
Insert into V_EVALUATION values ('M002', 'V000002', 2);
Insert into V_EVALUATION values ('M003', 'V000003', 1);
Insert into V_EVALUATION values ('M004', 'V000004', 5);


------------08-INSERT--------------------
------------SG_INFO----------------------
---------------------------------20181210
insert into SG_INFO values('S' || LPAD(SG_INFO_SEQ.nextval, 3, 0), 'M001', '中央大學籃球魂不滅', to_timestamp('2019-02-25 10:00:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2018-12-20 00:00:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2019-02-23 00:00:00','yyyy-mm-dd hh24:mi:ss'),0,null,null,'公開','SP003','V000001',10,3,null,null,'歡迎歡迎熱烈歡迎',default,null,null);
insert into SG_INFO values('S' || LPAD(SG_INFO_SEQ.nextval, 3, 0), 'M002', '熱血雙城計畫', to_timestamp('2019-02-20 21:30:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2018-12-8 00:00:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2019-02-17 00:00:00','yyyy-mm-dd hh24:mi:ss'),100,null,null,'公開','SP007',null,8,5,4,null,'一起來騎卡打掐',default,'{"lat":25.0478142,"lng":121.51694880000002}','{"lat":22.639146,"lng":120.302201}');
insert into SG_INFO values('S' || LPAD(SG_INFO_SEQ.nextval, 3, 0), 'M001', '台北直直跑', to_timestamp('2019-02-07 17:30:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2018-11-30 00:00:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2019-02-04 00:00:00','yyyy-mm-dd hh24:mi:ss'),null,null,null,'公開','SP006',null,5,3,5,null,'跑起來',default,'{"lat":24.968264,"lng":121.192198}','{"lat":24.959995,"lng":121.215186}');
insert into SG_INFO values('S' || LPAD(SG_INFO_SEQ.nextval, 3, 0), 'M001', '打排球', to_timestamp('2018-11-30 18:30:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2018-11-20 00:00:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2018-11-27 00:00:00','yyyy-mm-dd hh24:mi:ss'),null,null,null,'限社團','SP002','V000009',20,12,5,null,null,'流團',null,null);
insert into SG_INFO values('S' || LPAD(SG_INFO_SEQ.nextval, 3, 0), 'M002', '跳樓大拍賣', to_timestamp('2019-12-30 18:30:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2018-12-20 00:00:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2019-12-27 00:00:00','yyyy-mm-dd hh24:mi:ss'),null,null,null,'公開','SP004','V000012',99,3,1,null,'便宜進口包包熱賣中',default,null,null);--notice the max of SG_MAXNO is 99; 

insert into SG_INFO values('S' || LPAD(SG_INFO_SEQ.nextval, 3, 0), 'M001', '籃球火', to_timestamp('2019-01-30 10:00:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2018-12-20 00:00:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2019-01-27 00:00:00','yyyy-mm-dd hh24:mi:ss'),100,null,null,'公開','SP003','V000006',10,3,1,null,'歡迎歡迎熱烈歡迎',default,null,null);
insert into SG_INFO values('S' || LPAD(SG_INFO_SEQ.nextval, 3, 0), 'M001', '晨間老人羽球', to_timestamp('2019-02-15 08:00:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2018-12-5 00:00:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2019-02-12 00:00:00','yyyy-mm-dd hh24:mi:ss'),100,null,null,'限社團','SP005','V000002',4,2,2,null,'來打羽球吧',default,null,null);
insert into SG_INFO values('S' || LPAD(SG_INFO_SEQ.nextval, 3, 0), 'M006', '跑跑跑向前跑', to_timestamp('2019-02-20 21:30:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2018-12-8 00:00:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2019-02-17 00:00:00','yyyy-mm-dd hh24:mi:ss'),100,null,null,'公開','SP006',null,8,5,3,null,'來追我啊',default,'{"lat":25.001000,"lng":121.319393}','{"lat":24.998277,"lng":121.320697}');
insert into SG_INFO values('S' || LPAD(SG_INFO_SEQ.nextval, 3, 0), 'M005', '唯一支持戴資穎', to_timestamp('2018-12-7 17:30:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2018-11-30 00:00:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2018-12-4 00:00:00','yyyy-mm-dd hh24:mi:ss'),null,null,null,'公開','SP005','V000004',5,3,5,4,'羽你一起','成團',null,null);
insert into SG_INFO values('S' || LPAD(SG_INFO_SEQ.nextval, 3, 0), 'M005', '人妖打排球', to_timestamp('2019-02-26 18:30:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2018-11-20 00:00:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2019-02-27 00:00:00','yyyy-mm-dd hh24:mi:ss'),null,null,null,'限社團','SP002','V000009',20,12,5,null,null,default,null,null);

insert into SG_INFO values('S' || LPAD(SG_INFO_SEQ.nextval, 3, 0), 'M007', '網球王子', to_timestamp('2019-02-10 18:30:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2018-12-20 00:00:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2019-02-14 00:00:00','yyyy-mm-dd hh24:mi:ss'),null,null,null,'公開','SP004','V000005',4,3,null,null,'吃我一記外旋發球',default,null,null);
insert into SG_INFO values('S' || LPAD(SG_INFO_SEQ.nextval, 3, 0), 'M002', '棒球大聯盟', to_timestamp('2019-02-11 15:30:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2018-12-10 00:00:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2019-02-08 00:00:00','yyyy-mm-dd hh24:mi:ss'),300,null,null,'公開','SP001','V000010',20,9,3,null,'沒有棒球就吃不下飯，睡不著覺的人快來唷!',default,null,null);
insert into SG_INFO values('S' || LPAD(SG_INFO_SEQ.nextval, 3, 0), 'M012', '南崁籃球魂不滅', to_timestamp('2019-02-03 15:00:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2018-12-20 00:00:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2019-02-01 00:00:00','yyyy-mm-dd hh24:mi:ss'),null,null,null,'公開','SP003','V000015',5,2,null,null,'鬥牛要不要',default,null,null);
insert into SG_INFO values('S' || LPAD(SG_INFO_SEQ.nextval, 3, 0), 'M013', '桃園籃球魂不滅', to_timestamp('2019-02-11 19:00:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2018-12-15 00:00:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2019-02-07 00:00:00','yyyy-mm-dd hh24:mi:ss'),null,null,null,'公開','SP003','V000012',10,2,null,null,'少林功夫好耶~少林功夫好耶~少林功夫好耶~少林功夫好耶~少林功夫好耶~少林功夫好耶~少林功夫好耶~少林功夫好耶~少林功夫好耶~少林功夫好耶~',default,null,null);
insert into SG_INFO values('S' || LPAD(SG_INFO_SEQ.nextval, 3, 0), 'M014', '台北籃球魂不滅', to_timestamp('2019-02-25 20:00:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2018-12-10 00:00:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2019-02-23 00:00:00','yyyy-mm-dd hh24:mi:ss'),null,null,null,'公開','SP003','V000032',15,5,2,null,'以球會友!',default,null,null);

insert into SG_INFO values('S' || LPAD(SG_INFO_SEQ.nextval, 3, 0), 'M004', '中原大學籃球魂不滅', to_timestamp('2019-01-25 20:00:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2018-12-10 00:00:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2019-01-24 00:00:00','yyyy-mm-dd hh24:mi:ss'),null,null,null,'限社團','SP003','V000025',10,3,1,null,'單挑啊!嫩逼',default,null,null);
insert into SG_INFO values('S' || LPAD(SG_INFO_SEQ.nextval, 3, 0), 'M008', '中壢高中籃球魂不滅', to_timestamp('2019-02-12 18:00:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2018-12-05 00:00:00','yyyy-mm-dd hh24:mi:ss'),to_timestamp('2019-02-10 00:00:00','yyyy-mm-dd hh24:mi:ss'),null,null,null,'公開','SP003','V000215',10,5,2,null,'教練，我想打球阿....',default,null,null);



------------09-INSERT--------------------
------------SG_MSG-----------------------
---------------------------------20181210
insert into SG_MSG values('MSG' || LPAD(SG_MSG_SEQ.nextval, 3, 0),'S002','M002', '請問需要準備哪些裝備呢?', to_timestamp('2018-12-10 10:00:00','yyyy-mm-dd hh24:mi:ss')); 
insert into SG_MSG values('MSG' || LPAD(SG_MSG_SEQ.nextval, 3, 0),'S002','M003', '安安你好', to_timestamp('2018-12-10 08:35:00','yyyy-mm-dd hh24:mi:ss'));
insert into SG_MSG values('MSG' || LPAD(SG_MSG_SEQ.nextval, 3, 0),'S003','M003', 'how are you?', to_timestamp('2018-12-11 21:00:00','yyyy-mm-dd hh24:mi:ss'));
insert into SG_MSG values('MSG' || LPAD(SG_MSG_SEQ.nextval, 3, 0),'S004','M002', 'peter1', to_timestamp('2018-12-01 18:40:00','yyyy-mm-dd hh24:mi:ss'));
insert into SG_MSG values('MSG' || LPAD(SG_MSG_SEQ.nextval, 3, 0),'S005','M004', '欠檢舉逆!?', to_timestamp('2018-11-21 19:40:00','yyyy-mm-dd hh24:mi:ss'));

insert into SG_MSG values('MSG' || LPAD(SG_MSG_SEQ.nextval, 3, 0),'S012','M019', '團長好帥', to_timestamp('2018-12-09 09:47:00','yyyy-mm-dd hh24:mi:ss'));
insert into SG_MSG values('MSG' || LPAD(SG_MSG_SEQ.nextval, 3, 0),'S012','M020', '當天會好天氣嗎?', to_timestamp('2018-12-09 11:32:00','yyyy-mm-dd hh24:mi:ss'));
insert into SG_MSG values('MSG' || LPAD(SG_MSG_SEQ.nextval, 3, 0),'S012','M022', '看我電報你!', to_timestamp('2018-12-10 10:40:00','yyyy-mm-dd hh24:mi:ss'));
insert into SG_MSG values('MSG' || LPAD(SG_MSG_SEQ.nextval, 3, 0),'S012','M008', '可以帶女友去嗎?', to_timestamp('2018-12-10 12:08:00','yyyy-mm-dd hh24:mi:ss'));
insert into SG_MSG values('MSG' || LPAD(SG_MSG_SEQ.nextval, 3, 0),'S010','M002', 'David說你好', to_timestamp('2018-12-11 08:40:00','yyyy-mm-dd hh24:mi:ss'));
insert into SG_MSG values('MSG' || LPAD(SG_MSG_SEQ.nextval, 3, 0),'S010','M004', '感恩seafood，讚嘆seafood', to_timestamp('2018-12-12 19:40:00','yyyy-mm-dd hh24:mi:ss'));



------------10-INSERT--------------------
------------SG_MEM-----------------------
---------------------------------20181210
--SG_MEM假資料建立(資料不足 需再補充)
insert into SG_MEM (SG_NO,MEM_NO) values ('S002','M002');
insert into SG_MEM (SG_NO,MEM_NO) values ('S002','M003');
insert into SG_MEM (SG_NO,MEM_NO) values ('S002','M005');
insert into SG_MEM (SG_NO,MEM_NO) values ('S002','M010');
insert into SG_MEM (SG_NO,MEM_NO) values ('S003','M002');
insert into SG_MEM (SG_NO,MEM_NO) values ('S003','M003');
insert into SG_MEM (SG_NO,MEM_NO) values ('S003','M004');
insert into SG_MEM (SG_NO,MEM_NO) values ('S003','M005');
insert into SG_MEM (SG_NO,MEM_NO) values ('S003','M007');
insert into SG_MEM (SG_NO,MEM_NO) values ('S004','M002');
insert into SG_MEM (SG_NO,MEM_NO) values ('S004','M003');
insert into SG_MEM (SG_NO,MEM_NO) values ('S004','M004');
insert into SG_MEM (SG_NO,MEM_NO) values ('S005','M004');
insert into SG_MEM (SG_NO,MEM_NO) values ('S006','M004');
insert into SG_MEM (SG_NO,MEM_NO) values ('S007','M010');
insert into SG_MEM (SG_NO,MEM_NO) values ('S007','M003');
insert into SG_MEM (SG_NO,MEM_NO) values ('S008','M005');
insert into SG_MEM (SG_NO,MEM_NO) values ('S008','M013');
insert into SG_MEM (SG_NO,MEM_NO) values ('S008','M014');
insert into SG_MEM (SG_NO,MEM_NO,CH_STATUS) values ('S009','M008','已報到');
insert into SG_MEM (SG_NO,MEM_NO,CH_STATUS) values ('S009','M009','已報到');
insert into SG_MEM (SG_NO,MEM_NO,CH_STATUS) values ('S009','M010','已報到');
insert into SG_MEM (SG_NO,MEM_NO,CH_STATUS) values ('S009','M011','已報到');
insert into SG_MEM (SG_NO,MEM_NO) values ('S009','M012');
insert into SG_MEM (SG_NO,MEM_NO) values ('S010','M010');
insert into SG_MEM (SG_NO,MEM_NO) values ('S010','M013');
insert into SG_MEM (SG_NO,MEM_NO) values ('S010','M014');
insert into SG_MEM (SG_NO,MEM_NO) values ('S010','M012');
insert into SG_MEM (SG_NO,MEM_NO) values ('S010','M015');
insert into SG_MEM (SG_NO,MEM_NO) values ('S012','M007');
insert into SG_MEM (SG_NO,MEM_NO) values ('S012','M006');
insert into SG_MEM (SG_NO,MEM_NO) values ('S012','M009');
insert into SG_MEM (SG_NO,MEM_NO) values ('S015','M009');
insert into SG_MEM (SG_NO,MEM_NO) values ('S015','M007');
insert into SG_MEM (SG_NO,MEM_NO) values ('S016','M003');
insert into SG_MEM (SG_NO,MEM_NO) values ('S017','M001');
insert into SG_MEM (SG_NO,MEM_NO) values ('S017','M002');



------------11-INSERT--------------------
------------SG_REP-----------------------
---------------------------------20181210
insert into SG_REP values('REP' || LPAD(SG_REP_SEQ.nextval, 3, 0),'S005','M004','廣告推銷','欠檢舉啦',default);



------------12-INSERT--------------------
------------EVAOFMEM-----------------------
---------------------------------20181210


------------13-INSERT--------------------
------------SG_LIKE----------------------
---------------------------------20181210
insert into SG_LIKE values('S001','M002');
insert into SG_LIKE values('S001','M003');
insert into SG_LIKE values('S001','M004');
insert into SG_LIKE values('S002','M003');
insert into SG_LIKE values('S002','M004');
insert into SG_LIKE values('S003','M008');
insert into SG_LIKE values('S007','M008');
insert into SG_LIKE values('S007','M010');
insert into SG_LIKE values('S005','M004');
insert into SG_LIKE values('S005','M010');
insert into SG_LIKE values('S005','M013');


------------14-INSERT--------------------
------------CLUB-------------------------
---------------------------------20181210
Insert into CLUB (CLUB_NO,SP_NO,PHOTO,PHOTO_EXT,CLUB_STATUS,CLUB_NAME,CLUB_INTRO) 
            values ('C'||LPAD(to_char(club_seq.NEXTVAL), 4, '0'),'SP006',NULL,NULL,'封鎖','跑跑跑向前跑','歡迎所有喜歡跑步的朋友一起加入跑跑跑向前跑，這邊將提供提供慢跑運動、運動飲食、體能訓練，並提供最新慢跑鞋介紹，歡迎大家一起來分享跑步與訓練心得。');
Insert into CLUB (CLUB_NO,SP_NO,PHOTO,PHOTO_EXT,CLUB_STATUS,CLUB_NAME,CLUB_INTRO)
            values ('C'||LPAD(to_char(club_seq.NEXTVAL), 4, '0'),'SP003',NULL,NULL,DEFAULT,'籃球組隊約戰','籃球，不要光用「看」的；更不要用「講」的。籃球，用「打」的才過癮！一起來「打」球吧！');
Insert into CLUB (CLUB_NO,SP_NO,PHOTO,PHOTO_EXT,CLUB_STATUS,CLUB_NAME,CLUB_INTRO)
            values ('C'||LPAD(to_char(club_seq.NEXTVAL), 4, '0'),'SP007',NULL,NULL,DEFAULT,'中央騎跡','大至國際的自行車盛事，小到YouBike的芝麻小事，讓我們從踩踏間找到生活的樂趣，中央騎跡要讓你成為全世界最幸福的車友！');
Insert into CLUB (CLUB_NO,SP_NO,PHOTO,PHOTO_EXT,CLUB_STATUS,CLUB_NAME,CLUB_INTRO)
            values ('C'||LPAD(to_char(club_seq.NEXTVAL), 4, '0'),'SP004',NULL,NULL,DEFAULT,'今晚打老虎','打爆你們這些嫩逼');
Insert into CLUB (CLUB_NO,SP_NO,PHOTO,PHOTO_EXT,CLUB_STATUS,CLUB_NAME,CLUB_INTRO)
            values ('C'||LPAD(to_char(club_seq.NEXTVAL), 4, '0'),'SP005',NULL,NULL,DEFAULT,'羽球俱樂部','不管你是新手、老手、High咖、悶騷咖，只要你是想打球的『羽球咖』，哩來，哩來，攏總來！技巧不重要，開心才重要，逗陣來打球，一起交朋友。 我們都很好相處哦，想打球的伙伴快加入我們吧！');
Insert into CLUB (CLUB_NO,SP_NO,PHOTO,PHOTO_EXT,CLUB_STATUS,CLUB_NAME,CLUB_INTRO)
            values ('C'||LPAD(to_char(club_seq.NEXTVAL), 4, '0'),'SP002',NULL,NULL,DEFAULT,'排球魂','排球の魂~初衷、熱血、團結、努力 ');
Insert into CLUB (CLUB_NO,SP_NO,PHOTO,PHOTO_EXT,CLUB_STATUS,CLUB_NAME,CLUB_INTRO)
            values ('C'||LPAD(to_char(club_seq.NEXTVAL), 4, '0'),'SP001',NULL,NULL,'封鎖','棒球樂園','歡迎來到棒球樂園 , 這裡希望能帶給大家歡樂 !');



------------15-INSERT--------------------
------------CLUB_MEMBERLIST--------------
---------------------------------20181210
Insert into CLUB_memberlist (CLUB_NO,MEM_NO,CMEM_STATUS,CMEM_CLASS) 
                    values('C0001','M003','待審核',DEFAULT);
Insert into CLUB_memberlist (CLUB_NO,MEM_NO,CMEM_STATUS,CMEM_CLASS,SILENCE_TIME) 
                    values ('C0002','M005','正常',DEFAULT,to_timestamp('2018-11-10 12:00:04','yyyy-mm-dd hh24:mi:ss'));
Insert into CLUB_memberlist (CLUB_NO,MEM_NO,CMEM_STATUS,CMEM_CLASS)
                    values ('C0003','M001','正常',DEFAULT);
Insert into CLUB_memberlist (CLUB_NO,MEM_NO,CMEM_STATUS,CMEM_CLASS)
                    values ('C0004','M002','正常',DEFAULT);
Insert into CLUB_memberlist (CLUB_NO,MEM_NO,CMEM_STATUS,CMEM_CLASS,SILENCE_TIME)
                    values ('C0005','M007','正常',DEFAULT,to_timestamp('2019-01-30 00:00:00','yyyy-mm-dd hh24:mi:ss'));
Insert into CLUB_memberlist (CLUB_NO,MEM_NO,CMEM_STATUS,CMEM_CLASS)
                    values ('C0006','M004','待審核','管理員');
Insert into CLUB_memberlist (CLUB_NO,MEM_NO,CMEM_STATUS,CMEM_CLASS)
                    values ('C0007','M006','正常','管理員');



------------16-INSERT--------------------
------------MUTIMEDIA--------------------
---------------------------------20181210
insert into multimedia(
	media_no, file_extension, media_content,
	club_no, mem_no,
	media_releasedate, media_title)
values(
	'ME'||LPAD(TO_CHAR(multimedia_seq.NEXTVAL),5,'0'),NULL,NULL,
	'C0002','M005',
	to_timestamp('2018-12-09 12:30:00' ,'yyyy-mm-dd hh24:mi:ss' ),'聚餐'
);
insert into multimedia(
	media_no,file_extension,media_content,
	club_no,mem_no,
	media_releasedate,media_title)
values(
	'ME'||LPAD(TO_CHAR(multimedia_seq.NEXTVAL),5,'0'),NULL,NULL,
	'C0003','M001',
	to_timestamp('2018-12-11 12:30:00','yyyy-mm-dd hh24:mi:ss'),'沿路風景'
);



------------17-INSERT--------------------
------------POST_INFO--------------------
---------------------------------20181210
Insert into POST_INFO (POST_NO,CLUB_NO,MEM_NO,POST_TOPIC,POST_CONTENT,POST_DATE) 
                    values ('P'||LPAD(to_char(post_info_seq.NEXTVAL), 4, '0'),'C0001','M003','運動保健','運動後的護理保養


● 運動後的緩和收操~避免痠痛肌肉產生

激烈運動後不要馬上停止，要慢慢降低做一些有氧緩和的動作，至少要維持10分鐘以上，能夠將體內形成的乳酸再次合成並代謝掉。

全身性舒緩的有氧運動：緩跑健走、緩騎自行車
能夠讓心跳率慢慢緩降至正常情況，也能夠讓運痛受產生出的物質(例如乳酸)能夠代謝排出。

局部關節運動：頸部、腳踝、膝蓋
關節部分慢慢地做伸展環繞運動，因為運動時關節與肌腱承受相當的壓力，藉由運動後關節的舒緩活動能夠避免關節僵化並促進關節系統的代謝。

伸展拉筋運動：
肌肉的溫度依然溫熱的情形下進行是最佳的，緩慢地將肌肉拉長延展維持6~30秒一個循環，這項緩和運動是一個維持肌肉長度與彈性的關鍵，尤其是在做完超負荷的訓練時伸展就更為重要。



● 運動後營養補充：多補充電解質、鉀、鎂、蛋白質以及水分

運動的營養補充主要包括水份及電解質，過度疲勞或營養不夠的身體，不但容易發生急性運動傷害，也容易產生慢性運動傷害。

如果身體已經痠痛就要多休息、多喝水、多按摩。補充電解質、鉀、鎂，來維持肌肉功能正常。

補充蛋白質：魚、瘦肉、牛奶、蛋

運動後肌纖維內蛋白質的合成速率最快，有助肌肉生成、代謝及修復。所以運動後，可多吃富含蛋白質的食物。

補充鎂：
鎂能幫助醣類代謝，並負責維持心臟、肌肉及神經正常功能，運動後會大量出汗，補充鎂能夠幫助維持心臟功能；此外鎂能夠維持肌肉正常，提升運動表現，也能夠舒緩運動後的緊繃肌肉。

補充水分：
一解身體運動後的乾渴，幫助身體降低溫度，減少組織發炎的機會。

適度睡眠：
充足的睡眠時間與良好的睡眠品質，讓身體有最好的時間與最佳的效率來恢復運動造成的身體消耗。


● 運動後黃金保養

運動後的30分鐘是體內血液循環代謝率增高的時間，因此在此時有效的肌膚保養能夠增加吸收。',to_timestamp('2018-12-08 00:00:00','yyyy-mm-dd hh24:mi:ss'));

Insert into POST_INFO (POST_NO,CLUB_NO,MEM_NO,POST_TOPIC,POST_CONTENT,POST_DATE) 
                    values ('P'||LPAD(to_char(post_info_seq.NEXTVAL), 4, '0'),'C0002','M005','閒聊','怪力亂神？你不知道的球員迷信


1.Jordan每場比賽都會穿兩條球褲
在1982年帶領北卡奪得NCAA冠軍之後，Jordan認為當時所穿的球褲就是他的幸運物。因此在他帶領公牛隊建立六冠王朝期間，他每場比賽都會將北卡的球褲穿在公牛隊的球褲裏面。
為了同時穿上兩條球褲，Jordan必須穿上大一碼的球褲。但正因為這樣Jordan順道帶起了整個NBA都穿大球褲的潮流。


2.Caron Butler被聯盟禁止壞習慣
每個球星都有他獨特的習慣，例如Curry的咬牙套，詹皇開場前的撒白粉，但是我們很少聽見聯盟會指明禁止某個球星的習慣，而這樣的規定剛好出現在Caron Butler身上兩次。
在為巫師效力期間，Caron Butler會在賽前喝半瓶兩公升的汽水，並在中場休息時喝完另一半。聯盟認為喝兩公升的汽水對他的表現及健康絕對有壞影響，所以決定禁止他再狂喝下去。
而第二樣被禁止的習慣是嚼吸管，他最高紀錄可以一場嚼12支吸管。他的上癮程度甚至要妻子每天為他拿60支吸管。在板凳休息的時侯，他會把吸管切成一小段然後慢慢嚼，而這項行為在2010年正式被聯盟禁止。


3.Jason Terry會在比賽前穿對手的球褲睡覺
作為專業球員當然要在比賽前好好了解自己的對手，而Terry採取了另類的方法去了解敵人。他在比賽前的一晚會穿對手的球褲睡覺，雖然穿對手的球褲睡覺不算太特別，但最特別的是他要求球褲必須是對手在比賽中親身穿過的。Terry認為他需要和對手有一定的連結才能夠保持比賽上的專注。
至於他為什麼能夠收集這麼多球褲，就是因為他私下跟不少球隊的訓練師及球員有不錯的交情。當然他也有收集不到球褲的時候，例如2006年對上熱火的總冠軍戰，他連一件熱火的球褲也拿不到，這可能就是小牛失落冠軍的原因之一。


4.三巨頭年代的賽爾提克會在比賽前吃三明治
為了預防嘔吐，大部份球員都會避免在比賽前進食。但是三巨頭年代的KG偏偏反其道而行，在每場比賽開始前1個小時會吃至小一個花生果醬三明治。
這一個習慣後來更發展到全隊都會在比賽前開三明治派對，而Rondo也因此養成習慣，並延續至今。有些人更認為這就是KG能在比賽高度集中的秘密。



5.Hamilton會在比賽前洗澡
一般而言，大家都會在運動過後滿身大汗才會去洗澡。有趣的是Hamilton會在比賽前就洗澡，他解釋指洗澡會令他感覺潔凈並能更有效跟比賽節奏同步。雖然隊友們都會因為這個習慣而嘲笑他，但他認為這是他保持高水平表現的必要元素。
除了Hamilton以外，Rondo也是其中一個會在比賽前洗澡的人。跟Hamilton不同的是，Rondo會在比賽當天洗澡四次，所以大家別再說Rondo是一個「骯髒」的球員了！',to_timestamp('2018-12-15 18:36:57','yyyy-mm-dd hh24:mi:ss'));


------------18-INSERT--------------------
------------POST_LIKE--------------------
---------------------------------20181210
Insert into POST_LIKE(POST_NO,MEM_NO,LIKE_TYPE) values ('P0001','M001','讚');
Insert into POST_LIKE(POST_NO,MEM_NO,LIKE_TYPE) values ('P0002','M005','讚');



------------19-INSERT--------------------
------------RESPONES---------------------
---------------------------------20181210
Insert into RESPONES (RES_NO,POST_NO,MEM_NO,RES_CONTENT,RES_DATE)
                   values ('R'||LPAD(to_char(respones_seq.NEXTVAL), 4, '0'),'P0001','M003','讚讚der',to_timestamp('2018-12-08 14:45:32','yyyy-mm-dd hh24:mi:ss'));
Insert into RESPONES (RES_NO,POST_NO,MEM_NO,RES_CONTENT,RES_DATE)
                   values ('R'||LPAD(to_char(respones_seq.NEXTVAL), 4, '0'),'P0002','M005','黑人問號',to_timestamp('2018-12-15 22:45:32','yyyy-mm-dd hh24:mi:ss'));

------------20-INSERT--------------------
------------RESPONES_LIKE----------------
---------------------------------20181210
Insert into RESPONES_LIKE (RES_NO,MEM_NO) values ('R0001','M003');
Insert into RESPONES_LIKE (RES_NO,MEM_NO) values ('R0002','M005');



------------21-INSERT--------------------
------------ORD--------------------------
---------------------------------20181210
Insert into ORD (ORD_NO,
MEM_NO,
ORD_DATE,
ORD_DELDATE,
ORD_STATUS,
ORD_BACKDELDATE,
ORD_AMOUNT,
ORD_BACKAMOUNT
) values (
to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ORD_SEQ.NEXTVAL),6, '0'),
'M001',
CURRENT_TIMESTAMP,
CURRENT_TIMESTAMP,
'待出貨',
CURRENT_TIMESTAMP,
0000001,
0000001
);



------------22-INSERT--------------------
------------PRODUCTCLASS-----------------
---------------------------------20181210
Insert into PRODUCTCLASS (PRO_CLASSID,PRO_CLASSNAME) values ('PT'||LPAD(to_char(PRODUCTCLASS_SEQ.NEXTVAL), 3, '0'),'CLOTHING');
Insert into PRODUCTCLASS (PRO_CLASSID,PRO_CLASSNAME) values ('PT'||LPAD(to_char(PRODUCTCLASS_SEQ.NEXTVAL), 3, '0'),'SHOES');

------------23-INSERT--------------------
------------PRODUCT----------------------
---------------------------------20181210
Insert into PRODUCT (
PRO_NO,
PRO_CLASSID,
PRO_NAME,
PRO_PIC,
PRO_PIC_EXT,
PRO_FORMAT,
PRO_BONUS,
PRO_STOCK,
PRO_SAFESTOCK,
PRO_DETAILS,
PRO_SHELVE,
PRO_ALL_ASSESS,
PRO_ALL_ASSESSMAN
) values (
'P'||LPAD(to_char(PRODUCT_SEQ.NEXTVAL), 3, '0'),
'PT001',
'Nikex',
NULL,
'PIC_EXT',
'9.5',
2000,
20,
5,
'DETAILS..........',
'上架中',
5,
10
);


------------24-INSERT--------------------
------------ORDDETAILS-------------------
---------------------------------20181210
Insert into ORDDETAILS(
ORD_NO,
PRO_NO,
ORD_PROBONUNS,
PRO_COUNT    
) values (
to_char(sysdate,'yyyymmdd')||'-000001',
'P001',
3400,
5
);


------------25-INSERT--------------------
------------PRODUCTLIKE------------------
---------------------------------20181210



------------26-INSERT--------------------
------------SHOPPINGCART---Redis---------
---------------------------------20181209



------------27-INSERT--------------------
------------PROMOTION--------------------
---------------------------------20181210
Insert into PROMOTION (PROM_PROJECT_ID,
PROM_PROJECT_NAME,
PROM_PROJECT_SDATE,
PROM_PROJECT_EDATE) values 
    ('PR'||LPAD(to_char(PROMOTION_SEQ.NEXTVAL), 3, '0'),
    '母親節優惠',
    to_timestamp('2019-05-2','YYYY-MM-DD'),
    to_timestamp('2019-05-12','YYYY-MM-DD')
);

Insert into PROMOTION (PROM_PROJECT_ID,
PROM_PROJECT_NAME,
PROM_PROJECT_SDATE,
PROM_PROJECT_EDATE) values 
    ('PR'||LPAD(to_char(PROMOTION_SEQ.NEXTVAL), 3, '0'),
    '聖誕節優惠',
    to_timestamp('2019-12-15','YYYY-MM-DD'),
    to_timestamp('2019-12-25','YYYY-MM-DD')
);



------------28-INSERT--------------------
------------PRO_DETAIL_PROMO-------------
---------------------------------20181210
Insert into PRO_DETAIL_PROM(
    PROM_PROJECT_ID,
    PRO_NO,
    PRO_SALE
) values (
    'PR001',
    'P001',
    7000
);


------------29-INSERT--------------------
------------ADDRESS----------------------
---------------------------------20181210
INSERT INTO ADDRESS(ADDR_NO,MEM_NO,RECEIVER,RECEIVER_PHONE,COUNTRY,CITY,ADDR_DETAIL,ADDR_ZIP) 
VALUES ('A'||LPAD(TO_CHAR(address_seq.NEXTVAL),3,'0'),'M001','大衛海鮮','0987654321','台灣','桃園市','中壢區中大路300-1號','32001');

INSERT INTO ADDRESS(ADDR_NO,MEM_NO,RECEIVER,RECEIVER_PHONE,COUNTRY,CITY,ADDR_DETAIL,ADDR_ZIP) 
VALUES ('A'||LPAD(TO_CHAR(address_seq.NEXTVAL),3,'0'),'M002','Peter1','0987654321','台灣','桃園市','中壢區中大路300-1號','32001');

INSERT INTO ADDRESS(ADDR_NO,MEM_NO,RECEIVER,RECEIVER_PHONE,COUNTRY,CITY,ADDR_DETAIL,ADDR_ZIP) 
VALUES ('A'||LPAD(TO_CHAR(address_seq.NEXTVAL),3,'0'),'M003','大崛彩','0987654321','台灣','桃園市','中壢區中大路300-1號','32001');

INSERT INTO ADDRESS(ADDR_NO,MEM_NO,RECEIVER,RECEIVER_PHONE,COUNTRY,CITY,ADDR_DETAIL,ADDR_ZIP) 
VALUES ('A'||LPAD(TO_CHAR(address_seq.NEXTVAL),3,'0'),'M004','松井稼頭央','0987654321','台灣','桃園市','中壢區中大路300-1號','32001');

INSERT INTO ADDRESS(ADDR_NO,MEM_NO,RECEIVER,RECEIVER_PHONE,COUNTRY,CITY,ADDR_DETAIL,ADDR_ZIP) 
VALUES ('A'||LPAD(TO_CHAR(address_seq.NEXTVAL),3,'0'),'M005','櫻木花道','0987654321','台灣','桃園市','中壢區中大路300-1號','32001');

INSERT INTO ADDRESS(ADDR_NO,MEM_NO,RECEIVER,RECEIVER_PHONE,COUNTRY,CITY,ADDR_DETAIL,ADDR_ZIP) 
VALUES ('A'||LPAD(TO_CHAR(address_seq.NEXTVAL),3,'0'),'M006','流川楓','0987654321','台灣','桃園市','中壢區中大路300-1號','32001');

INSERT INTO ADDRESS(ADDR_NO,MEM_NO,RECEIVER,RECEIVER_PHONE,COUNTRY,CITY,ADDR_DETAIL,ADDR_ZIP) 
VALUES ('A'||LPAD(TO_CHAR(address_seq.NEXTVAL),3,'0'),'M007','茂野吾郎','0987654321','台灣','桃園市','中壢區中大路300-1號','32001');

commit;

------------30-INSERT--------------------
------------NEWSTYPE---------------------
---------------------------------20181210
INSERT INTO NEWSTYPE(
	NEWSTYPE_NO, NEWSTYPE_NAME)
VALUES(
	'NT'||LPAD(TO_CHAR(NEWSTYPE_SEQ.NEXTVAL),3,'0'),'公告'
);
INSERT INTO NEWSTYPE(
	NEWSTYPE_NO, NEWSTYPE_NAME)
VALUES(
	'NT'||LPAD(TO_CHAR(NEWSTYPE_SEQ.NEXTVAL),3,'0'),'重大賽事資訊'
);
INSERT INTO NEWSTYPE(
	NEWSTYPE_NO, NEWSTYPE_NAME)
VALUES(
	'NT'||LPAD(TO_CHAR(NEWSTYPE_SEQ.NEXTVAL),3,'0'),'促銷商品'
);



------------31-INSERT--------------------
------------NEWS-------------------------
---------------------------------20181210
INSERT INTO NEWS(
	NEWS_NO,NEWS_TYPENO,NEWS_SCRIPT,
	PIC_EXTENSION,NEWS_PICTURE,NEWS_STUTAS,
	NEWS_RELEASE_DATE,NEWS_LAST_DATE)
VALUES(
	'N'||LPAD(TO_CHAR(NEWS_SEQ.NEXTVAL),3,'0'),'NT001','測試公告----ABCD1234',
	NULL,NULL,'未發布',
	NULL,NULL
);
INSERT INTO NEWS(
	NEWS_NO,NEWS_TYPENO,NEWS_SCRIPT,
	PIC_EXTENSION,NEWS_PICTURE,NEWS_STUTAS,
	NEWS_RELEASE_DATE,NEWS_LAST_DATE)
VALUES(
	'N'||LPAD(TO_CHAR(NEWS_SEQ.NEXTVAL),3,'0'),'NT002','測試重大賽事資訊----<BR>ABCD1234',
	NULL,NULL,'未發布',
	NULL,NULL
);
INSERT INTO NEWS(
	NEWS_NO,NEWS_TYPENO,NEWS_SCRIPT,
	PIC_EXTENSION,NEWS_PICTURE,NEWS_STUTAS,
	NEWS_RELEASE_DATE,NEWS_LAST_DATE)
VALUES(
	'N'||LPAD(TO_CHAR(NEWS_SEQ.NEXTVAL),3,'0'),'NT003','測試促銷商品----ABCD1234',
	NULL,NULL,'未發布',
	NULL,NULL
);



------------32-INSERT--------------------
------------EMP--------------------------
---------------------------------20181210
INSERT INTO EMP(
	EMP_NO,EMP_NAME,EMP_AUTH,EMP_PHONE,
	EMP_EMAIL,EMP_ACCOUNT,EMP_PSW,
	HIREDATE,LEAVEDATE)
VALUES(
	'E'||LPAD(TO_CHAR(EMP_SEQ.NEXTVAL),3,'0'),'Peter1','超級管理員','0912345678',
	'peter1@ca105.test.test','Peter1','123456',
	null,null
);


------------33-INSERT--------------------
------------COMPETITION------------------
---------------------------------20181210
INSERT INTO COMPETITION(
	COMP_NO, COMP_NAME,
	COMP_STARTDATE,COMP_ENDDATE,
	COMP_CONT)
VALUES(
	'C'||LPAD(TO_CHAR(COMPETITION_SEQ.NEXTVAL),3,'0'),'武嶺盃－自我挑戰練車趣',
	TO_TIMESTAMP('2018-12-08 05:00:00','yyyy-mm-dd hh24:mi:ss'),
	TO_TIMESTAMP('2018-12-08 13:00:00','yyyy-mm-dd hh24:mi:ss'),
	'武嶺盃:自我挑戰練車趣~
一、	活動特色:
(一)	專業達人領騎，機車巡迴交管，休旅車隨時保姆補給，遊覽車支援保護。
(二)	親朋好友也可以報名繳費參加，坐在遊覽車上共同武嶺加油趣。
(三)	騎不動上車，沿途吃吃喝喝， 遊覽車上隨時準備咖啡，茶水，補給品:果凍+餅乾+可樂+舒跑+沙其瑪+牛乳糖…。
(四)	可以騎一段，上車休息一段再騎。
(五)	幫助新人完成騎上武嶺夢想，老手重温武嶺舊夢。
(六)	幫助平安下山。
二、	活動日期:
108/2/17
108/4/14
108/6/9
108/8/11
108/10/13
108/12/8上午5點至13點左右。
三、	活動路線:起點埔里鎮地理中心碑出發→人止關16K/790M→霧社22K/1170M→清境26K/1600M→翠峰39K/2330M→鳶峰45K/2730M→昆陽52K/3100M→終點武嶺（55K/3275M）完騎。
四、	報名日期:即日起至2019年12月8日(星期日)止 。
五、	報名費用: 	
五、A報名費980元: 1武嶺完騎證書。
2武嶺完騎獎牌。
3專業達人交管領騎。
4補給餐點(依大會安排)
5免費簡易維修換胎:參加者須自備内胎。
6保險。
7高級大毛巾一條。
8坐交通工具下山。
B報名費1480元: 1武嶺完騎證書。
2武嶺完騎獎牌。
3專業達人交管領騎。
4補給餐點(依照大會安排)
5免費簡易維修換胎:參加者須自備内胎。
6保險。
7高級大毛巾一條。
8台中高鐵站上車埔里→清境來回，需要搭車的車友,
請洽遊覽車劉老闆:電話0931-171-757，前後輪必須拆裝置入單車袋中,
才可以上車或上貨車。');


commit;
