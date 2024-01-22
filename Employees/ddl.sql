-- Example untuk membuat database

-- Example 1
CREATE DATABASE Sales;

-- Example 2
CREATE DATABASE IF NOT EXISTS Sales;

-- Example 3
CREATE SCHEMA IF NOT EXISTS Sales;

-- Dari ketiga cara diatas, semuanya dapat dilakukan
-- hanya saja jika kalian menggunakan perintah
-- [IF NOT EXISTS] maka ini akan membantu kalian, jika
-- database yang ada pada server kalian sudah banyak
-- sebagai contoh jika kalian menggunakan [IF NOT EXISTS]
-- maka ketika kalian membuat database baru dan kebetulan terdapat
-- nama yang sama maka MySQL akan otomatis menolaknya dan database
-- yang sama tersebut tidak akan ada pada MySQL.

--------------------------------------------------------------------------------

-- Query dibawah akan digunakan untuk menunjukkan pada MySQL
-- Bahwa saat ini kita ingin menggunakan database dengan nama 'sales'
USE sales;

--------------------------------------------------------------------------------

-- Selanjutnya pada query dibawah ini kita akan membuat table baru
-- dengan beberapa column dan type data yang akan kita tentukan

-- Table 1 -> sales
-- Example 1
CREATE TABLE sales(
    purchase_number INT NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Membuat column dengan ketentuan 4 constraint (batasan)
    date_of_purchase DATE NOT NULL, -- Membuat column dengan ketentuan 2 constraint (batasan)
    customer_id INT, -- Membuat column dengan ketentuan 1 constraint (batasan) sekaligus penghubung FK table 'sales' dengan table 'customers'
    item_code VARCHAR(10) NOT NULL -- Membuat column dengan ketentuan 2 constraint (batasan) dan salah satunya memiliki length 10 sekaligus FK untuk table 'sales' dengan table 'items'
); -- Pasti akan default memakai ENGINE = InnoDB

-- Example 2
CREATE TABLE sales(
    purchase_number INT NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Membuat column dengan ketentuan 4 constraint (batasan)
    date_of_purchase DATE NOT NULL, -- Membuat column dengan ketentuan 2 constraint (batasan)
    customer_id INT, -- Membuat column dengan ketentuan 1 constraint (batasan) sekaligus penghubung FK table 'sales' dengan table 'customers'
    item_code VARCHAR(10) NOT NULL -- Membuat column dengan ketentuan 2 constraint (batasan) dan salah satunya memiliki length 10 sekaligus FK untuk table 'sales' dengan table 'items'
) ENGINE = InnoDB; -- Menegaskan ENGINE yang digunakan adalah InnoDB

-- Example 3 [ADD PRIMARY KEY in DDL]
-- Cara pembuatan table dibawah ini sebenarnya sama dengan cara 1 ataupun 2,
-- hanya saja PRIMARY KEY diletakkan pada perintah terakhir setelah pembuatan column

CREATE TABLE sales(
    purchase_number INT NOT NULL AUTO_INCREMENT, -- Membuat column dengan ketentuan 3 constraint (batasan)
    date_of_purchase DATE NOT NULL, -- Membuat column dengan ketentuan 2 constraint (batasan)
    customer_id INT, -- Membuat column dengan ketentuan 1 constraint (batasan) sekaligus penghubung FK table 'sales' dengan table 'customers'
    item_code VARCHAR(10) NOT NULL, -- Membuat column dengan ketentuan 2 constraint (batasan) dan salah satunya memiliki length 10 sekaligus FK untuk table 'sales' dengan table 'items'
    PRIMARY KEY(purchase_number) -- Membuat satu column menjadi unik
) ENGINE = InnoDB; -- Menegaskan ENGINE yang digunakan adalah InnoDB

--------------------------------------------------------------------------------

-- Table 2 -> customers
-- Selanjutnya kita akan membuat table kedua yang mana nama dari table ini
-- adalah 'customers'

CREATE TABLE customers(
    customer_id INT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_address VARCHAR(255),
    number_of_complaints INT
);

-- Jika sebelumnya pada query diatas table dibuat tanpa adanya column unik
-- maka perintah DDL dibawah ini akan membuat table 'customers' untuk salah satu
-- columnnya menjadi unik

