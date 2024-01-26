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
WITH rerata AS(
	SELECT
		AVG(salary) AS avg_salary
	FROM salaries
)
SELECT
	SUM(
		/*
        Penggunaan CASE statement:
        - Menggunakan CASE statement dalam SUM() untuk menghitung 
        jumlah karyawan laki-laki yang memiliki gaji di bawah rata-rata. 
        Jika gaji kurang dari rata-rata, nilai yang dihitung adalah 1, 
        dan jika tidak, nilai yang dihitung adalah 0.
        */
		CASE
			WHEN s.salary < r.avg_salary THEN 1
            ELSE 0
		END
    ) AS no_salaries_below_avg,
    COUNT(s.salary) AS no_of_salary_contracts
FROM salaries s
JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'M'
JOIN rerata r;

-- Exercise Number 2
/*
Use a CTE (a Common Table Expression) and (at least one) COUNT() function 
in the SELECT statement of a query to find out how many male employees have 
never signed a contract with a salary value higher than or equal 
to the all-time company salary average.
*/
WITH rerata2 AS(
	SELECT
		AVG(salary) AS avg_salary
	FROM salaries
)
SELECT
	COUNT(
		/*
        Penggunaan CASE statement:
		- Menggunakan CASE statement dalam COUNT() untuk menghitung jumlah 
        gaji karyawan laki-laki yang berada di bawah rata-rata. Jika gaji 
        kurang dari rata-rata, nilai yang dihitung adalah gaji tersebut; 
        jika tidak, nilai yang dihitung adalah NULL.
        */
		CASE
			WHEN s.salary < r.avg_salary THEN s.salary
            ELSE NULL
		END
    ) AS no_salaries_below_avg_w_count,
    COUNT(s.salary) AS no_of_salary_contracts
FROM salaries s
JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'M'
JOIN rerata2 r;

-- Exercise Number 3
/*
Use MySQL joins (and don’t use a Common Table Expression) in a query to find out 
how many male employees have never signed a contract with a salary value higher 
than or equal to the all-time company salary average (i.e. to obtain the same 
result as in the previous exercise).
*/
SELECT
	COUNT(
		/*
        Penggunaan CASE statement:
		- Menggunakan CASE statement dalam COUNT() untuk menghitung jumlah 
        gaji karyawan laki-laki yang berada di bawah rata-rata. Jika gaji 
        kurang dari rata-rata, nilai yang dihitung adalah gaji tersebut; 
        jika tidak, nilai yang dihitung adalah NULL.
        */
		CASE
			WHEN s.salary < a.avg_salary THEN s.salary
            ELSE NULL
		END
    ) AS no_salaries_below_avg_w_count,
    COUNT(s.salary) AS no_of_salary_contracts
FROM salaries s
JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'M'
JOIN (
	SELECT
		AVG(salary) AS avg_salary
	FROM salaries
) AS a;

-- Exercise Number 4
/*
Use a cross join in a query to find out how many male employees have never signed 
a contract with a salary value higher than or equal to the all-time company salary 
average (i.e. to obtain the same result as in the previous exercise).
*/
WITH rerata3 AS(
	SELECT
		AVG(salary) AS avg_salary
	FROM salaries
)
SELECT
	SUM(
		/*
        Penggunaan CASE statement:
        - Menggunakan CASE statement dalam SUM() untuk menghitung 
        jumlah karyawan laki-laki yang memiliki gaji di bawah rata-rata. 
        Jika gaji kurang dari rata-rata, nilai yang dihitung adalah 1, 
        dan jika tidak, nilai yang dihitung adalah 0.
        */
		CASE
			WHEN s.salary < r.avg_salary THEN 1
            ELSE 0
		END
    ) AS no_salaries_below_avg_w_sum,
	COUNT(
		/*
        Penggunaan CASE statement:
		- Menggunakan CASE statement dalam COUNT() untuk menghitung jumlah 
        gaji karyawan laki-laki yang berada di bawah rata-rata. Jika gaji 
        kurang dari rata-rata, nilai yang dihitung adalah gaji tersebut; 
        jika tidak, nilai yang dihitung adalah NULL.
        */
		CASE
			WHEN s.salary < r.avg_salary THEN s.salary
            ELSE NULL
		END
    ) AS no_salaries_below_avg_w_count,
    COUNT(s.salary) AS no_of_salary_contracts
FROM salaries s
JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'M'
CROSS JOIN rerata3 r;

