-- Masuk pada materi Aggregate Functions

-- Penggunaan COUNT() dan COUNT(DISTINCT...)
-- Explore Data
SELECT 
    *
FROM
    salaries
ORDER BY salary DESC
LIMIT 10;

-- Penggunaan Aggregate COUNT()
SELECT 
    COUNT(salary) -- Ini akan melakukan perhitungan untuk total keseluruhan data row pada table
FROM
    salaries;

SELECT 
    COUNT(DISTINCT salary) -- Penggunaan DISTINCT disini adalah untuk menghilangkah nilai duplikat yang ada pada sebuah rows data
FROM
    salaries;

-- Exercise Number 1
/*
How many departments are there in the “employees” database? 
Use the ‘dept_emp’ table to answer the question.
*/

-- Explore Data
SELECT 
    *
FROM
    dept_emp;

-- Build Query
SELECT 
    COUNT(DISTINCT dept_no) AS Jumlah_Departments
FROM
    dept_emp;

/*------------------------------------------------------------------------------------*/

-- Penggunaan SUM()
SELECT 
    SUM(salary) -- Ini akan melakukan penjumlahan dari setiap rows salary yang ada, sehingga diketahui totalnya
FROM
    salaries;
    
-- Exercise Number 1
/*
What is the total amount of money spent on salaries 
for all contracts starting after the 1st of January 1997?
*/

-- Explore Data
SELECT 
    *
FROM
    salaries
LIMIT 10;

