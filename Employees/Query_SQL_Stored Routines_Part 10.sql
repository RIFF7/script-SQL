-- Masuk Materi Stored Routines
/*
Stored Routines tersimpan tidak lain adalah pernyataan SQL, 
atau sekumpulan pernyataan SQL yang dapat disimpan di server database
*/

/*------------------------------------------------------------------------------------*/
-- Store Procedure
-- Sebelum membuat prosedure baru, silakan lankukan langkah dibawah ini dulu
DROP PROCEDURE IF EXISTS select_employees;

-- Lalu silakan buat procedure-nya
-- First Build non-parametric procedures (tanpa parameter)
DELIMITER $$
CREATE PROCEDURE select_employees()
BEGIN
	SELECT *
    FROM employees
    LIMIT 1000;
END$$
DELIMITER ; -- Untuk semikolom (;) terakhir ini harus menggunakan space

/*
Setelah membuat procedure selanjutnya adalah bagaimana kita mengetahuinya,
kita bisa melihat schema pada workbench pada database employees disini
terdapat pilihan table, views, stored procedures dan functions.

Jika kita sudah membuatnya procedure maka silakan refresh schema terlebih dahulu
lalu silakan klik store proceduere, atau kita dapat memanggilnya dengan query
dibawah ini:

CALL database_name.procedure_name();
*/
-- Cara Default
CALL employees.select_employees();

-- Cara ketika sudah Use Database
CALL select_employees;

-- Exercise Number 1
/*
Create a procedure that will provide 
the average salary of all employees.

Then, call the procedure.
*/

DELIMITER $$
CREATE PROCEDURE emp_avg_salary()
BEGIN
	SELECT
		ROUND(AVG(salary),2) as avg_salary
	FROM 
		salaries;
END$$
DELIMITER ;

CALL employees.emp_avg_salary();

/*------------------------------------------------------------------------------------*/
-- Cara lainnya untuk membuat Stored Procedures
/*
Untuk membuat Store Procedures selain menuliskan query,
kita juga dapat membuatnya pada Navigator SCHEMA pada Workbench
untuk langkahnya antara lain:

- Pada kolom SCHEMA silakan cari Stored Procedures
- Klik kanan lalu pilih 'Creat Stored Procedres'
- Nanti akan terbukan workspace baru
- Selanjutnya ketik query yang diinginkan
- Jika sudah selesai, maka kita bisa menyimpamnnya
dengan klik 'Apply'
- Kita akan diarahkan menuju tampilan form Procedures
- Jika tidak ada yang diubah, maka bisa klik 'Apply'
- Tunggu prosesnya dan klik 'Finish'
- DONE

Jika saat ini kita sudah membuat stored procedures, menggunakan
cara diatas maka langkah selanjutnya adalah memastikannya dengan
memanggil procedures yang sudah dibuat.

*/

CALL employees.select_salaries();

/*------------------------------------------------------------------------------------*/

/*
Jika sebelumnya kita sudah membuat Stored Procedures
maka langkah selanjutnya adalah bagaimana untuk menghapus
procedures yang sudah dibuat?

Untuk melakukan langkah ini cukup mudah, ini hampir sama
ketika kita akan melakukan penghapusan pada database, yaitu
dengan menggunakan DROP.

Namun yang perlu diketahui untuk menghapus procedures memang 
menggunakan DROP tapi tentua ada tambahannya ya, yaitu
DROP PROCEDURE nama_procedure;
*/

DROP PROCEDURE select_employees;

/*
Atau untuk cara lainnya untuk menghapus procedures
- Kita dapat pergi ke menu Navigator SCHEMAS, lalu cari 
- Stored Procedures setelah itu klik kanan pada bagian
nama procedures yang akan dihapus, dan silakan pilih
- 'Drop Procedures' setelah itu silakan pilih dan klik
- 'DROP NOW'
*/

/*------------------------------------------------------------------------------------*/

