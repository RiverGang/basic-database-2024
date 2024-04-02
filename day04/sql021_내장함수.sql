-- 내장함수
-- 함수의 결과 값은 열이름 없음 => 이름 지정 필요
SELECT ABS(-5), ABS(5);

-- 올림, 내림, 반올림, n승
SELECT CEILING(4.1), FLOOR(4.4), ROUND(4.5, 0), POWER(2, 10);


-- 고객별 평균주문 금액
SELECT custid
     , SUM(saleprice) '고객별 총 주문금액'
     , AVG(saleprice) '고객별 주문평균금액'
     , SUM(saleprice) / COUNT(*) AS ' 계산한 평균금액'
  FROM Orders
GROUP BY custid

-- 문자열함수들
-- 책제목에 야구를 농구로 바꿔서 출력
-- FOMAT(VAL, '포멧값)

SELECT bookid
     , REPLACE(bookname, '야구'. '농구') AS bookname
     , publisher
     , FORMAT(price, '#,#') AS price
 FROM Book;

 SELECT bookname AS '제목'
      , LEN(bookname) AS [제목별 길이]
   FROM Book
 WHERE publisher = '굿스포츠';

 -- 영문자 단어, 코드 변환
 SELECT LOWER('HEELLO'), UPPER('hello');

 -- LTPIM, RTRIM, TRIM(!!), 공백제거
 SELECT '|' + LTRIM('     HELLO     ') + '|' -- 왼쪽 공백제거
      , '|' + RTRIM('     HELLO     ') + '|' -- 오른쪽 공백제거
      , '|' + TRIM('     HELLO     ') + '|' -- 양쪽 공백제거

-- LEFT(), RIGHT()
SELECT LEFT('HELLO WORLD!', 5)
     , RIGHT('HELLO WORLD!', 5)
     , SUBSTRING('HELLO WORLD!', 7, 5);

-- CHARINDEX() : 문자 찾기 함수
SELECT CHARINDEX('sql', 'Mycrosoft SQL Server 2022'); -- 'sql'라는 문자를 'Mycrosoft SQL Server 2022'안에서 찾는다

-- SUBSTRING() 연계
SELECT SUBSTRING('Mycrosoft SQL Server 2022',
                CHARINDEX('sql', 'Mycrosoft SQL Server 2022'),
                LEN('sql'));
                

-- SUBSTRING
-- DB는 인덱스가 1부터 시작
SELECT SUBSTRING([name], 1, 1) AS '성씨'
     , COUNT(*) AS '성씨별 인원수'
  FROM Customer
GROUP BY SUBSTRING([name], 1, 1)


-- 날짜 및 시간 함수
SELECT GETDATE();

SELECT DAY(GETDATE()); -- 오늘의 일
SELECT MONTH(GETDATE()); -- 오늘의 월
SELECT YEAR(GETDATE()); -- 오늘의 년

SELECT FORMAT(GETDATE(), 'yyyy-MM-dd'); -- 날짜 포맷을 원하는 형태로 변경 (년-월-일)
SELECT FORMAT(GETDATE(), 'HH:mm:ss'); -- 시간 포맷을 원하는 형태로 변경 (시:분:초)


-- 주문 테이블에서 주문 10일 후에 각 주문을 확정짓는다. 확정 일자 출력
-- dd(일수), mm(달수), yy(년수), qq(분기), wk(주)
SELECT orderid
     , orderdate AS '주문일자'
     , saleprice
     , DATEADD(dd, 10, orderdate) AS '확정일자'-- 일수(dd)로, 10일 더하기, orderdate 값에서
     , DATEADD(mm, 1, orderdate) AS '통계일자' -- 달수(mm)로, 한달 더하기, orderdate 값에서
  FROM Orders;
