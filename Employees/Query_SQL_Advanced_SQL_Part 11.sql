-- ADVANCED SQL TOPIC
-- Types of MySQL Variables - Local Variables
/*
MySQL Variables, terbagi menjadi 3 bagian diantaranya:
- Local -> Ditulis dengan DECLARE
- Session -> Ditulis dengan SET @variable
- Global -> Ditulis dengan SET GLOBAL vat_name = value; / SET @@global.var_name = value;

Saat ini kita akan fokus pada pembuatan Local Variable
terlebih dahulu, seperti yang sebelumnya sudah kita ketahui
bahwa kita telah membuat function 'f_emp_avg_salary' disini
kita akan menghapus function tersebut untuk kita lakukan percobaan
penggunaan Local Variable:
*/
DROP FUNCTION IF EXISTS f_emp_avg_salary;

DELIMITER $$
CREATE FUNCTION f_emp_avg_salary(p_emp_no INTEGER) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN

DECLARE v_avg_salary DECIMAL(10, 2);
	
    SELECT
		AVG(s.salary) AS avg_salary
	INTO v_avg_salary
    FROM employees e
    JOIN salaries s ON e.emp_no = s.emp_no
    WHERE
		e.emp_no = p_emp_no;

RETURN v_avg_salary;
END$$

DELIMITER ;

-- Coba kita jalankan Local Variable dari function diatas
SELECT v_abg_salary; -- Hasil outputnya akan menampilkan error dimana kolom tidak diketahui dalam field list

/*
Langkah selanjutnya coba kita buat ulang function 
diatas dengan menambahkan variable baru didalam sebuah
procedure, dan ketika function dibawah dijalankan akan menampilkan pesan error
karena variable baru [v_avg_salary_2] belum dilakukan deklarasinya.

Masalah pada query dibawah ini adalah karena deklarasi variabel v_avg_salary_2 
berada dalam blok yang terpisah dan tidak dapat diakses di luar blok tersebut. 
Variable tersebut hanya dapat digunakan di dalam blok dimana ia dideklarasikan.
*/
DROP FUNCTION IF EXISTS f_emp_avg_salary; -- Hapus function sebelumnya

DELIMITER $$
CREATE FUNCTION f_emp_avg_salary(p_emp_no INTEGER) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN

DECLARE v_avg_salary DECIMAL(10, 2);

BEGIN
	DECLARE v_avg_salary_2 DECIMAL(10, 2);
END;
	
    SELECT
		AVG(s.salary) AS avg_salary
	INTO v_avg_salary_2
    FROM employees e
    JOIN salaries s ON e.emp_no = s.emp_no
    WHERE
		e.emp_no = p_emp_no;

RETURN v_avg_salary_2;
END$$

DELIMITER ;

/*------------------------------------------------------------------------------------*/

-- Masuk Pada Materi Session Variables
/*
Perlu diketahui untuk Session Variables hanya berpengaruh pada
satu koneksi yang sama ketika Session Variable ini dibuat, example:

- Saat ini saya membuat Session Variable pada koneksi workbench 'connect_one'
maka ketika saya memanggil perintah SELECT @variable_session nilainya akan tetap
muncul pada koneksi ini walaupun saya membuat lembar kerja query SQL baru.

- Namun ketika saya memanggil fungsi SELECT @variable_session di koneksi lainnya
sebagai contoh 'connect_two' maka nilainya bukan lagi yang kita setting pada 'connect_one'
namun hasilnya akan NULL sebab nilai yang sudah kita SET pada koneksi awal hanya dapat digunakan
pada koneksi 'connect_one' saja dan tidak bisa digunakan pada 'connect_two'.
*/
SET @s_var1 = 3; -- Disini kita menetapkan variable '@s_var1' dengan value 3
SELECT @s_var1; -- Hasil outputnya akan bernilai 3, sesuai dengan yang telah kita atur

/*
NOTE:
Jika ada sepuluh koneksi yang berbeda ke server 
pada saat yang sama, akan ada sepuluh sesi yang berbeda
*/

