# Praktikum Komunikasi Data dan Jaringan Komputer Modul 1 - K06

## Anggota Kelompok
| NRP | Nama |
|---|---|
| 5027241006 | Nabilah Anindya Paramesti |
| 5027241041 | Raya Ahmad Syarif |

---

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

## Soal 1
*By : Nabilah Anindya*

Untuk mempersiapkan pembuatan entitas, Eru yang berperan sebagai Router membuat dua Switch/Gateway. Switch 1 akan terhubung ke Melkor dan Manwe, sedangkan Switch 2 terhubung ke Varda dan Ulmo. Keempat Ainur tersebut akan berperan sebagai **Client**.

### Penjelasan Topologi
Topologi jaringan ini membentuk struktur hierarkis sederhana.

- **Eru (Router)**: Berfungsi sebagai pusat jaringan yang akan menghubungkan subnet yang berbeda dan mengatur lalu lintas antar mereka.
- **Switch1 & Switch2**: Berfungsi sebagai penghubung perangkat dalam satu segmen jaringan lokal (LAN) yang sama.
- **Melkor, Manwe, Varda, Ulmo (Client)**: Perangkat akhir yang akan berkomunikasi satu sama lain melalui jaringan yang dibangun.

![](/images/1-topologi.png)

---

## Soal 2
*By : Nabilah Anindya*

Karena Arda (Bumi) masih terisolasi, **Eru harus dapat tersambung ke internet.**

### Penjelasan Perintah
Untuk menghubungkan jaringan virtual GNS3 ke internet, kita menambahkan node **NAT (Network Address Translation)**. Node ini bertindak sebagai jembatan antara jaringan internal GNS3 dan jaringan fisik tempat GNS3 dijalankan (misalnya, laptop Anda), yang sudah terhubung ke internet.

Untuk menguji koneksi, kita menggunakan perintah `ping`:

```bash
ping google.com -c 3
```
Perintah ini mengirimkan 3 paket ICMP Echo Request ke server Google. Jika server merespons, itu menandakan bahwa koneksi internet dari node Eru telah berhasil.

**Sebelum ditambahkan NAT**  
![](/images/2.1-sebelum-nat.png)
Koneksi gagal karena Eru tidak tahu rute menuju internet.

**Sesudah ditambahkan NAT**  

![](/images/2.2-tambah-nat.png)
![](/images/2.3-ping.png)
Koneksi berhasil dengan **0% packet loss**.

---

## Soal 3
*By : Nabilah Anindya*

Pastikan agar setiap **Ainur (Client) dapat saling terhubung.**

![](/images/3-koneksi.png)

### Penjelasan Konfigurasi
Agar semua client dapat berkomunikasi, kita harus melakukan konfigurasi IP Address secara statis.

- **Router (Eru)**: Dikonfigurasi dengan tiga antarmuka. `eth0` terhubung ke NAT untuk internet, sementara `eth1` dan `eth2` menjadi gateway untuk masing-masing subnet.
- **Client**: Setiap client diatur dengan alamat IP statis yang unik dalam subnetnya dan harus menunjuk ke alamat IP gateway (interface router Eru) yang sesuai agar bisa berkomunikasi dengan client di subnet lain.

### Config Router (Eru)
```bash
# eth0 terhubung ke NAT, mendapat IP via DHCP
auto eth0
iface eth0 inet dhcp

# eth1 menjadi gateway untuk Melkor & Manwe dengan IP 192.214.1.1
auto eth1
iface eth1 inet static
    address 192.214.1.1
    netmask 255.255.255.0

# eth2 menjadi gateway untuk Varda & Ulmo dengan IP 192.214.2.1
auto eth2
iface eth2 inet static
    address 192.214.2.1
    netmask 255.255.255.0
```

### Config Client
**Melkor**  
```bash
auto eth0
iface eth0 inet static
    address 192.214.1.2 
    netmask 255.255.255.0 
    gateway 192.214.1.1 
```

**Manwe**  
```bash
auto eth0
iface eth0 inet static
    address 192.214.1.3
    netmask 255.255.255.0 
    gateway 192.214.1.1 
```

**Varda**  
```bash
auto eth0
iface eth0 inet static
    address 192.214.2.2 
    netmask 255.255.255.0 
    gateway 192.214.2.1 
```

