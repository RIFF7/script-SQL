-- PENGGUNAAN SELECT STATEMENT

-- Menampilkan keseluruhan data employees
SELECT 
    *
FROM
    employees; -- Total rows ada 1000, karena limit yang diatur ada 1000 di workbench

-- Query dibawah akan menampilkan semua data table employees dengan limit 10
SELECT 
    *
FROM
    employees
LIMIT 10;

-- Query dibawah akan menampilkan 2 data column
SELECT 
    first_name, last_name
FROM
    employees;

/*------------------------------------------------------------------------------------*/

-- Query dibawah akan menampilkan 1 data kolom pada table departments
SELECT 
    dept_no
FROM
    departments;

-- Query dibawah akan menampilkan semua data kolom pada table departments
SELECT 
    *
FROM
    departments;

/*------------------------------------------------------------------------------------*/

-- Masuk pada Pembahasan terkait clase WHERE
SELECT 
    *
FROM
    employees
/*
Perintah dibawah akan melakukan filter pada database 
dengan first_name 'Elvis' saja yang akan ditampilkan
*/
WHERE
    first_name = 'Elvis';

-- Penggunaan logika AND bersamaan dengan clause WHERE
SELECT 
    *
FROM
    employees
/* Penggunaan query dibawah akan melakukan filter 
untuk first_name yang akan ditampilkan adalah 'Denis' dan gendernya adalah 'M'
penggunaan AND disini adalah sebagai logic, dimana jika keduanya TRUE 
maka data yang akan ditampilkan TRUE juga
*/    
WHERE
    first_name = 'Denis' AND gender = 'M';

SELECT 
    *
FROM
    employees
/*
Ini akan menampilkan data karyawan dimana first_name adalah 'Kellie'
dan gender yang dicari adalah 'F' (Female)
*/
WHERE
    first_name = 'Kellie' AND gender = 'F';

-- Penggunaan logika OR pada clause WHERE
SELECT 
    *
FROM
    employees
/*
Penggunaan query dibawah ini akan menampilkan first_name 'Kellie'
atau first_name 'Aruna', karena disini saya menggunakan logika OR
maka data yang ditampilkan adalah seluruh data dengan first_name 'Kellie' dan 'Aruna'
*/
WHERE
    first_name = 'Kellie'
        OR first_name = 'Aruna';

/*------------------------------------------------------------------------------------*/

-- Masuk pada penggabungan logika AND dan OR pada clause WHERE
SELECT 
    *
FROM
    employees
/*
Penggunaan query dibawah ini adalah SALAH, karena hasilnya tidak akan
memunculkan data last_name 'Denis' dengan gender 'M' ataupun 'F'
*/
WHERE
    last_name = 'Denis' AND gender = 'M'
        OR gender = 'F';

-- Solusi dari query diatas
SELECT 
    *
FROM
    employees
/*
Solusinya adalah menempatkan dalam kurung () pada logika atau kondisi kedua
sehingga data yang akan ditampilkan adalah last_name dengan nama 'Denis'
dan gender-nya adalah 'M' ataupun 'F'
*/
WHERE
    last_name = 'Denis'
        AND (gender = 'M' OR gender = 'F');

-- Example 2
SELECT 
    *
FROM
    employees
/*
Query dibawah akan mengambil semua gender 'F' dan data kolom first_name
dengan nama 'Kellie' ataupun 'Aruna'
*/    
WHERE
    gender = 'F'
        AND (first_name = 'Kellie'
        OR first_name = 'Aruna');

/*------------------------------------------------------------------------------------*/

-- Penggunaan Operator IN
-- Jika terdapat case dimana kita ingin menampilkan first_name 
-- dengan nama cathie, mark dan nathan disini memang kita dapat menggunakan
-- logika OR, namun terdapat operator lainnya yang lebih simple, yaitu IN

-- Example OR
SELECT 
    *
FROM
    employees
WHERE -- Query ini memang dapat dilakukan, namun tidak terlalu efektif
    first_name = 'Cathie'
        OR first_name = 'Mark'
        OR first_name = 'Nathan';

-- Example 2
SELECT 
    *
FROM
    employees