/*------------------------------------------------------------------------------------*/

-- Masuk Materi Global Variables
/*

Global Variable bisa digunakan untuk mengatur batasan jumlah koneksi
pada server sesuai dengan yang kita inginkan dan juga dapat mengatur 
ruang memori yang dialokasikan pada server.

- .max_connections() -> Menunjukkan jumlah maksimum koneksi ke server yang dapat dibuat pada titik waktu tertentu
- .max_join_size() -> Menetapkan ruang memori maksimum yang dialokasikan untuk sambungan yang dibuat oleh sambungan tertentu

Contoh membuat batasakan pada koneksi server:

- SET GLOBAL max_connections = 1000; -> Ini akan mebatasi koneksi MySQL sebanyak 1000
- SET @@global.max_connections = 1; -> Ini akan membatasi koneksi MySQL sebanyak 1 saja

NOTE:
Seseorang dengan profesi yang akan memegang kendali 
untuk mengatur variabel global dalam database adalah
seorang Database Administrator.
*/

/*------------------------------------------------------------------------------------*/

-- LECTURE: MySQL Triggers

# Pada pelajaran ini, kami akan memperkenalkan Anda pada trigger MySQL.

# Menurut definisi, trigger MySQL adalah sebuah jenis program yang tersimpan, yang diasosiasikan dengan sebuah tabel, 
# yang akan diaktifkan secara otomatis ketika ada kejadian tertentu yang berhubungan dengan tabel yang diasosiasikan. 

# Peristiwa ini harus berhubungan dengan salah satu dari tiga pernyataan DML berikut: 
# INSERT, UPDATE, atau DELETE. 
# Oleh karena itu, trigger adalah alat yang kuat dan praktis yang disukai para profesional 
# untuk digunakan ketika konsistensi dan integritas basis data 
# konsistensi dan integritas basis data yang bersangkutan.

# Selain itu, untuk salah satu dari pernyataan DML ini, salah satu dari dua jenis trigger dapat ditetapkan - trigger "before", atau trigger "after".

# Dengan kata lain, trigger adalah objek MySQL yang dapat "mentrigger/memicu" tindakan atau perhitungan tertentu 'before' atau 'after' INSERT, 
# UPDATE, atau pernyataan DELETE telah dieksekusi. Sebagai contoh, trigger dapat diaktifkan sebelum record baru dimasukkan ke dalam tabel, 
# atau setelah sebuah record diperbarui.

# Sempurna! Mari kita jalankan beberapa kode.  

# Pertama, jika Anda baru saja memulai Workbench, pilih "employees" sebagai database default Anda.
USE employees;

# Kemudian, jalankan pernyataan COMMIT, karena trigger yang akan kita buat akan membuat beberapa perubahan pada 
# status data dalam database kita. Di akhir latihan, kita akan ROLLBACK ke saat COMMIT ini.  
COMMIT;

# Tadi kita sudah mengatakan bahwa trigger adalah sebuah jenis program tersimpan. 
#Nah, bisa dikatakan sintaksnya mirip dengan prosedur tersimpan, bukan?

# BEFORE INSERT
DELIMITER $$

CREATE TRIGGER before_salaries_insert
BEFORE INSERT ON salaries
FOR EACH ROW
BEGIN 
	IF NEW.salary < 0 THEN 
		SET NEW.salary = 0; 
	END IF; 
END $$

DELIMITER ;

# Setelah menyatakan bahwa kita ingin MEMBUAT sebuah trigger dan kemudian menunjukkan namanya, kita harus menunjukkan jenisnya dan nama tabel 
# yang akan diterapkan. Dalam kasus ini, kita membuat trigger "before", yang akan diaktifkan setiap kali ada data baru yang dimasukkan 
# di dalam tabel "Gaji". 

# Bagus!

