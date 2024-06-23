--BAI 1
SELECT COUNTRY.Continent, ROUND(AVG(CITY.Population),0)
from COUNTRY 
INNER JOIN CITY 
on  CITY.CountryCode=COUNTRY.Code
GROUP BY COUNTRY.Continent

--BAI2 - bai nay em chay khong ra ket qua chinh xax no ghi la 0.00? ma giong nhu trong giải em chỉ alias lại đúng tên bản thôi?

SELECT 
ROUND(COUNT(b.email_id)::DECIMAL 
/COUNT(DISTINCT a.email_id), 2) AS activation_rate
FROM emails AS a
LEFT JOIN texts AS b 
ON a.email_id = b.email_id 
AND b.signup_action = 'confirmed';

--Xong rồi em code lại bằng cái hàm CAST như này thì nó k chạy được nữa luôn
SELECT 
CAST(ROUND(COUNT(b.email_id)::DECIMAL 
/COUNT(DISTINCT a.email_id), 2) AS DECIMAL) AS activation_rate
FROM emails AS a
LEFT JOIN texts AS b 
ON a.email_id = b.email_id 
AND b.signup_action = 'confirmed';

--bai3
SELECT 
b.age_bucket, 
ROUND(100.0*
  SUM(a.time_spent) filter (where a.activity_type = 'send')/
  SUM(a.time_spent),2) as send_perc,
ROUND(100.0*
  SUM(a.time_spent) filter (where a.activity_type = 'open')/
  SUM(a.time_spent),2) as open_perc
FROM activities as a
LEFT JOIN age_breakdown as b
on a.user_id = b.user_id
where a.activity_type in ('send', 'open')  
group by b.age_bucket

--bai 4. bài này em muốn code kiểu chọn khách hàng với điều kiện là mua sản phẩm từ cả 3 categorize 'where b.product_category in ('Analytics', 'compute', 'containers')' nhưng mà kết quả vẫn chưa đúng ạ 
SELECT 
a.customer_id
FROM customer_contracts AS a
INNER JOIN products as b 
on a.product_id=b.product_id
where b.product_category in ('Analytics', 'compute', 'containers')
group by a.customer_id
order by customer_id;

--bai 5 (cai nay la SELF JOIN)
SELECT 
    a.employee_id,
    a.name,
    COUNT(b.employee_id) AS reports_count,
    ROUND(AVG(b.age), 0) AS average_age
FROM Employees as a
JOIN Employees as b
ON a.employee_id = b.reports_to
GROUP BY a.employee_id, a.name
HAVING COUNT(b.employee_id) > 0
ORDER BY a.employee_id;

--bai 6 
select a.product_name, 
sum(b.unit) as unit from products as a 
left join orders as b 
on a.product_id=b.product_id
where order_date between '2020-02-01' and '2020-02-29' 
group by a.product_name
having sum(b.unit)>=100

--bai7 
SELECT a.page_id FROM pages as a 
LEFT JOIN page_likes as b
on a.page_id=b.page_id
where b.liked_date is NULL
order by a.page_id
