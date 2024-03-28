# basic-database-2024
IoT 개발자과정 SQLServer 학습 리포지토리

## 1일차
- MS SQL Server 설치 : [최신버전] https://www.microsoft.com/ko-kr/sql-server/sql-server-downloads
    - DBMS 엔진 : 개발자 버전
        - iso 다운로드 후 설치 추천
        - SQL Server에 대한 Azure 확장 비활성화 후 진행
        - 데이터베이스 엔진 구성부터 중요
            - Windows인증모드 -> 외부에서 접속 불가
            - 혼합모드 -> sa(시스템 관리자 계정)에 대한 암호 지정(8자 이상, 대소문자구분, 특수문자 1자 이상 포함)
            - 암호: mssql_p@ss
            - 데이터루트 디렉토리 변경
    - 개발툴 설치
        - SSMS(SQL Server Management Studio) DB에 접근, 여러 개발작업할 툴
        - https://learn.microsoft.com/ko-kr/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16
        - 한국어 Ver으로 설치

- 데이터베이스 개념
    - 데이터를 보관, 관리, 서비스
    - Data, Infomation, Knowlege 개념
    - DBMS > Database > Data(Model)

- DB언어
    - SQL(Structed Query Language) : 구조화된 질의 언어
        - DDL(Date Definition Lang) - 데이터베이스, 테이블, 인덱스 생성
        - DML(Data manipulation Lang) - 검색(SELECT)/삽입(INSERT)/수정(UPDATE)/삭제(DELETE) 등의 기능(중요!)
        - DCL(Data Control Lang) - 권한, 트랜스액션 부여/제거 기능

- SQL 기본 학습
    - SSMS 실행

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