-- Sored Procedures dengan menambahkan Input Parameter
/*
Dalam pembuatan procedure ini kita akan membuat procedure
dengan inputan yang kita sendiri masukkan dan ketika kita
memasukkan data INTEGER emp_no seperti yang sudah kita tentukan 
pada data type procedure sebelumnya, maka kita hanya perlu menyebutkan
emp_no dari karyawan yang akan kita cari.

Cara mencari data procedure dengan inputan adalah:
1. - Pada Navigation SCHEMA cari Stored Procedure
   - Pilih nama procedure yang sudah dibuat dengan parameter
   - Untuk memasukkan inputan melalui Navigation kita dapat
   memilih icon petir untuk memasukkan data emp_no dari karyawan

2. Cara lainnya dapat menggunakan 'CALL nama_database.nama_procedure(emp_no);'

- Pada procedure emp_salary pertama disini kita akan mencari
besaran gaji dari emp_no karyawan yang kita ingin cari, example
'11300'

- Pada procedure emp_no_avg_salary kedua disini kita mencari 
nilai rata-rata dari emp_no karyawan yang kita akan masukkan
atau cari, example '11300'
*/
DROP PROCEDURE IF EXISTS emp_salary_in;

DELIMITER $$
CREATE PROCEDURE emp_salary_in(IN p_emp_no INTEGER) -- Membuat procedure dengan parameter dan data type INTEGER
BEGIN
	SELECT
		e.first_name, -- Lakukan query yang akan dijadikan sebagai procedure
        e.last_name, 
        s.salary, 
        s.from_date, 
        s.to_date
	FROM employees e
    JOIN salaries s ON e.emp_no = s.emp_no
    /*
    Jangan lupa, jika kita membuat parameter tambahkan WHERE 
    gunanya agar melakukan pengecekan apakah parameter sudah
    sesuai dengan query yang ada saat ini.
    */
    WHERE e.emp_no = p_emp_no; 
END$$
DELIMITER ;

-- Stored Procedure juga dapat digunakan untuk melakukan aggregate function
-- Example
DROP PROCEDURE IF EXISTS emp_avg_salary_in;

DELIMITER $$
CREATE PROCEDURE emp_avg_salary_in(IN p_emp_no INTEGER) -- Membuat procedure dengan parameter dan data type INTEGER
BEGIN
	SELECT
		e.first_name, -- Lakukan query yang akan dijadikan sebagai procedure
        e.last_name, 
        AVG(s.salary) AS avg_salary -- Store Procedure untuk aggrgate function
	FROM employees e
    JOIN salaries s ON e.emp_no = s.emp_no
    /*
    Jangan lupa, jika kita membuat parameter tambahkan WHERE 
    gunanya agar melakukan pengecekan apakah parameter sudah
    sesuai dengan query yang ada saat ini.
    */
    WHERE e.emp_no = p_emp_no
    GROUP BY 1 , 2; 
END$$
DELIMITER ;

/*------------------------------------------------------------------------------------*/
-- Sored Procedures dengan menambahkan Output Parameter
DROP PROCEDURE IF EXISTS emp_avg_salary_out;

DELIMITER $$
CREATE PROCEDURE emp_avg_salary_out(IN p_emp_no INTEGER, OUT p_avg_salary DECIMAL(10,2))
BEGIN
	SELECT
		AVG(s.salary) AS avg_salary
	INTO p_avg_salary 
    FROM employees e
    JOIN salaries s ON e.emp_no = s.emp_no
    WHERE e.emp_no = p_emp_no;
END$$
DELIMITER ;

-- Exercise Number 1
/*
Create a procedure called ‘emp_info’ that uses as parameters 
the first and the last name of an individual, and returns their employee number.
*/
DROP PROCEDURE IF EXISTS emp_info;

DELIMITER $$
CREATE PROCEDURE emp_info(IN p_first_name VARCHAR(255), IN p_last_name VARCHAR(255), OUT p_emp_no INTEGER)
BEGIN
	SELECT
		e.emp_no
	INTO p_emp_no
	FROM employees e
    WHERE
		e.first_name = p_first_name
			AND e.last_name = p_last_name;
END$$
DELIMITER ;