/*------------------------------------------------------------------------------------*/

-- Pembahasan Using Multiple Subclauses in a WITH Clause
-- Mencari Nilai MAX() salary tanpa CTE
-- Example 1 [Menggunakan JOIN]
SELECT
	s.emp_no,
    MAX(s.salary) AS highest_salary
FROM salaries s
JOIN employees e ON e.emp_no = s.emp_no AND e.gender = 'F'
GROUP BY 1;

-- Example 2 [Menggunakan WHERE clause]
SELECT
	s.emp_no,
    MAX(s.salary) AS highest_salary
FROM salaries s
JOIN employees e ON e.emp_no = s.emp_no 
WHERE e.gender = 'F'
GROUP BY 1;

-- Contoh penggunaan 2 CTE
-- Example 1
WITH cte1 AS(
	SELECT
		AVG(salary) AS avg_salary
	FROM salaries
),
cte2 AS(
	SELECT
		s.emp_no,
        MAX(s.salary) AS f_highest_salary
	FROM salaries s
    JOIN employees e ON e.emp_no = s.emp_no
		AND e.gender = 'F'
	GROUP BY 1
)
SELECT
	SUM(
		CASE
			WHEN c2.f_highest_salary > c1.avg_salary THEN 1
            ELSE 0
		END
    ) AS f_highest_salaries_above_avg,
    COUNT(e.emp_no) AS total_no_female_contracts
FROM employees e
JOIN cte2 c2 ON e.emp_no = c2.emp_no
CROSS JOIN cte1 c1;

-- Example 2
WITH cte3 AS(
	SELECT
		AVG(salary) AS avg_salary
	FROM salaries
),
cte4 AS(
	SELECT
		s.emp_no,
        MAX(s.salary) AS f_highest_salary
	FROM salaries s
    JOIN employees e ON e.emp_no = s.emp_no
		AND e.gender = 'F'
	GROUP BY 1
)
SELECT
	COUNT(
		CASE
			WHEN c4.f_highest_salary > c3.avg_salary THEN c4.f_highest_salary
            ELSE NULL
		END
    ) AS f_highest_salary_above_avg,
    COUNT(e.emp_no) AS total_no_female_contracts
FROM employees e
JOIN cte4 c4 ON e.emp_no = c4.emp_no
CROSS JOIN cte3 c3;

-- Example 3
WITH cte5 AS(
	SELECT
		AVG(salary) AS avg_salary
	FROM salaries
),
cte6 AS(
	SELECT
		s.emp_no,
        MAX(s.salary) AS f_highest_salary
	FROM salaries s
    JOIN employees e ON e.emp_no = s.emp_no
		AND e.gender = 'F'
	GROUP BY 1
)
SELECT
	SUM(
		CASE
			WHEN c6.f_highest_salary > c5.avg_salary THEN 1
            ELSE 0
		END
    ) AS f_highest_salaries_above_avg,
    COUNT(e.emp_no) AS total_no_female_contracts,
    ROUND((
		SUM(
			CASE
				WHEN c6.f_highest_salary > c5.avg_salary THEN 1
                ELSE 0
			END
        ) / COUNT(e.emp_no)
    ) * 100, 2) AS round_percent
FROM employees e
JOIN cte6 c6 ON e.emp_no = c6.emp_no
CROSS JOIN cte5 c5;

-- Example 4 [Menggunakan CONCAT(ROUND(expression))]
WITH cte5 AS(
	SELECT
		AVG(salary) AS avg_salary
	FROM salaries
),
cte6 AS(
	SELECT
		s.emp_no,
        MAX(s.salary) AS f_highest_salary
	FROM salaries s
    JOIN employees e ON e.emp_no = s.emp_no
		AND e.gender = 'F'
	GROUP BY 1
)
SELECT
	SUM(
		CASE
			WHEN c6.f_highest_salary > c5.avg_salary THEN 1
            ELSE 0
		END
    ) AS f_highest_salaries_above_avg,
    COUNT(e.emp_no) AS total_no_female_contracts,
    CONCAT(ROUND((
		SUM(
			CASE
				WHEN c6.f_highest_salary > c5.avg_salary THEN 1
                ELSE 0
			END
        ) / COUNT(e.emp_no)
    ) * 100, 2), '%') AS '% Percentage'
FROM employees e
JOIN cte6 c6 ON e.emp_no = c6.emp_no
CROSS JOIN cte5 c5;

