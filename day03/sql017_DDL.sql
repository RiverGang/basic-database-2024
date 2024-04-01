-- DDL: 데이터 정의 언어
-- 객체 생성, 수정, 삭제

-- 1. 테이블 생성
/* 
    Newbook 테이블 생성 예시)
    bookid(도서번호 => 기본키) - int
    bookname(도서이름) - varchar(20)
    publiser(출판사) - varchar(20)
    pirce(가격) - int

    -- 타입종류
    INT[정수], BIGINT[큰값의 정수], BINARY(n)[이진데이터], BIT[0|1], CHAR(n)[고정문자], N- [유니코드] -N
    VARCHAR(n)[가변문자열], DATE[날짜], DATETIME[날짜&시간], DECIMAL(18,0)[소수점 표현 실수] FLOAT[실수],
    IMSGR(이미지바이너리)

    ex) username: CHAR(10) => 'hugo      ', 이름을 넣고 나머지 공간 스페이스(' ')입력
    ex) username: VARCHAR(10) => 'hugo', 이름을 넣고 빈 공간 전부 없앰

    - 가장 많이 쓰는 타입
    INT, CHAR, WARCHAR, DATETIME, DECIMAL, FLOAT, TEXT 외네는 잘 안씀  
*/

CREATE TABLE NewBook (
    bookid INT,
    bookname VARCHAR(20),
    publisher VARCHAR(20), 
    price INT
    primary KEY (bookid) -- 기본키로 bookid 지정
);

-- 기본키 두개 이상
CREATE TABLE NewBook (
    bookid INT,
    bookname VARCHAR(20),
    publisher VARCHAR(20), 
    price INT
);

-- 각 컬럼에 제약조건을 걸기
CREATE TABLE NewBook (
    bookname VARCHAR(20)  NOT NULL,
    publisher VARCHAR(20) UNIQUE, 
    price INT DEFAULT 10000 CHECK(price > 1000) -- 기본 값 제약조건, 체크 제약조건
    PRIMARY KEY (bookname, publisher) -- 기본키로 bookid 지정
);

-- 새 고객테이블(기본키)
CREATE TABLE NewCustomer (
    custid INT PRIMARY KEY, -- NewCustomer 기본키
    custname VARCHAR(40),
    custaddress VARChAR(255),
    phone VARCHAR(30)
);

-- 새 주문테이블(기본키 + 외래키)
CREATE TABLE NewOrder (
    orderid INT,
    custid INT NOT NULL,
    bookid INT NOT NULL,
    saleprice INT,
    orderdate DATE,
    PRIMARY KEY (orderid), -- New Order의 기본키 설정
    FOREIGN KEY (custid) REFERENCES NewCustomer(custid) ON DELETE CASCADE
    -- NewCustomer의 custid를 외래키로 설정(연결되어있음)
);

-- 2. 테이블 변경/수정
CREATE TABLE MyBook (
    bookid    INT,
    bookname  VARCHAR(20),
    pulbisher VARCHAR(20),
    price     INT,
);

-- MyBook에 isbn 컬럼 추가(ADD)
ALTER TABLE MyBook ADD isbn VARCHAR(13);

-- isbn을 int형으로 변경(ALTER)
ALTER TABLE MyBook ALTER COLUMN isbn INT;

-- isbn 속성 삭제(DROP)
ALTER TABLE MyBook DROP COLUMN isbn;

-- MyBook의 bookname을 NOT NULL로 제약조건 적용
ALTER TABLE MyBook ALTER COLUMN bookname INT NOT NULL;

-- bookid를 기본키(PRIMARY KEY)로 설정
-- 기본키로 설정하기 위해선, NOT NULL 조건이 선행되어야함
ALTER TABLE MyBook ALTER COLUMN bookid INT NOT NULL;
ALTER TABLE MyBook ADD PRIMARY KEY(bookid);


-- 3. 테이블 삭제
DROP TABLE MyBook;
-- DROP TABLE NewCustomer; -- >  불가능. 자식테이블(NewOrder)에서 NewCustomer의 속성을 외래키로 사용 중
-- 자식 테이블을 지운 뒤, 부모 테이블 삭제 가능

-- 자식테이블 삭제 후 부모테이블 삭제
DROP TABLE NewOrder;
DROP TABLE NewCustomer;