/*
NOTE:

Ketika kita melakukan pencarian pada p_first_name, p_last_name dan juga p_emp_no
untuk emp_no dari table employees dengan value '10001' ini akan menyebabkan error
disini error terjadi karena nilai dari emp_no tersebut keluar lebih dari 1 kali
sehingga parameter yang kita buat pada procedure tidak bisa menampuny 2 nilai output tersebut

untuk membuktikannya nilai emp_no '10001' ini keluar lebih dari 1 kali, maka kita dapat
melakukan pengecekan dengan menggunakan query:

SELECT
	*
FROM employees
WHERE first_name = 'Georgi' AND last_name = 'Facello';

Dari hasil output query diatas, akan memberikan informasi pada kita bahwa terdapat
2 value dengan nama yang sama namun berbeda dalam emp_no, khusus untuk procedure
yang kita buat diatas hanya bisa mengembalikan satu nilai, sehingga akan menyebabkan
error ketika Stored Procedure dijalankan.
*/

/*------------------------------------------------------------------------------------*/

-- Materi Variables 
/*
Variables dapat kita gunakan untuk memanggil sebuah procedure 
yang sudah kita buat sebelumnya, untuk menggunakannya bisa dengan
cara dibawah ini:
*/
SET @v_avg_salary = 0; -- Dijalankan pertama
CALL employees.emp_avg_salary_out(11300, @v_avg_salary); -- Dijalankan kedua
SELECT @v_avg_salary; -- Dijalankan ketiga untuk mendapatkan hasil AVG

-- Exercise Number 1
/*
Create a variable, called ‘v_emp_no’, where you will store 
the output of the procedure you created in the last exercise.

Call the same procedure, inserting the values 
‘Aruna’ and ‘Journel’ as a first and last name respectively.

Finally, select the obtained output.
*/
SET @v_emp_no = 0;
CALL employees.emp_info('Aruna', 'Journel', @v_emp_no);
SELECT @v_emp_no;

/*------------------------------------------------------------------------------------*/

/*
Materi User-defined functions in MySQL
[Fungsi yang ditentukan pengguna di MySQL]
*/

/*
Untuk contoh awal ini saya akan membuat sebuah function
seperti terlihat dibawah ini, namun ketika di jalankan
query ini akan menampilkan error, untuk mengatasi error yang ada
pada query dibawah ini, kita bisa menambahkan karakter
DETERMINISTIC, NO SQL, READS SQL DATA
*/

-- Akan ERROR
DROP FUNCTION IF EXISTS f_emp_avg_salary;

DELIMITER $$
CREATE FUNCTION f_emp_avg_salary(p_emp_no INTEGER) RETURNS DECIMAL(10, 2)
BEGIN

DECLARE v_avg_salary DECIMAL(10, 2);
	
    SELECT
		AVG(s.salary) AS avg_salary
	INTO v_avg_salary
    FROM employees e
    JOIN salaries s ON e.emp_no = s.emp_no
    WHERE e.emp_no = p_emp_no;
    
RETURN v_avg_salary;

END$$
DELIMITER ;

-- Berhasil DIJALANKAN
DROP FUNCTION IF EXISTS f_emp_avg_salary;

DELIMITER $$
CREATE FUNCTION f_emp_avg_salary(p_emp_no INTEGER) RETURNS DECIMAL(10, 2)
DETERMINISTIC -- Untuk menambahkan karakter lainnya tidak perlu menggunakan koma example: DETERMINISTIC NO SQL READS SQL DATA
BEGIN

DECLARE v_avg_salary DECIMAL(10, 2);
	
    SELECT
		AVG(s.salary) AS avg_salary
	INTO v_avg_salary
    FROM employees e
    JOIN salaries s ON e.emp_no = s.emp_no
    WHERE e.emp_no = p_emp_no;
    
RETURN v_avg_salary;

END$$
DELIMITER ;

-- Memanggil FUNCTION yang sudah dibuat
SELECT f_emp_avg_salary(11300);

