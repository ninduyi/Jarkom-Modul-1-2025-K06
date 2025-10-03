# Praktikum Komunikasi Data dan Jaringan Komputer Modul 1 - K06

## Anggota Kelompok

| NRP        | Nama                      |
| :--------- | :------------------------ |
| 5027241006 | Nabilah Anindya Paramesti |
| 5027241041 | Raya Ahmad Syarif         |

## Daftar Isi

- [Soal 1](#soal-1)
- [Soal 2](#soal-2)
- [Soal 3](#soal-3)
- [Soal 4](#soal-4)
- [Soal 5](#soal-5)
- [Soal 6](#soal-6)
- [Soal 7](#soal-7)
- [Soal 8](#soal-8)
- [Soal 9](#soal-9)
- [Soal 10](#soal-10)
- [Soal 11](#soal-11)
- [Soal 12](#soal-12)
- [Soal 13](#soal-13)

---

# Soal 1

***By : Nabilah Anindya***

Untuk mempersiapkan pembuatan entitas, **Eru** yang berperan sebagai Router membuat dua **Switch/Gateway**. Switch 1 akan terhubung ke **Melkor** dan **Manwe**, sedangkan Switch 2 terhubung ke **Varda** dan **Ulmo**. Keempat Ainur tersebut akan berperan sebagai **Client**.

### Penjelasan Topologi

Topologi jaringan ini membentuk struktur hierarkis sederhana.
-   **Eru (Router)**: Berfungsi sebagai pusat jaringan yang akan menghubungkan subnet yang berbeda dan mengatur lalu lintas antar mereka.
-   **Switch1 & Switch2**: Berfungsi sebagai penghubung perangkat dalam satu segmen jaringan lokal (LAN) yang sama.
-   **Melkor, Manwe, Varda, Ulmo (Client)**: Perangkat akhir yang akan berkomunikasi satu sama lain melalui jaringan yang dibangun.

![](/images/1-topologi.png)

---

# Soal 2

***By : Nabilah Anindya***

Karena Arda (Bumi) masih terisolasi, **Eru** harus dapat tersambung ke **internet**.

### Penjelasan Perintah

Untuk menghubungkan jaringan virtual GNS3 ke internet, kita menambahkan node **NAT (Network Address Translation)**. Node ini bertindak sebagai jembatan antara jaringan internal GNS3 dan jaringan fisik tempat GNS3 dijalankan (misalnya, laptop Anda), yang sudah terhubung ke internet.

Untuk menguji koneksi, kita menggunakan perintah `ping`.
-   `ping google.com -c 3`: Perintah ini mengirimkan 3 paket `ICMP Echo Request` ke server Google. Jika server merespons, itu menandakan bahwa koneksi internet dari node Eru telah berhasil.

### Sebelum ditambahkan NAT

Koneksi gagal karena Eru tidak tahu rute menuju internet.
![](/images/2.1-sebelum-nat.png)

### Sesudah ditambahkan NAT

Koneksi berhasil dengan `0% packet loss`.
![](/images/2.2-tambah-nat.png)

---

