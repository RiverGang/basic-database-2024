-- NULL에 대한 고찰
-- MyBook 테이블에서 시작

-- NULL값은 어떤 걸 더해도 NULL
SELECT bookid
     , price + 100
  FROM MyBook;

-- 합계, 전체 COUNT는 문제 되지 않음 
-- 평균(AVG)에서와 price의 COUNT는 NULL 값이 집계 X => 문제가 될 수 있음
SELECT SUM(price), AVG(price), COUNT(*), COUNT(price)
  FROM MyBook;

-- 지정된 bookid가 없는 데이터로 통계를 낼 때 반드시 NULL이 나와야 함
-- COUNT는 NULL값이 없음 (0으로 표기)
SELECT SUM(price), AVG(price), COUNT(*), COUNT(price)
  FROM MyBook
 WHERE bookid >=4;

 
 -- NULL 비교(!)
 SELECT *
   FROM MyBook
 WHERE price = NULL -- NULL은 일반 비교연산자로 비교할수 없음

 -- IS NULL / IS NOT NULL
 SELECT *
   FROM Mybook
  WHERE price IS NULL; -- price 값이 NULL인 튜플 검색

 SELECT *
   FROM Mybook
  WHERE price IS NOT NULL; -- price 값이 NULL이 아닌 튜플 검색
  

-- ISNULL() 함수
-- 사전 작업 (Customer 테이블)
SELECT *
  FROM Customer

UPDATE Customer
   SET phone = NULL
 WHERE custid = 2;

SELECT custid
     , [name]
     , [address]
     , ISNULL(phone, '연락처 없음') AS phone
    -- ISNULL(속성A, 변경값) => 속성A의 값이 NULL이면 표기를 변경값으로 치환
    -- NULL 자체의 데이터 값이 변경되는 것은 아님! 
  FROM Customer;


-- TOP n
-- 함수가 아닌 내장된 키워드
-- 정렬된 기준으로 상위 n개만 나타남
SELECT TOP 3 orderid
     , custid
     , saleprice
  FROM Orders
ORDER BY saleprice DESC;