# Kemudian, frasa yang menarik mengikuti - "untuk setiap baris (for each row)". Ini menunjukkan bahwa sebelum trigger diaktifkan, MySQL akan melakukan
# pemeriksaan untuk perubahan status data pada semua baris. Dalam kasus kami, perubahan dalam data tabel "Salaries" akan disebabkan 
# oleh penyisipan record baru. 

# Di dalam blok BEGIN-END, Anda dapat melihat sepotong kode yang lebih mudah dipahami jika Anda membacanya tanpa fokus pada 
# sintaksnya.

# Tubuh dari blok ini bertindak sebagai inti dari trigger "before_salaries_insert". Pada dasarnya, ia mengatakan bahwa jika gaji yang baru dimasukkan 
# gaji yang baru disisipkan bernilai negatif, maka akan ditetapkan sebagai 0.
/*
	IF NEW.salary < 0 THEN 
		SET NEW.salary = 0; 
	END IF;
*/

# Dari sudut pandang seorang programmer, ada tiga hal yang perlu diperhatikan tentang tiga baris kode ini.

# Pertama, terutama bagi Anda yang sudah terbiasa dengan pemrograman, ini adalah contoh kondisional. Pernyataan IF 
# memulai blok kondisional. Kemudian, jika kondisi gaji negatif terpenuhi, kita harus menggunakan kata kunci THEN sebelum menunjukkan 
# tindakan apa yang harus dilakukan selanjutnya. Operasi diakhiri dengan frasa END IF dan titik koma. 

# Hal kedua yang perlu diperhatikan di sini bahkan lebih menarik. Yaitu penggunaan kata kunci NEW. Secara umum, kata kunci ini merujuk pada sebuah baris yang 
# baru saja disisipkan atau diperbarui. Dalam kasus kita, setelah kita menyisipkan record baru, "NEW dot salary" akan merujuk pada nilai yang akan 
# disisipkan di kolom "salary" pada tabel "salaries".

# Bagian ketiga dari sintaks tersebut berkaitan dengan kata kunci SET. Seperti yang telah Anda ketahui, kata kunci ini digunakan setiap kali sebuah nilai harus ditetapkan ke sebuah 
# variabel tertentu. Di sini, variabelnya adalah gaji yang baru dimasukkan, dan nilai yang akan diberikan adalah 0. 

# Baiklah! Mari kita jalankan kueri ini. 

# BEFORE INSERT
DELIMITER $$

CREATE TRIGGER before_salaries_insert
BEFORE INSERT ON salaries
FOR EACH ROW
BEGIN 
	IF NEW.salary < 0 THEN 
		SET NEW.salary = 0; 
	END IF; 
END $$

DELIMITER ;

# Mari kita periksa nilai tabel "salaries" untuk karyawan 10001.
SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001'; -- awalnya akan berjumlah 17 rows

# Sekarang, mari kita masukkan entri baru untuk karyawan 10001, yang gajinya akan berupa angka negatif.
INSERT INTO salaries VALUES ('10001', -92891, '2010-06-22', '9999-01-01');

# Mari kita jalankan kueri SELECT yang sama untuk melihat apakah record yang baru dibuat memiliki gaji 0 dolar per tahun.
SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001';
    
# Anda bisa melihat bahwa trigger "before_salaries_insert" diaktifkan secara otomatis. Ini mengoreksi nilai minus 92.891 
# yang kami coba masukkan. 

# Fantastis!

# Sekarang, mari kita lihat trigger BEFORE UPDATE. Kode ini mirip dengan salah satu trigger yang kita buat di atas, dengan dua 
# perbedaan yang substansial.

# BEFORE UPDATE
DELIMITER $$

CREATE TRIGGER trig_upd_salary
BEFORE UPDATE ON salaries
FOR EACH ROW
BEGIN 
	IF NEW.salary < 0 THEN 
		SET NEW.salary = OLD.salary; 
	END IF; 
END $$

DELIMITER ;

# Pertama, kami mengindikasikan bahwa ini akan menjadi trigger SEBELUM UPDATE.  
/*
BEFORE UPDATE ON salaries
*/