-- Langkah pertama, saya akan menghapus table 'customers' sebelumnya

DROP TABLE customers;

-- Langkah selanjutnya adalah membuat ulang table 'customers' dengan column unik

CREATE TABLE customers(
    customer_id INT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_address VARCHAR(255),
    number_of_complaints INT,
    PRIMARY KEY(customer_id)
);

--------------------------------------------------------------------------------

-- Table 3 -> items
-- Selanjutnya saya akan membuat table ke-3 dimana nama table
-- tersebut adalah 'items'

CREATE TABLE items(
    item_code VARCHAR(255),
    item VARCHAR(255),
    unit_price NUMERIC(10, 2),
    company_id VARCHAR(255), -- Column ini akan menjadi FK untuk menghuungkan table 'items' dengan table 'companies'
    PRIMARY KEY(item_code)
);

--------------------------------------------------------------------------------

-- Table 4 -> companies
-- Untuk table berikutnya adalah 'companies'

CREATE TABLE companies(
    company_id VARCHAR(255),
    company_name VARCHAR(255),
    headquarters_phone_number INT(12),
    PRIMARY KEY(company_id)
);

--------------------------------------------------------------------------------

-- Pada bagian ini akan menunjukkan perintah untuk 
-- menampilkan table pada database yang sudah dibuat

-- Example Default
-- Pertama, pastikan kita sudah memilih database dengan cara dibawah ini
USE sales;

-- Setelah memilih database, maka langkah selanjutnya adalah menampilkan
-- data dengan perintah SELECT secara deafault.
-- [SELECT * FROM nama_table]
SELECT * FROM customers;

-- Example Memanggil table dari database tertentu ini bisa tanpa menggunakan USE
-- [SELECT * FROM nama_database.nama_table]
SELECT * FROM sales.customers;

-- Example lainnya
-- Jika suatu saat saya menggunakan USE pada database sales,
-- namun saya juga ingin menampilkan hasil query dari database lainnya
-- maka saya dapat menggunakan perintah yang lebih spesifik lagi seperti
-- pada contoh sebelumnya, misal saya ingin menampilkan data table admin
-- pada database belajar_mysql, saya tidak perlu melakukan 
-- USE pada database belajar_mysql ini, yang perlu saya lakukan hanyalah

SELECT * FROM belajar_mysql.admin;

-- Query diatas akan membantu kita untuk menampilkan data tanpa perlu keluar dari
-- database lainnya, karena kita memberikan perintah pada MySQL yang lebih spesifik lagi

--------------------------------------------------------------------------------

-- Pada query DDL dibawah ini akan menunjukkan pada kita cara bagaimana
-- untuk menghapus sebuah table pada database
-- [DROP TABLE nama_table]

DROP TABLE sales;

--------------------------------------------------------------------------------

-- Memuat FK (FOREIGN KEY) untuk column customer_id pada table 'sales'

ALTER TABLE sales
ADD CONSTRAINT fk_sales_customers -- Memberikan nama alias pada sebuah FK (FOREIGN KEY)
FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE;

-- Pada perintah ON DELETE CASCADE ini berguna ketika pada table parent data dihapus
-- maka pada table child juga data akan terhapus. Contoh...

-- Saya memiliki table 'customers' sebagai parent disini dengan ID 7
-- Maka pada table 'sales' sebagai child saya juga memili data ID 7 untuk data pembelian
-- dari customer ini, maka ketika saya melakukan pengahpusan data pada ID 7
-- pada parent table yaitu 'customers' otomatis data pada table child yaitu 'sales'
-- data penjualannya untuk ID 7 ini akan terhapus juga.

-- EXERCISE
-- Disini saya akan mencoba DELETE semua table terlebih dahulu 
-- untuk masuk pada materi selanjutnya

DROP TABLE sales;
DROP TABLE companies;
DROP TABLE customers;
DROP TABLE items;

--------------------------------------------------------------------------------

-- Membuat UNIQUE KEY pada column dengan menggunakan ALTER TABLE

-- Langkah pertama buat table 'customers' terlebih dahulu
-- tanpa menggunakan fungsi UNIQUE KEY

CREATE TABLE customers(
    customer_id INT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_address VARCHAR(255),
    number_of_complaints INT,
    PRIMARY KEY(customer_id)
);

