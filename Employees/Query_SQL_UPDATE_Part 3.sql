-- PENGGUNAAN TCL's COMMIT and ROLLBACK

-- Explore data yang akan menjadi target UPDATE
SELECT 
    *
FROM
    employees
WHERE
    emp_no = 999901;

-- Saatnya melakukan UPDATE data pada table employees
UPDATE employees
SET
	first_name = 'Stella',
    last_name = 'Parkinson',
    birth_date = '1990-12-31',
    gender = 'F' -- Perlu diketahui disini saya tidak melakukan UPDATE pada kolom hire_date
    -- dan itu tidak masalah, query akan tetap jalan, sesuai keinginan UPDATE yang saya tulis
WHERE 
	emp_no = 999901; -- Ini akan menjadi target UPDATE data

-- Explore new data
SELECT 
    *
FROM
    employees
WHERE
    emp_no = 999901;

/*------------------------------------------------------------------------------------*/

-- Penggunaan COMMIT dan ROLLBACK statement
/*
Harap diingat untuk menggunakan COMMIT dan ROLLBACK
selalau pastikan tanda centang dan tanda silang
disebelah kolom limit selalu AKTIF, jika tidak aktif
query tidak akan berjalan.
*/

/*
Disini saya akan menggunakan table departments_dup
sebagai contoh untuk melakukan kesalahan UPDATE data
dan saya akan menggunakan COMMIT dan ROLLBACK statement
*/

-- Explore Data
SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

-- Untuk Menggunakan COMMIT kita hanya perlu memanggil statement tersebut
COMMIT;

-- Lalu saya UPDATE data dengan kesalahan, tanpa target UPDATE
UPDATE departments_dup
SET
	dept_no = 'd011',
    dept_name = 'Quality Control'; -- Disini saya tidak mentargetkannya dengan WHERE

/*
Lalu jika saya SELECT data table 'departments_dup'
maka data akan terubah semuanya dan itu jelas SALAH
*/
SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

/*
Lalu bagaimana untuk mengembalikannya seperti semula?
Itu mudah, selama query UPDATE yang dijalankan belum 
dilakukan COMMIT akhir, maka data tersebut bisa kita
kembalikan seperti awal, dengan cara ketik ROLLBACK dan jalankan query-nya
*/
ROLLBACK;

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

/*
Jika sudah selesai dan dirasa tidak ada perubahan lagi, 
jangan lupa lakukan COMMIT kembali untuk mengakhirinya
*/
COMMIT;

-- Exercise Number 1
/*
Change the “Business Analysis” department name to “Data Analysis”.

Hint: To solve this exercise, use the “departments” table.
*/

-- Explore Data
SELECT 
    *
FROM
    departments
ORDER BY dept_no;

-- Build query UPDATE Data
UPDATE departments
SET
	dept_name = 'Data Analysis'
WHERE
	dept_no = 'd010';

/*------------------------------------------------------------------------------------*/