-- Exercise Number 1
/*
Create a function called ‘emp_info’ that takes for parameters 
the first and last name of an employee, and returns the salary 
from the newest contract of that employee.

Hint: In the BEGIN-END block of this program, you need to declare and 
use two variables – v_max_from_date that will be of the DATE type, 
and v_salary, that will be of the DECIMAL (10,2) type.

Finally, select this function.
*/
DROP FUNCTION IF EXISTS emp_info;

DELIMITER $$
CREATE FUNCTION emp_info(f_first_name VARCHAR(255), f_last_name VARCHAR(255)) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
	DECLARE v_max_from_date DATE;
    DECLARE v_salary DECIMAL(10, 2);
	
    SELECT
        MAX(s.from_date) AS max_date
	INTO v_max_from_date
    FROM employees e
    JOIN salaries s ON e.emp_no = s.emp_no
    WHERE e.first_name = f_first_name
		AND e.last_name = f_last_name;
    
    SELECT
		s.salary
	INTO v_salary
    FROM employees e
    JOIN salaries s ON e.emp_no = s.emp_no
    WHERE e.first_name = f_first_name
		AND e.last_name = f_last_name
        AND s.from_date = v_max_from_date;
RETURN v_salary;
END$$
DELIMITER ;

SELECT emp_info('Aruna', 'Journel');

/*
Cara Ke-2, dengan menggabungkan 2 parameter dalam satu perintah SELECT
dengan menggunakan batasan LIMIT dan penggunaan ORDER BY diakhir pembuatan FUNCTION.

Dalam query ini, kita melakukan sorting berdasarkan from_date 
secara descending menggunakan ORDER BY s.from_date DESC, 
dan kemudian menggunakan LIMIT 1 untuk membatasi hasil query 
hanya pada baris pertama (yang memiliki from_date tertinggi, atau kontrak terbaru).

Dengan cara ini, kita hanya perlu satu query untuk 
mendapatkan informasi kontrak terbaru dan salary yang sesuai.
*/
DELIMITER $$
CREATE FUNCTION emp_info(p_first_name VARCHAR(255), p_last_name VARCHAR(255)) RETURNS DECIMAL(10, 2)
READS SQL DATA
BEGIN
    DECLARE v_max_from_date DATE;
    DECLARE v_salary DECIMAL(10, 2);

    SELECT s.from_date, s.salary
    INTO v_max_from_date, v_salary
    FROM salaries s
    JOIN employees e ON s.emp_no = e.emp_no
    WHERE e.first_name = p_first_name AND e.last_name = p_last_name
    ORDER BY s.from_date DESC
    LIMIT 1;

    RETURN v_salary;
END$$
DELIMITER ;

/*------------------------------------------------------------------------------------*/

-- Stored routines - conclusion

/*
Perbedaan Stored Procedure & User-Defined Function
------------------------------------------------------
Stored Procedure: Can have multiple OUT parameters
User-Defined Function: Can return a single value only

#####################################################################
Kapan kita menggunakan Procedure dan Function?

- Jika kita perlu mendapatkan lebih dari satu nilai sebagai
hasil perhitungan, lebih baik kita menggunakan procedure.

- Namun jika kita hanya perlu satu nilai untuk dikembalikan maka
kita dapat menggunkan function.
#####################################################################

Perbedaan Lainnya Stored Procedure & User-Defined Function
------------------------------------------------------------
Stored Procedure: Mendukung perintah INSERT, UPDATE, DELETE
User-Defined Function: TIDAK mendukung perintah INSERT, UPDATE, DELETE?

Pemanggilan Output DATA:
--------------------------
Stored Procedure: CALL procedure;
User-Defined Function: SELECT function;
*/

/*
Dalam penggunaan function dengan SELECT, disini
memungkinkan kita untuk menggabungkannya dengan perintah
lainnya, seperti dibawah ini:
*/
SET @v_emp_no = 11300;
SELECT
	emp_no,
    first_name,
    last_name,
    f_emp_avg_salary(@v_emp_no) AS avg_salary
FROM 
	employees
WHERE
	emp_no = @v_emp_no; -- Pada query ini sangat memungkinkan menggabungkannya dengan FUNCTION

/*------------------------------------------------------------------------------------*/