-- 책중에서 '축구의 역사'라는 도서의 출판사와 가격을 알고 싶다
-- dbo = DataBase Owner
-- FROM절을 먼저 적으면 자동완성 가능
-- DML(4가지) 중 SELECT(조회)
SELECT publisher, price
 FROM Book
 WHERE bookname = '축구의 역사';

/*
SQL의 특징
- equal 연산자는 (=)
- 문자열 홑따옴표 ('')
- 대소문자 구분없음 but, 키워드(파란색)는 대문자로 사용
- 세미콜론(;) 필수 아님. but, 중요한 상황에서 사용
*/

-- 김연아 고객의 전화번호를 찾으시오
-- (*) => All 이라고 호칭함

-- 1 step
SELECT *
  FROM Customer;

-- 2 step
SELECT *
  FROM Customer
 WHERE [name] = '김연아'; - [] name이 키워드가 아님을 명시

-- 3 step
SELECT phone
  FROM Customer
 WHERE [name] = '김연아';