-- Introduction to MySQL Window Functions

/*------------------------------------------------------------------------------------*/

/*
Seumpama disini kita menDAPATKAN SUATU case dimana kita harus
menentukan ranking dari gaji untuk setiap karyawan yang ada pada
perusahaan, disini kita dapat mengggunakan window function untuk melakukannya
*/
-- Before Use WINDOW FUNCTION
SELECT
	emp_no,
    salary
FROM salaries;

-- After Use WINDOW FUNCTION
/*
Query dibawah menunjukkan penggunaan fungsi ROW_NUMBER() 
dan OVER() yang merupakan bagian dari penggunaan fungsi 
analitik di MySQL. Fungsi ini digunakan untuk memberikan 
nomor baris berdasarkan urutan hasil query.

ROW_NUMBER() OVER() AS row_num: 
Fungsi ROW_NUMBER() digunakan untuk memberikan nomor baris 
untuk setiap baris hasil query. OVER() tidak memiliki 
partisi (partition) yang diatur, yang berarti nomor baris 
akan dihitung untuk seluruh hasil query.

Contoh hasil query mungkin seperti ini:
+--------+--------+---------+
| emp_no | salary | row_num |
+--------+--------+---------+
|   1001 | 50000  |    1    |
|   1002 | 60000  |    2    |
|   1003 | 55000  |    3    |
|   ...  |  ...   |   ...   |
+--------+--------+---------+

Dengan menggunakan ROW_NUMBER() OVER(), setiap baris akan mendapatkan 
nomor baris sesuai dengan urutan hasil query. Perlu diingat bahwa tanpa 
menggunakan klausa ORDER BY dalam OVER(), urutan nomor baris mungkin 
tidak dapat diandalkan karena tidak ada urutan yang spesifik yang diberikan 
oleh database. 

Sehingga, jika Anda ingin urutan yang pasti, Anda dapat menambahkan 
ORDER BY dalam OVER() sesuai dengan kolom yang diinginkan.
*/
SELECT
	emp_no,
    salary,
    ROW_NUMBER() OVER() AS row_num
FROM salaries;

-- Use PARTITION BY
/*
Query dibawah menunjukkan penggunaan fungsi analitik ROW_NUMBER() 
dengan klausa PARTITION BY di MySQL. Klausa PARTITION BY membagi 
hasil query menjadi partisi berdasarkan nilai kolom tertentu, 
dan kemudian ROW_NUMBER() dihitung secara terpisah untuk setiap partisi. 

Ini memungkinkan penghitungan nomor baris dimulai ulang untuk setiap nilai 
unik dalam kolom yang dijelaskan dalam klausa PARTITION BY.

ROW_NUMBER() OVER(PARTITION BY emp_no) AS row_num: 
Fungsi ROW_NUMBER() digunakan untuk memberikan nomor baris untuk setiap baris hasil query. 
Klausa PARTITION BY emp_no menginstruksikan database untuk membagi hasil query menjadi 
partisi-partisi yang terpisah berdasarkan nilai unik dalam kolom emp_no. Sehingga, 
nomor baris akan dihitung ulang untuk setiap partisi yang berbeda.

Contoh hasil query mungkin seperti ini:
+--------+--------+---------+
| emp_no | salary | row_num |
+--------+--------+---------+
|   1001 | 50000  |    1    |
|   1001 | 55000  |    2    |
|   1002 | 60000  |    1    |
|   1003 | 55000  |    1    |
|   1003 | 58000  |    2    |
|   ...  |  ...   |   ...   |
+--------+--------+---------+

Dalam contoh ini, nomor baris dihitung secara terpisah untuk setiap nilai 
unik dalam kolom emp_no. Sehingga, nomor baris dimulai ulang ketika nilai emp_no berubah.

*/
SELECT
	emp_no,
    salary,
    ROW_NUMBER() OVER(PARTITION BY emp_no) AS row_num
FROM salaries;

