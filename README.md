# basic-database-2024
IoT 개발자과정 SQLServer 학습 리포지토리

## 1일차
- MS SQL Server 설치 : [최신버전] https://www.microsoft.com/ko-kr/sql-server/sql-server-downloads
    - DBMS 엔진 : 개발자 버전
        - iso 다운로드 후 설치 추천
        - SQL Server에 대한 Azure 확장 비활성화 후 진행

        ![기능선택](https://raw.githubusercontent.com/RiverGang/basic-database-2024/main/images/db001.png)

        - 데이터베이스 엔진 구성부터 중요
            - Windows인증모드 -> 외부에서 접속 불가
            - 혼합모드 -> sa(시스템 관리자 계정)에 대한 암호 지정(8자 이상, 대소문자구분, 특수문자 1자 이상 포함)
            - 암호: mssql_p@ss
            - 데이터루트 디렉토리 변경
    - [개발툴 설치](https://learn.microsoft.com/ko-kr/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16): 
        - SSMS(SQL Server Management Studio) DB에 접근, 여러 개발작업할 툴
        - 한국어 Ver으로 설치

- 데이터베이스 개념
    - 데이터를 보관, 관리, 서비스
    - Data, Infomation, Knowlege 개념
    - DBMS > Database > Data(Model)

- DB언어
    - SQL(Structed Query Language) : 구조화된 질의 언어
        - DDL(Date Definition Lang) - 데이터베이스, 테이블, 인덱스 생성
        - DML(Data manipulation Lang) - 검색(SELECT)/삽입(INSERT)/수정(UPDATE)/삭제(DELETE) 등의 기능(중요!)
        - DCL(Data Control Lang) - 보안, 권한 부여/제거 기능
        - TCL (Transaction Control Lang) - 트랜스액션(트랜잭션) 제어 기능 COMMIT, ROLLBACK

- SQL 기본 학습
    - SSMS 실행
    - 특이사항: SSMS 쿼리창에서 소스코드 작성 시, 빨간색 오류 밑줄이 가끔 나타남(전부 오류는 아님)

    ![SSMS 로그인](https://raw.githubusercontent.com/RiverGang/basic-database-2024/main/images/db002.png)

- DML 학습
    - SQL 명령어 키워드 : SELECT, INSERT, UPDATE, DELETE
    - IT개발 표현(CRUD) : Request, Create, Update, Delete
        ex) 고객화면 구현하는데 CRU 기능을 개발하라 => SELECT, INSERT, UPDATE 기능 개발
    - SELECT
        ```sql
        SELECT [All | DISTINCT] 속성이름(들)
          FROM 테이블이름(들)
         [WHERE 검색조건(들)]
         [GROUP BY 속성이름(들)]
         [HAVING 검색조건(들)]
         [ORDER BY 속성이름(들) [ASC|DESC]]
        ```
    - SELECT문 학습
        - 기본, 조건검색 학습 중
        
## 2일차
- Databas학습
    - DB 개발 시 사용가능한 툴
        - SSMS(기본)
        - Visual Studio : 추가적인 설치없이 개발 가능
        - Visual Studio Code : SQL Server(mssql) 플러그인 설치
    - ServerName(hostName): 내 컴퓨터의 이름 | 내 네크워트 주소 | 127.0.0.1(LoopBack IP) | localhost(본인의 LoopBack URL)

    - 관계 데이터 모델
        - 구성요소
            - 릴레이션(Relation)
            - 제약조건(Contraints)
            - 관계대수(Relational algebra)

        - 릴레이션: 행과 열로 구성된 테이블
            - 행=튜플, 열=속성, 스키마, 인스턴스
        - 매핑되는 테이블 이름(실제DB):
            - 행=레코드, 열=컬럼|필드, 내포(필드명), 외연(데이터)
        - 차수(dgree) - 속성의 개수
        - 카디날리티(cardinality) - 튜플의 개수
        
        - 릴레이션의 특징
            1. 속성은 단일 값을 가짐 (책 이름 여러개 들어가면 안됨)
            2. 속성은 다른 이름으로 구성 (책이름이라는 속성이 두개 X)
            3. 속성의 값은 정의된 도메인값만 가짐(대학교 학년에 5학년 X)
            4. 속성과 튜플의 순서는 무관
            5. 릴레이션 내 중복된 튜플 허용X

- DML 학습
    - SELECT문
        - 복합조건, 정렬
        - 집계함수와 Group By
            - SUM(총합), AVG(평균), COUNT(개수), MIN(최소), MAX(최대)
            - 집계함수와 일반 컬럼은 Group By 절에 속한 컬럼만 SELECT문에 사용가능
            - HAVING은 집계함수의 필터로 GROUP BY 뒤에 작성. WHERE절과 필터링이 다름
        
        - JOIN: 두개 이상의 테이블 질의(Query)
            - 관계형 DB에서 가장 중요한 기법 중 하나
            - [참조](https://sql-joins.leopard.in.ua/)
            - INNER JOIN(내부 조인)
            - LEFT|RIGHT OUTER JOIN(외부 조인): 어느 테이블이 기준인지에 따라 결과가 상이

        ![외부조인](https://raw.githubusercontent.com/RiverGang/basic-database-2024/main/images/db004.png)
        
## 3일차
- Databas 학습
    - 관계 데이터 모델
        - 무결성 제약조건
            - 슈퍼키: 튜플(행)을 유일한 값으로 구분 지을수 있는 속성 or 속성집합
                (고객번호 | {고객번호, 이름} | {고객번호, 주소} etc...)
            - 후보키: 튜플(행)을 유일한 값으로 구분 지을 수 있는 최소한의 속성집합
            - 복합키: 후보키 중 속성을 2개이상 집합으로 하는 키
            - 기본키(Primary Key): 여러 후보키 중 하나를 선정하여 대표로 삼는 키
                - 고려사항: 고유한 값(Unique), NULL불가(Not Null), 최소 속성의 집합, 개인정보 등 보안사항은 사용 자제
                (고객번호 | 주민번호)
            - 대리키: 기본키가 여러 개의 속성으로 구성되어 복잡하거나, 보안문제가 생길 때 새롭게 생성하는 키
            - 대체키: 기본키로 선정되지 않은 후보키
            - 외래키(Foriegn Key): 기본키를 참조하여 사용하는 것
                - 고려사항: 다른 릴레이션과의 관계, 다른 릴레이션의 기본키를 호칭, 서로 같은 값 사용 => 기본키 변경 시, 외래키도 변경
                - NULL과 중복을 허용(NOT NULL인 경우도 있음)
                - 자기 자신의 기본키를 외래키로 사용 가능, 외래키가 기본 키의 속성 중 하나가 될 수도 있음
            
            - 데이터 무결성(Intergrity): DB에 저장된 데이터의 일관성과 정확성을 지키는 것
                - 도메인 무결성 제약조건: 데이터 타입, NOT NULL, 기본 값, 체크 특성을 지키는 것
                - 개체(기본키) 무결성 제약조건: Unique + NOT NULL
                - 참조(외래키) 무결성 제약조건: 부모의 키가 아닌 값은 사용 불가 (외래키가 바뀔 때 기본 키의 값이 아닌 것은 제약을 받는다)
                    - RESTRUCT: 자식에서 키를 사용하고 있으면 부모 삭제 금지
                    - CASCADEL: 학생 릴레이션의 해당 튜플을 연쇄적으로 삭제
                    - DEFAULT: 부모가 지워지면 자식은 지정된 기본 값으로 변경
                    - NULL: 부모가 지워지면 자식의 해당 값을 NULL로 변경
                - 유일성 제약조건: 일반 속성의 값은 중복 불가
        

- DML 학습
    - SELECT 문
        - OUTER JOIN(외부조인)
            - LEFT|RIGHT|FULL: 왼쪽(오른쪽) 테이블을 기준으로 조건에 일치하지 않는 왼쪽테이블 데이터도 모두 표시
        
        - 부속질의(SubQuery)
            - 쿼리 내에 쿼리 작성
            - 서브쿼리를 쓸 수 있는 장소
                - SELECT: 한컬럼에 하나의 값만
                - FROM: 가사의 테이블로 사용
                - WHERE: 여러 조건에 많이 사용

        - 집합연산: JOIN도 집합이지만, 속성 별로 가로로 병합하기에 집합이라 부르지 않음. 집합이란 데이터를 세로로 합치는 것을 뜻함
            - 차집합(EXCEPT): 하나의 테이블에서 교집합 값을 뺀 나머지
            - 합집합(UNION) => 주로 사용됨
                - UNION: 중복 제거
                - UNION ALL: 중복 허용
            - 교집합(INTERSECT): 두 테이블에 모두 존재하는 값
            - EXISTS: 데이터 자체의 존재여부

- DDL 학습
    - CREATE: 개체(데이터베이스, 테이블, 뷰, 사용자 등)를 생성하는 구문
    - SSMS에서 마우스로 조작이 편리
        
        ```sql
        -- 테이블 생성 한정
        CREATE TABLE 테이블명
        ({ 속성이름 데이터타입
            [NOT NULL]
            [UNIQUE]
            [DEFAULT 기본값]
            [CHECK 체크조건]
        }

            [PRIMARY KEY 속성이름(들)]
            {[FORIEGN KEY 속성이름 REFETENCES 테이블이름(속성이름)]
                 [ON UPDATE [NO ACTION | CACADE | SET NULL | SET EDFAULT]]
            } 
        )
        ```
    - ALTER: 개체를 변경(수정)하는 구문
        ```sql
        ALTER TABLE 테이블명
            [ADD 속성이름 데이터타입]
            [DROP COLUMN 속성이름]
            [ALTER COLUMN 속성이름 데이터타입]
            [ALTER COLUMN 속성이름 [NULL | NOT NULL]]
            [ALTER PRIMARY KEY(속성이름)]
            [[ADD | DROP] 제약조건이름]
        ```

    - DROP: 개체를 삭제하는 구문
        ```sql
        DROP TABLE 테이블명;
        ```

        - 외래키로 사용되는 기본키가 있으면, 외래키를 사용하는 테이블 삭제 후 기본키의 테이블을 삭제해야 함


## 4일차
- 관계 데이터 모델
    - 관계대수 연산자: 릴레이션에서 원하는 결과를 얻기 위한 수학의 대수와 같은 연산 사용 기술언어
        - 셀렉션(σ): 조건에 맞는 '튜플' 추출
        - 프로덕션(π): 조건에 맞는 '속성(애트리뷰트)' 추출
        - 합집합(U)
        - 차집합(-)
        - 카티션 프로덕트: 차수(열) = 두 릴레이션의 차수의 합, 카디날리티(데이터 전체 개수) = 두 릴레이션 카디날리티의 곱
        - 조인(⋈)
            - 세타조인
            - 외부조인
            - 자연조인: 같은 속성값 제거
            - 동등조인(= 이너조인)
        - 디비전(÷)

- DML 학습(SELECT 외)
    - INSERT

    ```sql
    INSERT INTO 테이블이름[(속성리스트)]
         VALUES (값리스트)
    ```
    - UPDATE
        - 트랜잭션을 걸어 복구 대비

    ```sql
    UPDATE 테이블이름
       SET 속성이름1=값[, 속성이름2=값, ...]
       [WHERE <검색조건>] -- 빼먹지 말 것
    ```
    - DELETE

- SQL 고급
    - 내장함수
    - 서브쿼리
        - 스칼라(SELECT) - 단일행, 단일열
        - FROM - 다수행, 다수열
        - 중첩질의(WHERE) - 다수행, 단일열(일반적)
            - 비교연산, 집합연산, 한정연산, 존재연산 가능

## 5일차
- SQL 고급
    - 서브쿼리 리뷰
    - 뷰: 하나 이상의 테이블을 합하여 만든 가상의 테이블 (JOIN, UNION)

        - 편리성(및 재사용성): 자주 사용되는 복잡한 질의를 미리 정의
        - 보안성: 각 사용자별로 필요한 데이터만 선별 가능, 중요한 질의의 경우 질의 내용을 암호화
            ex) 개인정보(주민번호)나 급여, 건강 같은 민감한 정보를 제외해서 테이블 생성
        - 논리적독립성: 개념 스키마의 데이터베이스 구조가 변해도, 외부 스키마에 영향을 주지 않도록하는 논리적 데이터 독립성 생성

        ```sql
        -- 생성
        CREATE VIEW 뷰이름 [(열이름 [, ...])]
        AS <SELECT 쿼리문>;

        -- 수정
        ALTER VIEW 뷰이름 [(열이름 [, ...])]
        AS <SELECT 쿼리문>;

        -- 삭제
        DROP VIEW 뷰이름
        ```

    - 인덱스

        ```sql
        -- 생성
        CREATE [UNIQUE] [CLUSTERED|NONCLUSTERED] INDEX 인덱스이름
        ON 테이블명 (속성이름 [ASC|DESC] [, ...n]);

        -- 수정
        ALTER INDEX {인덱스이름|ALL}
        ON 테이블명 { REBUILD | DISABLE | REORGANIZE };

        -- 삭제
        DROP INDEX 인덱스 이름 ON 테이블명;
        ```

        - 기본키 인덱스 -> 클러스터형
        - 기본키가 없는 인덱스 -> 비클러스터형
        - SSMS에서 실행계획을 가지고 쿼리 실행 성능을 체크할 수 있음



- 파이썬 SQL Server 연동 프로그래밍
    - Mdang DB 관리 프로그램
        - PyQT GUI 생성
        - SQL Server 데이터 핸들링
            - pymysql 라이브러리 설치

            ```shell
            > pip install pymssql
            ```
        
        - DB연결 설정: Oracle, MySQL 등은 설정 없음. 구성관리자에서 TCP/IP로 접근을 허용하지 않으면 접속 안됨
            1. 시작메뉴 > 모든 앱 > Microsoft SQL Server 20xx > **SQL Server 20xx 구성관리자** 실행
            2. SQL Server 네트워크 구성 > **MSSQL SERVER에 대한 프로토콜** 클릭
            3. TCP/IP 프로토콜 상태가 사용안함(최초) > **TCP/IP** 더블클릭
            4. **프로토콜 사용 > '예'**로 변경
            5. IP주소 탭 > IP주소가 본인 아이피인 것 > **사용 > '예'**로 변경
            6. 127.0.0.1로 된 주소 > **사용 > '예'**로 변경
            7. 적용 후 > SQL Server 서비스 > SQL Server(MSSQLSERVER) 더블클릭 후 > **다시 시작** 버튼 클릭 > **재시작** 필수

            ![구성관리자](https://raw.githubusercontent.com/RiverGang/basic-database-2024/main/images/db005.png)

## 6일차
- 파이썬 SQL Server 연동 프로그래밍
    - Mdang DB 관리 프로그램
        - PyQt5 + pymssql

        - 문제점: 한글 깨짐문제
            1. DB 테이블의 varchar(ASCII) -> nvarchar(UTF-8) 변경
            2. Python에서 pymssql로 접속할 때, Charset을 'UTF8'로 설정
            3. INSERT 쿼리에 한글 입력되는 컬럼은 홑따옴표 앞 N을 붙여준다 ==> N'' (유니코드로 입력하라는 뜻)
        
        - 실행화면
          

https://github.com/RiverGang/basic-database-2024/assets/122778656/ae4c96db-aa08-4939-9c4b-102c403dff19

## 7일차
- SQL 고급
    - 트랜잭션: All or Nothing
    - 트랜잭션 속성A(tomicity),C(onsistency),I(solation),D(urability)
    - TCL(Transaction Control Lag)
        - BEGIN
        - TRAN[SACTION]
        - COMMIT
        - ROLLBACK
        - SAVE
        
    - SQL Server는 기본적으로 Auto Commit(시스템이 자동으로 트랜잭션을 건다)
    - SSMS > 도구 > 옵션 > 쿼리실행 > SQL Server > ANSI 
        -> SET IMPLICIT_TRANSACTIONS 체크 후, 프로그램 재시작
    
    - 트랜잭션 로직 처리시, 다른 트랜잭션의 간섭을 받지 않기 위한 것(Lock)
    - 중요한 데이터 수정/삭제시 잘못된 변경을 방지하기 위한 것

- 데이터베이스 모델링
    - 설계 순서: 개념 설계 -> 논리 설계 -> 물리 설계
        - 개념 모델링: 요구사항을 받으면서 정해지지 않은 여러 개체들을 정립화 하는 단계
        - 논리 모델링: 기본키 지정, 외래키 지정, 관계 정립 속성들 이름(한글) 개체를 픽스
        - 물리 모델링: DB에 맞춰서 컬럼 이름, 컬럼데이터타입 및 크기 지정, DB에 대한 검토로 테이블을 만들기 직전의 설계 완성

    
    - ER 모델링 - ERD를 그리기위한 기본 이론
        - IE(Infomation Engineering) 표기법
    
- 인덱스 예제
    - PK나 인덱스가 없는 상태에서 성능문제 체크
    - 인덱스가 설정되면 성능이 어떤지 비교
    - 더미 생성시 100만건으로 제약을 두고 시작


    <!-- md 주석(Ctrl+/)![인덱스](https://raw.githubusercontent.com/RiverGang/basic-database-2024/main/images/db005.png) -->   
    <!-- html 이미지 태그가 이미지 사이즈 조정 가능-->
    <img src="https://raw.githubusercontent.com/RiverGang/basic-database-2024/main/images/db006.png" width="800">

## 8일차
- 인덱스 예제
- 정규화
    - DB상에서 생기는 (삽입, 삭제, 수정)이 생기지 않는 릴레이션(테이블) 분리해서 데이터베이스 설계
    - 이상현상이 생기는 테이블은 분리해서 해결
    - 기본키와 함수종속성을 파악
    - 1정규형: 도메인이 원자값을 가짐
    - 2정규형: 기본키가 아닌 속성이 기본키에 완전 종속일 떄(학생번호[PK], 강좌이름 ---> 성적을 결정)
    - 3정규형: 기본키가 아닌 속성이 기본키에 비이행적으로 종속할 떄 (학생번호 --> 강좌이름 --> 수강료 [이행적속성])
    - BCNF정규형: 함수 종속성 X -> Y가 성립할 때 모든 결정자 X가 후보키(=기본키가 될 수 있는 속성)
        - 보통 BCNF까지 정규화를 함
    - 4정규형(다치 종속성), 5정규형(조인종속성, 무손실 분해)

- 실무실습(사용자, 권한...)
    1. DB관리자(SSMS)
        - hr데이터베이스 생성, 관계 설정
        - hr DB를 사용할 사용자 계정을 설정, 필요한 권한 설정
            - 만약 sa 비밀번호를 잊어버리면, Windows 인증으로 로그인 후 
            - SSMS > 보안 > 로그인 > sa > 속성에서 비밀번호 변경 이후 SQL Server 인증으로 sa 비밀번호 입력 후 로그인
            
            - 사용자계정: hr_user, 비밀번호: hr_p@ss!
            - SSMS > 보안 > 로그인 > 새 로그인 클릭 > SQL Server 인증 > 아이디/비밀번호 설정
            - 일반: 기본 데이터베이스 hr 선택 
            - 사용자매핑: hr 선택 > 데이터베이스 역할 멤버 자격 > db_owner 추가 선택
            
    2. HR사용자 로그인(VS Code)

