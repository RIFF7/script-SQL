-- Penggunaan JOIN

-- Menghapus Kolom sebelumnya yang digunakan untuk COALESCE()
ALTER TABLE departments_dup
DROP COLUMN dept_manager;

-- Cek Data
SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

-- Ganti Type Data Table
ALTER TABLE departments_dup
CHANGE COLUMN dept_no dept_no CHAR(4) DEFAULT NULL;

-- Cek Data
DESC departments_dup;

/*
Membuat table duplikat kembali dengan menggunakan table
dept_manager
*/

-- Cek table sebelumnya ada atau tidak
DROP TABLE IF EXISTS dept_manager_dup; -- Jika table ada, maka akan dihapus

-- Buat Table Baru (dept_manager_dup)
CREATE TABLE dept_manager_dup(
	emp_no INT(11) NOT NULL,
    dept_no CHAR(4) NULL,
    from_date DATE NOT NULL,
    to_date DATE NULL
) ENGINE = InnoDB;

-- Masukkan data yang sama seperti pada table dept_manager pada dept_manager_dup
INSERT INTO dept_manager_dup
SELECT * FROM dept_manager;

-- Masukkan data baru pada dept_manager_dup
INSERT INTO dept_manager_dup(emp_no, from_date)
VALUES('999904', '2017-01-01'),
	  ('999905', '2017-01-01'),
      ('999906', '2017-01-01'),
      ('999907', '2017-01-01');

-- Coba lakukan penghapusan pada data dept_manager_dup
DELETE FROM dept_manager_dup
WHERE dept_no = 'd001';

-- Masukan data baru pada table departments_dup untuk dilakukan analisa
INSERT INTO departments_dup(dept_name)
VALUES('Public Relations');

-- Hapus data baru pada table departments_dup untuk dilakukan analisa
DELETE FROM departments_dup
WHERE dept_no = 'd002';

-- Explore Data
-- Data Table dept_manager_dup
SELECT 
    *
FROM
    dept_manager_dup
ORDER BY dept_no;

-- Data Table departments_dup
SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

/*------------------------------------------------------------------------------------*/

-- Masuk Pada INNER JOIN
/*
Pada contoh dibawah ini akan menampilkan data dari hasil
INNER JOIN pada 2 table, yaitu table departments_dup dan
dept_manager.

Pada hasil ini akan memberikan insight pada kita dari data yang ada
pada kedua table, karena saat ini saya menggunakan INNER JOIN maka
hasilnya akan menampilkan data yang masing-masing data tersebut
memang ada pada kedua table dan jika data pada salah satu table itu
tidak ada, maka INNER JOIN tidak akan memunculkan data tersebut
pada hasil akhirnya.

Hal ini dikarenakan konsep dari INNER JOIN adalah mengambil nilai tengah
pada table yang telah digabungkan dengan mencocokkan data dari value kedua table
tersebut tersedia atau tidak, jika tersedia hanya pada satu table saja maka
data tidak akan ditampilkan, namun jika data tersedia pada kedua table maka 
data akan ditampilkan pada hasil akhirnya.
*/

-- Build Query
SELECT 
    m.emp_no, m.dept_no, d.dept_name
FROM
    dept_manager m
        INNER JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

-- Exercise Number 1
/*
Extract a list containing information about all managers’ 
employee number, first and last name, department number, and hire date. 
*/

-- Explore Data
SELECT 
    *
FROM
    employees
LIMIT 5;

SELECT 
    *
FROM
    dept_manager;

-- Build Query
SELECT 
    e.emp_no, e.first_name, e.last_name, m.dept_no, e.hire_date
FROM
    employees e
        INNER JOIN
    dept_manager m ON e.emp_no = m.emp_no
ORDER BY m.dept_no;

/*------------------------------------------------------------------------------------*/

-- INNER JOIN dan JOIN
/*
Untuk INNER JOIN dan JOIN sebenarnya sama saja, jika kita menggunakan JOIN
maka itu artinya kita melakukan INNER JOIN pada query yang kita buat.
*/

SELECT 
    m.dept_no, m.emp_no, m.from_date, m.to_date, d.dept_name
FROM
    dept_manager_dup m
        JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

/*------------------------------------------------------------------------------------*/

