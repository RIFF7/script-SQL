-- PENGGUNAAN DELETE Statement

/*
Untuk menggunakan fungsi DELETE disini saya akan meakukan implementasi
COMMIT seperti pada materi Part 3 sebelumnya

Jangan lupa untuk selalu mengaktifkan tanda petir
disebelah pilihan LIMIT, agar perintah COMMIT dapat diakses
*/

COMMIT;

-- Explore Data Table Employees
SELECT 
    *
FROM
    employees
WHERE
    emp_no = 999903;

-- Explore Data Titles
SELECT 
    *
FROM
    titles
WHERE
    emp_no = 999903;

-- Delete Data
DELETE FROM employees 
WHERE
    emp_no = 999903;
/*
Disini kita asumsikan bahwa saat ini kita 
salah melakukan penghapusan data dan ingin mengembalikan
data yang sudah dihapus seeblumnya, maka kita dapat menggunakan
fungsi dibawah ini
*/
ROLLBACK;

-- Lalu setelah mengembalikan data jangan lupa lakukan COMMIT kembali
COMMIT;

/*------------------------------------------------------------------------------------*/

/*
Contoh kesalahan ketika menggunakan DELETE statement
disini tidak melakukan filter (WHERE) pada data yang akan dihapus
*/

-- Langkah 1 (Lakukan COMMIT)
COMMIT;

-- Explore Data departments_dup
SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

/*
Jika kalian menggunakan perintah penghapusan dibawah ini
tanpa adanya WHERE sebagai filter data yang akan dihapus
maka fungsi DELETE akan menganggap kalian ingin melakukan
penghapusan pada keseluruhan data pada table. 

Fungsi ini hampir sama dengan TRUNCATE TABLE nama_table
yaitu mengosongkan data pada table tujuan.
*/
DELETE FROM departments_dup;

/*
Karena disini saya tidak ingin melakukan penghapusan data permanen
maka saya akan mengembalikan data kembali dengan ROLLBACK.
*/
ROLLBACK;

-- Langkah terakhir jangan lupa COMMIT
COMMIT;

-- Exercise Number 1
/*
Remove the department number 10 record from the “departments” table.
*/
-- Explore Data departments
SELECT 
    *
FROM
    departments
ORDER BY dept_no;

-- Langkah 1
COMMIT;

DELETE FROM departments
WHERE dept_no = 'd010';

/*
Namun disini saya tidak akan melakukan penghapusan
pada data table 'd010'
*/
ROLLBACK;
COMMIT;

/*------------------------------------------------------------------------------------*/

/*
Masuk pada materi perbedaan fungsi
- DROP: Ini akan menghapus table dan data yang ada di dalamnya

- TRUNCATE: Ini akan mengosongkan data yang ada pada table 
dan tetap mempertahankan struktur table. 
Penggunaan TRUNCATE tidak memerlukan kondisi WHERE, dia akan melakukan
penghapusan secara menyeluruh.

- DELETE: Ini akan melakukan penghapusan berdasarkan kondisi
yang kita tetapkan dengan penggunaan WHERE dan akan fungsi ini akan
melakukan penghapusan row by row yang kita tetapkan kondisinya
*/

/*------------------------------------------------------------------------------------*/
