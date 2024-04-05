-- 테이블 생성
-- basic2024 데이터베이스 사용
USE basic2024;
GO


-- 유저 테이블 생성
CREATE TABLE Users (
	userid BIGINT IDENTITY(1,1) NOT NULL -- 유저아이디 IDENTITY(1,1) => 자동증가, INSERT문에 values 추가할 필요없음
  ,	username NVARCHAR(40) NOT NULL
  , guildno INT DEFAULT 0
  , regdata DATETIME DEFAULT GETDATE() -- 등록일시 
);
GO

-- 인벤토리 테이블 생성
CREATE TABLE Inventory (
	itemno BIGINT IDENTITY(1,1) NOT NULL
  , userid BIGINT NOT NULL
  , itemid int NOT NULL
  , regdata DATETIME DEFAULT GETDATE()
);
GO

-- 1만건 더미데이터 생성
DECLARE @i INT; -- i라는 이름의 int type 변수 정의(DECLARE)
SET @i = 0; -- 변수 i 값 0으로 초기설정

WHILE (@i < 100000) -- WHILE (조건) => 반복문
BEGIN -- 반복문 시작점
	SET @i = @i+1; -- 반복마다 변수 i += 1
	INSERT INTO Users (username, guildno, regdata)
	VALUES(CONCAT('user', @i), @i/100, DATEADD(dd, -@i/100, GETDATE())); -- CONCAT('A', B): A와 B 글자 합치기(연결하기)
END; -- 반복문 끝점

SELECT *
  FROM Users;

TRUNCATE TABLE Users;