WHERE -- Query dibawah ini akan lebih efektif untuk mencari, dibanding query Example 1
    first_name IN ('Cathie' , 'Mark', 'Nathan');

-- Exercise
SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Denis' , 'Elvis');

/*------------------------------------------------------------------------------------*/

-- Penggunaan NOT IN
SELECT 
    *
FROM
    employees
WHERE -- Query ini akan menampilkan data selain 3 nama first_name
    first_name NOT IN ('Cathie' , 'Mark', 'Nathan');

-- Exercise
SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('John' , 'Mark', 'Jacob');

/*------------------------------------------------------------------------------------*/

-- Penggunaa operator LIKE
-- Penggunaan Wildcard Characters pada LIKE
-- ( % ) - ( _ ) - ( * )

-- Example 1
SELECT 
    *
FROM
    employees
/*
Query dibawah akan menampilkan data first_name dengan awalan 'Mar'
penggunaan % diakhir kata menunjukkan bahwa kata awal yang dicari
*/
WHERE
    first_name LIKE ('Mar%');

-- Example 2
SELECT 
    *
FROM
    employees
/*
Penggunaan Query dibawah akan menampilkan data first_name
yang mana diakhiri dengan kata 'Mar', penggunaan % diakhir juga
menunjukkan bahwa kata yang dicari adalah kata yang diakhiri dengan 
filter yang dicari
*/
WHERE
    first_name LIKE ('%Mar');

-- Example 3
SELECT 
    *
FROM
    employees
/*
Query dibawah akan melakukan filter data pada kolom first_name,
dimana data yang memiliki awalan ataupun akhiran 'ir' akan ditampilkan
*/
WHERE
    first_name LIKE ('%ir%');

-- Example 4
SELECT 
    *
FROM
    employees
/*
Penggunaan Query dibawah akan menampilkan data pada kolom first_name
dengan awalan 'Mar' dan akan ditampilkan sebanyak 4 karakter saja.
Ini disebabkan karena penggunaan underscore ( _ ).
*/
WHERE
    first_name LIKE ('Mar_');

-- Exercise Number 1
/*
Working with the “employees” table, use the LIKE operator 
to select the data about all individuals, whose first name starts with “Mark”; 
specify that the name can be succeeded by any sequence of characters.
*/
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('Mark%');

-- Exercise Number 2
/*
Retrieve a list with all employees who have been hired in the year 2000.
*/
SELECT 
    *
FROM
    employees
WHERE
    hire_date LIKE ('%2000%');

-- Exercise Number 3
/*
Retrieve a list with all employees whose employee 
number is written with 5 characters, and starts with “1000”.
*/
SELECT 
    *
FROM
    employees
WHERE
    emp_no LIKE ('1000_');

-- Exercise Number 4
/*
Extract all individuals from the ‘employees’ table whose first name contains “Jack”.
*/
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('Jack%');

/*------------------------------------------------------------------------------------*/

-- Penggunaan operator NOT LIKE
-- Example 1
SELECT 
    *
FROM
    employees
/*
Query dibawah tidak akan menampilkan data first_name dengan awalan 'Mar'
penggunaan % diakhir kata menunjukkan bahwa kata awal yang dicari
*/
WHERE
    first_name NOT LIKE ('Mar%');

-- Example 2
SELECT 
    *
FROM
    employees
/*
Penggunaan Query dibawah tidak akan menampilkan data first_name
yang mana diakhiri dengan kata 'Mar', penggunaan % diakhir juga
menunjukkan bahwa kata yang dicari adalah kata yang diakhiri dengan 
filter yang dicari
*/
WHERE
    first_name NOT LIKE ('%Mar');

-- Example 3
SELECT 
    *
FROM
    employees
/*
Query dibawah tidak akan melakukan filter data pada kolom first_name,
dimana data yang memiliki awalan ataupun akhiran 'ir' akan ditampilkan
*/
WHERE
    first_name NOT LIKE ('%ir%');

-- Example 4
SELECT 
    *
FROM
    employees
/*
Penggunaan Query dibawah tidak akan menampilkan data pada kolom first_name
dengan awalan 'Mar' dan akan ditampilkan sebanyak 4 karakter saja.
Ini disebabkan karena penggunaan underscore ( _ ).
*/
WHERE
    first_name NOT LIKE ('Mar_');

