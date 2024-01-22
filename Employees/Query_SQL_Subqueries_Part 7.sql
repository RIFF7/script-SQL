-- Masuk pada materi penggunaan Subqueries untuk SQL
/*
Untuk subqueries sendiri biasa digunakan pada clause WHERE
namun ada juga beberapa digunakan pada SELECT statement
*/

/*
Semisal disni kita ingin mengambil data dari nama depan dan belakang
pada table employees dengan kolom employees number dapat ditemukan
pada table departments manager
*/

-- check data
-- table [dept_manager]
SELECT 
    *
FROM
    dept_manager;

-- table [employees]
SELECT 
    *
FROM
    employees;

-- Build Subqueries
/*
Ini akan menampilkan semua data pada table employees
dimana data employees number (emp_no) ada juga pada table dept_manager
*/
SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    e.emp_no IN (SELECT 
            dm.emp_no
        FROM
            dept_manager dm);

-- Exercise Number 1
/*
Extract the information about all department managers 
who were hired between the 1st of January 1990 and the 1st of January 1995.
*/

SELECT 
    dm.*
FROM
    dept_manager dm
WHERE
    dm.emp_no IN (SELECT 
            e.emp_no
        FROM
            employees e
        WHERE
            e.hire_date BETWEEN '1990-01-01' AND '1995-01-01')
ORDER BY dm.from_date;
        
/*------------------------------------------------------------------------------------*/

-- SQL subqueries with EXISTS - NOT EXISTS nested inside WHERE
-- Penggunaan EXISTS
/*
Sebenarnya penggunaan EXISTS sama dengan penggunaan IN
namun yang membedakan disini adalah...
EXISTS:
- Pada penggunaan EXISTS, dia akan menguji 
nilai baris untuk mengetahui keberadaannya
- Lalu pada penggunaannya lebih cepat dalam 
mengambil data dalam jumlah besar

Sedangkan IN:
- Pencariannya akan berdasarkan diantara nilai-nilai 
- Penggunaannya lebih cepat ketika data yang diolah
dalam jumlah sedikit
*/

-- EXISTS
SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            dept_manager dm
        WHERE
            dm.emp_no = e.emp_no);

-- EXISTS with ORDER BY
SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            dept_manager dm
        WHERE
            dm.emp_no = e.emp_no
        ORDER BY dm.emp_no);

-- EXISTS dengan penggunaan ORDER BY diluar subqueries
/*
Cara ini lebih logis dilakukan daripada cara diatas,
untuk penempatan ORDER BY. Beberapa profesional 
juga menggunkan cara ini.
*/
SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            dept_manager dm
        WHERE
            dm.emp_no = e.emp_no)
ORDER BY e.emp_no;

-- Exercise Number 1
/*
Select the entire information for all employees 
whose job title is “Assistant Engineer”. 

Hint: To solve this exercise, use the 'employees' table.
*/
SELECT 
    e.*
FROM
    employees e
WHERE
    EXISTS( SELECT 
            t.*
        FROM
            titles t
/*
Pernyataan WHERE t.emp_no = e.emp_no dalam subquery EXISTS adalah 
kunci untuk mengaitkan baris dari tabel employees (e) 
dengan baris di tabel titles (t). Ini menentukan hubungan 
antara kedua tabel berdasarkan kolom emp_no.

t.emp_no = e.emp_no memastikan bahwa ada baris dalam tabel titles 
yang memiliki nilai emp_no yang sama dengan 
nilai emp_no pada baris yang sedang diperiksa di tabel employees.

t.title = 'Assistant Engineer' memastikan bahwa 
posisi pekerjaan adalah 'Assistant Engineer'.
*/
        WHERE
            t.emp_no = e.emp_no
                AND t.title = 'Assistant Engineer');

/*------------------------------------------------------------------------------------*/

-- SQL subqueries nested in SELECT and FROM
-- (Subqueries yang bersarang pada SELECT dan juga FROM)

/*
Example Case:

Assign employee number 110022 as a manager to all employees from
10001 to 10020, and employee number 110039 as a manager to all
employees from 10021 to 10040.

Tetapkan karyawan nomor 110022 sebagai manajer untuk semua 
karyawan dari 10001 hingga 10020, dan karyawan nomor 110039 
sebagai manajer untuk semua karyawan dari 10021 hingga 10040.
*/
-- Explore Data
SELECT 
    emp_no
FROM
    dept_manager
WHERE
    emp_no = 110022;

SELECT 
    MIN(dept_no) AS departments_code
FROM
    dept_emp;

-- Build Query
SELECT 
    e.emp_no AS employee_ID,
    MIN(de.dept_no) AS departments_code,
    (SELECT 
            emp_no
        FROM
            dept_manager
        WHERE
            emp_no = 110022) AS manager_ID
FROM
    employees e
        JOIN
    dept_emp de ON e.emp_no = de.emp_no
WHERE
    e.emp_no <= 10020
