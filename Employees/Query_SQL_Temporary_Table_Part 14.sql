-- Pembahasan MySQL Temporary Table [Tabel Sementara]
/*
Jika terdapat sebuah case dimana kita diminta untuk menampilkan
gaji tertinggi dari semua karyawan yang emmiliki jeni kelamin perempuan
dan disini kita diminta untuk membuat temporary table [table sementara],
maka kita bisa menggunkan query pada example 2 dibawah ini:
*/
-- Example 1 [Tanpa Temporary Table]
SELECT
	s.emp_no,
    MAX(s.salary) AS f_highest_salary
FROM salaries s
JOIN employees e ON s.emp_no = e.emp_no
	AND e.gender = 'F'
GROUP BY 1;

-- Example 2 [Menggunakan Temporary Table]
/*
Query dibawah ini menciptakan sebuah tabel sementara (f_highest_salaries) 
yang berisi informasi tentang gaji tertinggi untuk setiap karyawan perempuan (gender = 'F'). 

Mari kita jelaskan langkah-langkahnya:

CREATE TEMPORARY TABLE:
- Query dimulai dengan perintah untuk membuat tabel sementara yang disebut f_highest_salaries.

SELECT Statement:
- Query ini menggunakan SELECT statement untuk mengambil data 
yang akan dimasukkan ke dalam tabel sementara.

- Tabel salaries di-join dengan tabel employees berdasarkan kolom emp_no.

- Hanya baris-baris dengan gender = 'F' yang diambil dengan menggunakan kondisi WHERE.

- Hasilnya dikelompokkan berdasarkan kolom pertama (emp_no), dan untuk setiap kelompok, 
nilai tertinggi dari kolom salary dihitung menggunakan fungsi agregasi MAX().

INSERT INTO TEMPORARY TABLE:
- Hasil dari SELECT statement tersebut kemudian dimasukkan ke dalam 
tabel sementara f_highest_salaries yang telah dibuat.

Dengan demikian, setelah query dieksekusi, Anda akan memiliki tabel 
sementara f_highest_salaries yang berisi informasi tentang gaji tertinggi 
untuk setiap karyawan perempuan. Tabel ini hanya bersifat sementara dan akan 
dihapus setelah sesi koneksi SQL tertutup.

*/
CREATE TEMPORARY TABLE f_highest_salaries
SELECT
	s.emp_no,
    MAX(s.salary) AS f_highest_salary
FROM salaries s
JOIN employees e ON s.emp_no = e.emp_no
	AND e.gender = 'F'
GROUP BY 1;

# Show Temporary Table
SELECT *
FROM f_highest_salaries;

# Show Temporary Table dengan target 'emp_no'
SELECT *
FROM f_highest_salaries
WHERE emp_no <= '10010';

/*
Untuk menghapus Temporary Table terdapat 2 cara, diantaranya:
1. DROP TABLE IF EXISTS name_temporary_table
2. DROP TEMPORARY TABLE IF EXISTS name_temporary_table
*/
-- Cara 1
DROP TABLE IF EXISTS f_highest_salaries;

-- Cara 2
DROP TEMPORARY TABLE IF EXISTS f_highest_salaries;

/*
Coba Show Temporary Table kembali (Harusnya Output yang muncul adalah Error)
hal ini dikarenakan sebelumnya Temporary Table sudah kita hapus, jika memang ingin
dijalankan kembali maka kita harus melakukan CREATE TEMPORARY TABLE kembali.
*/
SELECT *
FROM f_highest_salaries;

/*
NOTE:
Temporary Table hanya bisa digunakan pada satu session saja pada MySQL
jika kita melakukan reconnect pada database maka temporary table yang sudah
kita buat sebelumnya akan hilang dan jika kita memang ingin menggunakannya kembali maka
kita bisa membuatnya kembali.
*/

-- Exercise Number 1
/*
Store the highest contract salary values of all male 
employees in a temporary table called male_max_salaries.
*/
CREATE TEMPORARY TABLE male_max_salaries
SELECT
	s.emp_no,
    MAX(s.salary) AS m_highest_salary
FROM salaries s
JOIN employees e ON s.emp_no = e.emp_no
	AND e.gender = 'M'
GROUP BY 1;

-- Exercise Number 2
/*
Write a query that, upon execution, allows you to check the result 
set contained in the male_max_salaries temporary table you created in the previous exercise.
*/
# Show Temporary Table male_max_salaries
SELECT *
FROM male_max_salaries;

/*------------------------------------------------------------------------------------*/

-- Other Features of MySQL Temporary Tables [Fitur Lainnya Pada Table Sementara]
-- Example 1
# Hapus Temporary Table
DROP TEMPORARY TABLE IF EXISTS f_highest_salaries;

# Buat Temporary Table
CREATE TEMPORARY TABLE f_highest_salaries
SELECT
	s.emp_no,
    MAX(s.salary) AS f_highest_salary
FROM salaries s
JOIN employees e ON s.emp_no = e.emp_no
	AND e.gender = 'F'
GROUP BY 1
LIMIT 10;

# Show Temporary Table
SELECT *
FROM f_highest_salaries;

-- Example 2 [Menggunakan CTE dan JOIN untuk menggabungkan Temporary Table sebelumnya]
WITH cte AS(
	SELECT
		s.emp_no,
        MAX(s.salary) AS f_highest_salary
	FROM salaries s
    JOIN employees e ON s.emp_no = e.emp_no
		AND e.gender = 'F'
	GROUP BY 1
    LIMIT 10
)-- Hasilnya sama saja sebenarnya hanya terdapat tamnbahan pada kolom baru yang sama juga (menyamping ke kanan)
SELECT *
FROM f_highest_salaries f1 JOIN cte c;

