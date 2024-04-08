-- 지난주 잘못 입력한 데이터 전부 초기화
-- 삭제
DELETE FROM Users; -- WHERE 절이 없으면 모두 삭제

-- 단, identitiy(1,1)로 설정한 테이블에서 1부터 다시 넣도록 설정하려면
-- TRUNCATE TABLE: 모두 지우고 테이블 초기화까지
TRUNCATE TABLE Users;

-- 200만건으로 줄여서 다시 시작
DECLARE @i INT; 
SET @i = 0; 

WHILE (@i < 2000000) -- 200만건
BEGIN 
	SET @i = @i+1; 
	INSERT INTO Users (username, guildno, regdata)
	VALUES(CONCAT('user', @i), @i/100, DATEADD(dd, -@i/100, GETDATE())); 
END;

-- 인덱스가 없는 상태
-- 100만건 정도의 데이터 조회시, 5~8초 사이 시간 소요

-- 인덱스를 걸기 위해서 userid에 기본키(PK) 설정
ALTER TABLE Users ADD PRIMARY KEY(usrid);
CREATE INDEX IX_Users_username ON Users(username);


-- ! 검색조건(WHERE) username 사용
-- 인덱스를 PK에 거는게 아니라 username에 적용하기
CREATE CLUSTERED INDEX IX_Users_username ON Users(username)
DROP INDEX IX_Users_username ON Users