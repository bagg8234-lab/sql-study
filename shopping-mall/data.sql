-- 회원
INSERT INTO shopping_mall.users (name, email, phone) VALUES
('김민준', 'minjun@email.com', '010-1111-2222'),
('이서연', 'seoyeon@email.com', '010-3333-4444'),
('박지호', 'jiho@email.com', '010-5555-6666'),
('최유나', 'yuna@email.com', '010-7777-8888'),
('정현우', 'hyunwoo@email.com', NULL);

-- 카테고리
INSERT INTO shopping_mall.categories (category_name) VALUES
('전자제품'), ('의류'), ('식품'), ('도서'), ('스포츠');

-- 상품
INSERT INTO shopping_mall.products (category_id, product_name, price, stock) VALUES
(1, '무선 이어폰', 89000,  50),
(1, '스마트워치',  320000, 20),
(1, '블루투스 스피커', 55000, 35),
(2, '기능성 티셔츠', 29000, 100),
(2, '청바지',       59000, 80),
(3, '유기농 견과류', 18000, 200),
(3, '프로틴 바',    35000, 150),
(4, 'SQL 완전정복', 28000, 60),
(4, '파이썬 기초',  25000, 45),
(5, '요가 매트',    42000, 70);

-- 주문
INSERT INTO shopping_mall.orders (user_id, order_date, status, total_amount) VALUES
(1, '2024-11-01', 'delivered', 144000),
(1, '2024-12-15', 'delivered', 55000),
(2, '2024-11-20', 'delivered', 88000),
(2, '2025-01-05', 'cancelled', 59000),
(3, '2024-12-01', 'delivered', 320000),
(4, '2025-01-10', 'shipped',   67000),
(5, '2025-01-12', 'pending',   28000);

-- 주문 상세
INSERT INTO shopping_mall.order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 89000), (1, 4, 1, 29000), (1, 9, 1, 25000),  -- 주문1
(2, 3, 1, 55000),                                        -- 주문2
(3, 1, 1, 89000), (3, 6, 2, 18000), (3, 7, 1, 35000),  -- 주문3 (버그: 총액 160000 실제)
(4, 5, 1, 59000),                                        -- 주문4 (취소)
(5, 2, 1, 320000),                                       -- 주문5
(6, 8, 1, 28000), (6, 10, 1, 42000),                    -- 주문6
(7, 8, 1, 28000);                                        -- 주문7

-- 리뷰
INSERT INTO shopping_mall.reviews (user_id, product_id, rating, comment) VALUES
(1, 1, 5, '음질이 정말 좋아요!'),
(1, 9, 4, '입문자용으로 딱 좋습니다'),
(2, 1, 4, '가성비 최고'),
(3, 2, 5, '디자인도 예쁘고 기능도 많아요'),
(4, 8, 5, 'SQL 공부에 정말 도움됐어요'),
(5, 8, 3, '예제가 좀 더 많았으면 좋겠어요');
