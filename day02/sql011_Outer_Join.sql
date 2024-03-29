﻿-- OUTER JOIN(외부조인)
-- LEFT OUTER JOIN vs RIGHT OUTER JOIN

SELECT *
  FROM TableA A
  LEFT OUTER JOIN TableB B
    ON A.key = B.key

SELECT *
  FROM TableB B
  RIGHT OUTER JOIN TableA A
    ON A.key = B.key

-- 위의 둘은 같은 의미의 쿼리