-- Penulisan Variable Query CTE yang lebih baik dari beberapa example sebelumnya
/*
Query dibawah ini bertujuan untuk menghitung statistik terkait dengan 
gaji tertinggi di antara karyawan perempuan dibandingkan dengan rata-rata 
gaji semua karyawan. 

Mari kita jelaskan langkah-langkahnya:

WITH Clause (CTE):
- cte_avg_salary: Menghitung rata-rata gaji dari tabel "salaries".
- cte_f_highest_salary: Menghitung gaji tertinggi untuk setiap karyawan perempuan dari tabel "salaries".

SELECT Statement:
JOIN dan CROSS JOIN:
- Menggabungkan hasil dari dua CTE ("cte_f_highest_salary" dan "cte_avg_salary") 
dengan tabel "employees". Penggabungan ini melibatkan CROSS JOIN antara 
"cte_f_highest_salary" dan "cte_avg_salary" karena tidak ada kondisi penggabungan yang diberikan.

Penggunaan CASE statement:
- Dua kali menggunakan CASE statement dalam SUM() untuk menghitung 
jumlah karyawan perempuan yang memiliki gaji tertinggi di atas rata-rata 
dan menghitung total jumlah kontrak karyawan perempuan.

Perhitungan Persentase:
- Menggunakan CONCAT() dan ROUND() untuk menghasilkan persentase dari karyawan 
perempuan yang memiliki gaji tertinggi di atas rata-rata.

Hasil Output:
# Query ini menghasilkan tiga kolom:
- "f_highest_salaries_above_avg" yang berisi jumlah karyawan perempuan 
yang memiliki gaji tertinggi di atas rata-rata.

- "total_no_female_contracts" yang berisi total jumlah kontrak karyawan perempuan.

- "% Percentage" yang berisi persentase dari karyawan perempuan yang 
memiliki gaji tertinggi di atas rata-rata.

*/
WITH cte_avg_salary AS(
	SELECT
		AVG(salary) AS avg_salary
	FROM salaries
),
cte_f_highest_salary AS(
	SELECT
		s.emp_no,
        MAX(s.salary) AS f_highest_salary
	FROM salaries s
    JOIN employees e ON e.emp_no = s.emp_no
		AND e.gender = 'F'
	GROUP BY 1
)
SELECT
	SUM(
		CASE
			WHEN c2.f_highest_salary > c1.avg_salary THEN 1
            ELSE 0
		END
    ) AS f_highest_salaries_above_avg,
    COUNT(e.emp_no) AS total_no_female_contracts,
    CONCAT(ROUND((
		SUM(
			CASE
				WHEN c2.f_highest_salary > c1.avg_salary THEN 1
                ELSE 0
			END
        ) / COUNT(e.emp_no)
    ) * 100, 2), '%') AS '% Percentage'
FROM employees e
JOIN cte_f_highest_salary c2 ON e.emp_no = c2.emp_no
CROSS JOIN cte_avg_salary c1;

-- Exercise Number 1
/*
Use two common table expressions and a SUM() function in the SELECT statement 
of a query to obtain the number of male employees whose highest salaries 
have been below the all-time average.
*/
/*

Query dibawah ini bertujuan untuk menghitung statistik terkait dengan 
gaji tertinggi di antara karyawan laki-laki yang berada di bawah rata-rata gaji semua karyawan. 

Mari kita jelaskan langkah-langkahnya:

WITH Clause (CTE):
- cte_avg_salary: Menghitung rata-rata gaji dari tabel "salaries".

- cte_m_highest_salary: Menghitung gaji tertinggi untuk setiap 
karyawan laki-laki dari tabel "salaries".

SELECT Statement:
JOIN dengan CTE dan Tabel:
- Menggabungkan hasil dari dua CTE ("cte_m_highest_salary" dan "cte_avg_salary") 
dengan tabel "employees". Penggabungan ini melibatkan JOIN antara "cte_m_highest_salary" 
dan "cte_avg_salary" dengan "employees".

Penggunaan CASE statement:
- Menggunakan CASE statement dalam SUM() untuk menghitung jumlah karyawan laki-laki 
yang memiliki gaji tertinggi di bawah rata-rata.

Hasil Output:
- Query ini menghasilkan satu kolom, yaitu "m_highest_salary_below_avg", 
yang berisi jumlah karyawan laki-laki yang memiliki gaji tertinggi di bawah rata-rata.

*/
WITH cte_avg_salary AS(
	SELECT
		AVG(salary) AS avg_salary
	FROM salaries
),
cte_m_highest_salary AS(
	SELECT
		s.emp_no,
        MAX(s.salary) AS m_highest_salary
	FROM salaries s
    JOIN employees e ON s.emp_no = e.emp_no
		AND e.gender = 'M'
	GROUP BY 1
)
SELECT
	SUM(
		CASE
			WHEN c2.m_highest_salary < c1.avg_salary THEN 1
            ELSE 0
		END
    ) AS m_highest_salary_below_avg
