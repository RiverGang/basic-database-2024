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