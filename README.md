# OO football (Football Shop PBP Mobile)

Nama : Muhammad Azka Awliya \
NPM  : 2406431510 \
Kelas: PBP-C \

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
