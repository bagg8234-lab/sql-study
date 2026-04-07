# SQL Study

SQL 학습을 위한 토이프로젝트 모음입니다.

## 프로젝트 목록

### 🛒 shopping-mall
MySQL 기반 쇼핑몰 데이터베이스 설계 및 쿼리 연습

**사용 기술:** MySQL 8.0

**테이블 구조**
- `users` 회원
- `categories` 카테고리
- `products` 상품
- `orders` 주문
- `order_items` 주문 상세
- `reviews` 리뷰

## 학습 내용

- JOIN (INNER, LEFT)
- 서브쿼리 / NOT EXISTS
- GROUP BY / HAVING
- 집계 함수 (COUNT, SUM, AVG, MAX)
- 윈도우 함수 (RANK, ROW_NUMBER, LAG, LEAD, SUM OVER)
- CTE (WITH절)

## 파일 구성

```
shopping-mall/
├── schema.sql    # 테이블 생성
├── data.sql      # 샘플 데이터
└── queries.sql   # 미션별 쿼리 풀이 (주석 포함)
```


## 앞으로 추가 예정
- Spark SQL 실습