-- Duplicate Records
/*
Duplicate Records adalah isi data yang jumlahnya 
lebih dari 1 dan datanya sama pada table database. 
Duplicate Records tidak selalu diperbolehkan 
dalam database atau table data.

Duplicate Records biasanya ditemukan pada data baru, 
mentah, atu data yang tidak terkontrol
jika terdapat data yang duplicate maka 
kita bisa menggunakan fungsi GROUP BY untuk mengindari
hasil output akhir pada tampilan data yang tampil memiliki kesamaan
pada data lainnya.

Pada contoh dibawah ini, saya akan melakukan manipulasi data kembali
untuk memberikan contoh duplicate records serta penggunaan dari GROUP BY,
pada contoh kali ini saya akan menggunakan table 'dept_manager_dup' dan
'departments_dup'.
*/

# Create Duplicate Records
-- Masukkan data yang sama dimana data sebelumnya sudah ada pada table
INSERT INTO dept_manager_dup
VALUES('110228', 'd003', '1992-03-21', '9999-01-01');

INSERT INTO departments_dup
VALUES('d009', 'Customer Service');

-- Cek data table 'dept_manager_dup' dan 'departments_dup'
SELECT 
    *
FROM
    dept_manager_dup
ORDER BY dept_no;

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

-- INNER JOIN
/*
Jika sebelumnya data yang sudah kita tambahkan telah masuk
maka coba lakukan INNER JOIN pada kedua table, jika dalam
output tertampil data yang sama muncul lebih dari satu kali
maka untuk percobaan input data sebelumnya telah berhasil

Namun disini yang menjadi fokus harusnya data yang ditampilkan
pada output yang ada tidak diperbolehkan adanya duplicate, untuk
mengatasi permasalahan tersebut maka, kita dapat menggunakan fungsi
DISTINCT untuk melakukan filter pada data duplicate sehingga data yang
sama tidak ditampilkan lebih dari satu kali.
*/

-- Before
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        INNER JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

-- After
SELECT 
	DISTINCT(m.emp_no),
    m.dept_no, d.dept_name
FROM
    dept_manager_dup m
        INNER JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

/*------------------------------------------------------------------------------------*/

-- Masuk pada penggunaan LEFT JOIN
/*
Sebelum memasuki penggunaan LEFT JOIN, disini saya akan menambahkan data baru
dan menghapus data duplicate yang sebelumnya telah dibuat lalu masukkan kembali 
data yang ada sebelumnya, ini akan saya gunakan untuk membantu pemahaman terkait 
dengan penggunaan LEFT JOIN
*/

-- Remove the duplicates from the two tables
DELETE FROM dept_manager_dup
WHERE emp_no = '110228';

DELETE FROM departments_dup
WHERE dept_no= 'd009';

-- Add back the initial records
INSERT INTO dept_manager_dup
VALUES('110228', 'd003', '1992-03-21', '9999-01-01');

INSERT INTO departments_dup
VALUES('d009', 'Customer Service');

-- Implementasi LEFT JOIN
/*
Penggunaan LEFT JOIN ini akan menampilkan data kolom
yang telah dipilih pada SELECT pada table pertama dan
table kedua yang dilakukan JOIN, sehingga akan dilakukan
pengecekan pada table pertama untuk data yang akan ditampilkan
dan selanjutnya pada table kedua akan dilakukan pengecekan kembali
jika data pada table pertama tidak ada pada data table kedua, maka
nilai akan diisi dengan NULL
*/
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        LEFT JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

/*
Jika sebelumnya penempatan table 'dept_manager_dup' berada pada sebelah kiri
dan pada table 'departments_dup' berada pada sebelah kanan pada query diatas,
maka saat ini akan kita tukar penempatannya menjadi, 'dept_manager_dup' akan
ada disebelah kanan dan 'departments_dup' akan ada di sebelah kiri, lalu kita akan
menggunakan fungsi LEFT JOIN.

Perlu diketahui pada perintah SELECT pada index 1 untuk mendapatkan
hasil pada table pertama sebagai acuan maka dilakan untuk menggunakan
alias dan nama kolom pada table pertama agar outputnya menjadi sesuai 
*/
SELECT 
    d.dept_no, m.emp_no, d.dept_name
FROM
    departments_dup d
        LEFT JOIN
    dept_manager_dup m ON m.dept_no = d.dept_no
ORDER BY d.dept_no;

/*
Example mencari nilai NULL pada table dengan LEFT JOIN
query ini hanya akan menampilkan data yang valuenya NULL
pada kedua table
*/
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        LEFT JOIN
    departments_dup d ON m.dept_no = d.dept_no