**Ulmo**  
```bash
auto eth0
iface eth0 inet static
    address 192.214.2.3 
    netmask 255.255.255.0 
    gateway 192.214.2.1 
```



---

## Soal 4
*By : Nabilah Anindya*

Pastikan agar setiap **Client dapat tersambung ke internet secara mandiri.**

### Router Eru
```bash
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
```
![](/images/4.1-iptables.png)

### Konfigurasi DNS pada setiap Client
```bash
echo nameserver 192.168.122.1 > /etc/resolv.conf
```

### Penjelasan Perintah
- **iptables di Eru**: Perintah ini mengaktifkan NAT pada router Eru.  
  `iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE` menyembunyikan alamat IP privat dari client di belakang alamat IP publik Eru. Ketika client mengirim paket ke internet, Eru akan mengubah alamat IP sumber paket tersebut menjadi alamat IP miliknya (`eth0`) sebelum meneruskannya.
- **DNS di Client**: Client membutuhkan alamat DNS server untuk mengubah nama domain (seperti google.com) menjadi alamat IP.
  - `cat /etc/resolv.conf`: menampilkan konfigurasi DNS saat ini.
  ![](/images/4.2-eru.png)
  - `echo nameserver 192.168.122.1 > /etc/resolv.conf`: mengatur alamat DNS server untuk client.
  ![](/images/4.3-melkor.png)
  ![](/images/4.4-manwe.png)
  ![](/images/4.5-varda.png)
  ![](/images/4.6-ulmo.png)

**Uji Coba Ping di Melkor**  
Hasilnya menunjukkan koneksi berhasil dengan **0% packet loss**.
![](/images/4.7-ping-google.png)


---

## Soal 5
*By : Nabilah Anindya*

Eru meminta agar semua **konfigurasi tidak hilang** saat semua node di-restart.

### Penjelasan Solusi
Untuk membuat konfigurasi menjadi permanen, perintah-perintah penting harus ditambahkan ke skrip startup. File `/root/.bashrc` adalah skrip yang dijalankan setiap kali shell login dibuka, sehingga cocok untuk memastikan konfigurasi diterapkan secara otomatis setelah reboot.

### Pada Router Eru
Perintah untuk menginstall iptables dan menerapkan aturan NAT dimasukkan ke `.bashrc`.

```bash
# Tambahkan di akhir file /root/.bashrc
apt update && apt upgrade -y
apt install -y iptables
iptables -t nat -A POSTROUTING -o eth0 MASQUERADE 192.214.0.0/16 
```
![](/images/5.1-bash.png)

### Pada setiap Client
Perintah untuk mengatur DNS server dimasukkan ke `.bashrc` agar tidak perlu diatur ulang setiap kali node menyala.

```bash
# Tambahkan di akhir file /root/.bashrc
echo nameserver 192.168.122.1 > /etc/resolv.conf
```

![](/images/5.2-node-lain.png)

---

## Soal 6
*By : Nabilah Anindya*

Lakukan **packet sniffing** pada koneksi antara Manwe dan Eru, lalu terapkan display filter untuk menampilkan semua paket dari atau menuju IP Address Manwe.

**Di node Manwe, jalankan script untuk membuat traffic**  
Mendownload file traffic terlebih dahulu
```bash
wget --no-check-certificate "https://docs.google.com/uc?export=download&id=1bE3kF1Nclw0VyKq4bL2VtOOt53IC7lG5" -O traffic.zip && 
unzip traffic.zip -d traffic && 
mv traffic/traffic.sh . && 
rm traffic.zip && rm -r traffic
```
![](/images/6.1.png)

Lalu memberikan izin eksekusi dan menjalankan file tersebut
```bash
chmod +x traffic.sh

# Sebelum menjalankan jangan lupa capture
./traffic.sh
```
![](/images/6.2-buat-traffic.png)

### Penjelasan Perintah
Skrip ini bertujuan untuk mengunduh, menyiapkan, dan menjalankan file yang akan menghasilkan lalu lintas jaringan untuk dianalisis.