# Kedua, dalam pernyataan bersyarat IF, alih-alih menetapkan nilai baru menjadi 0, pada dasarnya kita memberi tahu MySQL untuk mempertahankan nilai lama. 
# Secara teknis, hal ini dilakukan dengan mengatur nilai BARU di kolom "Gaji" agar sama dengan nilai LAMA. Ini adalah contoh yang bagus untuk 
# ketika kata kunci LAMA perlu digunakan.
/*
	IF NEW.salary < 0 THEN 
		SET NEW.salary = OLD.salary; 
	END IF;
*/

# Buat trigger "before_salaries_update" dengan menjalankan pernyataan di atas. 

# Kemudian, jalankan pernyataan UPDATE berikut ini, dimana kita akan memodifikasi nilai gaji karyawan 10001 dengan nilai positif lainnya.
UPDATE salaries 
SET 
    salary = 98765
WHERE
    emp_no = '10001'
        AND from_date = '2010-06-22';


# Jalankan pernyataan SELECT berikut untuk melihat bahwa record telah berhasil diperbarui.
SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001'
        AND from_date = '2010-06-22';

# Sekarang, mari kita jalankan pernyataan UPDATE lainnya, yang dengannya kita akan mencoba 
# memodifikasi gaji yang diperoleh 10001 dengan nilai negatif, minus 50.000.
UPDATE salaries 
SET 
    salary = - 50000
WHERE
    emp_no = '10001'
        AND from_date = '2010-06-22';

# Mari kita jalankan pernyataan SELECT yang sama untuk memeriksa apakah nilai gaji telah disesuaikan.
SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001'
        AND from_date = '2010-06-22';

# Tidak, tidak. Semuanya tetap utuh. Jadi, kita dapat menyimpulkan bahwa hanya pembaruan dengan gaji yang lebih tinggi dari nol dolar per tahun 
# akan dilaksanakan.

# Baiklah. Untuk saat ini, Anda tahu bahwa Anda telah menciptakan hanya dua trigger. Tetapi bagaimana Anda bisa membuktikannya kepada seseorang yang melihat 
# script untuk pertama kalinya?
# Nah, di bagian 'info' pada database "karyawan", Anda dapat menemukan sebuah tab yang berhubungan dengan trigger. Ketika Anda mengklik namanya, 
# MySQL akan menampilkan nama, kejadian terkait, tabel, waktu, dan karakteristik lain mengenai setiap trigger yang sedang digunakan.  

# Luar biasa!

# Mari kita perkenalkan Anda pada fakta menarik lainnya tentang MySQL. Anda sudah mengetahui bahwa ada variabel sistem yang sudah ditentukan sebelumnya, tetapi fungsi sistem 
# Fungsi-fungsi sistem juga ada! 
# Fungsi sistem juga dapat disebut sebagai fungsi bawaan. 
# Fungsi-fungsi ini sering digunakan dalam praktik, mereka menyediakan data yang berhubungan dengan saat eksekusi query tertentu.

# Sebagai contoh, SYSDATE() memberikan tanggal dan waktu saat Anda memanggil fungsi ini.
SELECT SYSDATE();

# Fungsi lain yang sering digunakan, "Format Tanggal", menetapkan format tertentu untuk tanggal tertentu. Misalnya, kueri berikut ini 
# dapat mengekstrak tanggal saat ini, mengutip tahun, bulan, dan hari. 
SELECT DATE_FORMAT(SYSDATE(), '%y-%m-%d') as today;

# Tentu saja, ada banyak cara lain untuk memformat tanggal; yang kami tunjukkan di sini, hanyalah sebuah contoh.
# Jadi, menggunakan fungsi sistem tampak keren, bukan?

# Hebat! Anda sudah mengetahui cara bekerja dengan sintaks yang memungkinkan Anda membuat trigger. 

# Sebagai latihan, cobalah untuk memahami kueri berikut ini. Secara teknis, ini berkaitan dengan pembuatan trigger yang lebih kompleks. 
#Ini adalah ukuran yang sering dihadapi oleh para profesional.

