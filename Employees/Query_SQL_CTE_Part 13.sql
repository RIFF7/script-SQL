-- MySQL Common Table Expressions (CTE) - Introduction

-- Mencari AVG Salary tanpa CTE
SELECT
	AVG(salary) AS avg_salary
FROM salaries;

-- Mencari AVG Salary dengan CTE
-- Example 1
/*
Query dibwah menggunakan Common Table Expressions (CTE) atau dikenal sebagai WITH clause. 
CTE adalah subquery yang diberi nama untuk digunakan dalam bagian utama dari query. 
Pada kasus ini, CTE digunakan untuk menghitung rata-rata gaji dari tabel "salaries".

Berikut adalah penjelasan langkah demi langkah dari query dibawah:

WITH Clause (CTE):
Dalam blok ini, CTE bernama "cte" dibuat. Subquery di dalamnya 
menghitung rata-rata gaji (AVG(salary)) dari tabel "salaries".

SELECT Statement:
Setelah CTE didefinisikan, kita menggunakan SELECT statement untuk 
memilih semua kolom dari CTE ("*") dan menampilkan hasilnya.

Jadi, keseluruhan query ini menghitung rata-rata gaji dari tabel "salaries" 
menggunakan CTE dan kemudian menampilkan hasilnya. Penggunaan CTE membantu menjadikan 
query lebih terstruktur dan membaca, terutama ketika Anda perlu melakukan operasi yang 
kompleks atau menggunakan subquery lebih dari satu kali dalam query utama.

*/
WITH cte AS(
	SELECT
		AVG(salary) AS avg_salary
	FROM salaries
)
SELECT
	*
FROM cte;

-- Example 2
/*
Query dibawah menggunakan Common Table Expressions (CTE) dalam kombinasi 
dengan operasi JOIN. 

Mari kita jelaskan langkah-langkahnya:

WITH Clause (CTE):
Dalam blok ini, CTE bernama "cte2" dibuat. Subquery di dalamnya menghitung 
rata-rata gaji (AVG(salary)) dari tabel "salaries".

SELECT Statement:
Setelah CTE didefinisikan, kita menggunakan SELECT statement untuk memilih 
semua kolom dari tabel "salaries" (s.*) dan melakukan JOIN dengan CTE ("cte2 c"). 
Namun, ada beberapa masalah dengan query ini:
- Tidak ada kondisi JOIN yang ditentukan, sehingga query ini akan menghasilkan 
hasil CROSS JOIN, yaitu setiap baris dari "salaries" akan digabungkan dengan setiap baris dari CTE.

- Seharusnya, kita seharusnya menggunakan rata-rata gaji yang dihitung dari CTE 
dalam hasil query, tetapi tidak ada referensi terhadap kolom-kolom CTE dalam SELECT statement.

Jadi, query ini mungkin tidak memberikan hasil yang diinginkan atau menghasilkan 
hasil yang tidak bermakna. Untuk mengoreksi query, kita perlu menambahkan kondisi 
JOIN yang sesuai dan memilih kolom-kolom yang diinginkan dari tabel "salaries" dan CTE. 

Sebagai contoh:
WITH cte2 AS (
    SELECT
        AVG(salary) AS avg_salary
    FROM salaries
)
SELECT
    s.*,
    c.avg_salary
FROM
    salaries s
JOIN cte2 c;

Note: Namun hasilnya sama saja sebenarnya, hanya beda pada penegasan dalam kolomnya yang dipanggil saja

*/
WITH cte2 AS(
	SELECT
		AVG(salary) AS avg_salary
	FROM salaries
)
SELECT *
FROM salaries s 
JOIN cte2 c;