- `wget --no-check-certificate "..." -O traffic.zip`: mengunduh file dari URL yang diberikan dan menyimpannya sebagai `traffic.zip`.
- `unzip traffic.zip -d traffic`: mengekstrak isi `traffic.zip` ke folder `traffic`.
- `mv traffic/traffic.sh .`: memindahkan `traffic.sh` ke direktori saat ini.
- `chmod +x traffic.sh`: memberikan izin eksekusi pada `traffic.sh`.
- `./traffic.sh`: menjalankan skrip untuk memulai pembuatan lalu lintas jaringan.

### Analisis Wireshark

![](/images/6.3.png)
Dengan menggunakan display filter:
```
ip.addr == 192.214.1.3
```
Wireshark hanya akan menampilkan paket di mana alamat IP sumber atau tujuannya adalah milik Manwe.


![](/images/6.4.png)

---

## Soal 7
*By : Nabilah Anindya*

Eru membuat **FTP Server** di node miliknya. Buat dua user: **ainur** dengan hak akses write&read dan **melkor** tanpa hak akses sama sekali ke direktori `shared`.

### Konfigurasi di node Eru
```bash
adduser ainur 
adduser melkor
mkdir -p /srv/ftp/shared
chown -R ainur:ainur /srv/ftp/shared
chmod 700 /srv/ftp/shared

# ubah konfigurasi
nano /etc/vsftpd.conf
    local_enable=YES
    write_enable=YES
    chroot_local_user=YES
    allow_writeable_chroot=YES

# Pastikan konfigurasi di /etc/vsftpd.conf sudah sesuai 
usermod -d /srv/ftp/shared ainur
service vsftpd restart
```
### Penjelasan Perintah di Eru
- `adduser ainur / adduser melkor`: membuat user baru di sistem.
- `mkdir -p /srv/ftp/shared`: membuat direktori untuk file-file FTP.
- `chown -R ainur:ainur /srv/ftp/shared`: mengubah kepemilikan direktori `shared` menjadi milik user `ainur`.
- `chmod 700 /srv/ftp/shared`: memberikan hak akses penuh hanya kepada pemilik (`ainur`).
- `usermod -d /srv/ftp/shared ainur`: menjadikan direktori `shared` sebagai home directory untuk user `ainur`.
- `service vsftpd restart`: memuat ulang konfigurasi server FTP.

### Pengujian

### Di node Eru
```bash
echo "halo" > /srv/ftp/shared/halo.txt
```
![](/images/7.1-echo.png)

### Di node Manwe
```bash
ftp 192.214.1.1
# login sebagai ainur, lalu coba perintah get
ftp> get halo.txt
# transfer akan complete, lalu coba bye
```
- Login sebagai **ainur**: berhasil login dan dapat mengunduh file (`get halo.txt`).
![](/images/7.4.png)
![](/images/7.3-get.png)
```bash
ftp 192.214.1.1
# login sebagai melkor, lalu coba perintah get
ftp> get halo.txt
# akan failed to open file
```
- Login sebagai **melkor**: berhasil login, tetapi gagal mengunduh file karena tidak memiliki hak akses baca ke direktori tersebut.
![](/images/7.4-melkor.png)


---

## Soal 8
*By : Nabilah Anindya*

Ulmo mengirimkan data ramalan cuaca ke FTP Server Eru. Analisis proses ini menggunakan Wireshark dan **identifikasi perintah FTP** yang digunakan untuk proses upload.

### Perintah di node Ulmo
```bash
wget --no-check-certificate "https://docs.google.com/uc?export=download&id=11ra_yTV_adsPIXeIPMSt0vrxCBZu0r33" -O cuaca.zip && unzip cuaca.zip 
```
Perintah tersebut untuk mendownload file, lalu dilanjut masuk ke FTP server Eru
```bash
ftp 192.214.2.1
# (Login sebagai user ainur)
# jangan lupa capture untuk menganalisis
put cuaca.txt 
put mendung.jpg 
```
### Penjelasan Perintah
- `ftp 192.214.2.1`: memulai koneksi sebagai client FTP ke server Eru.
- `put cuaca.txt`: perintah FTP untuk mengunggah (*put*) file bernama `cuaca.txt` dari client ke server.

![](/images/8.1-success.png)

### Perintah di node Eru
Cek keberadaan file di folder shared
```bash
ls -la /srv/ftp/shared/
```
![](/images/8.2.png)