DELIMITER $$

CREATE TRIGGER trig_ins_dept_mng
AFTER INSERT ON dept_manager
FOR EACH ROW
BEGIN
	DECLARE v_curr_salary int;
    
    SELECT 
		MAX(salary)
	INTO v_curr_salary FROM
		salaries
	WHERE
		emp_no = NEW.emp_no;

	IF v_curr_salary IS NOT NULL THEN
		UPDATE salaries 
		SET 
			to_date = SYSDATE()
		WHERE
			emp_no = NEW.emp_no and to_date = NEW.to_date;

		INSERT INTO salaries 
			VALUES (NEW.emp_no, v_curr_salary + 20000, NEW.from_date, NEW.to_date);
    END IF;
END $$

DELIMITER ;

# Setelah Anda yakin bahwa Anda telah memahami cara kerja query ini, silahkan eksekusi dan jalankan pernyataan INSERT berikut ini.  
INSERT INTO dept_manager VALUES ('111534', 'd009', date_format(sysdate(), '%y-%m-%d'), '9999-01-01');

# SELECT record nomor karyawan 111534 di tabel 'dept_manager', dan kemudian di tabel 'salaries' untuk melihat bagaimana output terpengaruh. 
SELECT 
    *
FROM
    dept_manager
WHERE
    emp_no = 111534;
    
SELECT 
    *
FROM
    salaries
WHERE
    emp_no = 111534;

# Secara konseptual, ini adalah trigger 'after' yang secara otomatis menambahkan $20.000 ke gaji karyawan yang baru saja dipromosikan sebagai manajer. 
# Selain itu, ini menetapkan tanggal mulai kontrak barunya menjadi hari di mana Anda mengeksekusi pernyataan insert.

# Terakhir, untuk mengembalikan data dalam database ke kondisi awal kuliah ini, jalankan pernyataan ROLLBACK berikut ini. 
ROLLBACK;

# End.

-- Exercise Number 1
/*
Create a trigger that checks if the hire date of an employee 
is higher than the current date. If true, set this date to be 
the current date. Format the output appropriately (YY-MM-DD).
*/
COMMIT;

DELIMITER $$

CREATE TRIGGER trig_hire_date
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
	IF NEW.hire_date > DATE_FORMAT(SYSDATE(), '%Y-%m-%d') THEN
		SET NEW.hire_date = DATE_FORMAT(SYSDATE(), '%Y-%m-%d');
	END IF;
END$$

DELIMITER ;

INSERT INTO employees VALUES('999904', '1970-01-31', 'John', 'Johnson', 'M', '2025-01-01');

SELECT *
FROM employees
ORDER BY emp_no DESC;

ROLLBACK;

/*------------------------------------------------------------------------------------*/

-- Materi MySQL Indexes
/*
Penggunaan Index pada MySQL dapat memudahkan kita
untuk melakukan pencarian pada suatu data pada database
sehingga prosesnya lebih cepat jika data pada database sudah
terbilang sangat banyak.

Bayangkan saja pada saat kita melakukan pencarian buku pada suatu
perpustakaan, jika tidak ada label dalam rak buku maka sudah dipastikan
pencarian buku yang kita inginkan akan sangat lama.
*/

/*
Example, ketika kita ingin mencari berapa banyak orang yang sudah
direkrut setelah tanggal 1 Januari 2000?
*/
SELECT *
FROM employees
WHERE -- Tanpa index butuh 0.3 detik untuk menjalankan hasil dari query
	hire_date > '2000-01-01';

/*
Lalu kita akan mencoba membuat Index untuk kolom hire_date
dan kita coba jalankan kembali query diatas.
*/
CREATE INDEX i_hire_date ON employees(hire_date);

SELECT *
FROM employees
WHERE -- Menggunakan index hanya butuh waktu 0.0 detik saja untuk menghasilkan output untuk query ini
	hire_date > '2000-01-01';

