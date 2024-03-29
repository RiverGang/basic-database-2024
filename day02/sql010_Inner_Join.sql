-- 두개 이상의 테이블 SQL 쿼리 작성
-- "조건없이" Customer, Order 테이블을 동시에 조회
SELECT *
  FROM Customer, Orders;

-- "둘의 custid가 일치하는 조건" Customer, Order 테이블을 동시에 조회
-- RDB(Ralation DateBase)에서 중요한 쿼리문 1 - Join(조인)
SELECT *
  FROM Customer, Orders
 WHERE Customer.custid = Orders.custid
 ORDER BY Customer.custid ASC;
 -- 테이블.테이블의속성


-- 주문한 책의 고객이름과 책판매액 조회
SELECT Customer.[name]
	 , Orders.saleprice
  FROM Customer, Orders
 WHERE Customer.custid = Orders.custid;

-- 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬
SELECT Customer.[name] 
	 , SUM(Orders.saleprice) AS [판매액]
  FROM Customer, Orders
 WHERE Customer.custid = Orders.custid
 GROUP BY Customer.[name] -- 부모테이블 기준
 ORDER BY Customer.[name];

-- 각 테이블의 별명으로 줄여서 사용
-- 내부조인(Inner Join): 양쪽 쿼리의 개수를 동일하게 JOIN
SELECT c.custid
	 , o.custid
	 , c.[name]
	 , c.[address]
	 , c.phone
	 , o.orderdate
	 , o.saleprice
	 , o.orderdate
  FROM Customer AS c, Orders AS o
 WHERE c.custid = o.custid
 ORDER BY c.custid ASC;


-- 세개 테이블 JOIN
SELECT * -- 컬럼 별 나눠적기 생략
  FROM Customer AS c, Orders AS o, Book AS b
 WHERE c.custid = o.custid 
   AND o.bookid = b.bookid;

-- 표준 SQL Inner Join
-- 표준 SQL은 복잡함
SELECT *
  FROM Customer AS c
 INNER JOIN Orders AS o
	ON c.custid = o.custid
 INNER JOIN Book AS b
	ON o.bookid = b.bookid;

-- 가격이 20,000원 이상인 도서를 주문한 고객의 이름과 도서명 조회
SELECT c.[name]
	 , b.bookname
	 , o.saleprice
	 , b.price
  FROM Customer AS c, Orders AS o, Book AS b
 WHERE c.custid = o.custid
   AND o.bookid = b.bookid -- Join을 위한 조건(65,66행)
   AND b.price >= 20000; -- 필터링을 위한 조건