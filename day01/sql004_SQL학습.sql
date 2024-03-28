-- 모든 도서의 이름과 가격을 검색하시오
-- Ctrl+Shif+U : 대문자
-- Ctrl+Shif+L : 소문자
SELECT bookname, price 
  FROM Book;

-- 모든 도서의 가격과 이름을 검색하시오 -> 순서변경, 가상의 테이블(메모리상 저장)로 구현 가능
-- 실제 데이터파일은 하드디스크에 파일로 저장되어있음(영구)
SELECT price, bookname
  FROM Book;

-- 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오
SELECT *
  FROM Book;

  -- 실무에서는 컬럼명을 모두 적는게 일반적
SELECT bookid, bookname, publisher, price
  FROM Book;

-- 도서에서 출판사를 검색하시오(중복제거)
-- DISTINCT: 중복제거
-- 단, SELECT의 속성이 중복제거가 가능한 형태일때만 가능
SELECT DISTINCT publisher
  FROM Book;

-- 조건검색(조건 연산자 사용) WHERE절
-- 가격이 20,000원 미만인 도서를 검색하시오.
SELECT *
  FROM Book
 WHERE price < 20000; 

-- 가격이 10,000원 이상 20,000 이하인 도서를 검색하시오.
SELECT *
  FROM Book
 WHERE price >= 10000 AND price <= 20000;

SELECT *
  FROM Book
 WHERE price BETWEEN 10000 AND 20000;
-- BETWEEN은 이상/이하만 가능 (초과/미만 불가)

-- 출판사가 굿스포츠와 대한미디어인 도서를 검색하시오
SELECT *
  FROM Book
 WHERE publisher IN ('굿스포츠', '대한미디어');

-- 출판사가 굿스포츠와 대한미디어가 아닌 도서를 검색하시오
SELECT *
  FROM Book
 WHERE publisher NOT IN ('굿스포츠', '대한미디어');
 
-- 축구의 역사를 출간한 출판사를 검색하시오
SELECT bookname, publisher
 FROM Book
 WHERE bookname = '축구의 역사';

-- 도서 이름에 축구가 포함된 출판사를 검색하시오
SELECT bookname, publisher
  FROM Book
 WHERE bookname LIKE '축구%'; -- 축구%: '축구'로 시작하는

SELECT bookname, publisher
  FROM Book
 WHERE bookname LIKE '%축구'; -- %축구: '축구'로 문장이 끝나는

SELECT bookname, publisher
  FROM Book
 WHERE bookname LIKE '%축구%'; -- %축구%: '축구' 글자를 포함하는 모든 책의 이름과 출판사 출력


-- 두글자인 구로 끝나는 단어로 시작되는 책제목의 출판사를 검색하시오
SELECT bookname, publisher
  FROM Book
 WHERE bookname LIKE '_구%'; -- _(무슨 글자든 한글자(언더바 개수)가 들어간)구로 시작하는 ex)야구 축구 농구 배구 (o), 변화구 (x)