-- Example 3
/*
Query dibawah menggunakan Common Table Expressions (CTE) 
dengan nama "cte3" dan menggabungkannya dengan tabel "salaries" dan 
"employees" menggunakan operasi JOIN. 

Mari kita jelaskan langkah-langkahnya:

WITH Clause (CTE):
Dalam blok ini, CTE bernama "cte3" dibuat. Subquery di dalamnya menghitung 
rata-rata gaji (AVG(salary)) dari tabel "salaries".

SELECT Statement:
Setelah CTE didefinisikan, kita menggunakan SELECT statement untuk memilih 
semua kolom dari tabel "salaries" (s.*), melakukan JOIN dengan tabel "employees" 
menggunakan kondisi s.emp_no = e.emp_no AND e.gender = 'F', dan terakhir melakukan 
JOIN dengan CTE ("cte3 c").

Pertama, JOIN dengan "employees":
- Menggabungkan baris-baris dari tabel "salaries" dan "employees" berdasarkan 
kondisi bahwa nomor karyawan (emp_no) harus cocok dan gender harus 'F' (wanita).

Kemudian, JOIN dengan CTE ("cte3"):
- Menggabungkan hasil sebelumnya dengan CTE "cte3". Harap diperhatikan bahwa dalam CTE, 
kita menghitung rata-rata gaji untuk seluruh tabel "salaries", tetapi kita menggabungkannya 
dengan baris-baris dari JOIN yang hanya melibatkan karyawan perempuan ("e.gender = 'F'").

Kondisi JOIN dalam SELECT statement:
- JOIN dengan "employees" menggunakan kondisi s.emp_no = e.emp_no AND e.gender = 'F' 
memastikan bahwa hanya karyawan perempuan yang dipertimbangkan dalam hasil query.

Klausa SELECT:
- Memilih semua kolom dari tabel "salaries", tabel "employees", dan nilai rata-rata gaji dari CTE.

Jadi, hasil query ini akan mencakup informasi gaji untuk karyawan perempuan 
dan nilai rata-rata gaji dari seluruh tabel "salaries".

*/
WITH cte3 AS(
	SELECT
		AVG(salary) AS avg_salary
	FROM salaries
)
SELECT *
FROM salaries s
JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'F'
JOIN cte3 c;

-- Example 4
/*
Query dibawah menggunakan Common Table Expressions (CTE) dengan nama "cte4" 
dan melakukan CROSS JOIN antara tabel "salaries" dan "employees" dengan CTE. 

Mari kita jelaskan langkah-langkahnya:

WITH Clause (CTE):
- Dalam blok ini, CTE bernama "cte4" dibuat. Subquery di dalamnya menghitung 
rata-rata gaji (AVG(salary)) dari tabel "salaries".

SELECT Statement:
Setelah CTE didefinisikan, kita menggunakan SELECT statement untuk memilih 
semua kolom dari tabel "salaries" (s.*), melakukan JOIN dengan tabel "employees" 
menggunakan kondisi s.emp_no = e.emp_no AND e.gender = 'F', 
dan melakukan CROSS JOIN dengan CTE ("cte4 c").

Pertama, JOIN dengan "employees":
- Menggabungkan baris-baris dari tabel "salaries" dan "employees" berdasarkan 
kondisi bahwa nomor karyawan (emp_no) harus cocok dan gender harus 'F' (wanita).

Kemudian, CROSS JOIN dengan CTE ("cte4"):
- CROSS JOIN adalah operasi gabungan yang menghasilkan hasil gabungan dari 
setiap baris dari tabel pertama dengan setiap baris dari tabel kedua, 
tanpa memerlukan kondisi. Dalam hal ini, kita melakukan CROSS JOIN antara 
hasil JOIN sebelumnya dan CTE "cte4".

Kondisi JOIN dalam SELECT statement:
- JOIN dengan "employees" menggunakan kondisi s.emp_no = e.emp_no AND e.gender = 'F' 
memastikan bahwa hanya karyawan perempuan yang dipertimbangkan dalam hasil query.

Klausa SELECT:
- Memilih semua kolom dari tabel "salaries", tabel "employees", dan nilai rata-rata gaji dari CTE.

Jadi, hasil query ini akan mencakup informasi gaji untuk karyawan perempuan dan 
nilai rata-rata gaji dari seluruh tabel "salaries", dengan setiap baris dari hasil JOIN 
dikombinasikan dengan setiap baris dari hasil CROSS JOIN.

*/
WITH cte4 AS(
	SELECT
		AVG(salary) AS avg_salary
	FROM salaries
)
SELECT * 
FROM salaries s
JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'F'
CROSS JOIN cte4 c;