-- Exercise Number 1
/*
Once you have done that, extract another list 
containing the names of employees that do not contain “Jack”.
*/
SELECT 
    *
FROM
    employees
WHERE
    first_name NOT LIKE ('Jack%');

/*------------------------------------------------------------------------------------*/

-- Penggunaan BETWEEN dan NOT BETWEEN
-- BETWEEN
SELECT 
    *
FROM
    employees
/*
Query dibawah akan memerintahkan SQL untuk mencari
hire_date antara 1990-01-01 sampai 2000-01-01
*/
WHERE
    hire_date BETWEEN '1990-01-01' AND '2000-01-01';

-- NOT BETWEEN
SELECT 
    *
FROM
    employees
/*
Query dibawah akan menampilkan data hire_date tidak diantara
1990-01-01 sampai 200-01-01
*/
WHERE
    hire_date NOT BETWEEN '1990-01-01' AND '2000-01-01';

-- Execise Number 1
/*
Select all the information from the “salaries” 
table regarding contracts from 66,000 to 70,000 dollars per year.
*/
SELECT 
    *
FROM
    salaries
WHERE
    salary BETWEEN 66000 AND 70000;

-- Exercise Number 2
/*
Retrieve a list with all individuals whose 
employee number is not between ‘10004’ and ‘10012’.
*/
SELECT 
    *
FROM
    employees
WHERE
    emp_no NOT BETWEEN 10004 AND 10012;

-- Exercise Number 3
/*
Select the names of all departments with 
numbers between ‘d003’ and ‘d006’.
*/

SELECT 
    *
FROM
    departments
WHERE
    dept_no BETWEEN 'd003' AND 'd006'
ORDER BY dept_no;

/*------------------------------------------------------------------------------------*/

-- Penggunaan IS NOT NULL dan IS NULL
-- IS NOT NULL
SELECT 
    *
FROM
    employees
/*
Query dibawah akan menampilkan data pada kolom first_name
yang tidak bernilai NULL dengan operator IS NOT NULL
*/
WHERE
    first_name IS NOT NULL;

-- IS NULL
SELECT 
    *
FROM
    employees
/*
Query dibawah akan melakukan pengecekan pada kolom first_name
apakah data terdapat yang nilainya NULL atau tidak menggunakan
operator IS NULL
*/
WHERE
    first_name IS NULL;

-- Exercise Number 1
SELECT 
    *
FROM
    departments
WHERE
    dept_no IS NOT NULL;

-- Exercise Number 2
SELECT 
    *
FROM
    departments
WHERE
    dept_no IS NULL;

/*------------------------------------------------------------------------------------*/

-- Penggunaan Comparison Operator (operator perbandingan)
/*
So far:
- BETWEEN ... AND ...
- LIKE
- NOT LIKE
- IS NOT NULL
- IS NULL

and another comparison operator in symbol:
=	: equal to
>	: greater than
>=	: greater than equal to
<	: less than
<=	: less than equal to
<>	: not equal
!=	: not equal
*/

SELECT 
    *
FROM
    employees
/*
Query dibawah akan menampilkan data kolom hire_date
pada rentang waktu lebih dari 200-01-01
*/
WHERE
    hire_date > '2000-01-01';
    
SELECT 
    *
FROM
    employees
/*
Query dibawah akan menampilkan data kolom hire_date
pada rentang waktu lebih dari sama dengan 200-01-01
*/
WHERE
    hire_date >= '2000-01-01';

SELECT 
    *
FROM
    employees
/*
Query dibawah akan menampilkan data kolom first_name
dengan nama Mark
*/
WHERE
    first_name = 'Mark';
    
SELECT 
    *
FROM
    employees
/*
Query dibawah akan menampilkan data kolo firs_name
yang tidak sama dengan 'Mark'
*/
WHERE
    first_name != 'Mark';

-- Exercise Number 1
/*
Retrieve a list with data about all female 
employees who were hired in the year 2000 or after.
*/
SELECT 
    *
FROM
    employees
WHERE
    gender = 'F' AND hire_date >= '2000-01-01';

