-- 서브쿼리 연습문제 part1
-- 1. 박지성이 구매한 도서의 출판사수
-- 1-1 서브쿼리로 풀어보기
SELECT COUNT (DISTINCT publisher) AS [박지성 구매 출판사 수]
  FROM Book
 WHERE bookid IN (SELECT bookid
                    FROM Orders
                   WHERE custid = (SELECT custid
                                     FROM Customer
                                    WHERE [name] = '박지성'))

-- 1-2 JOIN으로 풀어보기
-- 관계형 DB에서는 JOIN 이용이 조금 더 일반적
SELECT COUNT (DISTINCT b.publisher) AS [박지성 구매 출판사 수]
  FROM Book As b, Orders AS o, Customer AS c
 WHERE b.bookid = o.bookid
   AND o.custid = c.custid
   AND c.name = '박지성'

-- 2. 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이
SELECT b.bookname
     , b.price
     , o.saleprice
     , (b.price - o.saleprice) AS '정가와의 차'
  FROM Book As b, Orders AS o, Customer AS c
 WHERE b.bookid = o.bookid
   AND o.custid = c.custid
   AND c.name = '박지성'

-- 3. 박지성이 구매하지 않은 도서의 이름
-- 박지성이 구매한 도서의 책번호를 구해 책 목록에서 NOT IN
SELECT b.bookname
  FROM Book AS b
 WHERE b.bookid NOT IN(SELECT o.bookid
                         FROM Orders AS o, Customer AS c
                        WHERE o.custid = c.custid
                          AND c.name = '박지성')