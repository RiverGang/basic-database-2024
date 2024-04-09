-- 1번
-- 회원 테이블에서 이메일, 모바일, 이름, 주소 순으로 나오도록 검색하시오.(결과는 아래와 동일하게 나와야 하며, 전체 행의 개수는 31개입니다)

SELECT Email as email
	 , Mobile as mobile
	 , Names as names
	 , Addr as addr
  FROM membertbl
  ORDER BY Addr DESC;



 -- 2번
 -- 함수를 사용하여 아래와 같은 결과가 나오도록 쿼리를 작성하시오.(전채 행의 개수는 59개입니다)
 
SELECT Names as '도서명'
	 , Author as '저자'
	 , ISBN
	 , Price as '정가'
  FROM bookstbl
ORDER BY Price DESC;



-- 3번
-- 책을 한번도 빌린적이 없는 회원 출력 쿼리문
SELECT m.Names AS '회원명'
	 , m.Levels AS '회원등급'
	 , m.Addr AS '회원주소'
	 , r.rentalDate AS '대여일'
  FROM rentaltbl AS r 
  RIGHT OUTER JOIN membertbl AS m
    ON r.memberIdx = m.memberIdx
 WHERE r.memberIdx IS NULL
   AND m.Levels = 'A'
 


-- 4번 
-- 책 장르별 총합계금액
SELECT d.Names AS '책 장르'
	 , p.총합계금액
  FROM divtbl AS d
	 , (SELECT b.Division
		     , FORMAT(SUM(Price),'#,#') + ' 원' As 총합계금액
		  FROM bookstbl AS b
	  GROUP BY b.Division) as p
 WHERE d.Division = p.Division




-- 5번
SELECT ISNULL(d.Names, '--합계--') AS '책 장르'
	 , p.권수
	 , p.총합계금액
  FROM divtbl AS d
  RIGHT OUTER JOIN (SELECT b.Division
					     , COUNT(Division) AS '권수'
						 , FORMAT(SUM(Price),'#,#') + ' 원' As 총합계금액
					  FROM bookstbl AS b
					  GROUP BY ROLLUP(b.Division)) as p
	ON d.Division = p.Division