FROM employees e
JOIN cte_m_highest_salary c2 ON e.emp_no = c2.emp_no
JOIN cte_avg_salary c1;

-- Exercise Number 2
/*
Use two common table expressions and a COUNT() function in the SELECT statement 
of a query to obtain the number of male employees whose highest salaries 
have been below the all-time average.
*/
/*
Query dibawah ini bertujuan untuk menghitung jumlah gaji tertinggi 
di antara karyawan laki-laki yang berada di bawah rata-rata gaji semua karyawan. 

Mari kita jelaskan langkah-langkahnya:

WITH Clause (CTE):
- cte_avg_salary: Menghitung rata-rata gaji dari tabel "salaries".

- cte_m_highest_salary: Menghitung gaji tertinggi untuk setiap 
karyawan laki-laki dari tabel "salaries".

SELECT Statement:
JOIN dengan CTE dan Tabel:
- Menggabungkan hasil dari dua CTE ("cte_m_highest_salary" dan "cte_avg_salary") 
dengan tabel "employees". Penggabungan ini melibatkan JOIN antara "cte_m_highest_salary" 
dan "cte_avg_salary" dengan "employees".

Penggunaan CASE statement:
- Menggunakan CASE statement dalam COUNT() untuk menghitung jumlah gaji tertinggi 
di antara karyawan laki-laki yang berada di bawah rata-rata. 
Jika gaji tertinggi lebih kecil dari rata-rata, nilai yang dihitung adalah 
gaji tertinggi tersebut; jika tidak, nilai yang dihitung adalah NULL.

Hasil Output:
- Query ini menghasilkan satu kolom, yaitu "max_salary", yang berisi jumlah 
gaji tertinggi di antara karyawan laki-laki yang berada di bawah rata-rata.

*/
WITH cte_avg_salary AS(
	SELECT
		AVG(salary) AS avg_salary
	FROM salaries
),
cte_m_highest_salary AS(
	SELECT
		s.emp_no,
        MAX(s.salary) AS m_highest_salary
	FROM salaries s
    JOIN employees e ON s.emp_no = e.emp_no
		AND e.gender = 'M'
	GROUP BY 1
)
SELECT
	COUNT(
		CASE
			WHEN c2.m_highest_salary < c1.avg_salary THEN c2.m_highest_salary
            ELSE NULL
		END
    ) AS max_salary
FROM employees e
JOIN cte_m_highest_salary c2 ON e.emp_no = c2.emp_no
JOIN cte_avg_salary c1;

-- Exercise Number 3
/*
Does the result from the previous exercise change if you used 
the Common Table Expression (CTE) for the male employees' 
highest salaries in a FROM clause, as opposed to in a join?
*/
/*
Query dibawah ini juga memiliki tujuan yang serupa dengan query sebelumnya, 
yaitu menghitung jumlah gaji tertinggi di antara karyawan 
laki-laki yang berada di bawah rata-rata gaji semua karyawan. 

Mari kita jelaskan langkah-langkahnya:

WITH Clause (CTE):
- cte_avg_salary: Menghitung rata-rata gaji dari tabel "salaries".

- cte_m_highest_salary: Menghitung gaji tertinggi untuk 
setiap karyawan laki-laki dari tabel "salaries".

SELECT Statement:
JOIN dengan CTE:
- Menggabungkan hasil dari dua CTE ("cte_m_highest_salary" dan "cte_avg_salary"). 
Penggabungan ini melibatkan JOIN antara "cte_m_highest_salary" dan "cte_avg_salary".

Penggunaan CASE statement:
- Menggunakan CASE statement dalam COUNT() untuk menghitung jumlah gaji tertinggi 
di antara karyawan laki-laki yang berada di bawah rata-rata. 
Jika gaji tertinggi lebih kecil dari rata-rata, nilai yang dihitung adalah 
gaji tertinggi tersebut; jika tidak, nilai yang dihitung adalah NULL.

Hasil Output:
- Query ini menghasilkan satu kolom, yaitu "max_salary", yang berisi jumlah gaji tertinggi 
di antara karyawan laki-laki yang berada di bawah rata-rata.

*/
WITH cte_avg_salary AS(
	SELECT
		AVG(salary) AS avg_salary
	FROM salaries
),
cte_m_highest_salary AS(
	SELECT
		s.emp_no,
        MAX(s.salary) AS m_highest_salary
	FROM salaries s
    JOIN employees e ON s.emp_no = e.emp_no
		AND e.gender = 'M'
	GROUP BY 1
)
SELECT
	COUNT(
		CASE
			WHEN c2.m_highest_salary < c1.avg_salary THEN c2.m_highest_salary
            ELSE NULL
		END
    ) AS max_salary
