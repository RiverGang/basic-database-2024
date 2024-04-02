-- 연습문제 p196
-- 1. 박지성이 구매한 도서의 출판사와 같은 출판사에서 도서를 구매한 고객의 이름
SELECT b.bookname, b.publisher, c.[name]
  FROM Book as b, Customer as c, Orders AS o
     , (SELECT publisher
          FROM Book AS b, Orders AS o
         WHERE o.bookid = b.bookid
           AND o.custid = (SELECT custid
                             FROM Customer
                            WHERE [name] = '박지성')) AS pub
 WHERE c.custid = o.custid 
   AND b.publisher = pub.publisher
   AND b.bookid = o.bookid
   AND NOT c.[name] = '박지성'

-- 1번 강사님 풀이
SELECT DISTINCT custid
  FROM Orders
 WHERE bookid IN(
SELECT bookid
  FROM Book
 WHERE publisher IN (SELECT b.publisher
                       FROM Customer AS c, Orders AS o, book as b
                      WHERE c.custid = o.custid
                        AND o.bookid = b.bookid
                        AND c.[name] = '박지성'));
 
/* 고객별 구매 도서
SELECT c.[name], b.bookname, b.publisher
 FROM Orders as o, Customer as c, Book as b
WHERE o.custid = c.custid
  AND b.bookid = o.bookid
ORDER BY c.name
*/

-- 2. 두 개 이상의 서로 다른 출판사에서 도서를 구매한 고객의 이름
SELECT cu.[name], pub.[count]
  FROM Customer as cu
     , (  SELECT c.custid, COUNT(DISTINCT publisher) AS [count]
            FROM Book as b, Customer as c, Orders as o
           WHERE b.bookid = o.bookid
             AND o.custid = c.custid
        GROUP BY c.custid) AS pub
  WHERE pub.count >= 2
    AND cu.custid = pub.custid


-- 3. 전체 고객의 30% 이상이 구매한 도서

SELECT *
  FROM Orders
ORDER BY bookid


SELECT b.bookname, b.bookid, (BEST.[count] / 
  FROM Book AS b
--   , Orders AS o
     , (SELECT bookid, COUNT(bookid) AS [count]
          FROM Orders
      GROUP BY bookid) AS Best
 WHERE Best.bookid = b.bookid


-- 강사님 풀이
SELECT b.custid
     , CONVERT(float, b.custCount) / b.totalCount
  FROM (SELECT custid
             , COUNT(custid) AS custCount
             , (SELECT COUNT(custid) FROM Orders) AS totalCount
          FROM Orders
          GROUP BY custid) AS b 
  WHERE CONVERT(float, b.custCount) / b.totalCount >= 0.3;