-- Exercise Number 2
/*
Extract a list with all employees’ 
salaries higher than $150,000 per annum.
*/
SELECT 
    *
FROM
    salaries
WHERE
    salary > 150000;

/*------------------------------------------------------------------------------------*/

-- Penggunaan DISTINCT
/*
Penggunaan DISTINCT disini akan mencegah data
yang akan ditampilkan tidak ada yang di duplikat sama sekali
*/
SELECT DISTINCT
    gender
FROM
    employees;

-- Exercise Number 1
/*
Obtain a list with all different “hire dates” from the “employees” table.

Expand this list and click on “Limit to 1000 rows”. 
This way you will set the limit of output rows displayed back to the default of 1000.

In the next lecture, we will show you how to manipulate the limit rows count. 
*/
SELECT DISTINCT
    hire_date
FROM
    employees;
    
/*------------------------------------------------------------------------------------*/

-- Penggunaan Aggregate Function
/*
- COUNT()
- SUM()
- MIN()
- MAX()
- AVG()
*/

SELECT 
    /*
    Fungsi COUNT() akan melakukan perhitungan record pada data column emp_no
    */
    COUNT(emp_no)
FROM
    employees;

SELECT 
    /*
    Fungsi COUNT() akan melakukan perhitungan record pada data column first_name
    */
    COUNT(first_name)
FROM
    employees;

SELECT 
    /*
    Fungsi COUNT(DISTINCT ... ) akan melakukan perhitungan 
    tanpa adanya duplikat pada column first_name
    */
    COUNT(DISTINCT first_name)
FROM
    employees;

-- Exercise Number 1
/*
How many annual contracts with 
a value higher than or equal to $100,000 
have been registered in the salaries table?
*/
SELECT 
    COUNT(*) AS higher_salary
FROM
    salaries
WHERE
    salary >= 100000;

-- Exercise Number 2
/*
How many managers do we have in the “employees” database? 
Use the star symbol (*) in your code to solve this exercise.
*/
SELECT 
    COUNT(*) AS total_manager
FROM
    dept_manager;
    
/*------------------------------------------------------------------------------------*/

-- Pengggunaan ORDER BY
SELECT 
    *
FROM
    employees
ORDER BY first_name; -- Ini akan auto ASC atau diurutkan dari abjad awal

SELECT 
    *
FROM
    employees
ORDER BY first_name DESC; -- ini akan DESC atau diurutkan dari abjad bawah

-- Exercise Number 1
/*
Select all data from the “employees” table, ordering it by “hire date” in descending order.
*/
SELECT 
    *
FROM
    employees
ORDER BY hire_date DESC;

/*------------------------------------------------------------------------------------*/

-- Penggunaan GROUP BY

-- Example tidak menggunakan GROUP BY
/*
Query dibawah akan menampilkan keseluruhan data
pada kolom first_name, sehingga data duplikat juga akan selalu ditampilkan
*/
SELECT 
    first_name
FROM
    employees;

-- Menggunakan fungsi GROUP BY
SELECT 
    first_name
FROM
    employees
/* 
Ketika kita menggunakan GROUP BY pada suatu kolom yang kita pilih
maka nantinya data dari kolom ini jika didalamnya terdapat kesamaan
maka hanya ditampilkan satu saja, fungsi ini sama dengan DISTINCT
*/
GROUP BY first_name;

/* 
Perlu diketahui juga GROUP BY biasa digunakan ketika kita menggunakan
fungsi aggregate dalam query yang kita olah
*/

-- Example 1
/*
Mencari banyaknya nama pada kolom first_name lalu kelompokkan berdasarkan DESC atau ASC
*/

SELECT 
    first_name, COUNT(first_name) AS jumlah_nama
FROM
    employees
GROUP BY first_name
ORDER BY jumlah_nama DESC;

-- Exercise 1
/*
Using Aliases (AS) - exercise

This will be a slightly more sophisticated task.

Write a query that obtains two columns. 
The first column must contain annual salaries higher than 80,000 dollars. 
The second column, renamed to “emps_with_same_salary”, 
must show the number of employees contracted to that salary. 
Lastly, sort the output by the first column.

*/
-- Step 1: Explore the column
SELECT 
    *
FROM
    salaries;

