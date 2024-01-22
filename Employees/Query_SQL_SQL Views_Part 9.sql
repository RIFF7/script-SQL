-- Materi SQL Views
/*
Pada hasil dept_emp dari query dibawah ini pada
kolom emp_no kita akan menemukan beberapa data yang
sama didalamnya, example '10010' dan '10010'. 
*/
SELECT 
    *
FROM
    dept_emp;

/*
Hal ini disebabkan karena entri baru tentang karyawan
yang sama telah dicatat setiap kali karyawan mengubah departemennya,
sehingga ini menghasilkan lebih dari satu tanggal mulai dan berakhir 
bagi karyawan tersebut. Untuk memverifikasi hal ini kita dapat
menjalankan query yang menunjukkan jumlah karyawan yang terdaftar
di table karyawan lebih dari sekali. 

Setelah menjalankan query dibawah ini maka kita akan tahu berapa 
banyak entri yang kita miliki dengan meanmbahkan kolom [Num]
*/
SELECT 
    dept_no, from_date, to_date, COUNT(emp_no) AS Num
FROM
    dept_emp
GROUP BY dept_no, from_date , to_date
HAVING Num > 1
ORDER BY Num;

-- Example Case
/*
Visualize only the period encompassing the last
contract of each employee
*/

-- Example Data View
SELECT 
    emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
FROM
    dept_emp
GROUP BY emp_no
ORDER BY emp_no;

-- Mmebuat views data pada SQL dari query diatas
CREATE OR REPLACE VIEW v_dept_emp_latest_date AS
	SELECT 
		emp_no,
        MAX(from_date) AS from_date,
        MAX(to_date) AS to_date
	FROM
		dept_emp
	GROUP BY emp_no
	ORDER BY emp_no;

-- Check Data Views yang sudah dibuat
/*
Kita juga dapat melakukan pengecekan pada schema pada pilihan views
dibawah tables untuk mengecek apakah views sudah terbuat atau belum
(jangan lupa refresh schema dulu ya!)
*/
SELECT 
    *
FROM
    employees.v_dept_emp_latest_date;

/*
Mungkin akan timbul beberapa pertanyaan mengapa 
kita harus membuat tampilan vuews seperti diatas, 
bukankah perintah 'SELECT column' saja sudah cukup?

Mungkin penjelasannya seperti ini, dapat kita bayangkan jika kita memiliki
sebuah database yang digunakan oleh aplikasi web yang cukup besar
lalu web ini sedang digunakan / diakses oleh banyak pengguna, jika
kita ingin mengizinkan setiap pengguna melihat table ini alih-alih mengetik
dan menjalankan pernyataan SQL untuk mengekstrak informasi yang diperlukan
setiap kali permintaan dari pennguna muncul.

'Views' dapat memungkinkan setiap pengguna untuk melihat hasil yang ditetapkan
pada ruang pengguna mereka, fungsi views disini sebagai jalan pintas untuk menulis
pernyataan pilihan pengguna yang sama setiap kali permintaan baru telah dibuat,
dengan demikian menghemat banyak waktu untuk menuliskan code query.

Terlebih lagi karena ini ditulis hanya sekali tampilan tidak menempati memori tambahan,
dan akhirnya views bertindak sebagai table dinamis karena langsung mencerminkan data dan
perubahan struktural di table dasar, example:

- Jika sudatu ketika kita melakukan perubahan pada emp_no 10001 pada kolom to_date
yang mana awalnya 9999-01-01 menjadi 2025-01-01 maka secara otomatis pada 'views'
juga data akan berubah.

Namun demikian tolong jangan lupa bahwa itu bukan dataset fisik / asli (nyata)
yang berarti kita tidak dapat memasukkan atau memperbarui informasi yang telah
diekstraksi. 'Views' ini hanya dilihat sebagai table data virtual sementara yang
mengambil informasi dari table dasar.
*/

/*------------------------------------------------------------------------------------*/

-- Exrcise Number 1
/*
Create a view that will extract the average salary of 
all managers registered in the database. 
Round this value to the nearest cent.

If you have worked correctly, after executing 
the view from the “Schemas” section in Workbench, 
you should obtain the value of 66924.27.
*/

-- Rangka Query
SELECT 
    ROUND(AVG(salary), 2) avg_salary
FROM
    salaries s
        JOIN
    dept_manager dm ON s.emp_no = dm.emp_no;

-- Build Views
CREATE OR REPLACE VIEW v_manager_avg_salary AS
    SELECT 
        ROUND(AVG(salary), 2) avg_salary -- Membulatkan ke nominal terdekat dengan 2 angka dibelakang koma
    FROM
        salaries s
            JOIN
        dept_manager dm ON s.emp_no = dm.emp_no;

-- Check Views
SELECT 
    *
FROM
    employees.v_manager_avg_salary;