WHERE
    dept_name IS NULL
ORDER BY m.dept_no;

/*
Sedangkan contoh dibawah adalah menampilkan data dengan fungsi LEFT JOIN
dimana value dari kedua table tidak berisi nilai NULL
*/
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        LEFT JOIN
    departments_dup d ON m.dept_no = d.dept_no
WHERE
    dept_name IS NOT NULL
ORDER BY m.dept_no;

-- Exercise Number 1
/*
Join the 'employees' and the 'dept_manager' tables to return 
a subset of all the employees whose last name is Markovitch. 
See if the output contains a manager with that name.  

Hint: Create an output containing information corresponding 
to the following fields: ‘emp_no’, ‘first_name’, ‘last_name’, 
‘dept_no’, ‘from_date’. Order by 'dept_no' descending, 
and then by 'emp_no'.
*/

-- Explore Data
SELECT 
    *
FROM
    employees
LIMIT 5;

SELECT 
    *
FROM
    dept_manager
ORDER BY dept_no;

-- Build Query

-- Exercise Menggunakan INNER JOIN
SELECT 
    e.emp_no, 
    e.first_name, 
    e.last_name, 
    d.dept_no, 
    d.from_date
FROM
    employees e
        INNER JOIN
    dept_manager d ON e.emp_no = d.emp_no
WHERE
    last_name = 'Markovitch'
ORDER BY d.dept_no DESC , e.emp_no;

-- Exercise Menggunakan LEFT JOIN
SELECT 
    e.emp_no, 
    e.first_name, 
    e.last_name, 
    d.dept_no, 
    d.from_date
FROM
    employees e
        LEFT JOIN
    dept_manager d ON e.emp_no = d.emp_no
WHERE
    last_name = 'Markovitch'
ORDER BY d.dept_no DESC , e.emp_no;

/*------------------------------------------------------------------------------------*/

-- Masuk pada penggunaan RIGHT JOIN
/*
Pada penggunaan RIGHT JOIN sebenarnya hampir sama dengan LEFT JOIN
hanya saja perbedaan pengambilan data pada arahnya saja, karena untuk
LEFT JOIN akan mengambil data mulai dari table sebelah kiri terlebih dahulu
sedangkan RIGHT JOIN ini akan mengambil data dimulai pada table yang ada pada 
sebelah kanan terlebih dahulu.
*/

SELECT 
    d.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m -- Table Bagian LEFT
        RIGHT JOIN
    departments_dup d /* Table Bagian RIGHT */ ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

/*
Pada penggunaan query RIGHT JOIN diatas akan sama tampilan outputnya
dengan poenggunaan query LEFT JOIN dibawah ini, namun yang beda disini
hanya penempatan dari tablenya saja
*/

SELECT 
    d.dept_no, m.emp_no, d.dept_name
FROM
    departments_dup d
        LEFT JOIN
    dept_manager_dup m ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

/*------------------------------------------------------------------------------------*/

-- The New and The Old JOIN syntax
/*
Pada pembahasan kali ini akan menampilkan penggunaan
JOIN versi New (baru) dan Old (lama)
*/
# JOIN (New)
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        INNER JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

# WHERE (Old)
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m,
    departments_dup d
WHERE
    m.dept_no = d.dept_no
ORDER BY m.dept_no;

-- Exercise Number 1
/*
Extract a list containing information about all managers’ employee number, 
first and last name, department number, and hire date. 
Use the old type of join syntax to obtain the result.
*/

-- Menggunakan JOIN tipe lama
SELECT 
    e.emp_no, e.first_name, e.last_name, d.dept_no, e.hire_date
FROM
    employees e,
    dept_manager d
WHERE
    e.emp_no = d.emp_no
ORDER BY e.emp_no;

-- Menggunakan JOIN tipe baru
SELECT 
    e.emp_no, e.first_name, e.last_name, d.dept_no, e.hire_date
FROM
    employees e
        JOIN
    dept_manager d ON e.emp_no = d.emp_no
ORDER BY e.emp_no;

/*------------------------------------------------------------------------------------*/

-- Penggunaan JOIN dengan WHERE clause
/*
Pada example query dibawah saat ini kita akan melakukan pencarian
data gaji yang lebih dari $145000 dari 2 table yang tersedia pada
databases employees, yaitu table employees dan table salaries.
*/
SELECT 
    e.emp_no, e.first_name, e.last_name, s.salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    s.salary > 145000;