### Analisis Wireshark
![](/images/8.3.png)
Saat proses upload, client FTP akan mengirimkan perintah **STOR** (Store) ke server. Perintah ini menginstruksikan server untuk menyimpan file yang akan dikirim oleh client.

---

## Soal 9
*By : Nabilah Anindya*

Eru membagikan "Kitab Penciptaan" kepada Manwe dan mengubah akses user **ainur** menjadi read-only. Uji akses dan identifikasi perintah FTP untuk download.

### Pengujian dari Eru
Mendownload file
```bash
wget --no-check-certificate "https://docs.google.com/uc?export=download&id=11ua2KgBu3MnHEIjhBnzqqv2RMEiJsILY" -O kitab_penciptaan.zip
unzip kitab_penciptaan.zip -d /srv/ftp/shared
```
![](/images/9.1-download.png)

Lalu mengubah hak akses
```bash
chmod 755 /srv/ftp/shared
chmod -R 744 /srv/ftp/shared/*
chown root:root /srv/ftp/shared
```
![](/images/9.2.png)
**Penjelasan :** 
- `chmod 755 /srv/ftp/shared`: Mengatur folder agar pemilik punya hak penuh, sementara pengguna lain hanya bisa melihat isinya.
- `chmod -R 744 /srv/ftp/shared/*`: Menjadikan semua file di dalamnya hanya bisa dibaca (read-only) oleh pengguna lain.
- `chown root:root /srv/ftp/shared`: Mengganti pemilik folder menjadi root, sehingga ainur tidak bisa lagi membuat/menghapus file.


### Pengujian dari Manwe
```bash
ftp 192.214.1.1
# login sebagai ainur
# jangan lupa capture manwe
get kitab_penciptaan.txt   # berhasil karena ainur masih memiliki hak baca
put coba.txt               # gagal: 553 Could not create file (hak tulis dicabut)
```
![](/images/9.3.png)

Dapat dilihat ainur dapat melakukan perintah `ls` namun tidak dapet melakukan perintah `put`

### Analisis Wireshark
Perintah FTP yang digunakan untuk proses download adalah **RETR** (Retrieve).
![](/images/9.4.png)

---


## Soal 10
*By : Nabilah Anindya*

Melkor melakukan serangan dengan mengirimkan **100 paket ping** ke server Eru. Amati hasilnya, catat packet loss dan average round trip time.

### Penjelasan Perintah
```bash
ping -c 100 192.214.1.1
```

Perintah ini mengirimkan 100 paket ICMP (`-c 100`) ke alamat IP Eru (`192.214.1.1`). Tujuannya adalah untuk membanjiri server dengan request dan melihat dampaknya pada kinerja.

### Hasil Analisis
![](/images/10-ping.png)

- **Packet Loss**: 0% packet loss. Ini berarti semua 100 paket yang dikirim berhasil diterima dan dibalas oleh Eru.
- **Average RTT**: Rata-rata waktu bolak-balik adalah **0.392 ms**.

### Kesimpulan
Serangan spam ping dengan 100 paket dalam lingkungan virtual ini tidak berpengaruh signifikan terhadap kinerja server Eru.

![](/images/soal-10.png)

---

## Soal 11
*By : Nabilah Anindya*

Buktikan kelemahan protokol **Telnet** dengan menangkap sesi login Eru ke Melkor dan menunjukkan username dan password sebagai plain text.

### Instalasi
```bash
apt install openbsd-inetd telnetd -y #[NODE MELKOR]
apt install telnet -y #[NODE ERU]
```

### Konfigurasi di Melkor (Server)
```bash
adduser jarkom
nano /etc/inetd.conf
# tambahkan ini
    telnet stream tcp nowait root /usr/sbin/tcpd /usr/sbin/telnetd  
service openbsd-inetd restart
ss -tulpn | grep :23
```
![](/images/11.1.png)
**Penjelasan :** 
-   **`apt install openbsd-inetd telnetd -y`**: Menginstal software yang dibutuhkan untuk menjalankan server Telnet.
-   **`adduser jarkom`**: Membuat user baru bernama `jarkom` yang akan digunakan untuk login.
-   **`nano /etc/inetd.conf`**: Mengaktifkan layanan Telnet dengan mengedit file konfigurasinya.
-   **`service openbsd-inetd restart`**: Menjalankan ulang layanan agar konfigurasi baru Telnet diterapkan.
-   **`ss -tulpn | grep :23`**: Memastikan server Telnet sudah aktif dan berjalan di port 23.