-- Langkah kedua tambahkan fungsi UNIQUE KEY
-- dengan menggunakan ALTER TABLE

-- ALTER TABLE nama_table
-- ADD UNIQUE KEY(nama_column);

ALTER TABLE customers
ADD UNIQUE KEY(email_address); -- Perintah ini akan menambahkan fungsi UNIQUE pada kolom 'email_address'

-- Setelah pembuatan query UNIQUE pada satu kolom seperti diatas
-- maka selanjutnya bagaimana untuk menghapus nilai UNIQUE tersebut?
-- disini kita dapat menggunakan fungsi ALTER TABLE kembali, example...

-- ALTER TABLE nama_table
-- DROP INDEX nama_column; 

-- disini untuk statement DROP tidak perlu menggunakan tanda kurung (), 
-- karena termasuk pada relevan sintax pada statment DROP

ALTER TABLE customers
DROP INDEX email_address;

-- Selanjutnya saya membuat kembali table 'customers' dengan
-- menamahkan fungsi AUTO_INCREMENT, lalu saya akan menambahkan
-- data pada table ini...

DROP TABLE customers;

CREATE TABLE customers(
    customer_id INT AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_address VARCHAR(255),
    number_of_complaints INT,
    PRIMARY KEY(customer_id)
);

-- Setelah membuat table 'customers' yang baru diatas
-- maka selanjutnya saya akan menambahkan 1 kolom baru
-- dengan type data ENUM, sebagai pilihan untuk gender customer
-- M -> Male (Laki-Laki)
-- F -> Female (Perempuan)

ALTER TABLE customers
ADD COLUMN gender ENUM('M', 'F') AFTER last_name; -- Fungsi AFTER disini digunakan untuk penempatan tataletak kolom

-- Setelah selesai membuat table 'customers' yang baru dan menambahkan kolom baru
-- selanjutnya saya akan coba untuk memasukkan satu data untuk table ini, example...

-- Perlu diingat ketika kita memasukkan data pastikan menyebutkan semua column table
-- yang akan kita masukkan datanya, seperti contoh dibawah ini
-- pada contoh dibawah ini saya tidak menyertakan column 'customer_id'
-- karena sudah menggunakan fungsi AUTO_INCREMENT yang akan terisi sendiri nilainya
INSERT INTO customers(first_name, last_name, gender, email_address, number_of_complaints)
VALUES('John', 'Mackinley', 'M', 'john@example.com', 0); -- Lalu masukkan value dari data yang akan dimasukkan

-- Jika query yang dituliskan benar, maka ketika menjalankan perintah SELECT
-- data akan tampil dalam bentuk table

SELECT * FROM customers;

--------------------------------------------------------------------------------

-- Masuk pada pembahasan DEFAULT CONSTRAINT 
-- Jika sebelumnya pada pembuatan table 'customers' 
-- kita tidak menentukan DEAFULT CONSTRAINT dari kolom yang ada pada table
-- Maka kita akan mengubahnya menggunakan ALTER TABLE

-- Harusnya pembuatan table 'customers' seperti dibawah
CREATE TABLE customers(
    customer_id INT AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_address VARCHAR(255),
    number_of_complaints INT DEFAULT 0,
    PRIMARY KEY(customer_id)
);

-- Namun kita sudah terlanjut membuatnya tanpa menggunakan DEFAULT CONSTRAINT
-- pada column 'number_of_complaints', kita dapat mengubahnya dengan menggunakan
-- ALTER TABLE CHANGE, example...

-- ALTER TABLE nama_table
-- CHANGE COLUMN nama_column sebutkan_kembali_nama_column [Masukkan CONSTRAINT];

ALTER TABLE customers
CHANGE COLUMN number_of_complaints number_of_complaints INT DEFAULT 0;

-- Lalu silakan coba untuk memasukkan data kembali
-- namun disini saya akan mencoba mengosongkan value dari 2 column

INSERT INTO customers(first_name, last_name, gender)
VALUES('Peter', 'Figaro', 'M');

-- Ketika kalian mencoba SELECT data, maka tampilan pada 2 column
-- yang tidak saya isi datanya, akan bernilai NULL dan 0

SELECT * FROM customers;