-- Step 2: Build query
SELECT 
    salary, COUNT(emp_no) AS emps_with_same_salary
FROM
    salaries
WHERE
    salary > 80000
GROUP BY salary
ORDER BY salary;

/*------------------------------------------------------------------------------------*/

-- Penggunaan fungsi HAVING
/*
Secara penggunaan HAVING hampir mirip dengan WHERE,
hanya saja untuk WHERE kita tidak dapat menggunakannya
untuk melakukan agregate, namun untuk HAVING disini kita dapat 
menggunakannya untuk melakukan aggrefate function
*/

-- Example aggregate function with clause WHERE
/*
Semisal kita ingin mencari nama depan yang muncul pada
kolom first_name yang lebih dari 250x munculnya dengan
menggunakan cluase WHERE. Ketika query dibawah dijalankan
maka workbench akan menampilkan hasil error, karena clause WHERE
tidak bisa digunakan untuk fungsi aggregate!
*/
SELECT 
    first_name, COUNT(first_name) AS name_count
FROM
    employees
WHERE
    COUNT(first_name) > 250
GROUP BY first_name
ORDER BY first_name;

/*
Namun untuk menyelesaikan case diatas, disini kita dapat
mengubah penggunaan WEHERE menjadi HAVING untuk menemukan data
pada kolom first_name yang muncul lebih dari 250x
*/

-- Example Menggunakan fungsi HAVING
/*
Perlu untuk diingat juga, bahwa penggunaan HAVING
dapat berjalan setelah GROUP BY dan diatas ORDER BY
bukan sebelum atau setelah penulisan dari 2 fungsi tersebut
tapi persis ditengah 2 fungsi itu.
*/
SELECT 
    first_name, COUNT(first_name) AS name_count
FROM
    employees
GROUP BY first_name
HAVING COUNT(first_name) > 250
ORDER BY first_name;

-- Exercise Number 1
/*
Select all employees whose average salary is higher than $120,000 per annum.
Hint: You should obtain 101 records.
*/

SELECT 
    *
FROM
    salaries;

SELECT 
    emp_no, AVG(salary) AS higher_salary_120K
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000
ORDER BY emp_no;

/*------------------------------------------------------------------------------------*/

-- Penggunaan WHERE vs HAVING
-- Exrcise Number 1
/*
Extract a list of all names that are encountered less than 200 times.
Let the data refer to people hired after the 1st of january 1999.
*/

-- Sebelum penggunaan WHERE dan HAVING
SELECT 
    first_name, COUNT(first_name) AS name_count
FROM
    employees
GROUP BY first_name;

-- Setelah pengunaan WHERE dan HAVING
SELECT 
    first_name, COUNT(first_name) AS name_count
FROM
    employees
WHERE
    hire_date > '1999-01-01' -- Akan melakukan filter pada hire_date setelah 1999-01-01
GROUP BY first_name
HAVING name_count < 200 -- Akan melakukan filter pada first_name karyawan yang totalnya kurang dari 200
ORDER BY first_name DESC;

-- Exercise Number 2
/*
Select the employee numbers of all individuals 
who have signed more than 1 contract after the 1st of January 2000.

Hint: To solve this exercise, use the “dept_emp” table.
*/
-- Explore Data
SELECT 
    *
FROM
    dept_emp;

-- Build query
SELECT 
    emp_no, 
    COUNT(from_date) AS count_date -- Hitung tanggal kontrak
FROM
    dept_emp
WHERE
    from_date > '2000-01-01' -- Filter tanggal kontrak sesuai permintaan
GROUP BY emp_no
HAVING count_date > 1 -- Munculkan kontrak yang lebih dari 1 kali
ORDER BY emp_no; -- Urutkan berdasarkan ASC dari kolom emp_no

/*------------------------------------------------------------------------------------*/

-- Penggunaan LIMIT
-- Example Exercise
/*
Please show me the employee numbers of the 10 highest paid
employees in the database!
*/

SELECT 
    *
FROM
    salaries
ORDER BY salary DESC
LIMIT 10;

-- Exercise Number 1
/*
Select the first 100 rows from the ‘dept_emp’ table. 
*/
SELECT 
    *
FROM
    dept_emp
LIMIT 100;