-- Example 5
/*
Query dibwah ini menggunakan Common Table Expressions (CTE) dengan nama "cte5" 
dan menggabungkannya dengan tabel "salaries" dan "employees" menggunakan operasi CROSS JOIN. 

Mari kita jelaskan langkah-langkahnya:

WITH Clause (CTE):
Dalam blok ini, CTE bernama "cte4" dibuat. Subquery di dalamnya menghitung 
rata-rata gaji (AVG(salary)) dari tabel "salaries".

SELECT Statement:
Setelah CTE didefinisikan, kita menggunakan SELECT statement untuk melakukan 
beberapa perhitungan terkait gaji untuk karyawan perempuan:

JOIN dengan "employees":
- Menggabungkan baris-baris dari tabel "salaries" dan "employees" berdasarkan 
kondisi bahwa nomor karyawan (emp_no) harus cocok dan gender harus 'F' (wanita).

CROSS JOIN dengan CTE ("cte5"):
- CROSS JOIN adalah operasi gabungan yang menghasilkan hasil gabungan dari 
setiap baris dari tabel pertama dengan setiap baris dari tabel kedua, 
tanpa memerlukan kondisi. Dalam hal ini, kita melakukan CROSS JOIN antara hasil 
JOIN sebelumnya dan CTE "cte5".

Penggunaan CASE statement:
- Menggunakan CASE statement untuk mengevaluasi setiap gaji dalam tabel "salaries" 
terhadap rata-rata gaji yang dihitung dari CTE. Jika gaji lebih besar dari rata-rata, 
maka nilainya dihitung sebagai 1, dan jika tidak, nilainya dihitung sebagai 0. 
SUM() kemudian digunakan untuk menghitung jumlah karyawan perempuan yang memiliki gaji di atas rata-rata.

Penggunaan COUNT():
- Menggunakan COUNT() untuk menghitung total jumlah kontrak gaji untuk karyawan perempuan.

Hasil Output:
Query ini menghasilkan dua kolom dalam output: "no_f_salaries_above_avg" 
yang berisi jumlah karyawan perempuan dengan gaji di atas rata-rata, 
dan "total_no_of_salary_contracts" yang berisi total jumlah kontrak gaji untuk karyawan perempuan.

Jadi, hasil query ini memberikan informasi tentang distribusi gaji karyawan 
perempuan dan seberapa banyak dari mereka memiliki gaji di atas rata-rata.

*/
WITH cte5 AS(
	SELECT
		AVG(salary) AS avg_salary
	FROM salaries
)
SELECT
	SUM(
		CASE
			WHEN s.salary > c.avg_salary THEN 1
            ELSE 0
		END
    ) AS no_f_salaries_above_avg,
    COUNT(s.salary) AS total_no_of_salary_contracts
FROM salaries s
JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'F'
CROSS JOIN cte5 c;