### Koneksi dari Eru (Client)
```bash
# jangan lupa capture melkor
telnet 192.214.1.2 
```
![](/images/11.2-telnet.png)

**Penjelasan :** 
-   **`apt install telnet -y`**: Menginstal program Telnet client di Eru agar bisa melakukan koneksi.
-   **`telnet 192.214.1.2`**: Memulai koneksi dari Eru ke server Telnet di Melkor.

### Analisis Wireshark

![](/images/11.3-pass.png)

Dengan menggunakan fitur **Follow TCP Stream** di Wireshark pada sesi Telnet, seluruh percakapan antara client dan server akan ditampilkan persis seperti yang dikirimkan. Di sana, kita bisa melihat username (`jarkom`) dan password diketik karakter per karakter.

### Penjelasan Kelemahan
Telnet adalah protokol komunikasi yang sangat tidak aman karena semua data, termasuk nama pengguna dan kata sandi, dikirim dalam bentuk teks biasa tanpa enkripsi. Siapa pun yang memantau jaringan (melakukan sniffing) dapat dengan mudah melihat informasi sensitif tersebut.

---

## Soal 12
*By : Nabilah Anindya*

Lakukan pemindaian port sederhana dari Eru ke Melkor menggunakan **Netcat (nc)** untuk memeriksa port 21, 80 (terbuka), dan 666 (tertutup).

### Setup Layanan di Melkor (untuk simulasi)
```bash
apt install vsftpd -y
service vsftpd start  # Membuka port 21
apt install -y apache2
service apache2 start # Membuka port 80
ss -tlnp | grep ':80'
ss -tulpn | grep :21
```
![](/images/12.1-listen-port.png)

### Di Node Melkor (Server)
Tujuannya adalah menyiapkan layanan agar port 21 dan 80 terbuka untuk dipindai.

- **`apt install vsftpd -y` & `service vsftpd start`**: Menginstal dan menjalankan server FTP untuk membuka **port 21**.
- **`apt install -y apache2` & `service apache2 start`**: Menginstal dan menjalankan server web untuk membuka **port 80**.
- **`ss -tlnp | grep ...`**: Memastikan bahwa port 21 (FTP) dan 80 (HTTP) sudah aktif dan siap menerima koneksi.

### Scanning dari Eru
```bash
nc -vz -w 2 192.214.1.2 21

nc -vz -w 2 192.214.1.2 80

nc -vz -w 2 192.214.1.2 666
```
### Penjelasan Perintah
- `nc -vz -w 2 <IP> <PORT>`: perintah Netcat untuk melakukan pemindaian.  
- `-v`: verbose, menampilkan informasi lebih detail.  
- `-z`: zero-I/O mode, hanya memindai status port tanpa mengirim data.  
- `-w 2`: waktu timeout 2 detik.

![](/images/12.2-nc.png)
Tujuannya adalah menggunakan Netcat (`nc`) untuk memeriksa status port di Melkor.

- **`apt install -y netcat-openbsd`**: Menginstal Netcat, program yang akan digunakan untuk memindai port.
- **`nc -vz -w 2 192.214.1.2 21`**: Memindai **port 21**; hasilnya akan `succeeded!` karena portnya terbuka.
- **`nc -vz -w 2 192.214.1.2 80`**: Memindai **port 80**; hasilnya akan `succeeded!` karena portnya juga terbuka.
- **`nc -vz -w 2 192.214.1.2 666`**: Memindai **port 666**; hasilnya akan `failed` karena tidak ada layanan yang berjalan di port ini.


---

## Soal 13
*By : Nabilah Anindya*

Setelah insiden Telnet, semua koneksi administratif harus menggunakan **SSH (Secure Shell)**. Lakukan koneksi dari Varda ke Eru dan jelaskan mengapa username dan password tidak dapat dilihat.

### Setup SSH Server di Eru
```bash
apt install -y openssh-server 
service ssh start 
ss -tlnp | grep ':22'
```
![](/images/13.1.png)