GROUP BY e.emp_no
ORDER BY e.emp_no;
 
-- Membuat Subset query
/*
Hasil dibawah ini akan sama pada penggunaan subquery tanpa subset seperti diatas
ini dapat dilakukan jika kita akan melakukan penggabungan dengan subset lainnya
silakan perhaikan contoh selanjutnya
*/
SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS departments_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A;

-- Melakukan penggabungan subset A dengan UNION pada subset B
SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS departments_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A 
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS departments_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B;
    
-- Exercise Number 1
/*
Starting your code with “DROP TABLE”, create a table called 
“emp_manager” (emp_no – integer of 11, not null; 
dept_no – CHAR of 4, null; manager_no – integer of 11, not null). 
*/

DROP TABLE IF EXISTS emp_manager;

CREATE TABLE emp_manager(
	emp_no INT NOT NULL,
    dept_no CHAR(4),
    manager_no INT NOT NULL
)ENGINE = InnoDB;

-- Exercise Number 2
/*
Fill emp_manager with data about employees, 
the number of the department they are working in, and their managers.

Your query skeleton must be:

INSERT INTO emp_manager 
SELECT U.*
FROM (A)
UNION (B) UNION (C) UNION (D) AS U;

A and B should be the same subsets used in the last lecture 
(SQL Subqueries Nested in SELECT and FROM). In other words, 
assign employee number 110022 as a manager to all employees 
from 10001 to 10020 (this must be subset A), 
and employee number 110039 as a manager to all employees 
from 10021 to 10040 (this must be subset B).

Use the structure of subset A to create subset C, 
where you must assign employee number 110039 as a manager to employee 110022.

Following the same logic, create subset D. 
Here you must do the opposite - assign employee 
110022 as a manager to employee 110039.

Your output must contain 42 rows.

Good luck!
*/
INSERT INTO emp_manager
SELECT 
    u.*
FROM
    (SELECT 
        a.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS a UNION SELECT 
        b.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS b UNION SELECT 
        c.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110022
    GROUP BY e.emp_no) AS c UNION SELECT 
        d.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no) AS d) as u;

-- Check Data
SELECT 
    *
FROM
    emp_manager;
    
-- Penjelasan Soal Diatas
/*
Dari soal sebelumnya kita diminta untuk memasukkan data baru menggunakan
subqueries dengan membagi karyawa menjadi emp_no 110022 sebagai manager 
dan emp_no 110039 sebagai karyawan.

Untuk kolom penjelasannya ada pada kolom manager_no, bagi mereka untuk urutan
emp_no 10001 - 10020 pada case pertama akan ditulis sebagai manager [110022]
sedangkan pada case kedua bagi mereka dengan urutan 10021 - 10040 
akan ditulis sebagai karyawan [110039] untuk data ini akan dikelompokkan 
pada satu kolom dengan nama manager_no.

Lalu untuk case ketiga, yaitu dengan alias C, disini kita diminta untuk merubah
emp_no 110022 menjadi seorang karywan dengan manager_no 110039.

Sedangkan untuk case keempat yaitu dengan alias D,  disni kita diminta juga untuk
merubah emp_no 110039 menjadi seorang manager dengan manager_no 110022.

Sehingga jika dijalankan data akan masuk dengan jumlah 42 rows dengan berisi data
dari manager hingga karyawan.

Untuk memudahkan pemahaman lebih jauh disini saya membuat kembali subqueries yang menjadi
acuan penginputan data untuk soal diatas, disini perbedaannya hanya pada nama kolom karena
saya mennggunakan alias:

emp_no -> employee_ID
dept_no -> department_code
manager_no -> manager_ID
*/
SELECT 
    u.* -- Bungkus menjadi 1 query dengan alias 'u'