-- Example 3 [Menggunakan UNION ALL]
WITH cte AS(
	SELECT
		s.emp_no,
        MAX(s.salary) AS f_highest_salary
	FROM salaries s
    JOIN employees e ON s.emp_no = e.emp_no
		AND e.gender = 'F'
	GROUP BY 1
    LIMIT 10
)
SELECT *
FROM f_highest_salaries f1
UNION ALL
SELECT *
FROM cte;

-- Example 4
/*
Query dibawah ini bertujuan untuk membuat tabel sementara (dates) 
yang berisi informasi tanggal dan waktu. 

Mari kita jelaskan langkah-langkahnya:

CREATE TEMPORARY TABLE:
- Query dimulai dengan perintah untuk membuat tabel sementara yang disebut dates.

SELECT Statement:
- Query menggunakan SELECT statement untuk membuat hasil 
yang akan dimasukkan ke dalam tabel sementara.

- NOW() AS current_date_and_time: 
Menghasilkan tanggal dan waktu saat ini.

- DATE_SUB(NOW(), INTERVAL 1 MONTH) AS a_month_earlier: 
Menghasilkan tanggal dan waktu satu bulan sebelum saat ini.

- DATE_SUB(NOW(), INTERVAL -1 YEAR) AS a_year_later: 
Menghasilkan tanggal dan waktu satu tahun setelah saat ini.

INSERT INTO TEMPORARY TABLE:
Hasil dari SELECT statement tersebut kemudian dimasukkan 
ke dalam tabel sementara dates yang telah dibuat.

Dengan demikian, setelah query dieksekusi, Anda akan memiliki 
tabel sementara dates yang berisi tiga kolom: current_date_and_time, 
a_month_earlier, dan a_year_later, dengan nilai-nilai yang sesuai. 
Tabel sementara ini hanya bersifat sementara dan akan dihapus 
setelah sesi koneksi SQL tertutup.

*/
CREATE TEMPORARY TABLE dates
SELECT
	NOW() AS current_date_and_time,
    DATE_SUB(NOW(), INTERVAL 1 MONTH) AS a_month_earlier,
    DATE_SUB(NOW(), INTERVAL -1 YEAR) AS a_year_later;

# Show Temporary Table
SELECT *
FROM dates;

-- Example 5 [Temporary Table yang dibuat sebelumnya kita akan JOIN bersama dengan CTE]
WITH cte AS(
	SELECT
	NOW() AS current_date_and_time,
    DATE_SUB(NOW(), INTERVAL 1 MONTH) AS a_month_earlier,
    DATE_SUB(NOW(), INTERVAL -1 YEAR) AS a_year_later
) -- Hasilnya sama saja sebenarnya hanya terdapat tamnbahan pada kolom baru yang sama juga (menyamping ke kanan)
SELECT * FROM dates d1 JOIN cte c; 

WITH cte AS(
	SELECT
	NOW() AS current_date_and_time,
    DATE_SUB(NOW(), INTERVAL 1 MONTH) AS a_month_earlier,
    DATE_SUB(NOW(), INTERVAL -1 YEAR) AS a_year_later
) -- Hasilnya sama saja sebenarnya hanya terdapat tamnbahan pada kolom baru yang sama juga
SELECT * FROM dates 
UNION ALL
SELECT *
FROM cte; -- Jika memakai UNION ALL maka hasil yang sama akan digabungkan kebawah

-- Exercise Number 1
/*
Create a temporary table called dates containing the following three columns:
- one displaying the current date and time,
- another one displaying two months earlier than the current date and time, and a
- third column displaying two years later than the current date and time.
*/
CREATE TEMPORARY TABLE tempo_dates
SELECT
	NOW() AS current_date_and_time,
    DATE_SUB(NOW(), INTERVAL 2 MONTH) AS two_months_earlier,
    DATE_SUB(NOW(), INTERVAL -2 YEAR) AS two_years_later;

-- Exercise Number 2
/*
Write a query that, upon execution, allows you to check the result 
set contained in the dates temporary table you created in the previous exercise.
*/
SELECT *
FROM tempo_dates;

-- Exercise Number 3
/*
Create a query joining the result sets from the dates temporary 
table you created during the previous lecture with a new 
Common Table Expression (CTE) containing the same columns. 
Let all columns in the result set appear on the same row.
*/
WITH cte_temp AS(
	SELECT
	NOW() AS current_date_and_time,
    DATE_SUB(NOW(), INTERVAL 2 MONTH) AS two_months_earlier,
    DATE_SUB(NOW(), INTERVAL -2 YEAR) AS two_years_later
)
SELECT *
FROM tempo_dates td JOIN cte_temp ct;

-- Exercise Number 4
/*
Again, create a query joining the result sets from the dates temporary 
table you created during the previous lecture with a new Common Table Expression (CTE) 
containing the same columns. This time, combine the two sets vertically.
*/
WITH cte_temp AS(
	SELECT
	NOW() AS current_date_and_time,
    DATE_SUB(NOW(), INTERVAL 1 MONTH) AS months_earlier,
    DATE_SUB(NOW(), INTERVAL -1 YEAR) AS years_later
)
SELECT *
FROM dates 
UNION
SELECT *
FROM cte_temp;

-- Exercise Number 5
/*
Drop the male_max_salaries and dates temporary tables you recently created.
*/

-- Hapus Temporary Table male_max_salary
DROP TEMPORARY TABLE IF EXISTS male_max_salary;

-- Hapus Temporary Table tempo_dates
DROP TEMPORARY TABLE IF EXISTS tempo_dates;

/*------------------------------------------------------------------------------------*/