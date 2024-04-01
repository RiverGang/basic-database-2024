-- 1. 주문하지 않은 고객의 이름 (서브쿼리 사용)
SELECT [name]
  FROM Customer
 WHERE custid NOT IN (SELECT DISTINCT custid
                         FROM Orders);

-- 2. 주문 금액의 총액과 주문 평균 금액
SELECT SUM(saleprice) AS [총액], AVG(saleprice) AS [평균]
  FROM Orders

-- 3. 고객의 이름과 고객별 구매액

SELECT SUM(o.saleprice)
  FROM Orders AS o, customer AS c
 WHERE o.custid = c.custid
 GROUP BY o.custid

-- 3번 강사님 풀이
SELECT (SELECT [name] FROM Customer AS c WHERE c.custid = o.custid) AS '구매 고객'
     , SUM(o.saleprice)
  FROM Orders AS o
GROUP BY o.custid

-- 4. 고객의 이름과 고객이 구매한 도서 목록
SELECT c.[name], b.bookname
  FROM Book AS b, Customer AS c, Orders AS o
 WHERE b.bookid = o.bookid
   AND o.custid = c.custid
ORDER BY c.[name];
 
-- 5. 도서의 가격(book table)과 판매가격(Orders테이블)의 차이가 가장 많은 주문
SELECT *
  FROM Book

SELECT *
  FROM Orders

SELECT MAX(b.price - o.saleprice)
  FROM Book AS b, Orders AS o
WHERE b.bookid = o.bookid

-- 5번 강사님 풀이
SELECT TOP 1 o.orderid -- 1
     , o.saleprice -- 2
     , b.price -- 3
     , (b.price - o.saleprice) AS [판매금액 차] -- 4
  FROM Orders AS o, Book AS b
 WHERE o.bookid = b.bookid
 ORDER BY 4 DESC; -- 3번째 컬럼을 정렬

-- 6. 도서 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름
-- 전체 도서의 판매 평균금액 = 11,800원

-- 6번 강사님 풀이
SELECT (SELECT [name] FROM Customer WHERE custid = base.custid) AS '고객명'
     , base.Average
  FROM (SELECT o.custid
             , AVG(o.saleprice) AS Average
          FROM Orders AS o
      GROUP BY o.custid) AS base
 WHERE base.Average >=(SELECT AVG(saleprice)
                        FROM Orders AS o)