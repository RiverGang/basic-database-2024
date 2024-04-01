-- 책 가격이 가장 비싼 책
SELECT MAX(price)
  FROM Book

-- 35000원인 거 찾아보자
SELECT *
  FROM Book
 WHERE price = 35000;

-- 서브쿼리 사용 (WHERE절)
SELECT *
  FROM Book
 WHERE price = (SELECT MAX(price)
                 FROM Book);

-- 도서를 구매한 적이 있는 고객이름 검색
-- 서브쿼리 이용
SELECT *
  FROM Customer
WHERE custid = (SELECT DISTINCT custid -- 잘못된 사용, WHY? 고객 id가 1 & 2 & 3 & 4 없음
                  FROM Orders)

SELECT [name] AS '고객이름'
  FROM Customer
WHERE custid IN (SELECT DISTINCT custid
                   FROM  Orders); -- IN => 1 or 2 or 3 or 4

-- 내부조인 이용
SELECT DISTINCT c.[name] AS '고객이름'
  FROM Customer AS c, Orders AS o
 WHERE c.custid = o.custid;

-- 구매한 적 없는 고객 외부조인
SELECT DISTINCT c.[name] AS '고객이름'
  FROM Customer AS c LEFT OUTER JOIN Orders AS o
    ON c.custid = o.custid
 WHERE o.orderid IS NULL;


-- 서브쿼리 FROM 절
-- SELECT로 만든 실행결과(가상의 테이블)를 마치 DB에 있는 테이블처럼 사용가능
SELECT t.*
FROM(
    SELECT b.bookid
         , b.bookname
         , b.publisher
         , o.orderdate
         , o.orderid
    FROM Book As b
       , Orders AS o
    WHERE b.bookid = o.bookid
    ) AS t;

-- 서브쿼리 SELECT절
-- 무조건 한건에 1컬럼만 연결 가능
SELECT o.orderid
     , o.custid
     , o.bookid
     , (SELECT bookname /*, bookprice 불가능*/FROM Book WHERE bookid = o.bookid)
     , o.saleprice
     , o.orderdate
  FROM Orders AS o;