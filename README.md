# 🚜 Market Kakao Farm: Revolusi Belanja Petani & Peternak 🌾

Selamat datang di **Market Kakao Farm**! Ini adalah platform aplikasi mobile inovatif yang dirancang khusus untuk memenuhi kebutuhan petani (terutama petani kakao) dan peternak di Indonesia. Bayangkan sebuah pasar digital di genggaman Anda, tempat Anda bisa dengan mudah membeli segala jenis bahan baku, pakan, pupuk, peralatan, dan perlengkapan lain yang esensial untuk meningkatkan produktivitas pertanian dan peternakan Anda.

Kami hadir untuk menyederhanakan rantai pasok, memastikan petani dan peternak mendapatkan akses mudah dan aman ke sumber daya terbaik, kapan pun dan di mana pun, dengan jaminan keamanan transaksi.

## ✨ Fitur Utama

- **🛒 Marketplace Khusus Pertanian & Peternakan:** Katalog produk yang komprehensif, disesuaikan untuk kebutuhan spesifik petani dan peternak (mulai dari bibit, pupuk, pakan ternak, hingga peralatan pertanian modern).
- **💳 Pembayaran Aman dengan Midtrans:** Integrasi _payment gateway_ terkemuka Midtrans yang memungkinkan transaksi lancar dan aman dengan berbagai metode pembayaran yang populer di Indonesia (transfer bank, e-wallet, virtual account, minimarket, dll.).
- **🔐 Otentikasi Berlapis:**
  - **Login Aman:** Akses akun pribadi Anda dengan sistem login yang terenkripsi.
  - **PIN Transaksi:** Lapisan keamanan tambahan untuk setiap transaksi atau akses ke fitur sensitif.
  - **Biometrik (Sidik Jari):** Kemudahan dan keamanan ekstra dengan login atau otorisasi pembayaran menggunakan sidik jari (tergantung dukungan perangkat).
- **Histori Pesanan:** Lacak semua pembelian Anda, kelola status pengiriman, dan tinjau kembali transaksi sebelumnya dengan mudah.
- **Antarmuka Intuitif:** Desain UI/UX yang bersih, responsif, dan mudah digunakan, dirancang agar nyaman diakses oleh semua kalangan pengguna, bahkan bagi yang baru pertama kali menggunakan aplikasi mobile.

## 🚀 Teknologi yang Digunakan

Proyek ini dibangun dengan fondasi teknologi yang kuat untuk performa dan pengalaman pengguna yang optimal:

- **Frontend:** `Dart` dengan `Flutter` (untuk pengembangan aplikasi mobile _cross-platform_ yang cepat dan indah, mendukung Android dan iOS).
- **Backend (Percobaan):** `PHP` dengan `Laravel` (framework PHP yang populer dan robust untuk membangun API RESTful).
- **Database (Percobaan):** `SQLite` (database berbasis file yang ringan dan mudah digunakan untuk fase pengembangan dan prototipe).
- **Payment Gateway:** `Midtrans` (solusi pembayaran terintegrasi untuk Indonesia).

### Dependensi Flutter (dari `pubspec.yaml`)

Aplikasi Flutter ini menggunakan paket-paket berikut untuk fungsionalitasnya:

```yaml
dependencies:
  flutter:
    sdk: flutter
  google_fonts: ^6.2.1 # Menggunakan font Google untuk tipografi yang menarik
  provider: ^6.1.1 # Manajemen state yang sederhana dan powerful
  cupertino_icons: ^1.0.8 # Ikon gaya iOS
  flutter_svg: ^1.1.1 # Menampilkan gambar SVG
  firebase_core: ^3.13.1 # Inisialisasi Firebase
  cloud_firestore: ^5.6.8 # Database NoSQL dari Firebase (jika digunakan)
  firebase_database: ^11.3.6 # Realtime Database dari Firebase (jika digunakan)
  shared_preferences: ^2.5.3 # Menyimpan data sederhana secara lokal
  google_sign_in: ^6.2.1 # Integrasi login dengan Google
  flutter_facebook_auth: ^6.0.4 # Integrasi login dengan Facebook
  sqflite: ^2.4.2 # Plugin SQLite untuk Flutter
  path: ^1.8.3 # Membangun path yang aman lintas platform
  url_launcher: ^6.3.0 # Membuka URL di browser atau aplikasi eksternal
  local_auth: ^2.2.0 # Otentikasi biometrik (sidik jari/face ID)
  webview_flutter: ^4.8.0 # Menampilkan konten web di dalam aplikasi (penting untuk Midtrans)
```
