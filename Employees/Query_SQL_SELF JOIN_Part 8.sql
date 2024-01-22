-- Penggunaan SELF JOIN
/*
SELF JOIN digunakan ketika sebuah table akan 
digabungkan dengan dirinya sendiri, untuk detailnya dibawah ini:

Kapan waktu yang tepat untuk menggunakan self-join?
Jawab: ketika kolom dalam tabel direferensikan dalam tabel yang sama

Example Case:
From the emp_manager table, extract the record
data only of those employees who are managers as well
*/

-- Explore Data
SELECT 
    *
FROM
    emp_manager
ORDER BY emp_no;

-- Build Query
/*
Pada query dibawah ini data akan diambil berdasrkan table
yang sama yaitu emp_manager, namun perlu diperhatikan kembali
pada penggunaan dari SELF JOIN disini walaupun penggabungan diambil
dari table yang sama disini terdapat alias yaitu 'e1' dan 'e2'.

Operasi JOIN:
JOIN emp_manager e2 ON e1.emp_no = e2.manager_no: 
Ini adalah operasi JOIN yang menggabungkan baris dari 
e1 dan e2 di mana nilai emp_no dari e1 sama dengan nilai manager_no dari e2.
*/
SELECT 
    e1.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no; -- Penting untuk diingat untuk self join, pastikan isi data setiap kolom sama ya!

/*
Namun jika kita menggunakan SELECT e2.* maka datanya akan kembali
seperti sebelum digabungkan. Ini ibaratnya kita membagi 1 table menjadi 2
tampilan dari table itu sendiri.
*/
SELECT 
    e2.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no; -- Penting untuk diingat untuk self join, pastikan isi data setiap kolom sama ya!
    
/*
Lalu contoh lainnya, bagaimana jika kita ingin mendapatkan
kolom emp_no, dept_no dari [e1] dan manager_no dari [e2]
maka kita dapat melakukan query dibawah ini:
*/
-- Cara 1: Ini akan menampilkan unik emp_no saja tanpa adanya duplikat
SELECT DISTINCT
    e1.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no; -- Penting untuk diingat untuk self join, pastikan isi data setiap kolom sama ya!

/*
Cara 2: Sama pada cara pertama, output hanya ada 2
namun disini tidak menggunakan DISTINCT melainkan
melakukan filter dengan menggunakan WHERE cluse
dengan subqueries didalamnya
*/
SELECT 
    e1.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no -- Penting untuk diingat untuk self join, pastikan isi data setiap kolom sama ya!
WHERE
    e2.emp_no IN (SELECT 
            manager_no
        FROM
            emp_manager);