/*
Selanjutnya kita akan menggunakan contoh lainnya
disini kita akan mencoba untuk mencari nama karyawan
'Georgi Facello'
*/

SELECT *
FROM employees
WHERE -- Tanpa menggunakan Index butuh waktu 0.3 detik untuk menghasilkan output dari query
	first_name = 'Georgi' 
		AND last_name = 'Facello';

-- Membuat Index untuk 2 kolom
CREATE INDEX i_composite ON employees(first_name, last_name);

-- Jalankan kembali query sebelumnya
SELECT *
FROM employees
WHERE -- Dengan menggunakan index hanya butuh waktu 0.0 detik untuk menghasilkan output dari query
	first_name = 'Georgi' 
		AND last_name = 'Facello';

/*
Setelah membuat index sebelumnya cara untuk dapat melihat index
yang telah kita buat bisa menggunakan 3 cara dibawah ini:

- Silahkan pilih lambang 'i' pada schema employees, lalu pilih
'Index'

- Bisa memilih juga lambang 'i' pada table shema, lalu pilih
'Index'

- Atau kita juga bisa menjalankan DDL dibawah ini:
SHOW INDEX FROM table_name FROM database_name;
*/
SHOW INDEX FROM employees FROM employees;

-- Atau bisa menggunakan cara dibawah ini
SHOW INDEX FROM employees;

-- Exercise Number 1
/*
Drop the ‘i_hire_date’ index.
*/
ALTER TABLE employees
DROP INDEX i_hire_date;

-- Exercise Number 2
/*
Select all records from the ‘salaries’ table of people 
whose salary is higher than $89,000 per annum.

Then, create an index on the ‘salary’ column of that table, 
and check if it has sped up the search of the same SELECT statement.
*/

SELECT *
FROM salaries -- Kecepatan RUN Query 0.6 (Sebelum ada INDEX)
WHERE salary > 89000;

CREATE INDEX i_salary ON salaries(salary);

SELECT *
FROM salaries -- Kecepatan RUN Query menjadi 0.2 (Setelah pembuatan INDEX)
WHERE salary > 89000;

/*------------------------------------------------------------------------------------*/

-- Masuk Pada Materi CASE Statement
/*
CASE Statement adalah fungsi dimana kita akan menggunakan
pernyataan bersyarat pada query yang akan kita jalankan nantinya.

CASE Statement biasa digunakan dalam pernyataan pilihan ketika ingin
mengembalikan nilai tertentu berdasarkan beberapa kondisi.
*/
-- Cara 1: CASE Statement
SELECT
	emp_no,
    first_name,
    last_name,
    CASE
		WHEN gender = 'M' THEN 'Male'
        ELSE 'Female'
	END AS gender
FROM employees;

-- Cara 2: CASE Statement
SELECT
	emp_no,
    first_name,
    last_name,
    CASE gender
		WHEN 'M' THEN 'Male'
        ELSE 'Female'
	END AS gender
FROM employees;

-- Example Case
/*
Kita akan membuat kasus dimana jika value dari emp_no
tidak bernilai NULL maka kolom is_manager akan diisi dengan
'Manager' dan jika kolom emp_no ini bernilai NULL maka kolom
is_manager akan diisi dengan value 'Employee'
*/
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
    END AS is_manager
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
WHERE
    e.emp_no > 109990;

/*
Contoh selanjutnya adalah penuliasan query yang tidak sesuai
dimana pada CASE Statement disini dilakukan penulisana query
NOT NULL dan bukaknnya IS NOT NULL.

Perlu diketahui bahwa NOT NULL dan IS NOT NULL itu berbeda:

- NOT NULL digunakan saat mendefinisikan skema tabel untuk menyatakan 
bahwa kolom tidak boleh NULL.

- IS NOT NULL digunakan dalam pernyataan WHERE / CASE Statement untuk 
memeriksa apakah nilai aktual tidak NULL.
*/