FROM cte_m_highest_salary c2 
JOIN cte_avg_salary c1;

/*------------------------------------------------------------------------------------*/

-- Pembahasan Mengenai Referring to Common Table Expressions in a WITH Clause
-- Tanpa CTE
SELECT 
    *
FROM
    employees
WHERE
    hire_date > '2000-01-01';

-- Menggunakan CTE
/*
Query dibawah ini menggunakan Common Table Expressions (CTE) 
untuk menghasilkan informasi tentang karyawan yang dipekerjakan 
setelah tanggal 1 Januari 2000 dan nilai gaji tertinggi untuk setiap 
karyawan tersebut. 

Berikut adalah penjelasan langkah-langkahnya:

CTE "emp_hired_from_jan_2000":
- CTE pertama, emp_hired_from_jan_2000, menghasilkan seluruh kolom dari tabel "employees" 
untuk karyawan yang dipekerjakan setelah tanggal 1 Januari 2000.

CTE "highest_contracts_salary_values":
- CTE kedua, highest_contracts_salary_values, menghitung gaji tertinggi (max_salary) 
untuk setiap karyawan yang dipekerjakan setelah tanggal 1 Januari 2000. 
CTE ini menggunakan JOIN dengan CTE pertama untuk memastikan bahwa hanya 
karyawan yang memenuhi kriteria tersebut yang dimasukkan dalam perhitungan.

SELECT Statement:
- Statement SELECT terakhir mengambil semua kolom dari CTE "highest_contracts_salary_values". 
Dengan demikian, hasil akhir dari query ini adalah daftar karyawan yang dipekerjakan setelah 
tanggal 1 Januari 2000 dan gaji tertinggi yang diterima oleh setiap karyawan tersebut.

*/
WITH emp_hired_from_jan_2000 AS(
	SELECT 
		*
	FROM
		employees
	WHERE
		hire_date > '2000-01-01'
),
highest_contracts_salary_values AS(
	SELECT
		e.emp_no,
        MAX(s.salary) AS max_salary
	FROM salaries s
    JOIN emp_hired_from_jan_2000 e ON s.emp_no = e.emp_no
    GROUP BY 1
)
SELECT
	*
FROM highest_contracts_salary_values;

-- Ubah tata letak dari query diatas [Ini akan menampilkan error 1146]
/*
Untuk penjelasan mengapa ketika CTE Ke-2 diubah menjadi pertama
dan CTE Ke-1 diubah menjadi kedua sehingga menghasilkan 'Error Code: 1146'
dikarenakan pada penggunaan JOIN untuk CTE 'emp_hired_from_jan_2000' (CTE Ke-1)
dipanggil sebelum didefinisikan. Ini menyebabkan kesalahan karena 
CTE tersebut tidak dikenali saat diakses oleh CTE lainnya.

Sehingga jika ingin menjalankan kembali query, lebih baik menggunakan
CTE seperti yang ditulis sebelumnya atau bisa didefinikan terlebih dahulu
sebelum dilakukan JOIN dengan table lainnya.
*/
WITH highest_contracts_salary_values AS(
	SELECT
		e.emp_no,
        MAX(s.salary) AS max_salary
	FROM salaries s
    JOIN emp_hired_from_jan_2000 e ON s.emp_no = e.emp_no
    GROUP BY 1
),
emp_hired_from_jan_2000 AS(
	SELECT 
		*
	FROM
		employees
	WHERE
		hire_date > '2000-01-01'
)
SELECT
	*
FROM highest_contracts_salary_values;

/*------------------------------------------------------------------------------------*/