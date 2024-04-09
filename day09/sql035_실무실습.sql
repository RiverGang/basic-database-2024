-- p555

-- 5. 현재 날짜 타입을 날짜를 함수를 통해 확인, 2006년 5월 20일 부터 2007년 5월 20일 사이에 고용된 사원의 이름(First+Last), 사원번호, 고용일자 출력
-- 단, 입사일 빠른 순으로 정렬하시오(18개행)
SELECT GETDATE();

SELECT FIRST_NAME + ' '+ LAST_NAME AS 'name'
     , EMPLOYEE_ID
     , HIRE_DATE
  FROM employees
 WHERE HIRE_DATE BETWEEN '2006-05-20' AND '2007-05-20'
 ORDER BY HIRE_DATE ASC;

 -- 6. 급여와 수당율에 대한 지출보고서. 수당을 받는 모든 사원의 이름, 급여, 업무, 수당율을 출력하라 (35행)
 SELECT FIRST_NAME + ' '+ LAST_NAME AS 'name'
      , SALARY
      , JOB_ID
      , COMMISSION_PCT
   FROM employees
  WHERE COMMISSION_PCT IS NOT NULL
  ORDER BY SALARY DESC, COMMISSION_PCT DESC;


-- 단일행 함수, 변환 함수
-- 샘플문제: 60번 IT부서에 사원 급여를 12.3$ 인상하기로 함. 정수만 반올림하여 보고서를 작성하라 (사번, 이름, 급여, 인상된 급여(Increased Salary)) (5개행)
SELECT EMPLOYEE_ID
     , FIRST_NAME + ' '+ LAST_NAME AS 'name'
     , SALARY
     , CONVERT(INT, ROUND(SALARY * 1.123, 0)) AS 'Increased Salary' -- COVERT(TYPE, 값) => 형변환
  FROM employees
 WHERE DEPARTMENT_ID = 60;

 -- 7. 각 사원의 이름을 성이 s로 끝나는 사원의 이름과 업무를 아래와 같이 출력하라
 -- Michael Rogers is a ST_CLERK
 SELECT FIRST_NAME + ' '+ LAST_NAME AS 'name'
   FROM employees
 WHERE LAST_NAME LIKE '%s';

 -- 8. 이름, 급여, 수당 여부에 따른 연봉을 포함하여 출력, Salary + Commission Or Salary ONLY, 연봉이 높은 순(107행)

 -- 9. 이름, 입사일, 입사일의 요일 출력, 일요일부터 토요일순으로 (107개행)
 

 -- 집계함수 SUM, COUNT, AVG, MAX, MIN ...
 
 -- 11. 사원들의 업무별 전체 급여 평균이 10,000$ 보다 큰 경우 조회
 -- 업무, 급여 평균을 출력하시오 단, 사원(CLERK)이 포함된 경우는 제외
 -- 전체 급여 내림차순으로 (7개행)

 SELECT JOB_ID
      , '$' + FORMAT(AVG(SALARY), '#,#') AS 'Avg Salary'
   FROM employees
 GROUP BY JOB_ID
 HAVING AVG(SALARY) > 10000
 ORDER BY 2 DESC; --  2번 column 내림차순

-- 12. Employees, Department 조인, 사원 수가 5명 이상인 부서의 부서명, 사원수 출력
-- 사원수를 내림차순으로 정렬
 SELECT d.department_name
      , COUNT(*) AS '사원수'
   FROM employees AS e, departments AS d
  WHERE e.DEPARTMENT_ID = d.department_id
  GROUP BY d.department_name
    HAVING COUNT(*) >= 5
  ORDER BY 2 DESC;

-- 서브쿼리
-- 13. 사원의 급여 정보 중, 업무별 최소 급여를 받는 사원의 이름, 어무, 급여, 입사일 출력 (21개 행)

SELECT e.FIRST_NAME + ' '+ e.LAST_NAME AS 'name'
     , e.JOB_ID
     , e.SALARY
     , e.HIRE_DATE
  FROM employees AS e
 WHERE e.SALARY <= (SELECT MIN(SALARY) AS Salary
                      FROM employees
                     WHERE job_ID = e.JOB_ID
                  GROUP BY JOB_ID);

-- CASE 연산자(프로그래밍적인)
-- 14. 107명의 직원중 부서별로 인상한 SALARY 출력, HR_REP(10%), MK_REP(12%), PR_REP(15%), SA_REP(18&), IT_ROG(20%)
SELECT EMPLOYEE_ID
     , FIRST_NAME + ' ' + LAST_NAME as 'NAME'
     , JOB_ID
     , SALARY
     , CASE JOB_ID WHEN 'HR_REP' THEN SALARY * 1.10 -- 하나의 컬럼에 조건 적기
                   WHEN 'MK_REP' THEN SALARY * 1.12
                   WHEN 'PR_REP' THEN SALARY * 1.18
                   WHEN 'IT_ROG' THEN SALARY * 1.20
        ELSE SALARY END AS 'New Salary' 
  FROM employees;

-- 실무에서 많이 쓰이는 쿼리문법들
-- ROLLUP, CUBE

-- 15. 부서와 업무별 급여 합계를 구하여 신년 급여수준레벨을 지정하고자 함
-- 부서번호, 업무를 기준으로 그룹별로 나누고 급여합계와 인원수를 출력(20개행)
SELECT DEPARTMENT_ID
     , JOB_ID
     , COUNT(EMPLOYEE_ID) AS 'count EMPs'
     , '$' + FORMAT(SUM(SALARY), '#,#') AS 'Salary SUM'
  FROM employees
 GROUP BY DEPARTMENT_ID, JOB_ID
 ORDER BY DEPARTMENT_ID


 SELECT DEPARTMENT_ID
     , ISNULL(JOB_ID, '-- 합계 --') AS JOB_ID
     , COUNT(EMPLOYEE_ID) AS 'count EMPs'
     , '$' + FORMAT(SUM(SALARY), '#,#') AS 'Salary SUM'
  FROM employees
 GROUP BY DEPARTMENT_ID, JOB_ID WITH ROLLUP -- ROLLUP => 부서별, 전체금액 집계도 추가됨
 -- GROUP BY ROOLUP(DEPARTMENT_ID, JOB_ID) => ROLLUP을 앞쪽에 써도 동일


-- RANK, ROW_NUMBER, FIRST_VALUE

-- 사원들의 부서별 급여 기준으로 내림차순 정렬, 순위를 표시하시오(107개행)
SELECT EMPLOYEE_ID
     , LAST_NAME
     , SALARY
     , DEPARTMENT_ID
     , RANK() OVER (ORDER BY SALARY DESC) -- 급여기준으로 내림차순 등수
     , DENSE_RANK() OVER (ORDER BY SALARY DESC)
     -- RANK = 동등순위 중복증가(건너뛰기) 타입
     -- DENSE_RANK() = 동등순위 순차증가 타입     
  FROM employees
ORDER BY SALARY DESC; -- 급여기준으로 정렬


-- ROW_NUMBER(): 각 행의 번호를 실제 데이터 값으로 가져오는 함수
SELECT ROW_NUMBER() OVER (ORDER BY EMPLOYEE_ID)
     , *
  FROM employees