-- Penulisan Query yang SALAH
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE dm.emp_no 
        WHEN NOT NULL THEN 'Manager'
        ELSE 'Employee'
    END AS is_manager
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
WHERE
    e.emp_no > 109990;

-- Penggunaan Statement IF
/*
Sama pada penggunaan CASE Statement sebelumnya untuk query dibawah
dimaksudkan untuk jika value dari gender ini adalah 'M' maka akan diisi
dengan 'Male' namun jika gender tidak bernilai 'M' (ELSE) maka akan diisi
dengan 'Female'.
*/
SELECT
	emp_no,
    first_name,
    last_name,
    IF (gender = 'M', 'Male', 'Female') AS gender
FROM employees;

-- IF Vs CASE Statement
/*
Untuk perbedaan penggunaan pada kedua statement ini adalah:

- Untuk CASE Statement, kita dapat memiliki beberapa ekspresi
kondisional

- Sedangkan untuk IF, kita hanya dapat menggunakan satu kondisi saja
*/

-- Example Case 2
/*
Pada contoh Case kedua ini kita kan mencoba untuk mencari 
kenaikan gaji dari semua department manager berdasarkan beberapa
kondisi dengan menggunakan beberapa ekspresi WHEN yang akan mengembalikian
lebih dari dua nilai di kolom kenaikan gaji
*/

SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more than $30.000'
        WHEN MAX(s.salary) - MIN(s.salary) BETWEEN 20000 AND 30000 THEN 'Salary was raised by more than $20.000 but less than $30.000'
        ELSE 'Salary was raised by less than $20.000'
    END AS salary_increase
FROM
    dept_manager dm
        JOIN
    employees e ON dm.emp_no = e.emp_no
        JOIN
    salaries s ON e.emp_no = dm.emp_no
GROUP BY 1, 2, 3;

-- Exercise Number 1
/*
Similar to the exercises done in the lecture, obtain a result set 
containing the employee number, first name, and last name of all employees 
with a number higher than 109990. Create a fourth column in the query, 
indicating whether this employee is also a manager, according to the data 
provided in the dept_manager table, or a regular employee. 
*/
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
    END AS is_manager
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
WHERE
    e.emp_no > 109990;

-- Exercise Number 2
/*
Extract a dataset containing the following information about the managers: 
employee number, first name, and last name. Add two columns at the end – one 
showing the difference between the maximum and minimum salary of that employee, 
and another one saying whether this salary raise was higher than $30,000 or NOT.

If possible, provide more than one solution.
*/

-- Cara 1
SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more than $30.000'
        ELSE 'Salary wa NOT raised by more than $30.000'
    END AS salary_raise
FROM
    dept_manager dm
        JOIN
    employees e ON dm.emp_no = e.emp_no
        JOIN
    salaries s ON dm.emp_no = s.emp_no
GROUP BY 1 , 2 , 3;

-- Cara 2
SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    IF(MAX(s.salary) - MIN(s.salary) > 30000,
        'Salary was raised by more then $30.000',
        'Salary was NOT raised by more then $30.000') AS salary_increase
FROM
    dept_manager dm
        JOIN
    employees e ON dm.emp_no = e.emp_no
        JOIN
    salaries s ON dm.emp_no = s.emp_no
GROUP BY 1 , 2 , 3;

-- Exercise Number 3
/*
Extract the employee number, first name, and last name of the first 100 employees, 
and add a fourth column, called “current_employee” saying “Is still employed” 
if the employee is still working in the company, or “Not an employee anymore” if they aren’t.

Hint: You’ll need to use data from both the ‘employees’ and the ‘dept_emp’ table to solve this exercise. 
*/
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN MAX(dp.to_date) > SYSDATE() THEN 'Is still employed'
        ELSE 'Not an employee anymore'
    END AS current_employee
FROM
    employees e
        JOIN
    dept_emp dp ON e.emp_no = dp.emp_no
GROUP BY 1, 2, 3
LIMIT 100;

/*------------------------------------------------------------------------------------*/