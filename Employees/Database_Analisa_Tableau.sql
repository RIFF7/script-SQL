USE employees_mod;

-- Analisa Untuk Diterapkan Pada Tableau [Use Database employees_mod]
/*
Pada case saat ini kita akan menggunakan database 'employees_mod'
dimana pada case pertama kita akan mencari 3 kolom dari database:

1. Kolom Tahun
2. Kolom Gender
3. Kolom Nomor Karyawan

Sehingga dari 3 kolom ini kita akan menjadikannya sebuah Bar Chart pada Tableau
yang akan dianalisa untuk mendapatkan insight dari database yang sudah diolah
*/
-- Cara Yang BENAR
/*
Query dibawah ini mengambil data dari dua tabel, t_dept_emp (alias td) 
dan t_employees (alias te), dan menghasilkan ringkasan jumlah karyawan 
berdasarkan tahun kalender dan jenis kelamin. 

Berikut adalah penjelasan langkah-langkahnya:

SELECT Statement:
- YEAR(td.from_date) AS calendar_year: 
Mengekstrak tahun dari kolom from_date dalam tabel t_dept_emp dan memberikan alias calendar_year.

- te.gender AS gender: 
Mengambil kolom gender dari tabel t_employees dan memberikan alias gender.

- COUNT(te.emp_no) AS num_of_employees: 
Menghitung jumlah karyawan dengan menggunakan fungsi COUNT dan memberikan alias num_of_employees.

FROM Clause:
- FROM t_dept_emp td: 
Menggunakan tabel t_dept_emp dengan alias td.

- JOIN t_employees te ON td.emp_no = te.emp_no: 
Melakukan INNER JOIN antara t_dept_emp dan t_employees berdasarkan kolom emp_no.

GROUP BY Clause:
- GROUP BY 1, 2: Mengelompokkan hasil berdasarkan tahun (calendar_year) 
dan jenis kelamin (gender). Angka 1 dan 2 merujuk pada urutan kolom dalam SELECT statement.

HAVING Clause:
- HAVING calendar_year >= 1990: 
Menggunakan HAVING clause untuk menyaring hasil dan hanya mempertahankan 
baris-baris dengan tahun kalender lebih besar atau sama dengan 1990.

*/
SELECT
	YEAR(td.from_date) AS calendar_year,
    te.gender AS gender,
    COUNT(te.emp_no) AS num_of_employees
FROM t_dept_emp td
JOIN t_employees te ON td.emp_no = te.emp_no
GROUP BY 1, 2
HAVING calendar_year >= 1990;

-- Cara Yang SALAH
/*
Query kedua memiliki perbedaan utama pada penggunaan WHERE clause, 
yang memfilter data sebelum hasilnya dikelompokkan, sementara pada query pertama, 
penggunaan HAVING clause terjadi setelah hasil dikelompokkan. 

Berikut adalah perbandingan antara kedua query tersebut:

# Perbedaan utama:
Penggunaan WHERE vs HAVING:
- Pada query pertama, WHERE clause tidak digunakan, dan filter berdasarkan 
tahun kalender dilakukan setelah hasil dikelompokkan menggunakan HAVING clause.

- Pada query kedua, WHERE clause digunakan untuk menyaring data sebelum hasilnya dikelompokkan.

Urutan Eksekusi:
- Pada query pertama, urutan eksekusi adalah FROM, JOIN, GROUP BY, HAVING.
- Pada query kedua, urutan eksekusi adalah FROM, JOIN, WHERE, GROUP BY.

Efek pada Hasil:
- Kedua query akan memberikan hasil yang sama dalam konteks ini, 
karena filter tahun kalender diaplikasikan sebelum atau setelah hasil dikelompokkan.

Pilihan antara menggunakan WHERE atau HAVING tergantung pada kebutuhan 
dan kriteria pemfilteran yang diinginkan. Pada kasus ini, keduanya menghasilkan hasil yang setara.
*/
SELECT
	YEAR(td.from_date) AS calendar_year,
    te.gender AS gender,
    COUNT(te.emp_no) AS num_of_employees
FROM t_dept_emp td
JOIN t_employees te ON td.emp_no = te.emp_no
WHERE td.from_date >= 1990
GROUP BY 1, 2;

/*------------------------------------------------------------------------------------*/