-- Example 5.1 with Subquery
/*
Query dibawah ini melakukan penghitungan terkait gaji untuk karyawan 
perempuan dari tabel "salaries". 

Mari kita jelaskan langkah-langkahnya:

CROSS JOIN dengan Subquery:
Query ini membuat subquery yang menghitung rata-rata gaji (AVG(salary)) 
dari tabel "salaries" dan memberikan alias "a". Kemudian, hasilnya di-CROSS JOIN 
dengan tabel "salaries". CROSS JOIN ini akan menghasilkan setiap baris dari 
tabel "salaries" dikombinasikan dengan satu baris dari subquery 
(karena subquery hanya menghasilkan satu baris).

SELECT Statement:
Setelah CROSS JOIN, kita menggunakan SELECT statement untuk melakukan 
beberapa perhitungan terkait gaji untuk karyawan perempuan:

JOIN dengan "employees":
- Menggabungkan baris-baris dari tabel "salaries" dan "employees" 
berdasarkan kondisi bahwa nomor karyawan (emp_no) harus cocok dan gender harus 'F' (wanita).

Penggunaan CASE statement:
- Menggunakan CASE statement untuk mengevaluasi setiap gaji dalam 
tabel "salaries" terhadap rata-rata gaji yang dihitung dari subquery. 
Jika gaji lebih besar dari rata-rata, maka nilainya dihitung sebagai 1, 
dan jika tidak, nilainya dihitung sebagai 0. SUM() kemudian digunakan 
untuk menghitung jumlah karyawan perempuan yang memiliki gaji di atas rata-rata.

Penggunaan COUNT():
- Menggunakan COUNT() untuk menghitung total jumlah kontrak gaji untuk karyawan perempuan.

Hasil Output:
- Query ini menghasilkan dua kolom dalam output: "no_f_salaries_above_avg" 
yang berisi jumlah karyawan perempuan dengan gaji di atas rata-rata, 
dan "total_no_of_salary_contracts" yang berisi total jumlah kontrak gaji untuk karyawan perempuan.

Jadi, hasil query ini memberikan informasi tentang distribusi gaji 
karyawan perempuan dan seberapa banyak dari mereka memiliki gaji di 
atas rata-rata. Perlu diperhatikan bahwa perhitungan rata-rata gaji 
hanya dihitung sekali menggunakan subquery dan digunakan dalam perbandingan 
terhadap setiap gaji dalam tabel "salaries".

*/
SELECT
	SUM(
		CASE
			WHEN s.salary > a.avg_salary THEN 1
            ELSE 0
		END
    ) AS no_f_salaries_above_avg,
    COUNT(s.salary) AS total_no_of_salary_contracts
FROM salaries s
JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'F'
CROSS JOIN (
	SELECT
		AVG(salary) AS avg_salary
	FROM salaries
) AS a;

/*
Example 5 dan Example 5.1 memiliki tujuan yang sama, 
yaitu menghitung jumlah karyawan perempuan yang memiliki 
gaji di atas rata-rata gaji. Namun, terdapat perbedaan utama 
dalam cara penggunaan Common Table Expressions (CTE) dan alias untuk subquery.

Berikut adalah ringkasan perbedaannya:

Example 5:
- Mendefinisikan CTE bernama "cte5" untuk menghitung rata-rata gaji dari tabel "salaries".
- Pada query utama, menggunakan CTE secara langsung dalam CROSS JOIN dengan tabel "salaries".
- Menggunakan alias "c" untuk merujuk pada CTE dalam pernyataan CASE dan klausa SELECT.

Example 5.1:
- Membuat subquery (bukan CTE) dengan alias "a" untuk menghitung rata-rata gaji dari tabel "salaries".
- Pada query utama, melakukan CROSS JOIN dengan subquery "a" dan tabel "salaries".
- Menggunakan alias "a" untuk merujuk pada subquery dalam pernyataan CASE dan klausa SELECT.

Perbedaan Utama:

CTE vs. Subquery:
- Example 1 menggunakan CTE untuk menghitung rata-rata gaji, 
sementara Example 2 menggunakan subquery dengan alias.

- CTE didefinisikan dengan menggunakan klausa WITH dan dapat dirujuk beberapa kali dalam query.

- Subquery diapit dalam tanda kurung dan hanya dapat dirujuk dalam 
query di mana subquery tersebut didefinisikan.

Penggunaan Alias:
- Pada Example 1, CTE dirujuk menggunakan alias "c" sepanjang query.
- Pada Example 2, subquery dirujuk menggunakan alias "a" sepanjang query.

Struktur Query:
- Meskipun ada perbedaan dalam cara menghitung rata-rata gaji, 
kedua query tersebut melakukan perhitungan serupa untuk jumlah 
karyawan perempuan dengan gaji di atas rata-rata.

Secara keseluruhan, perbedaan utamanya terletak pada penggunaan CTE 
dalam Example 1 dan subquery dengan alias dalam Example 2. 
Kedua pendekatan tersebut mencapai hasil yang sama, 
dan pilihan antara keduanya tergantung pada faktor seperti keterbacaan dan kegunaan query.

*/

