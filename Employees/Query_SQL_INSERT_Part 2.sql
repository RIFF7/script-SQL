-- PENGGUNAAN SQL INSERT STATEMENT
-- Explore Data
SELECT 
    *
FROM
    employees
LIMIT 10;

-- Memasukkan data baru pada table employees
INSERT INTO employees (
	emp_no, 
	birth_date, 
	first_name, 
	last_name, 
	gender, 
	hire_date
) VALUES (
	999901, 
	'1986-04-21', 
	'John', 
    'Smith', 
	'M', 
	'2011-01-01'
);

-- Selanjutnya coba tampilkan datanya
SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC
LIMIT 10;

/*
Dalam menggunakan INSERT kita juga bisa menentukan kolom mana
yang akan kita isi datanya, disini tidak ada permasalahan ketika
kolom yang dimasukan tidak urut dengan kolom yang ada
*/
-- Example INSERT new data dengan ketentuan kolom tidak urut
INSERT INTO employees (
	birth_date, 
    emp_no, 
	first_name, 
	last_name, 
	gender, 
	hire_date
) VALUES (
	'1973-03-26', 
    999902, 
	'Patricia', 
    'Lawrence', 
	'F', 
	'2005-01-01'
);

SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC
LIMIT 10;

/*
Dalam teknik memasukkan data dengan INSERT kita juga bisa
tidak menyebutkan nama kolom ketika akan memasukkan data baru,
namun yang perlu diingat adalah urutan kolom yang akan diisi
dengan data baru haruslah sesuai urutan pada kolom table
(Tidak boleh kurang ataupun lebih)
*/

-- Example INSERT new data tanpa menyebutkan kolom
INSERT INTO employees
VALUES(
	999903, 
    '1977-09-14', 
    'Johnathan', 
    'Creek', 
    'M', 
    '1999-01-01');

-- Explore Data
SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC
LIMIT 10;

-- Exercise Number 1
/*
Select ten records from the “titles” table 
to get a better idea about its content.

Then, in the same table, insert information 
about employee number 999903. 
State that he/she is a “Senior Engineer”, 
who has started working in this position on October 1st, 1997.

At the end, sort the records from the “titles” 
table in descending order to check if you have 
successfully inserted the new record.

Hint: To solve this exercise, you’ll need 
to insert data in only 3 columns!

Don’t forget, we assume that, apart from the code related 
to the exercises, you always execute all code 
provided in the lectures. 
This is particularly important for this exercise. 
If you have not run the code from the previous lecture, 
called ‘The INSERT Statement – Part II’, 
where you have to insert information about employee 999903, 
you might have trouble solving this exercise!
*/

-- Explore Data Table 'titles'
SELECT 
    *
FROM
    titles;

-- Bulid Query
-- Memilih 10 Catatan pada table 'titles'
SELECT 
    *
FROM
    titles
LIMIT 10;

/*
Memasukkan data baru pada table 'title'
untuk mendata karyawan baru dengan emp_no 999903
menjadi 'Senior Engineer'
*/

INSERT INTO titles(
	emp_no, 
    title,
    from_date
) VALUES(
	999903,
	'Senior Engineer',
    '1997-10-01'
);

-- Exmplore data baru
SELECT 
    *
FROM
    titles
ORDER BY emp_no DESC
LIMIT 10;

-- Exercise Number 2
/*
Insert information about the individual with employee 
number 999903 into the “dept_emp” table. 
He/She is working for department number 5, 
and has started work on  October 1st, 1997; 
her/his contract is for an indefinite period of time.

Hint: Use the date ‘9999-01-01’ to designate 
the contract is for an indefinite period.
*/

-- Explore table
SELECT 
    *
FROM
    dept_emp
LIMIT 10;
    
-- Build Query
INSERT INTO dept_emp(
	emp_no,
    dept_no,
    from_date,
    to_date
) VALUES(
	999903,
    'd005',
    '1997-10-01',
    '9999-01-01'
);

-- Explore new data
SELECT 
    *
FROM
    dept_emp
ORDER BY emp_no DESC
LIMIT 10;

/*------------------------------------------------------------------------------------*/

-- Penggunaan INSERT INTO SELECT
/*
Pada pembahasan kali ini, akan menunjukkan cara bagaimana untuk
melakukan duplikat pada isi dalam data table dengan menggunakan INSERT INTO SELECT
*/

-- Langkah 1
-- Lihat semua data pada table yang menjadi target duplikat
SELECT 
    *
FROM
    departments
LIMIT 10;

-- Langkah 2
-- Create table duplikat 
/*
(Pastikan untuk menyamakan panjang struktur data 
dan constrain yang ada pada table target yang menjadi acuan duplikat)

Karena ketika struktur data dan constrain tidak sama, ketika melakukan
insert table untuk duplikat data akan terjadi error!!!
*/
CREATE TABLE departments_dup(
	dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL
) ENGINE = InnoDB;

-- Langkah 3
-- Explore table baru
SHOW CREATE TABLE departments_dup;

DESC departments_dup;

SELECT 
    *
FROM
    departments_dup;

-- Langkah 4
/*
Saatnya melakukan duplikat data pada table 'departments' ke dalam 
data table 'departments_dup'
*/
INSERT INTO departments_dup(
	dept_no,
    dept_name
)
SELECT * FROM departments;

-- Explore after insert duplicated data
SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

-- Exercise Number 1
/*
Create a new department called “Business Analysis”. Register it under number ‘d010’.

Hint: To solve this exercise, use the “departments” table.
*/
-- Cara INSERT 1
INSERT INTO departments(
	dept_no,
    dept_name
) VALUES(
	'd010',
    'Business Analysis'
);

-- Cara INSERT 2
INSERT INTO departments
VALUES(
	'd010',
    'Business Analysis'
);

-- Explore new data after input
SELECT 
    *
FROM
    departments
ORDER BY dept_no;

/*------------------------------------------------------------------------------------*/