**Penjelasan :** 
- **`apt install -y openssh-server`**: Menginstal `openssh-server`, software yang dibutuhkan untuk menjalankan server SSH.
- **`service ssh start`**: Menjalankan layanan SSH agar server siap menerima koneksi.
- **`ss -tlnp | grep ':22'`**: Memastikan bahwa server SSH sudah aktif dan berjalan di port 22.

### Koneksi dari Varda
```bash
# jangan lupa capture varda
ssh ainur@192.214.1.1 
```
![](/images/13.2-ssh.png)

**Penjelasan :** 

Tujuannya adalah melakukan koneksi ke server SSH yang sudah disiapkan.

- **`ssh ainur@192.214.1.1`**: Memulai koneksi SSH yang terenkripsi dari Varda ke server Eru dengan menggunakan user `ainur`.
### Analisis Wireshark
![](/images/13.3-capture.png)

Saat sesi SSH ditangkap, kita tidak dapat melihat informasi login. Paket-paket data setelah handshake awal akan diberi label **"Encrypted packet"**. Ini membuktikan bahwa data tersebut terlindungi dan tidak bisa dibaca oleh pihak ketiga, sangat kontras dengan Telnet.

### Penjelasan Keamanan SSH
SSH adalah protokol yang aman karena mengenkripsi seluruh sesi komunikasi antara client dan server. Proses ini dimulai dengan handshake di mana kedua belah pihak bertukar kunci enkripsi. Setelah koneksi aman terbentuk, semua data, termasuk otentikasi (username dan password) dan perintah yang dijalankan, dienkripsi sebelum dikirim.



---

## 14.Setelah insiden penyadapan Telnet, Eru memerintahkan semua koneksi administratif harus menggunakan SSH (Secure Shell) untuk mengamankan jaringan. Lakukan koneksi SSH dari node Varda ke Eru. Tangkap sesi tersebut menggunakan Wireshark. Analisis dan jelaskan mengapa username dan password tidak dapat dilihat seperti pada sesi Telnet. Tunjukkan paket-paket terenkripsi dalam hasil capture sebagai bukti keamanan SSH.

<img width="641" height="337" alt="image" src="https://github.com/user-attachments/assets/98c87bca-399a-4af1-a967-ba3cda9e93ae" />

1. Lihat jumlah packet di bagian bawah wireshark. 
2. terapkan filter http dan scroll ke bawah dikarenakan ini bruteforce. Anda bisa lihat di bawah ini:
   
   <img width="835" height="353" alt="image" src="https://github.com/user-attachments/assets/7b932543-68d2-463d-aea9-c32ca40a1eb6" />
   
3. Lihat packet di atasnya akan mengandung username dan password.

    <img width="690" height="389" alt="image" src="https://github.com/user-attachments/assets/2a668446-e8a9-4448-8b7f-17da32c2ceab" />

4. Klik paket dan follow tcp stream dan hasil akan menampilkan 41824.
5. Hasil dari TCP stream akan menampilkan tools yang digunakan.

<img width="893" height="488" alt="image" src="https://github.com/user-attachments/assets/2304e1fe-a28e-490f-9041-326cf43dc308" />

## 15. Melkor menyusup ke ruang server dan memasang keyboard USB berbahaya pada node Manwe. Buka file capture dan identifikasi pesan atau ketikan (keystrokes) yang berhasil dicuri oleh Melkor untuk menemukan password rahasia.
(link file) nc 10.15.43.32 3402

1. What device did Melkor use?
<img width="536" height="135" alt="image" src="https://github.com/user-attachments/assets/4fe9aec4-f34d-42f2-9901-d421bfa1b42e" />

Cara:
Gunakan filter _ws.col.info == "GET DESCRIPTOR Response STRING" lalu Anda akan menemukan paket seperti ini:

<img width="607" height="84" alt="image" src="https://github.com/user-attachments/assets/ed647a6b-4354-4483-a2a6-5f1854afe51d" />

2. What did Melkor Write?

<img width="895" height="180" alt="image" src="https://github.com/user-attachments/assets/048e3a0d-2d87-4ff5-9cc1-1bfebc0effbd" />