-- Example 6
/*
Query dibawah ini memiliki tujuan yang mirip dengan query sebelumnya, 
yaitu menghitung statistik terkait gaji untuk karyawan perempuan. 

Mari kita jelaskan langkah-langkahnya:

WITH Clause (CTE):
Dalam blok ini, CTE bernama "cte6" dibuat untuk menghitung rata-rata gaji dari tabel "salaries".

SELECT Statement:
JOIN dengan "employees":
- Menggabungkan baris-baris dari tabel "salaries" dan "employees" 
berdasarkan kondisi bahwa nomor karyawan (emp_no) harus cocok dan gender harus 'F' (wanita).

CROSS JOIN dengan CTE ("cte6"):
- CROSS JOIN antara hasil JOIN sebelumnya dan CTE "cte6".

Penggunaan CASE statement:
# Menggunakan CASE statement dalam dua penghitungan terpisah:
- Pertama, dalam SUM(), menghitung jumlah karyawan perempuan yang memiliki gaji di atas rata-rata.

- Kedua, dalam COUNT(), menghitung jumlah gaji karyawan perempuan yang di atas rata-rata, 
dan menggunakan NULL untuk gaji yang di bawah atau sama dengan rata-rata.

Hasil Output:
# Query ini menghasilkan tiga kolom dalam output:
- "no_f_salaries_above_avg_w_sum" yang berisi jumlah karyawan perempuan 
dengan gaji di atas rata-rata (menggunakan SUM()).

- "no_f_salaries_above_avg_w_count" yang berisi jumlah gaji karyawan perempuan 
yang di atas rata-rata (menggunakan COUNT()).

- "total_no_of_salary_contracts" yang berisi total jumlah kontrak gaji untuk karyawan perempuan.

*/
WITH cte6 AS(
	SELECT
		AVG(salary) AS avg_salary
	FROM salaries
)
SELECT
	SUM(
		CASE
			WHEN s.salary > c.avg_salary THEN 1
            ELSE 0
		END
    ) AS no_f_salaries_above_avg_w_sum,
    COUNT(
		CASE
			WHEN s.salary > c.avg_salary THEN s.salary
            ELSE NULL
		END
    ) AS no_f_salaries_above_avg_w_count,
    COUNT(s.salary) AS total_no_of_salary_contracts
FROM salaries s
JOIN employees e ON e.emp_no = s.emp_no AND e.gender = 'F'
CROSS JOIN cte6 c;

-- Exercise Number 1
/*
Use a CTE (a Common Table Expression) and a SUM() function in the 
SELECT statement in a query to find out how many male employees have 
never signed a contract with a salary value higher than or equal 
to the all-time company salary average.
*/


-- Exercise Number 2
/*
Use a CTE (a Common Table Expression) and (at least one) COUNT() function 
in the SELECT statement of a query to find out how many male employees have 
never signed a contract with a salary value higher than or equal 
to the all-time company salary average.
*/

-- Exercise Number 3
/*
Use MySQL joins (and don’t use a Common Table Expression) in a query to find out 
how many male employees have never signed a contract with a salary value higher 
than or equal to the all-time company salary average (i.e. to obtain the same 
result as in the previous exercise).
*/

-- Exercise Number 4
/*
Use a cross join in a query to find out how many male employees have never signed 
a contract with a salary value higher than or equal to the all-time company salary 
average (i.e. to obtain the same result as in the previous exercise).
*/

/*------------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------------*/