-- Build Query
SELECT 
    SUM(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01'; -- Ini akan melakukan filter tanggal SETELAH 1997-01-01

/*------------------------------------------------------------------------------------*/

-- Penggunaan MIN() dan MAX()
SELECT 
    MAX(salary) -- Mencari nilai salary tertinggi
FROM
    salaries;

SELECT 
    MIN(salary) -- Mencari nilai salary terendah
FROM
    salaries;

-- Exercise Number 1
/*
1. Which is the lowest employee number in the database?
2. Which is the highest employee number in the database?
*/

-- Explore Data
SELECT 
    *
FROM
    employees
LIMIT 10;

-- Build query Quetion 1
SELECT 
    MIN(emp_no)
FROM
    employees;

-- Build query Quetion 2
SELECT 
    MAX(emp_no)
FROM
    employees;

/*------------------------------------------------------------------------------------*/

-- Penggunaan AVG()
SELECT 
    AVG(salary) -- Mencari nilai rata-rata pada kolom salary
FROM
    salaries;

-- Exercise Number 1
/*
What is the average annual salary paid 
to employees who started after the 1st of January 1997?
*/

-- Explore Data
SELECT 
    *
FROM
    salaries
LIMIT 10;

-- Build Query
SELECT 
    AVG(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01';

/*------------------------------------------------------------------------------------*/

-- Penggunaan ROUND()
SELECT 
    ROUND(AVG(salary)) -- Melakukan pembulatan dan menghilangkan angka koma 
FROM
    salaries;

-- ROUND(#, decimal_number) -> ini akan memunculkan angka dibelakang koma sebanyak nilai decimal yang ditetapkan
SELECT 
    ROUND(AVG(salary), 2) -- Ini akan memunculkan nilai rata-rata dengan 2 angka dibelakang koma
FROM
    salaries;

-- Exercise Number 1
/*
Round the average amount of money spent on salaries 
for all contracts that started after the 1st of January 1997 to a precision of cents.
*/

-- Explore Data
SELECT 
    *
FROM
    salaries
LIMIT 10;

-- Build Query
SELECT 
    ROUND(AVG(salary), 2)
FROM
    salaries
WHERE
    from_date > '1997-01-01';

/*------------------------------------------------------------------------------------*/

-- Penggunaan IFNULL() dan COALESCE()
-- IFNULL: Tidak bisa melebihi dari 2 parameter
-- COALESCE: Bisa melebihi dari 2 parameter / can have one, two, or more arguments

-- Setting Table Untuk penggunaan IFNULL() dan COALESCE()
-- Modifikasi kolom table
ALTER TABLE departments_dup
CHANGE COLUMN dept_name dept_name VARCHAR(40) NULL; -- Ubah data kolom menjadi NULL

-- Masukkan Data Dummy
INSERT INTO departments_dup(dept_no)
VALUE('d010'), ('d011');

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

-- Menambahkan kolom baru
ALTER TABLE departments_dup
ADD COLUMN dept_manager VARCHAR(255) NULL AFTER dept_name;

SELECT 
    *
FROM
    departments_dup;

-- Example IFNULL()
SELECT 
    dept_no,
    /*
    Fungsi IFNULL() akan merubah nilai NULL menjadi string yang kita tentukan
    namun perlu diingat bahwa IFNULL() hanya mengizinkan 2 parameter saja dan tidak bisa lebih
    */
    IFNULL(dept_name, 
			'Department name not provide') AS dept_name
FROM
    departments_dup
ORDER BY dept_no;

-- Example COALESCE() 
/*
Fungsi COALESCE() pada MySQL digunakan untuk mengganti nilai NULL 
dengan nilai alternatif yang telah ditentukan. Jika nilai pertama tidak NULL, 
maka COALESCE() akan mengembalikan nilai pertama. Namun, jika nilai pertama NULL, 
maka akan dikembalikan nilai kedua (dan seterusnya, jika ada lebih banyak parameter).
*/

SELECT 
    dept_no, -- Argument 1
    /*
    Fungsi COALESCE() sebenarnya sama dengan IFNULL(), hanya saja pada
    fungsi ini diizinkan 1, 2, ataupun 3 parameter didalamnya berbeda dengan IFNULL()
    */
    COALESCE(dept_name, 
			'Department name not provide') AS dept_name -- Argument 2
FROM
    departments_dup
ORDER BY dept_no;

-- Example COALESCE() dengan 3 argument
SELECT 
    dept_no, -- Argument 1
    dept_name, -- Argument 2
    /*
    Pada fungsi COALESCE() dibawah ini akan melakukan pengecekan pada kolom
    dept_manager terdapat  nilainya ataiu tidak, jika tidak maka akan diabaikan dan
    lanjut pada pengecekan selanjutnya yaitu pada kolom dept_name jika pada kolom ini
    terdapat nilainya maka nilai ini akan digabungkan pada satu kolom alias
    yaitu dept_manager dan jika pada kolom dept_name nilai NULL ada didalamnya
    maka pada kolom selanjutnya yang tidak terisi akan bernilai N/A.
    */
    COALESCE(dept_manager, dept_name, 'N/A') AS dept_manager -- Argument 3
FROM
    departments_dup
ORDER BY dept_no;

-- Example penggunaan COALESCE() dengan 1 argument
SELECT 
    dept_no,
    dept_name,
    /*
    Ini akan membuat kolom baru dengan satu argument yang ada
    dan hasil dibawah ini akan menampilkan kolom baru dengan nama
    fake_col dengan isi pada kolom adalah:
    'department manager name'
    */
    COALESCE('department manager name') AS fake_col
FROM
    departments_dup;

-- Exercise Number 1
/*
Select the department number and name from the ‘departments_dup’ 
table and add a third column where you name the department number (‘dept_no’) as 
‘dept_info’. If ‘dept_no’ does not have a value, use ‘dept_name’.
*/

-- Explore Data
SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

-- Build Query
SELECT 
    dept_no,
    dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM
    departments_dup
ORDER BY dept_no;

-- Exercise Number 2
/*
Modify the code obtained from the previous exercise in the following way. 
Apply the IFNULL() function to the values from the first and second column, 
so that ‘N/A’ is displayed whenever a department number has no value, and 
‘Department name not provided’ is shown if there is no value for ‘dept_name’.
*/

-- Build Query
SELECT 
    IFNULL(dept_no, 'N/A') AS dept_no, -- Pada perintah ini nilai N/A akan ditampilkan jika kolom dept_no terdapat nilai NULL
    /*
    Sama halnya dengan diatas, jika pada kolom dept_name terdapat nilai NULL 
    maka value 'Department name not provided' akan ditampilkan
    */
    IFNULL(dept_name,
            'Department name not provided') AS dept_name,
	/*
    Pada fungsi ini jika setelah dicek pada dept_no terdapat nilai NULL
    maka argument selanjutnya akan digunakan yaitu dept_name dengan alias
    dept_info
    
    Namun jika pada argument 1 yaitu dept_no tidak ada nilai NULL, maka
    argument 1 yang akan digunakan pada fungsi COALESCE()
    */
    COALESCE(dept_no, dept_name) AS dept_info
FROM
    departments_dup
ORDER BY dept_no;

/*------------------------------------------------------------------------------------*/