-- Use PARTITION BY ... ORDER BY ... DESC/ASC
/*
NOTE:
PARTITION BY clause is NOT mandatory

Query dibawah menunjukkan penggunaan fungsi analitik ROW_NUMBER() 
dengan klausa PARTITION BY di MySQL, tetapi juga termasuk klausa ORDER BY dalam OVER(). 
Klausa ORDER BY ini digunakan untuk menentukan urutan dalam setiap partisi. 
Dengan kata lain, nomor baris akan dihitung berdasarkan urutan gaji (salary) 
dalam setiap partisi yang diidentifikasi oleh emp_no.

ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY salary DESC) AS row_num: 
Fungsi ROW_NUMBER() digunakan untuk memberikan nomor baris untuk setiap baris hasil query. 
Klausa PARTITION BY emp_no membagi hasil query menjadi partisi-partisi berdasarkan nilai unik 
dalam kolom emp_no. Klausa ORDER BY salary DESC menentukan bahwa urutan gaji (salary) 
dalam setiap partisi akan diurutkan secara menurun (descending), 
sehingga nomor baris akan dihitung berdasarkan gaji tertinggi ke terendah dalam setiap partisi.

Contoh hasil query mungkin seperti ini:
+--------+--------+---------+
| emp_no | salary | row_num |
+--------+--------+---------+
|   1001 | 55000  |    1    |
|   1001 | 50000  |    2    |
|   1002 | 60000  |    1    |
|   1003 | 58000  |    1    |
|   1003 | 55000  |    2    |
|   ...  |  ...   |   ...   |
+--------+--------+---------+

Dalam contoh ini, nomor baris dihitung berdasarkan urutan gaji (salary) 
dalam setiap partisi yang diidentifikasi oleh kolom emp_no, 
dengan urutan gaji tertinggi ke terendah.

*/
SELECT
	emp_no,
    salary,
    ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY salary DESC) AS row_num
FROM salaries;

-- Use ORDER BY ... DESC/ASC
/*
Query dibawah menggunakan fungsi analitik ROW_NUMBER() 
dengan klausa OVER() yang mencakup ORDER BY untuk memberikan 
nomor baris berdasarkan urutan tertentu dari seluruh hasil query. 
Dalam kasus ini, nomor baris dihitung berdasarkan urutan gaji (salary) 
secara menurun (descending) dari seluruh tabel.

ROW_NUMBER() OVER(ORDER BY salary DESC) AS row_num: 
Fungsi ROW_NUMBER() digunakan untuk memberikan nomor baris untuk setiap baris hasil query. 
Klausa ORDER BY salary DESC menentukan bahwa urutan gaji (salary) dalam seluruh hasil query 
akan diurutkan secara menurun (descending), sehingga nomor baris akan dihitung berdasarkan 
gaji tertinggi ke terendah dalam seluruh tabel.

Contoh hasil query mungkin seperti ini:
+--------+--------+---------+
| emp_no | salary | row_num |
+--------+--------+---------+
|   1002 | 60000  |    1    |
|   1003 | 58000  |    2    |
|   1001 | 55000  |    3    |
|   ...  |  ...   |   ...   |
+--------+--------+---------+

Dalam contoh ini, nomor baris dihitung berdasarkan urutan gaji (salary) 
dari terbesar ke terkecil dalam seluruh tabel.

*/
SELECT
	emp_no,
    salary,
    ROW_NUMBER() OVER(ORDER BY salary DESC) AS row_num
FROM salaries;

-- Exercise Number 1
/*
Write a query that upon execution, assigns a row number 
to all managers we have information for in the "employees" 
database (regardless of their department).

Let the numbering disregard the department the managers have worked in. 
Also, let it start from the value of 1. 
Assign that value to the manager with the lowest employee number.
*/
SELECT
	emp_no,
    dept_no,
    ROW_NUMBER() OVER(ORDER BY emp_no ASC) AS row_num
FROM dept_manager;

-- Exercise Number 2
/*
Write a query that upon execution, assigns a sequential number 
for each employee number registered in the "employees" table. 
Partition the data by the employee's first name and order it by 
their last name in ascending order (for each partition).
*/
SELECT
	emp_no,
    first_name,
    last_name, 
    ROW_NUMBER() OVER(PARTITION BY first_name ORDER BY last_name ASC) AS row_num
FROM employees;

/*------------------------------------------------------------------------------------*/

