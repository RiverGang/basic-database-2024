-- 차집합
-- [전체고객] - [도서 구매 고객] = 도서를 구매하지 않은 고객
-- 전체 고객 중 도서를 구매핮 ㅣ않은 고객의 이름을 조회
SELECT [name]
  FROM Customer
EXCEPT 
SELECT [name]
  FROM Customer
 WHERE custid IN (SELECT DISTINCT custid FROM Orders)


-- 합집합
SELECT [name]
  FROM Customer
 UNION 
SELECT [name]
  FROM Customer
 WHERE custid IN (SELECT DISTINCT custid FROM Orders)

-- 중복허용 합집합
   SELECT [name]
     FROM Customer
UNION ALL 
   SELECT [name]
     FROM Customer
    WHERE custid IN (SELECT DISTINCT custid FROM Orders)

-- 교집합
   SELECT [name]
     FROM Customer
INTERSECT 
   SELECT [name]
     FROM Customer
    WHERE custid IN (SELECT DISTINCT custid FROM Orders)

-- UNION
-- 각 컬럼의 타입형이 각각 일치해야 함
SELECT bookid -- int
     , bookname -- varchar(40)
  FROM Book
 UNION
SELECT custid -- int
     , [name] -- varchar(40)
  FROM Customer;

-- EXIST, 하나의 테이블에 존재하는 값만 보고싶다
SELECT c.[name]
     , c.[address]
 FROM Customer AS c
WHERE EXISTS ( SELECT *
                 FROM Orders AS o
                WHERE o.custid = c.custid)