FROM
    (SELECT -- Lakukan SELECT untuk subcategry 'a'
        a.*
    FROM
        (SELECT -- Ambil subqueries dari subcategories 'a'
        e.emp_no AS employee_ID, -- Tentukan kolom apa saja yang akan ditampilkan
			/*
            Fungsi MIN() digunakan di sini untuk menangani situasi 
            di mana seorang pegawai terlibat dalam lebih dari satu 
            departemen, dan kita hanya ingin menampilkan departemen 
            dengan kode terkecil.
            */
            MIN(de.dept_no) AS department_code, 
            (SELECT -- Lakukan subqueries untuk mengambil value table 'dept_manager' untuk menentukan isi kolom 'manager_ID'
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID -- Untuk saat ini value '110022' akan ditentukan sebagai MANAGER
    FROM
        employees e -- Ambil data table 'employees' untuk kolom employee_ID
    JOIN dept_emp de ON e.emp_no = de.emp_no -- Gabungkan dengan table 'dept_emp'
    WHERE
        e.emp_no <= 10020 -- Filter data yang ditampilkan pada kolom employee_ID sehingga data yang tampil kurang dari sama dengan '10020'
    GROUP BY e.emp_no -- Jangan lupa ketika ada fungsi aggregate dalam query tambahkan juga GROUP BY
    ORDER BY e.emp_no) AS a UNION SELECT 
        b.* -- Langkah selanjutnya ketika sudah mendapat data pada subcategories 'a', selanjutnya cari data untuk subcategories 'b'
    FROM
        (SELECT 
        e.emp_no AS employee_ID, -- Tentukan kolom apa saja yang akan ditampilkan
			/*
            Fungsi MIN() digunakan di sini untuk menangani situasi 
            di mana seorang pegawai terlibat dalam lebih dari satu 
            departemen, dan kita hanya ingin menampilkan departemen 
            dengan kode terkecil.
            */
            MIN(de.dept_no) AS department_code, 
            (SELECT -- Lakukan subqueries untuk mengambil value table 'dept_manager' untuk menentukan isi kolom 'manager_ID'
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID -- Untuk saat ini value '110039' akan ditentukan sebagai KARYAWAN
    FROM
        employees e -- Ambil data table 'employees' untuk kolom employee_ID
    JOIN dept_emp de ON e.emp_no = de.emp_no -- Gabungkan dengan table 'dept_emp'
    WHERE
        e.emp_no > 10020 -- Filter data yang ditampilkan pada kolom employee_ID sehingga data yang tampil lebih dari '10020'
    GROUP BY e.emp_no -- Jangan lupa ketika ada fungsi aggregate dalam query tambahkan juga GROUP BY
    ORDER BY e.emp_no -- Urutkan data column
    LIMIT 20 /* Batasi data yang tampil hanya 20 rows saja */) AS b UNION SELECT 
        c.* -- Langkah selanjutnya ketika sudah mendapat data pada subcategories 'a' dan 'b', selanjutnya cari data untuk subcategories 'c'
    FROM
        (SELECT 
        e.emp_no AS employee_ID, -- Tentukan kolom apa saja yang akan ditampilkan
			/*
            Fungsi MIN() digunakan di sini untuk menangani situasi 
            di mana seorang pegawai terlibat dalam lebih dari satu 
            departemen, dan kita hanya ingin menampilkan departemen 
            dengan kode terkecil.
            */
            MIN(de.dept_no) AS department_code,
            (SELECT -- Lakukan subqueries untuk mengambil value table 'dept_manager' untuk menentukan isi kolom 'manager_ID'
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID -- Untuk saat ini value '110039' akan ditentukan sebagai KARYAWAN
    FROM
        employees e -- Ambil data table 'employees' untuk kolom employee_ID
    JOIN dept_emp de ON e.emp_no = de.emp_no -- Gabungkan dengan table 'dept_emp'
    WHERE
		/*
        Filter data yang ditampilkan pada kolom employee_ID sehingga data yang tampil sama dengan '10022'
        khusus untuk subcategories 'c' ini kita akan menentukan employee_ID '10022' sebagai KARYAWAN dengan
        diperjelas pada column manager_ID -> 110039
        */
        e.emp_no = 110022
    GROUP BY e.emp_no -- Jangan lupa ketika ada fungsi aggregate dalam query tambahkan juga GROUP BY
    ORDER BY e.emp_no) AS c UNION SELECT 
        d.* -- Langkah selanjutnya ketika sudah mendapat data pada subcategories 'a', 'b', 'c', selanjutnya cari data untuk subcategories 'd'
    FROM
        (SELECT 
        e.emp_no AS employee_ID, -- Tentukan kolom apa saja yang akan ditampilkan
			/*
            Fungsi MIN() digunakan di sini untuk menangani situasi 
            di mana seorang pegawai terlibat dalam lebih dari satu 
            departemen, dan kita hanya ingin menampilkan departemen 
            dengan kode terkecil.
            */
            MIN(de.dept_no) AS department_code,
            (SELECT -- Lakukan subqueries untuk mengambil value table 'dept_manager' untuk menentukan isi kolom 'manager_ID'
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID -- Untuk saat ini value '110022' akan ditentukan sebagai MANAGER
    FROM
        employees e -- Ambil data table 'employees' untuk kolom employee_ID
    JOIN dept_emp de ON e.emp_no = de.emp_no -- Gabungkan dengan table 'dept_emp'
    WHERE
		/*
        Filter data yang ditampilkan pada kolom employee_ID sehingga data yang tampil sama dengan '110039'
        khusus untuk subcategories 'd' ini kita akan menentukan employee_ID '110039' sebagai MANAGER dengan
        diperjelas pada column manager_ID -> 110022
        */
        e.emp_no = 110039
    GROUP BY e.emp_no -- Jangan lupa ketika ada fungsi aggregate dalam query tambahkan juga GROUP BY
    ORDER BY e.emp_no) AS d) AS u; -- Bungkus semuanya dengan alias 'u'

/*------------------------------------------------------------------------------------*/