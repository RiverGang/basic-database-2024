-- 서브쿼리 리뷰
-- WHERE절 서브쿼리
-- ALL, ANY, SOME
-- 3번 고객이 주문한 도서의 최고금액보다 더 비싼 도서를 구입한 다른 주문의 주문번호, 금액 표시

SELECT *
  FROM Customer;


-- 장미란이 주문한 내역 중 최고금액 (=13000)
SELECT MAX(saleprice)
  FROM Orders
WHERE custid = 3

-- 13000원 보다 비싼 도서를 구입한 주문의 주문번호와 금액 표시
SELECT o1.orderid, o1.saleprice
  FROM Orders as o1
 WHERE o1.saleprice > ALL (SELECT MAX(saleprice)
                             FROM Orders
                            WHERE custid = 3);

-- EXISTS, NOT EXISTS : 열을 명시 안함
-- 대한민국 거주 고객에게 판매한 도서의 총판매액
-- 전체 판매액 11800, 대한민국 고객 판매액 46000
SELECT SUM(o.saleprice) AS '대한민국 거주 고객 판매액'
  FROM Orders AS o
 WHERE EXISTS (SELECT *
                 FROM  Customer AS c
                WHERE c.address LIKE '%대한민국%'
                  AND c.custid = o.custid)

-- 조인으로도 가능
SELECT SUM(o.saleprice) AS '조인도 가능'
  FROM Orders AS o, Customer AS c 
 WHERE o.custid = c.custid
   AND c.address LIKE '%대한민국%';


-- SELECT절 서브쿼리
-- JOIN으로도 변경 가능 But, 이미 쿼리가 너무 복잡해서 더이상 테이블을 추가하기 힘들 때 많이 사용
-- 고객별 판매액을 보이시오

SELECT o.custid -- GROUP BY에서 사용한 속성만 SELECT에 사용 가능
     , SUM(o.saleprice) AS '고객별 판매액'
     , (SELECT [name]
          FROM Customer
         WHERE custid = o.custid) AS '고객명'
         -- Customer의 custid가 기본키이기에, GROUP BY로 묶인 Orders의 custid와 1:1로 매칭 가능
  FROM Orders AS o
 GROUP BY o.custid -- GROUP BY 와 집계함수(SUM, AVG, MAX, MIN 등)는 세트
 
 -- UPDATE에서도 사용 가능
 -- 사전준비
 ALTER TABLE Orders ADD bookname VARCHAR(40); -- Orders 테이블에 bookname이라는 VARCHAR(40) type의 컬럼추가
 
 -- Orders테이블 bookname컬럼에, Book테이블의 bookname컬럼과 똑같은 값 넣기 (bookid와 대응되게)
 -- 한꺼번에 필요한 필드값을 한테이블에서 다른테이블로 복사할 때 유용
UPDATE Orders
   SET bookname = (SELECT bookname
                     FROM Book
                    WHERE Book.bookid = Orders.bookid)
 

-- FROM절 서브쿼리
-- 고객별 판매액을 보이시오(서브쿼리 --> 조인)
-- 고객별 판매액 집계 쿼리가 FROM절에 들어가면 모든 속성(컬럼)에 이름이 지정되어야함

SELECT b.* -- total과 custid만 나타났던 서브쿼리(=가상쿼리)
     , c.name 
  FROM (SELECT SUM(o.saleprice) AS total -- 서브쿼리 b의 속성에 total 이름 지정
             , o.custid
          FROM Orders AS o
      GROUP BY o.custid) AS b
      , Customer as c
 WHERE b.custid = c.custid -- b의 custid와 대응되는 name 출력
 

 -- 고객번호가 2이하인 고객의 판매액을 보이시오. 고객 이름, 판매액 표시
SELECT SUM(o.saleprice) AS '고객별 판매액'
     , (SELECT [name] FROM Customer WHERE custid = c.custid) AS '고객명' -- FROM절의 서브쿼리 테이블 custid와 Customer테이블의 custid 매칭하여 name 출력
  FROM (SELECT custid
             , [name]
          FROM Customer
         WHERE custid <= 2) AS c, Orders AS o
 WHERE c.custid = o.custid
 GROUP BY c.[custid]; -- GROUP BY에 들어갈 속성(컬럼)은 최소화 -> 중복 등의 문제가 있으면 결과가 다 틀어짐