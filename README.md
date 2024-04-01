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
- DML 학습(SELECT 외)
    - INSERT
    - UPDATE
    - DELETE

- SQL 고급
    - 내장함수
    - 서브쿼리 뷰
    - 뷰
    - 인덱스