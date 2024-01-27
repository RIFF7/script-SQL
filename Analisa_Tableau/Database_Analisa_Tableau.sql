USE employees_mod;

-- Analisa Untuk Diterapkan Pada Tableau [Use Database employees_mod]
/*
Case 1:
Create a visualization that provides a breakdown between the male 
and female employees working in the company each year, starting from 1990. 

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

/*
Case 2:
Compare the number of male managers to the number of female managers 
from different departments for each year, starting from 1990.
*/
-- Query Awal
/*
Disini kita akan melakukan analisa dari hasil output yang dikeluarkan
dan mengambil beberapa kolom saja untuk dilakukan analisan lebih lanjut
*/
SELECT
	*
FROM(
	SELECT
		YEAR(hire_date) AS calendar_year
	FROM t_employees
    GROUP BY calendar_year
) AS e
CROSS JOIN t_dept_manager tdm
JOIN t_departments td ON tdm.dept_no = td.dept_no
JOIN t_employees te ON tdm.emp_no = te.emp_no;

-- Query Akhir
/*
Hasil query dibawah ini adalah hasil dari beberapa kolom
yang sudah dipilih dan menambahkan kolom kondisi menggunakan CASE WHEN
*/
SELECT
	td.dept_name,
    te.gender,
    tdm.emp_no,
    tdm.from_date,
    tdm.to_date,
    e.calendar_year,
    CASE
		WHEN YEAR(tdm.to_date) >= e.calendar_year AND YEAR(tdm.from_date) <= e.calendar_year THEN 1
        ELSE 0
	END AS active_emp
FROM(
	SELECT
		YEAR(hire_date) AS calendar_year
	FROM t_employees
    GROUP BY calendar_year
) AS e
CROSS JOIN t_dept_manager tdm
JOIN t_departments td ON tdm.dept_no = td.dept_no
JOIN t_employees te ON tdm.emp_no = te.emp_no
ORDER BY 3, 6;

/*
Query diatas digunakan untuk menampilkan informasi tentang manajer departemen, 
termasuk tahun kalendar di mana manajer tersebut aktif. 

Mari kita bahas langkah-langkahnya:

Subquery (e):
- Subquery ini menghasilkan daftar tahun kalendar di mana karyawan direkrut. 
Subquery ini memberikan basis untuk CROSS JOIN dengan data manajer departemen.

CROSS JOIN dengan t_dept_manager (tdm):
- Menggabungkan setiap baris hasil dari subquery dengan setiap baris 
dalam tabel t_dept_manager menggunakan CROSS JOIN. 
Ini menciptakan kombinasi setiap tahun kalendar dengan setiap manajer departemen.

JOIN dengan t_departments (td) dan t_employees (te):
- Menggabungkan hasil dari CROSS JOIN dengan informasi 
tambahan dari tabel t_departments dan t_employees.

SELECT Statement:
- Memilih kolom-kolom yang ingin ditampilkan. Tambahan dari subquery memberikan informasi 
tentang tahun kalendar di mana manajer aktif.

ORDER BY:
- Mengurutkan hasil berdasarkan kolom ke-3 (emp_no) dan ke-6 (calendar_year).

Hasilnya adalah daftar manajer departemen dengan informasi tahun kalendar 
di mana mereka aktif. Kolom "active_emp" menunjukkan apakah manajer tersebut 
aktif pada tahun kalendar tertentu (1 untuk aktif, 0 untuk tidak aktif).

*/

/*------------------------------------------------------------------------------------*/

/*
Case 3:
Compare the average salary of female versus male employees in
the entire company until year 2002, and add a filter allowing
you to see that per each department. 
*/
SELECT
	te.gender,
    td.dept_name,
    ROUND(AVG(ts.salary), 2) AS salary,
    YEAR(ts.from_date) AS calendar_year
FROM t_employees te
JOIN t_salaries ts ON te.emp_no = ts.emp_no
JOIN t_dept_emp tde ON ts.emp_no = tde.emp_no
JOIN t_departments td ON tde.dept_no = td.dept_no
GROUP BY td.dept_no, te.gender, calendar_year
HAVING calendar_year <= 2002
ORDER BY td.dept_no;

/*
Query ini digunakan untuk menghasilkan informasi tentang rata-rata 
gaji per departemen, gender, dan tahun kalendar, dengan batasan bahwa hanya 
tahun kalendar hingga 2002 yang dipertimbangkan. 

Mari kita bahas langkah-langkahnya:

SELECT Statement:
- Memilih kolom-kolom yang ingin ditampilkan. AVG(ts.salary) menghitung 
rata-rata gaji, dan ROUND(...) menghasilkan rata-rata gaji dengan dua digit desimal. 
YEAR(ts.from_date) mengambil tahun dari tanggal mulai kontrak.

FROM Clause:
- Menggabungkan tabel t_employees, t_salaries, t_dept_emp, dan 
t_departments berdasarkan kunci-kunci yang sesuai.

GROUP BY Clause:
- Mengelompokkan hasil berdasarkan departemen (dept_no), gender (gender), 
dan tahun kalendar (calendar_year).

HAVING Clause:
- Memfilter hasil hanya untuk tahun kalendar yang kurang atau sama dengan 2002.

ORDER BY Clause:
- Mengurutkan hasil berdasarkan nomor departemen (dept_no).

Hasilnya adalah daftar rata-rata gaji per departemen, gender, 
dan tahun kalendar, dengan batasan hanya tahun kalendar hingga 2002.

*/

/*------------------------------------------------------------------------------------*/