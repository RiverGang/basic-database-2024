-- 집계함수, GROUP BY
-- 고객이 주문한 도서의 총 판매액
SELECT sum(saleprice) -- saleprice를 합친 값의 속성이름은 없음
  FROM Orders;

-- AS: 새로운 열(속성) 이름 설정, 띄워쓰기 필요할시 []사용
SELECT sum(saleprice) AS [총 매출]
  FROM Orders;

-- 김연아 고객이 주문한 도서의 총 판매액
SELECT *
  FROM Customer;
-- 김연아 고객의 custid = 2

SELECT sum(saleprice) AS [김연아고객 총 판매액]
  FROM Orders
 WHERE custid = 2;

-- COUNT()는 * 사용가능
-- 나머지 집계함수는 열(= 속성) 하나만 지정해서 사용
SELECT COUNT(saleprice) AS [주문개수]
     , SUM(saleprice) AS [총 판매액]
	 , AVG(saleprice) AS [평균 판매액]
	 , MIN(saleprice) AS [주문도서 최소금액]
	 , MAX(saleprice) AS [주문도서 최대금액]
  FROM Orders;

-- 출판사 중복제거 개수
-- DISTINCT 키워드가 없으면 중복도 합산되어 출력
SELECT COUNT(DISTINCT publisher)
  FROM Book;
 
-- GROUP BY: 필요조건으로 그룹핑을 해 결과(통계)를 내는 목적
-- GROUP BY는 집계함수 필수
-- custid별로 그룹핑, custid 별 saleprice 합계
SELECT custid
	 , SUM(saleprice) AS [판매액]
  FROM Orders
 GROUP BY custid;

-- HAVING: Where절은 일반 필터링조건
-- Having은 통계, 집합함수의 필터링조건
-- 가격이 8,000원 이상인 도서를 구매한 고객별 주문도서 총수량
-- 단, 2권 이상 구매한 경우만

SELECT custid, COUNT(*) AS [구매수] -- [구매수]는 열(속성)이 아닌 별칭 임시지정 느낌, 사용불가
  FROM Orders
 WHERE saleprice >= 8000
 GROUP BY custid
 HAVING COUNT(*) >= 2; -- 구매수가 2 이상인 것만