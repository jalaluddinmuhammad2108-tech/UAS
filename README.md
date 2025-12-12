# 📚 Aplikasi Baca Buku Online
Aplikasi Baca Buku Online adalah aplikasi Flutter yang digunakan untuk mencari dan menampilkan informasi buku secara online menggunakan API dari **OpenLibrary**. Pengguna dapat mencari buku berdasarkan kata kunci, memilih kategori (subjects), melihat detail buku, hingga menampilkan cover buku dalam resolusi tinggi.

Aplikasi ini dibuat sebagai proyek UAS dan menunjukkan implementasi pemanggilan data real-time dari internet menggunakan Flutter dan OpenLibrary API.

## 📝 Penjelasan Aplikasi

Aplikasi terdiri dari beberapa fitur utama:

### 🔍 1. Pencarian Buku
Pengguna dapat memasukkan kata kunci pada kotak pencarian.  
Aplikasi akan menampilkan daftar hasil pencarian beserta:
- Judul buku  
- Nama penulis  
- Tahun terbit pertama  
- Nomor edisi  
- Cover ID  
- Work Key  

### 📚 2. Kategori Buku (Subjects)
Pengguna dapat memilih kategori buku seperti:
Programming, Science, History, Education, Fantasy, dan lainnya.  
Setiap kategori akan menampilkan daftar buku relevan dengan subjek tersebut.

### 📖 3. Detail Buku (Work Details)
Ketika pengguna membuka salah satu buku, aplikasi menampilkan informasi lengkap, seperti:
- Deskripsi buku  
- Subjek dan kategori  
- Bahasa  
- Revisi buku  
- Tahun publikasi  
- Informasi tambahan dari OpenLibrary  

### 🖼 4. Cover Buku
Aplikasi juga menampilkan gambar cover buku berdasarkan **Cover ID** dari API OpenLibrary.

## 🌐 Daftar Endpoint API yang Digunakan

Aplikasi menggunakan 4 endpoint utama dari **OpenLibrary API**:

### **1. Endpoint Pencarian Buku**
https://openlibrary.org/search.json?q={query}&limit=30 
**Fungsi:**  
Mencari buku berdasarkan kata kunci (query) yang dimasukkan pengguna.
**Data yang diperoleh:**  
- Judul  
- Penulis  
- Tahun terbit pertama  
- Edisi  
- Cover ID  
- Work Key

### **2. Endpoint Kategori Buku (Subjects)**
https://openlibrary.org/subjects/{category}.json?limit=30 
**Fungsi:**  
Mengambil daftar buku berdasarkan kategori seperti:  
**Programming, Science, History, Education, Religion, Fantasy**, dan lainnya.

### **3. Endpoint Detail Buku (Work Detail)**
https:openlibrary.org{workKey}.json 
**Fungsi:**  
Mengambil detail lengkap dari buku yang dipilih berdasarkan Work Key.
**Detail yang diperoleh:**  
- Deskripsi lengkap  
- Subjek buku  
- Bahasa  
- Revisi  
- Tahun publikasi  
- Data tambahan lain
  
### **4. Endpoint Cover Gambar Buku**
https://covers.openlibrary.org/b/id/{coverId}-L.jpg 
**Fungsi:**  
Menampilkan cover buku beresolusi besar (**–L = Large**).

## 🛠 Cara Instalasi dan Menjalankan Aplikasi

### **1. Clone Repository**
git clone https://github.com/username/uas_online_book.git
### **2. Masuk ke Folder Project**
### **3. Install Dependency**
### **4. Jalankan Aplikasiy**
Untuk menjalankan di Android Emulator:




