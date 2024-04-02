-- 연습문제 p196
-- 1. 새로운 도서 ('스포츠 세계', '대한미디어', 10000원)가 마당서점에 입고 되었다. 삽입이 안될 때 필요한 데이터가 더있는지 찾아보시오.
-- bookid 필요
INSERT INTO Book
    VALUES(14, '스포츠 세계', '대한미디어', 10000);

-- 2. '삼성당'에서 출판한 도서를 삭제하시오
DELETE FROM Book
WHERE publisher = '삼성당'

-- 3. '이상미디어'에서 출판한 도서를 삭제하시오. 삭제가 안되면 원인을 생각해 보시오
DELETE FROM Book
WHERE publisher = '이상미디어'


-- 참조제약 조건에 걸리기때문에 삭제 불가
-- 원인: 2번에서 삭제한 '올림픽이야기'(bookid=9)는 Orders 테이블 튜플이 아니었기에 바로 삭제 가능,
-- 하지만 출판사가 '이상미디어'인 도서들의 bookid가 Orders 테이블(자식테이블)에서 외래키로 사용되고 있기에
-- 자식테이블에서 먼저 삭제가 되어야 부모테이블(Book)에서 삭제 가능



--4. 출판사 '대한미디어'를 '대한출판사'로 이름을 바꾸시오.
UPDATE Book
   SET publisher = '대한출판사' -- 변경값
 WHERE publisher = '대한미디어' -- 변경대상

-- 강사님 풀이
UPDATE Book
   SET publisher = '대한출판사'
 WHERE bookid IN (SELECT bookid
                    FROM Book
                   WHERE publisher = '대한미디어')