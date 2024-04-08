-- 트랜스액션(트랜잭션)
-- SELECT만 있으면 굳이 트랙잭션을 안 걸어도 됨
-- INSERT, UPDATE, DELETE에서 중요한 로직을 처리할 때 트랜잭션 반드시 필요

SELECT *
  FROM Customer;

-- 트랜잭션을 실수를 방지하기 위한 목적도 있음

BEGIN TRAN; -- 트랜잭션 시작

-- CUD에 대한 쿼리
UPDATE Customer
   SET phone = '010-7777-8888'
 WHERE custid = 2;

-- BEGIN TRAN 시작 후 COMMIT or ROLLBACK이 되면 다시 BEGIN TRAN부터 해야함
COMMIT;
ROLLBACK;