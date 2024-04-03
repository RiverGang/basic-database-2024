-- 인덱스(책의 목차와 기능이 동일)
-- Book의 bookname 옆에 넌클러스터드 인덱스 IX_book_bookname을 생성하시오
CREATE INDEX IX_Book_bookname ON Book(bookname);

-- Customer의 name 열에 클러스터링 인덱스 CIX_Customer_name을 생성
-- 기본키에 클러스터드, 나머지 컬럼 넌클러스터드
CREATE CLUSTERED INDEX CIX_Customer_name ON Customer(name);

-- Book에 publisher, price 동시에 인덱스 IX_Book_pubprice 인덱스 생성
CREATE INDEX IX_Book_pubprice ON Book(publisher, price);