-- Exercise Number 1
/*
Select the first and last name, the hire date, 
and the job title of all employees whose first name 
is “Margareta” and have the last name “Markovitch”.
*/

SELECT 
    e.first_name, e.last_name, e.hire_date, t.title
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    first_name = 'Margareta'
        AND last_name = 'Markovitch';

/*------------------------------------------------------------------------------------*/

-- Masuk pada penggunaan CROSS JOIN
/*
CROSS JOIN dalam MySQL digunakan untuk menggabungkan 
setiap baris dari dua atau lebih tabel, 
tanpa memperhatikan apakah ada keterkaitan antara data pada tabel tersebut. 
Hasilnya adalah produk Cartesan dari kedua tabel, 
di mana setiap baris dari satu tabel dipasangkan 
dengan setiap baris dari tabel lainnya.

Contoh sederhana penggunaan CROSS JOIN:

SELECT * FROM tabel1
CROSS JOIN tabel2;

Dalam contoh ini, setiap baris dari tabel1 akan dipasangkan 
dengan setiap baris dari tabel2. Jumlah baris dalam hasilnya 
akan menjadi jumlah baris dalam tabel1 dikali jumlah baris dalam tabel2.

Perlu diingat bahwa CROSS JOIN dapat menghasilkan jumlah baris 
yang sangat besar jika tabel yang terlibat memiliki jumlah baris yang signifikan. 
Oleh karena itu, penggunaan CROSS JOIN harus dipertimbangkan dengan hati-hati, 
dan biasanya digunakan dalam situasi khusus di mana kita benar-benar membutuhkan 
kombinasi setiap baris dari dua tabel tanpa memperhatikan keterkaitan data.
*/
SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
ORDER BY dm.emp_no , d.dept_no;

-- Old CROSS JOIN
SELECT 
    dm.*, d.*
FROM
    dept_manager dm,
    departments d
ORDER BY dm.emp_no , d.dept_no;

-- JOIN tanpa menggunakan ON
-- Ini akan sama saja, output yang dikeluarkan akan seperti CROSS JOIN
SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        JOIN
    departments d
ORDER BY dm.emp_no , d.dept_no;

-- CROSS JOIN dengan penggunaan WHERE
SELECT 
    dm.*, d.*
FROM
    departments d
        CROSS JOIN
    dept_manager dm
WHERE
    d.dept_no <> dm.dept_no -- <> Tidak sama dengan
ORDER BY dm.emp_no , d.dept_no;

-- Penggunaan CROSS JOIN digabungkan dengan INNER JOIN / JOIN
/*
Bisa diasumsikan disini kita akan menunjukkan lebih banyak informasi
tentang manager departemen dalam database seperti nama mereka atau bahkan
tanggal perekrutan mereka, untuk mendapatkan informasi ini sudah jelas kita
perlu melakukan penggabungan table pada employees
*/
SELECT
	/*
    Karena disini kolom dept_manager hampir sama dengan 
    employees maka pada kolom yang ditampilkan kita akan 
    fokuskan pada table employees (e)
    */
    e.*, d.*
FROM
    departments d
        CROSS JOIN
    dept_manager dm
        JOIN
    employees e ON dm.emp_no = e.emp_no
WHERE
    d.dept_no <> dm.dept_no
ORDER BY dm.emp_no , d.dept_no;

-- Exercise Number 1
/*
Use a CROSS JOIN to return a list with all possible 
combinations between managers from the dept_manager 
table and department number 9.
*/

-- Explore Data
SELECT 
    *
FROM
    dept_manager;

SELECT 
    *
FROM
    departments
ORDER BY dept_no;

-- Build Query
SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
WHERE
    d.dept_no = 'd009';

-- Exercise Number 2
/*
Return a list with the first 10 employees 
with all the departments they can be assigned to.

Hint: Don’t use LIMIT; use a WHERE clause.
*/

-- Build Query
SELECT 
    e.*, d.*
FROM
    employees e
        CROSS JOIN
    departments d
WHERE
    e.emp_no < 10011
ORDER BY e.emp_no , d.dept_name;

/*------------------------------------------------------------------------------------*/

-- Menggunakan Aggregate Function dengan JOIN
/*
Case nya adalah, semisal disini kita diminta untuk menampilkan
rata-rata pendapatan dari databse employees, namun disini haruslah diurutkan 
dengan gender yang ada pada kolom table yang ada dengan urutan ASC
*/
SELECT 
    e.gender, AVG(s.salary) AS average_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY e.gender;

