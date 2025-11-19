# OO football (Football Shop PBP Mobile)

Nama : Muhammad Azka Awliya \
NPM  : 2406431510 \
Kelas: PBP-C 

- [Tugas 7](#tugas-7)
- [Tugas 8](#tugas-8)
- [Tugas 9](#tugas-9)

# Tugas 7

## 1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.

Widget Tree (Pohon Widget) adalah struktur hierarkis dari semua widget untuk membangun antarmuka pengguna (UI) aplikasi Flutter. Semuanya di Flutter adalah widget, dan mereka tersusun seperti pohon keluarga, dimulai dari satu widget root (akar).

Prosesnya bekerja dua arah: induk menurunkan batasan (constraints) ukuran ke anaknya, dan anak mengembalikan ukuran (size) yang diinginkannya ke induk, yang kemudian menentukan posisi akhir anak tersebut di layar.

## 2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.

**Custom Widget**
- MyApp : sebagai root aplikasi, turunan StatelessWidget.
- MyHomePage : halaman utama yang menampung layout.
- InfoCard : kartu kustom untuk menampilkan info NPM, Nama, dan Kelas.
- ItemCard : kartu kustom di dalam grid yang merespons ketukan.

**Layout** 
- MaterialApp : widget root yang mengatur tema dan halaman awal.
- Scaffold : kerangka halaman yang menyediakan AppBar dan body.
- Column : menyusun widget secara vertikal.
- Row : menyusun widget InfoCard secara horizontal.
- GridView.count : membuat tata letak grid dengan 3 kolom.
- Padding : memberi jarak di sekitar body dan teks.
- SizedBox : memberi spasi vertikal.
- Center : menempatkan konten di tengah.
- Container : digunakan di InfoCard untuk mengatur lebar dan padding.

**Display & Interaction**
- Text : menampilkan semua teks.
- AppBar : menambah judul di atas.
- Icon : menampilkan ikon di ItemCard.
- Card : di dalam InfoCard untuk memberi efek bayangan.
- Material : sebagai dasar ItemCard untuk mengatur warna dan borderRadius.
- InkWell : membuat ItemCard dapat diklik dan memicu SnackBar.

## 3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.

MaterialApp adalah widget praktis yang membungkus sejumlah fungsionalitas inti yang diperlukan oleh sebagian besar aplikasi yang menggunakan Material Design. Fungsinya mencakup pengaturan tema (theme) global untuk warna dan font, manajemen tumpukan navigasi (routes) untuk berpindah antar halaman, dan menyediakan konfigurasi lokalisasi (bahasa).

## 4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?

StatelessWidget adalah widget yang immutable, dimana propertinya bersifat final dan tidak dapat berubah setelah widget dibuat hanya menerima data dan menampilkannya. 

StatefulWidget bersifat mutable, sehingga dapat mempertahankan state internal yang dapat dimodifikasi selama lifetime widget.

## 5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?

BuildContext adalah objek yang menyimpan informasi tentang lokasi sebuah widget di dalam widget tree. Penggunaan BuildContext cukup penting di Flutter karena BuildContext bertindak sebagai "pegangan" yang memungkinkan widget berinteraksi dengan widget ancestor (leluhurnya). Biasanya digunakan untuk tugas-tugas penting seperti mengambil data tema (Theme.of(context)), mencari Scaffold terdekat untuk menampilkan SnackBar (ScaffoldMessenger.of(context)), atau berpindah halaman (Navigator.of(context)).

## 6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".

Hot Reload adalah fitur pengembangan cepat yang menyuntikkan file kode sumber yang baru diubah ke dalam Dart Virtual Machine (VM) yang sedang berjalan.

Hot Restart menghancurkan Dart VM yang ada, memuat ulang kode aplikasi sepenuhnya, dan memulai ulang aplikasi dari awal. Ini jauh lebih cepat daripada cold restart (menutup dan membuka kembali aplikasi), tetapi semua state yang tersimpan di memori akan hilang dan aplikasi kembali ke keadaan awalnya.

# Tugas 8

## 1. Jelaskan perbedaan antara `Navigator.push()` dan `Navigator.pushReplacement()` pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?

`Navigator.push()` menambahkan halaman baru di atas stack sehingga pengguna masih bisa kembali ke halaman sebelumnya dengan tombol back. Fungsinya cocok untuk alur yang sifatnya drill-down sementara, misalnya membuka halaman tambah produk dari kartu "Tambah Produk" di `MyHomePage`, karena setelah selesai mengisi form pengguna mungkin ingin kembali melihat beranda.

`Navigator.pushReplacement()` menggantikan halaman teratas dengan halaman baru sehingga halaman sebelumnya tidak lagi ada di stack. Pendekatan ini cocok untuk komponen navigasi global seperti drawer yang berpindah antar halaman utama (home atau form). Ketika pengguna memilih menu di drawer (misalnya `LeftDrawer`), mereka biasanya tidak ingin kembali ke halaman yang sama hanya dengan menekan tombol back.

## 2. Bagaimana kamu memanfaatkan hierarchy widget seperti `Scaffold`, `AppBar`, dan `Drawer` untuk membangun struktur halaman yang konsisten di seluruh aplikasi?

Setiap halaman (beranda dan form) dibangun di atas `Scaffold` sehingga mendapatkan struktur dasar yang sama: area konten (`body`), `AppBar`, dan `Drawer`. `AppBar` digunakan untuk menampilkan judul halaman yang relevan sekaligus memanfaatkan tema warna global (misalnya kombinasi biru-putih brand OO Football). `LeftDrawer` diinjeksikan ke setiap `Scaffold` agar opsi navigasi "Home" dan "Tambah Produk" selalu tersedia dari mana pun pengguna berada. Dengan pola ini, keseluruhan aplikasi terasa konsisten walaupun konten body-nya berbeda.

## 3. Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti `Padding`, `SingleChildScrollView`, dan `ListView` saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.

- `Padding` menjaga jarak antar elemen sehingga input tidak saling berdempetan dan lebih mudah dibaca. Di halaman form (`ProductFormPage`) seluruh konten dibungkus `Padding.all(24)` supaya area sentuh nyaman dan responsif terhadap berbagai ukuran layar.
- `SingleChildScrollView` memastikan form tetap dapat digulir ketika tinggi layar tidak mencukupi, sehingga keyboard atau perangkat dengan layar kecil tidak memotong input penting. Hal ini penting karena form memiliki banyak field (nama, harga, kategori, deskripsi, thumbnail, toggle unggulan).
- `ListView` atau widget turunan seperti `ListView`/`Column` di dalam `Drawer` membuat opsi navigasi dapat digulir jika jumlahnya bertambah dan otomatis menangani tinggi konten. Drawer menggunakan `ListView` agar header dan setiap `ListTile` dapat discroll ketika tinggi layar terbatas.

## 4. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?

Warna dasar aplikasi diatur melalui `ThemeData` pada `MyApp`, dengan `ColorScheme.fromSeed(seedColor: Colors.blue)` untuk memunculkan nuansa biru khas OO Football serta aksen sekunder `Colors.blueAccent`. `AppBar` di setiap halaman menggunakan warna yang masih senada (misalnya indigo dengan teks putih di form) supaya identitas brand tetap konsisten. Komponen-komponen penting seperti kartu menu dan tombol utama juga menggunakan variasi biru, hijau, dan merah yang sudah dipilih agar harmonis dengan tema global.

# Tugas 9

## 1. Mengapa perlu model Dart saat ambil/kirim JSON? Apa konsekuensinya jika langsung memetakan `Map<String, dynamic>` tanpa model?

Model memastikan struktur data jelas dan ter-typed (null-safety, nama field konsisten). Tanpa model, raw `Map<String, dynamic>` membuat akses field rentan salah ketik, salah tipe, dan lebih sulit dirawat/di-refactor. Model juga memudahkan validasi dan serialisasi (fromJson/toJson) sehingga data lintas layer tetap terjaga.

## 2. Fungsi package `http` dan `CookieRequest` dalam tugas ini? Jelaskan peran perbedaan peran `http` vs `CookieRequest`.

`http` dipakai ketika melakukan request umum tanpa state sesi Django (mis. fetch JSON publik produk). `CookieRequest` membungkus `http` dengan manajemen cookie/sesi otomatis (login, register, POST form), sehingga header session/csrf disertakan tanpa mengelola manual. Jadi `CookieRequest` digunakan untuk endpoint yang butuh autentikasi atau butuh cookie.

## 3. Mengapa instance `CookieRequest` perlu untuk disediakan ke semua komponen Flutter?

Dengan 1 instance global (via `Provider`), semua halaman berbagi sesi/cookie yang sama: login di satu tempat langsung berlaku di halaman lain, dan refresh cookie tidak duplikatif. Ini menghindari masalah sesi terpisah antar halaman dan memudahkan akses ke data login (username/id) melalui `request.jsonData`.

## 4. Konfigurasi konektivitas Flutter ↔ Django: 10.0.2.2 pada `ALLOWED_HOSTS`, CORS/SameSite/cookie, izin internet Android. Apa yang terjadi jika tidak benar?

- `ALLOWED_HOSTS` mencantumkan `10.0.2.2` (bridge emulator ke host) supaya Django mengizinkan akses dari emulator. Jika tidak, Django menolak (400 Bad Request “DisallowedHost”).
- CORS dan pengaturan cookie/SameSite harus mengizinkan origin Flutter; jika salah, browser/webview menolak berbagi resource/cookie sehingga login tidak menempel.
- Izin internet Android (`android.permission.INTERNET`) wajib agar aplikasi bisa memanggil API; tanpa ini request gagal (network unreachable).

## 5. Mekanisme pengiriman data mulai dari input hingga produk ditampilkan pada Flutter.

Input dimasukkan di form (`ProductFormPage`) → divalidasi → dikirim dengan `request.postJson` ke endpoint Django → Django membuat objek dan merespons JSON status/message → Flutter menampilkan dialog sukses dan snackbar → Fetch daftar produk (`ProductListPage`) via endpoint JSON → data diparse dengan model (`newsListFromJson`) → ditrender di ListView.

## 6. Mekanisme autentikasi dari login/register sampai akun bisa digunakan.

Form login/register mengirim kredensial ke endpoint Django memakai `CookieRequest.post`/`login` → Django memvalidasi dan mengembalikan status, message, username/id serta mengatur cookie sesi → `CookieRequest` menyimpan cookie + `jsonData` → Aplikasi membaca `request.loggedIn` dan `request.jsonData` untuk state login → navigasi diarahkan ke halaman home; request selanjutnya otomatis menyertakan cookie sesi.

## 7. Implementasi checklist di atas secara step-by-step.

1. Pasang `pbp_django_auth` dan `http`, setup `Provider<CookieRequest>` di `main.dart` sebagai root.  
2. Tambahkan endpoint Django: JSON produk, create-flutter, auth login/register; pastikan `ALLOWED_HOSTS` memuat `10.0.2.2` dan konfigurasi CORS/SameSite sesuai.  
3. Implementasi form produk (`ProductFormPage`) dengan validasi, kirim via `request.postJson`, tampilkan dialog sukses/error.  
4. Implementasi login/register memakai `CookieRequest.login`/`post`, cek `request.loggedIn`, simpan data user di `request.jsonData`, dan arahkan ke home.  
5. Buat halaman daftar produk (`ProductListPage`), fetch dengan `http.get`/`newsListFromJson`, filter berdasarkan user id (onlyMine), tampilkan kartu + gambar/featured.  
6. Pastikan izin internet Android aktif dan uji di emulator/device; hot reload untuk iterasi UI.  
7. Uji alur lengkap: register/login → tambah produk → cek daftar produk & detail → verifikasi filter “Koleksi Saya” jalan dan status sukses muncul.
