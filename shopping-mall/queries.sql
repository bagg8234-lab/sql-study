#미션 1. 재고가 50개 이상인 상품을 가격 내림차순으로 조회하세요.
select product_name, price
from shopping_mall.products
where stock >=50 order by price DESC;

#미션 2. delivered 상태인 주문의 총 건수와 총 매출액을 구하세요.
select count(*) "총 건수",sum(total_amount) as "총 매출액" from shopping_mall.orders where status='delivered';

#미션 3. 카테고리별 상품 개수를 구하되, 상품이 2개 이상인 카테고리만 보여주세요.
select category_name from shopping_mall.categories c join shopping_mall.products p on c.category_id=p.category_id 
group by p.category_id having count(product_name) >=2;

# 미션 4. 각 주문에 대해 주문자 이름, 주문 날짜, 주문 상태, 총 금액을 조회하세요.
select u.name, o.order_date,o.status,o.total_amount 
from shopping_mall.orders o join shopping_mall.users u on u.user_id=o.user_id;

# 미션 5. 상품별 평균 평점과 리뷰 수를 구하세요. 리뷰가 없는 상품도 포함하세요. (힌트: LEFT JOIN) 
select avg(rating), count(review_id) from shopping_mall.products p left join shopping_mall.reviews r
on r.product_id=p.product_id group by p.product_id;
# select *하면 모든 열 표시됌 -> 카르테시안 곱(Cartesian Product) 또는 Cross Join : 두 테이블의 모든 행을 곱해버림


# 미션 6. 한 번도 주문한 적 없는 회원의 이름과 이메일을 조회하세요. (힌트: LEFT JOIN + IS NULL)
select name,email from shopping_mall.users u
left join shopping_mall.orders o on u.user_id=o.user_id where o.order_date is null;

#미션 7. 전체 상품 평균 가격보다 비싼 상품의 이름, 카테고리, 가격을 조회하세요. 이건 on을 안해도 같네?
select product_name,category_name,price from shopping_mall.products p join shopping_mall.categories c 
on p.category_id=c.category_id where price>(select avg(price) from shopping_mall.products);

#미션 8. 가장 많이 팔린 상품 TOP 3를 구하세요 (판매 수량 기준).
select product_name, sum(quantity) from shopping_mall.order_items o join shopping_mall.products p
ON o.product_id = p.product_id group by p.product_id,o.product_id order by sum(quantity) desc;

#미션 9. 회원별 총 구매금액을 구하고, 구매금액이 가장 높은 회원 1명을 찾으세요.
select name,sum(total_amount) total_amount from shopping_mall.users  u join shopping_mall.orders o on u.user_id=o.user_id
group by u.user_id order by sum(total_amount) desc limit 1;

#미션 10. 카테고리별로 가장 비싼 상품의 이름과 가격을 조회하세요.(힌트: 서브쿼리 또는 GROUP BY + HAVING)
SELECT c.category_name, p.product_name, p.price
FROM shopping_mall.products p
JOIN shopping_mall.categories c ON p.category_id = c.category_id
WHERE p.price = (
    SELECT MAX(price)
    FROM shopping_mall.products p2
    WHERE p2.category_id = p.category_id
);