-- Setelah membuat DEAFULT CONSTRAINT, kita juga dapat menghapusnya
-- dengan menggunakan perintah dibawah ini...

-- ALTER TABLE nama_table
-- ALTER COLUMN column_name DROP DEFAULT;

ALTER TABLE customers
ALTER COLUMN number_of_complaints DROP DEFAULT;

--------------------------------------------------------------------------------

-- Selanjutnya saya akan membuat kembali table 'companies'
-- dengan menambahkan UNIQUE KEY dan juga DEAFULT CONSTRAINT

CREATE TABLE companies(
    company_id VARCHAR(255),
    company_name VARCHAR(255) DEFAULT 'X', -- Setelah VARCHAR adalah DEFAULT CONSTRAINT yang saya atur dengan string 'X'
    headquarters_phone_number VARCHAR(255),
    PRIMARY KEY(company_id),
    UNIQUE KEY(headquarters_phone_number)
);

--------------------------------------------------------------------------------

-- Disini saya akan membuat ulang table 'companies', ingat untuk menghapusnya dulu
-- jika sudah dibuat
CREATE TABLE companies(
    company_id INT AUTO_INCREMENT,
    company_name VARCHAR(255),
    headquarters_phone_number VARCHAR(255),
    PRIMARY KEY(company_id)
);

-- Pembahasan selanjutnya adalah terkait dengan NOT NULL
-- Disini saya akan membuat column 'company_name' pada table
-- 'comapnies' menjadi CONSTRAINT NULL jika sebelumnya CONTRAINT-nya adalah
-- DEFAULT 'X'

-- Perlu diingat untuk mengubah column menjadi NULL kita tidak dapat menggunakan
-- 2 ALTER seperti pada table 'customers' untuk melakukan penghapusan CONSTRAINT column

ALTER TABLE companies
MODIFY company_name VARCHAR(255) NULL; -- Perintah MODIFY digunakan untuk melakukan modifikasi CONTRAINT pada DDL

-- Sedangkan DDL dibabwah ini akan digunakan untuk melakukan
-- perubahan pada struktur CONSTAINT DDL yang ada pada database

ALTER TABLE companies
CHANGE COLUMN company_name company_name VARCHAR(255) NOT NULL;

-- Cara diatas bisa dilakukan pada workbanch MySQL
-- Namun jika kalian menggunakan MySQL yang ada pada XAMPP, maka dapat menggunakan
-- query DDL dibawah ini untuk menegaskan data kolom tidak boleh NULL

ALTER TABLE companies
ADD CONSTRAINT check_company_name_not_null CHECK (company_name <> '');

-- Ini dapat memberikan pemahaman bagi end user ketika input data nantinya
-- dimana pada column 'company_name' haruslah diisi dan tidak boleh diiarkan kosong
-- Example ketika saya akan melakukan input data pada table 'companies'

INSERT INTO companies(headquarters_phone_number)
VALUES('+62 876 244 228'); -- DML ini akan menghasilkan error, karena harusnya kolom 'company_name' haruslah diisi

-- Namun ketika column 'company_name' juga masuk pada INSERT data
-- maka perintah DML akan dijalankan
INSERT INTO companies(company_name, headquarters_phone_number)
VALUES('Adam', '+62 876 244 228');
/*

Selanjutnya saya akan merubah struktur 'headquarters_phone_number'
yang sebelumnya bisa diisi dengan value NULL, namun kali ini harus tetap diisi
dan tidak boleh ada value NULL pada column ini

*/
-- BEFORE
ALTER TABLE companies
MODIFY headquarters_phone_number VARCHAR(255) NULL;

-- AFTER
ALTER TABLE companies -- DDL ini akan menginformasikan column yang disebutkan tidak boleh NULL
CHANGE COLUMN headquarters_phone_number headquarters_phone_number VARCHAR(255) NOT NULL;

ALTER TABLE companies -- DDL ini akan melakukan cek bahwa ketika data yang masuk NULL akan ditolak
ADD CONSTRAINT headquarters_phone_number_not_null CHECK(headquarters_phone_number <> '');

-- Example INSERT data
INSERT INTO companies(company_name)
VALUES('Sagitarius'); -- DML ini akan menampilkan error, sebab column 'headquarters_phone_number' tidak diisi