-- Catatan tentang Penggunaan Beberapa Fungsi Window Functions dalam query
-- Example 1
/*
Query dibawah menggunakan fungsi analitik ROW_NUMBER() 
bersama dengan klausa OVER(), PARTITION BY, dan ORDER BY untuk memberikan 
berbagai nomor baris berdasarkan kondisi dan urutan tertentu. 

- emp_no: 
Kolom yang berisi nomor pegawai.

- salary: 
Kolom yang berisi gaji.

- ROW_NUMBER() OVER() AS row_num1: 
Nomor baris dihitung secara global tanpa partisi dan urutan tertentu.

- ROW_NUMBER() OVER(PARTITION BY emp_no) AS row_num2: 
Nomor baris dihitung untuk setiap partisi yang diidentifikasi oleh kolom emp_no.

- ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY salary DESC) AS row_num3: 
Nomor baris dihitung untuk setiap partisi yang diidentifikasi oleh kolom emp_no, 
dan diurutkan berdasarkan gaji secara menurun (descending) dalam setiap partisi.

ROW_NUMBER() OVER(ORDER BY salary DESC) AS row_num4: 
Nomor baris dihitung secara global, dan diurutkan berdasarkan gaji 
secara menurun (descending) dalam seluruh tabel.

ORDER BY 1, 2: 
Hasil query diurutkan berdasarkan kolom pertama (emp_no) 
secara menaik (ascending), kemudian kolom kedua (salary) 
secara menaik (ascending) juga.

Contoh hasil query mungkin seperti ini:
+--------+--------+---------+---------+---------+---------+
| emp_no | salary | row_num1| row_num2| row_num3| row_num4|
+--------+--------+---------+---------+---------+---------+
|   1001 | 50000  |    1    |    1    |    1    |    4    |
|   1001 | 55000  |    2    |    2    |    2    |    3    |
|   1002 | 60000  |    3    |    1    |    1    |    1    |
|   1003 | 55000  |    4    |    1    |    1    |    2    |
|   1003 | 58000  |    5    |    2    |    2    |    1    |
|   ...  |  ...   |   ...   |   ...   |   ...   |   ...   |
+--------+--------+---------+---------+---------+---------+

Dalam contoh ini, setiap kolom row_num menunjukkan nomor baris 
yang dihitung berdasarkan kondisi dan urutan tertentu.

*/
SELECT
	emp_no,
    salary,
    ROW_NUMBER() OVER() AS row_num1,
    ROW_NUMBER() OVER(PARTITION BY emp_no) AS row_num2,
    ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY salary DESC) AS row_num3,
    ROW_NUMBER() OVER(ORDER BY salary DESC) AS row_num4
FROM
	salaries
ORDER BY 1, 2;

-- Example 2
/*
Query dibawah menggunakan fungsi analitik ROW_NUMBER() 
bersama dengan klausa OVER() dan PARTITION BY di MySQL.

- emp_no: 
Kolom yang berisi nomor pegawai.

- salary: 
Kolom yang berisi gaji.

- ROW_NUMBER() OVER(PARTITION BY emp_no) AS row_num2: 
Nomor baris dihitung untuk setiap partisi yang diidentifikasi oleh kolom emp_no. 
Dalam hal ini, nomor baris dihitung ulang untuk setiap nilai unik dalam kolom emp_no.

- ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY salary DESC) AS row_num3: 
Nomor baris dihitung untuk setiap partisi yang diidentifikasi oleh kolom emp_no, 
dan diurutkan berdasarkan gaji secara menurun (descending) dalam setiap partisi.

Contoh hasil query mungkin seperti ini:
+--------+--------+---------+---------+
| emp_no | salary | row_num2| row_num3|
+--------+--------+---------+---------+
|   1001 | 50000  |    1    |    1    |
|   1001 | 55000  |    2    |    2    |
|   1002 | 60000  |    1    |    1    |
|   1003 | 55000  |    1    |    1    |
|   1003 | 58000  |    2    |    2    |
|   ...  |  ...   |   ...   |   ...   |
+--------+--------+---------+---------+

Dalam contoh ini, row_num2 menunjukkan nomor baris untuk setiap partisi yang 
diidentifikasi oleh kolom emp_no, dan row_num3 menunjukkan nomor baris yang 
dihitung ulang untuk setiap partisi yang diidentifikasi oleh kolom emp_no, 
diurutkan berdasarkan gaji secara menurun (descending) dalam setiap partisi.

*/
SELECT
	emp_no,
    salary,
    ROW_NUMBER() OVER(PARTITION BY emp_no) AS row_num2,
    ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY salary DESC) AS row_num3
FROM
	salaries;

-- Exercise Number 1
/*
Obtain a result set containing the salary values each manager 
has signed a contract for. To obtain the data, refer to the "employees" database.

Use window functions to add the following two columns to the final output:

- a column containing the row number of each row 
from the obtained dataset, starting from 1.

- a column containing the sequential row numbers 
associated to the rows for each manager, where their 
highest salary has been given a number equal to 
the number of rows in the given partition, and their lowest - the number 1.

Finally, while presenting the output, make sure that the data 
has been ordered by the values in the first of the row number columns, 
and then by the salary values for each partition in ascending order.
*/
SELECT
	dm.emp_no,
    s.salary,
    ROW_NUMBER() OVER(PARTITION BY dm.emp_no ORDER BY s.salary ASC) AS row_num1,
    ROW_NUMBER() OVER(PARTITION BY dm.emp_no ORDER BY s.salary DESC) AS row_num2