Cara:
Gunakan filter usbhid.data lalu export as csv. Upload CSV file ke ChatGPT untuk mendapatkan HID Data nya saja dalam bentuk txt. Lalu Gunakan HID Data decoder untuk decode hid_data.txt. Setelah itu, hasil decode adalah base64 yang mana akan didecode lagi dan menghasilkan pesan di atas.

## 16. Melkor semakin murka ia meletakkan file berbahaya di server milik Manwe. Dari file capture yang ada, identifikasi file apa yang diletakkan oleh Melkor.
(link file) nc 10.15.43.32 3403

<img width="891" height="621" alt="image" src="https://github.com/user-attachments/assets/aa050842-b64f-459f-bf59-69cf32716072" />

<img width="894" height="165" alt="image" src="https://github.com/user-attachments/assets/3ace0c40-efc2-4ba0-8b8a-476af99171f7" />

Cara:
1. Terapkan filter FTP lalu Anda akan menemukan username dan password di bawah ini:

2. Terapkan Filter tcp contains “.exe” maka akan terlihat file exe tersembunyi\
   
<img width="682" height="206" alt="image" src="https://github.com/user-attachments/assets/32ac2abc-728e-4581-9799-17c1754e158d" />

3. Notes Stream Index: q = 2, w = 3, e = 4, r = 5, t = 6
Terapkan filter berikut: ftp-data && tcp.stream eq N (Ganti N dengan Stream Index dari setiap huruf.exe). Lalu, akan menampilkan seperti ini:

<img width="579" height="250" alt="image" src="https://github.com/user-attachments/assets/7be9bec8-6b36-4656-a3a5-5c1dc53fab14" />

Klik kanan lalu follow TCP Stream, Lalu pilih show as Raw

<img width="612" height="316" alt="image" src="https://github.com/user-attachments/assets/80c26e8d-e18b-4133-a783-a382dc09212d" />

Save as [huruf].exe di linux.
4. Lalu gunakan command sha256sum [huruf].exe di linux untuk mendapatkan hash.

## 17. Manwe membuat halaman web di node-nya yang menampilkan gambar cincin agung. Melkor yang melihat web tersebut merasa iri sehingga ia meletakkan file berbahaya agar web tersebut dapat dianggap menyebarkan malware oleh Eru. Analisis file capture untuk menggagalkan rencana Melkor dan menyelamatkan web Manwe.
(link file) nc 10.15.43.32 3404
1. What is the name of the first suspicious file?

<img width="835" height="114" alt="image" src="https://github.com/user-attachments/assets/c0fdccc7-6ca8-482a-8d9a-4b2282a2e8e7" />

Cara:
Gunakan filter: http contains ".exe" || smb2.filename contains ".exe"
maka Anda akan menemukan paket ini:

<img width="902" height="68" alt="image" src="https://github.com/user-attachments/assets/5a4b1270-8b72-4c65-a4ba-e48bde6ca498" />

Klik Follow TCP Stream lalu Tekan File > Export Objects > HTTP

<img width="891" height="655" alt="image" src="https://github.com/user-attachments/assets/ada332c0-aba5-4ff2-a98a-7525dc80c799" />

2. What is the name of the second suspicious file?
   
<img width="888" height="103" alt="image" src="https://github.com/user-attachments/assets/cc3753df-1aba-4b20-b6a0-4e72b39eb48d" />

Cara:
Input dari hasil Export Objects > HTTP
3. What is the hash of the second suspicious file (knr.exe)?
Cara:
Save file ke linux lalu gunakan command sha256sum knr.exe maka Anda akan mendapatkan sha256sum dari knr.exe seperti ini: 
749e161661290e8a2d190b1a66469744127bc25bf46e5d0c6f2e835f4b92db18

## 18. Karena rencana Melkor yang terus gagal, ia akhirnya berhenti sejenak untuk berpikir. Pada saat berpikir ia akhirnya memutuskan untuk membuat rencana jahat lainnya dengan meletakkan file berbahaya lagi tetapi dengan metode yang berbeda. Gagalkan lagi rencana Melkor dengan mengidentifikasi file capture yang disediakan agar dunia tetap aman.
(link file) nc 10.15.43.32 3405