/*------------------------------------------------------------------------------------*/

-- Masuk pada materi JOIN more than two tables in SQL 
-- (Melakukan JOIN lebih dari 2 table dalam SQL)
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    dm.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
        JOIN
    departments d ON dm.dept_no = d.dept_no
ORDER BY e.first_name;

/*
Semisal disini kita melakukan perubahan penempatan table
dimana table departments menjadi diatas dan employees dibawah
harusnya hasilnya akan tetap sama karena disini jalur penghubungnya
atau FK(foreign key) masih ada
*/
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    dm.from_date,
    d.dept_name
FROM
    departments d
        JOIN
    dept_manager dm ON d.dept_no = dm.dept_no
        JOIN
    employees e ON dm.emp_no = e.emp_no
ORDER BY e.first_name;

-- Exercise Number 1
/*
Select all managers’ first and last name, 
hire date, job title, start date, and department name.
*/

-- Build Query
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title AS job_title,
    dm.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
        JOIN
    departments d ON dm.dept_no = d.dept_no
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    t.title = 'Manager'
ORDER BY e.first_name;

-- Cara Kedua
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title AS job_title,
    dm.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
        JOIN
    departments d ON dm.dept_no = d.dept_no
        JOIN
    titles t ON e.emp_no = t.emp_no
        AND dm.from_date = t.from_date
ORDER BY e.first_name;

/*------------------------------------------------------------------------------------*/

-- Tips & Trick untuk JOIN
/*
Semisal disini kita ditugaskan untuk mengambil rata-rata gaji
dari setiap departments yang ada, maka untuk query JOIN nya perlu
diperhatikan agar selalu menggabungkannya dengan FK yang ada pada
setiap table yang ada walaupun dari FK ini tidak saling berelasi

Example:
departments dengan dept_manager disini mereka saling berelasi
namun pada table salaries, disini dari kedua table tersebut sama sekali
tidak ada relasi yang terhubung.

maka solusinya adalah, kita dapat menggabungkan 2 table yang berelasi dulu,
lalu ambil column yang ada pada masing-masing table, sehingga output sesuai
yang kita inginkan.
*/
SELECT 
    d.dept_name, ROUND(AVG(s.salary)) AS rata_rata_gaji
FROM
    departments d
        JOIN
    dept_manager dm ON d.dept_no = dm.dept_no
        JOIN
    salaries s ON dm.emp_no = s.emp_no
GROUP BY d.dept_name
ORDER BY rata_rata_gaji DESC;

-- Mencari nilai rata-rata dengan value 60000
SELECT 
    d.dept_name, ROUND(AVG(s.salary)) AS rata_rata_gaji
FROM
    departments d
        JOIN
    dept_manager dm ON d.dept_no = dm.dept_no
        JOIN
    salaries s ON dm.emp_no = s.emp_no
GROUP BY d.dept_name
HAVING rata_rata_gaji > 60000
ORDER BY rata_rata_gaji DESC;

-- Exercise Number 1
/*
How many male and how many female managers 
do we have in the ‘employees’ database?
*/
SELECT 
    e.gender, COUNT(dm.emp_no) AS total_karyawan
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
GROUP BY e.gender;

/*------------------------------------------------------------------------------------*/

-- Masuk pada penggunaan UNION vs UNION ALL
/*
Disini kita akan melakukan pembuatan table baru sebagai data uji coba
yang akan kita gunakan nantinya, yaitu employees_dup
*/

DROP TABLE IF EXISTS employees_dup; -- Hapus Table jika sudah ada
CREATE TABLE employees_dup( -- Buat Table baru
	emp_no INT,
    birth_date DATE,
    first_name VARCHAR(14),
    last_name VARCHAR(16),
    gender ENUM('M', 'F'),
    hire_date DATE
) ENGINE = InnoDB;

INSERT INTO employees_dup -- Masukkan data berdasarkan data yang sudah ada pada table asli
SELECT e.*
FROM employees e
LIMIT 20;

SELECT -- Coba cek data, jika data sudah terisi 20 maka query berhasil
    *
FROM
    employees_dup;

/*
Mari kita asumsikan jika kita mencoba masukkan data baru dan
data ini value-nya sama dengan data yang sudah ada pada table
*/
INSERT INTO employees_dup
VALUES('10001', '1953-09-02', 'Georgi', 'Facello', 'M', '1986-06-26');

