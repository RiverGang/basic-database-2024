-- VIEW(뷰)
-- 고객명과 책이름을 같이 볼 수 있는 주문VIEW 생성
-- 보통 뷰명 앞에 v를 붙이는 것이 일반적
CREATE VIEW v_orderdetail
    AS
SELECT o.orderid
     , o.custid
     , c.[name]
     , o.bookid
     , b.bookname
     , o.saleprice
     , b.price
     , o.orderdate
  FROM Customer AS c, Orders AS o, Book AS b
 WHERE c.custid = o.custid
   AND b.bookid = o.bookid


-- 대한민국 고객으로 구성된 뷰를 만드시오
CREATE VIEW v_kcustomer
    AS
SELECT *
  FROM Customer
 WHERE [address] LIKE '%대한민국%';

-- 조회
SELECT *
  FROM v_kcustomer;

-- VIEW에 데이터 입력 가능
INSERT INTO v_kcustomer
VALUES (6, '손흥민', '대한민국 강원도', '010-8372-3943');

-- v_orderdetail
-- JOIN으로 만든 뷰는 데이터 삽입/수정/삭제에 큰 제약이 있음 (거의불가)
INSERT INTO v_orderdetail
VALUE (11, 6, '손흥민', 1, '축구의 역사', 6500, 7000, '2024-04-03');

-- But, 뷰에는 되도록 삽입/수정/삭제 하지 말 것

-- 뷰 삭제
DROP VIEW v_kcustomer;


-- 시스템 뷰: DBMS가 미리 만들어 놓은 뷰들
-- 내 데이터베이스에 있는 DB종류
SELECT * FROM sys.databases;

-- 테이블 내에 존재하는 컬럼명 조회하는 시스템뷰 중 하나
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
 WHERE TABLE_NAME = 'Book';

-- 인덱스 재구성
-- PK인 기본키는 값이 추가되면 자동으로 인덱스 제공
-- 넌클러스터드 인덱스는 재구성이 필요할 수 있음(DBA 정기적으로 작업)
-- IX_Book_pubprice를 재구성하라
ALTER INDEX IX_Book_pubprice ON Book REBUILD;
ALTER INDEX IX_Book_pubprice ON Book REORGANIZE; -- 인덱스 재정리


-- 인덱스 삭제
-- DROP INDEX [인덱스명] ON [인덱스위치]
DROP INDEX IX_BOOK ON Book;
DROP INDEX CIX_Customer_name ON Book;