<img width="904" height="279" alt="image" src="https://github.com/user-attachments/assets/b9dd429b-9d82-489c-86d4-09cd3dfece4e" />

Cara:
1. File > Export Object > SMB

<img width="896" height="336" alt="image" src="https://github.com/user-attachments/assets/eb9c9030-409a-486f-85bb-ea165db2518d" />

Bisa terlihat bahwa terdapat dua file exe dan ada nama dari file tersebut.

2. Hash dari nama kedua file exe
   
<img width="825" height="148" alt="image" src="https://github.com/user-attachments/assets/6c32e484-8c0a-4f78-b9c1-d5b3767f24ed" />

Kedua file disave di linux dan gunakan command sha256sum <namafile> lalu akan muncul hasilnya.

## 19. Manwe mengirimkan email berisi surat cinta kepada Varda melalui koneksi yang tidak terenkripsi. Melihat hal itu Melkor sipaling jahat langsung melancarkan aksinya yaitu meneror Varda dengan email yang disamarkan. Analisis file capture jaringan dan gagalkan lagi rencana busuk Melkor.
	(link file) nc 10.15.43.32 3406
1. Cara:
Terapkan display filter: smtp lalu cari konten yang berisi ancaman pada kolom info seperti di bawah ini:

<img width="897" height="14" alt="image" src="https://github.com/user-attachments/assets/c4d9ce4a-8a1e-4552-8317-770352f1bc68" />

Dapat dilihat nama pengirimnya Your Life dan dia mengirim pesan ancaman

<img width="907" height="256" alt="image" src="https://github.com/user-attachments/assets/54fefacb-8d83-4fd4-bf18-2c14a7bf824a" />

Buka paket dan lihat line based text data, di situ terdapat data-data yang kita butuhkan untuk menjawab pertanyaan seperti jumlah ransom yang diminta, bitcoin walletnya

<img width="572" height="172" alt="image" src="https://github.com/user-attachments/assets/cd69a3a2-7194-4900-b643-76930f508318" />

<img width="890" height="87" alt="image" src="https://github.com/user-attachments/assets/74bb341c-3a20-4724-95e1-66a567b783c3" />

## 20. Untuk yang terakhir kalinya, rencana besar Melkor yaitu menanamkan sebuah file berbahaya kemudian menyembunyikannya agar tidak terlihat oleh Eru. Tetapi Manwe yang sudah merasakan adanya niat jahat dari Melkor, ia menyisipkan bantuan untuk mengungkapkan rencana Melkor. Analisis file capture dan identifikasi kegunaan bantuan yang diberikan oleh Manwe untuk menggagalkan rencana jahat Melkor selamanya.
(link file) nc 10.15.43.32 3407

<img width="899" height="322" alt="image" src="https://github.com/user-attachments/assets/13c5b86c-a799-4c03-97ff-bc51a6d9740c" />

Cara:
1. Gunakan filter tls && tls.handshake.type == 2 untuk melihat paket TLS handshake bertipe “Server Hello”.

<img width="699" height="264" alt="image" src="https://github.com/user-attachments/assets/ae39bec2-95d1-4292-9082-f9c4e81d118a" />

Bisa dilihat bahwa encryption method yang digunakan adalah TLS.
2. Pada bagian ini kita menggunakan log file yang sudah disediakan. Pertama, klik edit lalu preferences, pada bagian protocol drop down ke bagian TLS lalu (Pre)-master-log-filename kita isi dengan log file yang sudah disediakan pada link.

<img width="746" height="551" alt="image" src="https://github.com/user-attachments/assets/cb18a707-8a7e-4bef-b990-72f4eb5447e9" />

Klik ok dan bisa dilihat bahwa ada perubahan dalam list packets.
Setelah itu, buka file lalu klik Export Object > HTTP..

<img width="807" height="587" alt="image" src="https://github.com/user-attachments/assets/d5fc9606-2e5a-4750-94b2-f7d9dcb7b5ed" />

Bisa dilihat terdapat file yang paling besar sizenya yaitu invest_20.dll
3. Save invest_20.dll ke linux lalu gunakan command sha256sum invest_20.dll

<img width="892" height="73" alt="image" src="https://github.com/user-attachments/assets/a59227c2-209e-4089-852b-867a735bfe6b" />
