-- UNION ALL
/*
Perlu diketahui bahwa untuk penggunaan UNION ALL
jika pada table terdapat data yang sama, maka data tersebut
akan ikut ditampilkan juga pada hasil output.

Disini jika kita memang ingin mengoptimalkan hasil kinerja
maka dapat menggunakan UNION ALL.

PENTING untuk DIINGAT!!!
Penggunaan kolom pada SELECT jumlahnya haruslah sama 
dengan SELECT setelah UNION ALL, contoh error ada pada Example 1
dan contoh benar ada pada example 2
*/
-- Example 1
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name
FROM
    employees_dup e
WHERE
    e.emp_no = 10001 
UNION ALL SELECT 
    m.dept_no,
    m.from_date
FROM
    dept_manager m;
    
-- Example 2
SELECT 
    e.emp_no,
    e.first_name
FROM
    employees_dup e
WHERE
    e.emp_no = 10001 
UNION ALL SELECT 
    m.dept_no,
    m.from_date
FROM
    dept_manager m;

-- Example 3 (Dijabarkan Table-nya)
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    NULL AS dept_no,
    NULL AS from_date
FROM
    employees_dup e
WHERE
    e.emp_no = 10001 
UNION ALL SELECT 
    NULL AS emp_no,
    NULL AS first_name,
    NULL AS last_name,
    m.dept_no,
    m.from_date
FROM
    dept_manager m;
    
-- UNION
/*
Perlu diketahui bahwa untuk penggunaan UNION
jika pada table terdapat data yang sama, maka data tersebut
tidak akan ikut ditampilkan pada hasil output, berbeda dengan
UNION ALL yang akan mengambil semua baris baik yang unik
maupun duplikat

Disini jika kita ingin mencari hasil yang lebih baik
maka dapat menunggunakan UNION sekaligus menghilangkan
data duplikat pada table

PENTING untuk DIINGAT!!!
Penggunaan kolom pada SELECT jumlahnya haruslah sama 
dengan SELECT setelah UNION ALL, contoh error ada pada Example 1
dan contoh benar ada pada example 2
*/
-- Example 1
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name
FROM
    employees_dup e
WHERE
    e.emp_no = 10001 
UNION SELECT 
    m.dept_no,
    m.from_date
FROM
    dept_manager m;

-- Example 2
SELECT 
    e.emp_no,
    e.first_name
FROM
    employees_dup e
WHERE
    e.emp_no = 10001 
UNION SELECT 
    m.dept_no,
    m.from_date
FROM
    dept_manager m;

-- Example 3 (Dijabarkan Table-nya)
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    NULL AS dept_no,
    NULL AS from_date
FROM
    employees_dup e
WHERE
    e.emp_no = 10001 
UNION SELECT 
    NULL AS emp_no,
    NULL AS first_name,
    NULL AS last_name,
    m.dept_no,
    m.from_date
FROM
    dept_manager m;

-- Exercise Number 1
/*
Go forward to the solution and execute the query. 
What do you think is the meaning of the minus sign 
before subset A in the last row (ORDER BY -a.emp_no DESC)? 
*/

/*
Pada query [- a.emp_no DESC] digunakan untuk mengurutkan kolom
emp_no dengan urutan descending jadi jika kita menggunakan query tersebut
maka data pada table yang isinya NULL akan ditampilkan terakhir, namun jika
fungsi DESC ini dihapus, maka data yang akan di dahulukan untuk ditampilkan
pada output adalah data NULL baru setelah itu data selanjutnya dengan urutan
ascending.

Gampangnya:
Dengan menggunakan kode ini [- a.emp_no DESC], pertama-tama Anda akan mengurutkan 
karyawan dari yang paling rendah ke yang paling tinggi, 
dan kemudian meninggalkan nilai nol di bagian akhir.
*/

SELECT 
    *
FROM
    (SELECT 
        e.emp_no,
            e.first_name,
            e.last_name,
            NULL AS dept_no,
            NULL AS from_date
    FROM
        employees e
    WHERE
        last_name = 'Denis' UNION SELECT 
        NULL AS emp_no,
            NULL AS first_name,
            NULL AS last_name,
            dm.dept_no,
            dm.from_date
    FROM
        dept_manager dm) AS a
ORDER BY - a.emp_no DESC;

/*------------------------------------------------------------------------------------*/