FROM 
	dept_manager dm
JOIN 
	salaries s ON dm.emp_no = s.emp_no;

-- Exercise Number 2
/*
Obtain a result set containing the salary values each manager 
has signed a contract for. To obtain the data, refer to the "employees" database.

Use window functions to add the following two columns to the final output:

- a column containing the row numbers associated to each manager, 
where their highest salary has been given a number equal to the 
number of rows in the given partition, and their lowest - the number 1.

- a column containing the row numbers associated to each manager, 
where their highest salary has been given the number of 1, 
and the lowest - a value equal to the number of rows in the given partition.

Let your output be ordered by the salary values 
associated to each manager in descending order.

Hint: Please note that you don't need to use an ORDER BY clause 
in your SELECT statement to retrieve the desired output.
*/
SELECT
	dm.emp_no,
    s.salary,
    ROW_NUMBER() OVER() AS row_num1,
    ROW_NUMBER() OVER(PARTITION BY dm.emp_no ORDER BY s.salary DESC) AS row_num2
FROM 
	dept_manager dm
JOIN 
	salaries s ON dm.emp_no = s.emp_no
ORDER BY
	3, 1, 2 ASC;

/*------------------------------------------------------------------------------------*/

-- MySQL Window Functions Syntax
-- Example 1
SELECT
	emp_no,
    salary,
    ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY salary DESC) AS row_num
FROM
	salaries;

-- Example 2
/*
Pada query dibawah ini sebenarnya output yang dihasilkan
akan tetap sama seperti pada query Example 1, namun pada example 2
ini penulisan window function akan sedikit berbeda dari biasanya.
*/
SELECT
	emp_no,
    salary,
    ROW_NUMBER() OVER w AS row_num
FROM
	salaries
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

-- Exercise Number 1
/*
Write a query that provides row numbers for all workers 
from the "employees" table, partitioning the data by their 
first names and ordering each partition by their employee number in ascending order.

NB! While writing the desired query, do *not* use an ORDER BY clause 
in the relevant SELECT statement. At the same time, do use a WINDOW clause 
to provide the required window specification.
*/
SELECT
	emp_no,
    first_name,
    ROW_NUMBER() OVER w AS row_num
FROM employees
WINDOW w AS (PARTITION BY first_name ORDER BY emp_no);

/*------------------------------------------------------------------------------------*/

-- The PARTITION BY Clause VS the GROUP BY Clause
-- Example 1
SELECT
	emp_no,
    salary,
    ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY salary DESC) AS row_num
FROM
	salaries;

-- Example 2
SELECT
	a.emp_no,
    MAX(salary) AS max_salary
FROM (
	SELECT
		emp_no,
        salary,
        ROW_NUMBER() OVER w AS row_num
	FROM
		salaries
	WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC)
) AS a
GROUP BY 1;

-- Example 3
SELECT
	a.emp_no,
    MAX(salary) AS max_salary
FROM (
	SELECT
		emp_no,
        salary,
        ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY salary) AS row_num
	FROM
		salaries
) AS a
GROUP BY 1;

-- Exampel 4
SELECT
	a.emp_no,
    MAX(salary) AS max_salary
FROM (
	SELECT
		emp_no,
        salary
	FROM salaries
) AS a
GROUP BY 1;

-- Example 5
-- Exampel 4
SELECT
	a.emp_no,
    MAX(salary) AS max_salary
FROM (
	SELECT
		emp_no,
        salary,
        ROW_NUMBER() OVER w AS row_num
	FROM salaries
    WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC)
) AS a
WHERE a.row_num = 1
GROUP BY 1;

SELECT
	a.emp_no,
    MAX(salary) AS max_salary
FROM (
	SELECT
		emp_no,
        salary,
        ROW_NUMBER() OVER w AS row_num
	FROM salaries
    WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC)
) AS a
WHERE a.row_num = 2
GROUP BY 1;

-- Example 5
SELECT
	emp_no,
    salary,
    ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY salary DESC) AS row_num
FROM salaries;

-- Exercise Number 1
/*

*/


-- Exercise Number 2
/*

*/


-- Exercise Number 3
/*

*/


-- Exercise Number 4
/*

*/


-- Exercise Number 5
/*

*/


/*------------------------------------------------------------------------------------*/



/*------------------------------------------------------------------------------------*/