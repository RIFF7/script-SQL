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



/*------------------------------------------------------------------------------------*/