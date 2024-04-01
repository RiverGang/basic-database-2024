-- Cstomer를 기준으로 Oders 테이블과 외부조인하기
SELECT c.custid
     , c.[name]
     , c.[address]
     , c.phone
     , o.orderid
     , o.custid
     , o.bookid
     , o.saleprice
     , o.orderdate
  FROM Customer AS c LEFT OUTER JOIN Orders AS o
    ON c.custid = o.custid
-- 박지성, 김연아, 장미란, 추신수는 교집합 / 박세리는 주문테이블과 교집합인 속성 값이 없기에 NULL값 처리