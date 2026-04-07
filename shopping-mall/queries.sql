-- =============================================
-- 쇼핑몰 토이프로젝트 - 쿼리 연습
-- 학습 내용: JOIN, 서브쿼리, GROUP BY, 윈도우 함수, CTE
-- =============================================

-- =============================================
-- 🟢 기본 쿼리
-- =============================================

--미션 1. 재고가 50개 이상인 상품을 가격 내림차순으로 조회하세요.
select product_name, price
from shopping_mall.products
where stock >=50 order by price DESC;

--미션 2. delivered 상태인 주문의 총 건수와 총 매출액을 구하세요.
select count(*) "총 건수",sum(total_amount) as "총 매출액" from shopping_mall.orders where status='delivered';

--미션 3. 카테고리별 상품 개수를 구하되, 상품이 2개 이상인 카테고리만 보여주세요.
select category_name from shopping_mall.categories c join shopping_mall.products p on c.category_id=p.category_id 
group by p.category_id having count(product_name) >=2;

-- =============================================
-- 🟡 JOIN
-- =============================================

--미션 4. 각 주문에 대해 주문자 이름, 주문 날짜, 주문 상태, 총 금액을 조회하세요.
select u.name, o.order_date,o.status,o.total_amount 
from shopping_mall.orders o join shopping_mall.users u on u.user_id=o.user_id;

-- 미션 5. 상품별 평균 평점과 리뷰 수를 구하세요. 리뷰가 없는 상품도 포함하세요. (힌트: LEFT JOIN) 
select avg(rating), count(review_id) from shopping_mall.products p left join shopping_mall.reviews r
on r.product_id=p.product_id group by p.product_id;
-- select *하면 모든 열 표시됌 -> 카르테시안 곱(Cartesian Product) 또는 Cross Join : 두 테이블의 모든 행을 곱해버림

-- 미션 6. 한 번도 주문한 적 없는 회원의 이름과 이메일을 조회하세요. (힌트: LEFT JOIN + IS NULL)
select name,email from shopping_mall.users u
left join shopping_mall.orders o on u.user_id=o.user_id where o.order_date is null;

-- =============================================
-- 🔴 서브쿼리
-- =============================================

-- 미션 7. 전체 상품 평균 가격보다 비싼 상품의 이름, 카테고리, 가격을 조회하세요. 이건 on을 안해도 같네?
select product_name,category_name,price from shopping_mall.products p join shopping_mall.categories c 
on p.category_id=c.category_id where price > (select avg(price) from shopping_mall.products);

-- 미션 8. 가장 많이 팔린 상품 TOP 3를 구하세요 (판매 수량 기준).
select product_name, sum(quantity) from shopping_mall.order_items o join shopping_mall.products p
ON o.product_id = p.product_id group by p.product_id,o.product_id order by sum(quantity) desc;

-- 미션 9. 회원별 총 구매금액을 구하고, 구매금액이 가장 높은 회원 1명을 찾으세요.
select name,sum(total_amount) total_amount from shopping_mall.users  u join shopping_mall.orders o on u.user_id=o.user_id
group by u.user_id order by sum(total_amount) desc limit 1;

-- 미션 10. 카테고리별로 가장 비싼 상품의 이름과 가격을 조회하세요.(힌트: 서브쿼리 또는 GROUP BY + HAVING)
SELECT c.category_name, p.product_name, p.price
FROM shopping_mall.products p
JOIN shopping_mall.categories c ON p.category_id = c.category_id
WHERE p.price = (
    SELECT MAX(price)
    FROM shopping_mall.products p2
    WHERE p2.category_id = p.category_id
);

-- =============================================
-- 🪟 윈도우 함수
-- =============================================

-- 미션 1. 각 상품의 가격이 카테고리 내에서 몇 위인지 순위를 매기세요.
select category_name, product_name, price, rank() over (partition by c.category_name order by price desc) as "순위"
from shopping_mall.categories c join shopping_mall.products p on p.category_id=c.category_id;

-- 미션 2. 주문을 날짜순으로 정렬했을 때, 이전 주문 금액과 현재 주문 금액을 나란히 보여주세요.
select order_id, order_date, total_amount, lag(total_amount) over(order by order_date) as "이전 주문 금액" from shopping_mall.orders order by order_date;

-- 미션 3. 카테고리별 상품 가격의 누적 합계를 가격 오름차순으로 구하세요.
select category_name, product_name, price,sum(price) over(partition by category_name order by price) as"누적 합계" from shopping_mall.categories c
join shopping_mall.products p on c.category_id=p.category_id;

-- 미션 4. 회원별 주문을 날짜순으로 정렬하고, 다음 주문 날짜를 옆에 붙여주세요.
select name, order_date, lead(order_date) over(partition by name order by order_date) as "다음 주문 날짜" 
from shopping_mall.orders o join shopping_mall.users u on o.user_id=u.user_id;

-- =============================================
-- 🔷 CTE (WITH절)
-- =============================================

-- 미션 1. 회원별 총 구매금액을 CTE로 만들고, 총 구매금액이 10만원 이상인 회원만 조회하세요.
with 회원별_총구매금액 as(
	select user_id, sum(total_amount) "구매금액"
    from shopping_mall.orders
    group by user_id
)
select * from 회원별_총구매금액
where 구매금액 >= 100000;

-- 미션 2. 상품별 평균 평점을 CTE로 만들고, 평점이 전체 평균보다 높은 상품만 조회하세요.
with 평균_평점 as(
select product_id, avg(rating) as rating
from shopping_mall.reviews
group by product_id
)
select * from 평균_평점 where rating > (select avg(rating) from 평균_평점);

-- 미션 3. CTE 두 개를 이어서 써보세요.
-- 첫 번째 CTE: 회원별 총 구매금액
-- 두 번째 CTE: 상품별 총 판매수량
-- 최종: 두 CTE를 각각 조회해서 한 번에 출력하세요. (힌트: UNION ALL)
with 회원별_총_구매금액 as(
select user_id, sum(total_amount) total_amount
from shopping_mall.orders
group by user_id
),
상품별_총_판매수량 as(
select product_id, sum(quantity) total_quantity
from shopping_mall.order_items
group by product_id
)
select '상품' as 구분, product_id as id, total_quantity as 수량_또는_금액
from 상품별_총_판매수량
union all
select '회원' as 구분, user_id, total_amount
from 회원별_총_구매금액;

-- =============================================
-- 🔍 서브쿼리 심화
-- =============================================
 
-- 미션 4. 평균 주문금액보다 높은 주문 회원
SELECT user_id, total_amount
FROM orders
WHERE total_amount > (SELECT AVG(total_amount) FROM orders);
 
-- 미션 5. 한 번도 리뷰를 작성하지 않은 회원
-- 포인트: NOT EXISTS 안에 WHERE r.user_id = u.user_id 연결 필수
--         NOT IN은 서브쿼리에 NULL이 있으면 결과가 빈값이 될 수 있어 NOT EXISTS가 더 안전
SELECT user_id, name
FROM users u
WHERE NOT EXISTS (
    SELECT 1
    FROM reviews r
    WHERE r.user_id = u.user_id
);
