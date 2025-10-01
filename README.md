# Jarkom Modul 1 - 2025 K06

## 1. Topologi Dasar
Untuk mempersiapkan pembuatan entitas selain mereka, **Eru** yang berperan sebagai Router membuat dua **Switch/Gateway**:

- **Switch 1** → menuju ke dua Ainur yaitu **Melkor** dan **Manwe**.  
- **Switch 2** → menuju ke dua Ainur lainnya yaitu **Varda** dan **Ulmo**.  

Keempat Ainur tersebut diberi perintah oleh Eru untuk menjadi **Client**.  

**Intinya:**  
Router (**Eru**) → 2 Switch  
- Switch 1 → Melkor & Manwe (Client)  
- Switch 2 → Varda & Ulmo (Client)  

**Screenshot:**  
<img width="749" height="501" alt="image" src="https://github.com/user-attachments/assets/962767f2-dd7e-4d71-a08f-8bac84ffff9f" />

---

## 2. Koneksi Router ke Internet
Karena Arda (Bumi) masih terisolasi, Eru harus dapat tersambung ke internet.  

**Langkah:**
- Tambahkan **NAT**.  
- Uji dengan `ping google.com`.  

Node **NAT** digunakan sebagai penghubung antara jaringan virtual GNS3 dan jaringan Internet.  
Tanpa NAT, router Eru hanya menghubungkan client dalam jaringan lokal, tetapi tidak bisa meneruskan paket keluar.

**Screenshot:**  
Sebelum menambahkan NAT:  
<img width="711" height="48" alt="image" src="https://github.com/user-attachments/assets/027e3c63-c9a2-42de-8b1c-60e17293b446" />  

Sesudah ditambahkan:  
<img width="628" height="458" alt="image" src="https://github.com/user-attachments/assets/f5683653-35cc-4bb8-b398-62c3f9b16a4d" />  
<img width="802" height="161" alt="image" src="https://github.com/user-attachments/assets/931c63d5-64ec-4fcb-8869-104eec214794" />  

---

## 3. Koneksi Antar Client
Pastikan agar setiap **Ainur (Client)** dapat saling terhubung.  

**Screenshot:**  
<img width="505" height="475" alt="image" src="https://github.com/user-attachments/assets/fef55ca9-6366-4417-b2fc-21631003f9f6" />  

### Config Router (Eru)
```bash
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
    address 192.214.1.1
    netmask 255.255.255.0

auto eth2
iface eth2 inet static
    address 192.214.2.1
    netmask 255.255.255.0
```

Config Client

Melkor
```
auto eth0
iface eth0 inet static
    address 192.214.1.2
    netmask 255.255.255.0
    gateway 192.214.1.1
```

Manwe
```
auto eth0
iface eth0 inet static
    address 192.214.1.3
    netmask 255.255.255.0
    gateway 192.214.1.1
```

Varda
```
auto eth0
iface eth0 inet static
    address 192.214.2.2
    netmask 255.255.255.0
    gateway 192.214.2.1

```

Ulmo
```
auto eth0
iface eth0 inet static
    address 192.214.2.3
    netmask 255.255.255.0
    gateway 192.214.2.1
```

## 4. Client Tersambung ke Internet

Setelah berhasil terhubung, sekarang Eru ingin agar setiap Ainur (Client) dapat mandiri. Oleh karena itu pastikan agar setiap Client dapat tersambung ke internet.
Router Eru
```
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s [Prefix IP].0.0/16
```
Screenshot:  
<img width="810" height="249" alt="image" src="https://github.com/user-attachments/assets/cbd6790b-e927-4c51-9820-990945c40e44" />  
Cek DNS di Eru:  
```
cat /etc/resolv.conf
```
<img width="438" height="43" alt="image" src="https://github.com/user-attachments/assets/6965a20f-4619-4dd8-9321-e6336ed217a8" />  

Kemudian pada setiap node client jalankan:  

```
echo nameserver 192.168.122.1 > /etc/resolv.conf
```
Setelah konfigurasi, setiap node client dapat terkoneksi ke internet.

Node Melkor

<img width="656" height="54" alt="image" src="https://github.com/user-attachments/assets/ef8b93e8-0e1d-4fb6-a581-f8b7768adce4" />

Node Manwe

<img width="653" height="57" alt="image" src="https://github.com/user-attachments/assets/acd46a0d-a16f-4b33-be85-b1e984997961" />

Node Varda

<img width="655" height="57" alt="image" src="https://github.com/user-attachments/assets/2a5be5da-5f41-41dd-9efc-ccb46da50c21" />

Node Ulmo

<img width="653" height="56" alt="image" src="https://github.com/user-attachments/assets/693e9f7f-3ca4-4df6-99fe-9cedeef8001a" />  

Uji Coba ping google.com

<img width="817" height="165" alt="image" src="https://github.com/user-attachments/assets/dab11896-435a-4ce9-966b-f18e99e368bd" />


## 5. Ainur terkuat Melkor tetap berusaha untuk menanamkan kejahatan ke dalam Arda (Bumi). Sebelum terjadi kerusakan, Eru dan para Ainur lainnya meminta agar semua konfigurasi tidak hilang saat semua node di restart.
Eru  

<img width="654" height="507" alt="image" src="https://github.com/user-attachments/assets/1e56eb6e-ced3-4d56-a9ad-377ce994a68f" />

Node lainnya

<img width="650" height="469" alt="image" src="https://github.com/user-attachments/assets/d9c42532-347a-4a78-9e72-3e6442477283" />

## 6. Setelah semua Ainur terhubung ke internet, Melkor mencoba menyusup ke dalam komunikasi antara Manwe dan Eru. Jalankan file berikut (link file) lalu lakukan packet sniffing menggunakan Wireshark pada koneksi antara Manwe dan Eru, lalu terapkan display filter untuk menampilkan semua paket yang berasal dari atau menuju ke IP Address Manwe. Simpan hasil capture tersebut sebagai bukti.

- Manwe
  
```
apt update 
apt install unzip
wget --no-check-certificate "https://docs.google.com/uc?export=download&id=1bE3kF1Nclw0VyKq4bL2VtOOt53IC7lG5" -O traffic.zip && 
unzip traffic.zip -d traffic && 
mv traffic/traffic.sh . && 
rm -r 6 && rm -r traffic
```

<img width="711" height="272" alt="image" src="https://github.com/user-attachments/assets/4dc78e9a-6c9f-4857-8c3e-d3603e9e2b89" />


```
chmod +x traffic.sh
./traffic.sh
```

<img width="517" height="67" alt="image" src="https://github.com/user-attachments/assets/b4c05c54-cee1-470e-86c5-6e04f877fdaf" />

- **Start capture Switch 1 => Eru**

<img width="650" height="405" alt="image" src="https://github.com/user-attachments/assets/4684428b-a23b-4aa0-ab8e-9d315281a7ed" />

- **ip.addr == [ip manwe] || ip.addr == 192.214.1.3**

<img width="755" height="474" alt="image" src="https://github.com/user-attachments/assets/3c0d3e62-dddd-4b14-baa7-f7eb84daf190" />

## 7. Untuk meningkatkan keamanan, Eru memutuskan untuk membuat sebuah FTP Server di node miliknya. Lakukan konfigurasi FTP Server pada node Eru. Buat dua user baru: ainur dengan hak akses write&read dan melkor tanpa hak akses sama sekali ke direktori shared. Buktikan hasil tersebut dengan membuat file teks sederhana kemudian akses file tersebut menggunakan kedua user.

**ERU**

```
adduser ainur
adduser melkor
mkdir -p /srv/ftp/shared
chown -R ainur:ainur /srv/ftp/shared
chmod 700 /srv/ftp/shared
nano /etc/vsftpd.conf
local_enable=YES
write_enable=YES
chroot_local_user=YES
allow_writeable_chroot=YES
service vsftpd restart
Atur home directory khusus user ainur:
usermod -d /srv/ftp/shared ainur
```
**Pengujian di Node Manwe (client FTP)**

<img width="692" height="56" alt="image" src="https://github.com/user-attachments/assets/14265408-5c14-4e50-bb2a-041978bae064" />

<img width="760" height="270" alt="image" src="https://github.com/user-attachments/assets/70c32847-1cda-423a-b5e2-a013ee55e4a1" />

<img width="718" height="153" alt="image" src="https://github.com/user-attachments/assets/f01cb909-e271-40a5-aa85-453633168860" />

<img width="596" height="346" alt="image" src="https://github.com/user-attachments/assets/08c99d09-6e02-44c7-bcf9-432347ae40d6" />


## 8. Ulmo, sebagai penjaga perairan, perlu mengirimkan data ramalan cuaca ke node Eru. Lakukan koneksi sebagai client dari node Ulmo ke FTP Server Eru menggunakan user ainur. Upload sebuah file berikut (link file). Analisis proses ini menggunakan Wireshark dan identifikasi perintah FTP yang digunakan untuk proses upload.

```
wget --no-check-certificate "https://docs.google.com/uc?export=download&id=11ra_yTV_adsPIXeIPMSt0vrxCBZu0r33" -O cuaca.zip


	capture ulmo dan eru

file e di ulmo

masuk lewat ulmo tp sebagai eru (pake ip eru)

ftp ainur
ls itu gada apa”
terus put cuaca
ls 
cuaca

 ulmo
apt update
apt install inetutils-ftp

```

## 9. Eru ingin membagikan "Kitab Penciptaan" di (link file) kepada Manwe. Dari FTP Server Eru, download file tersebut ke node Manwe. Karena Eru merasa Kitab tersebut sangat penting maka ia mengubah akses user ainur menjadi read-only. Gunakan Wireshark untuk memonitor koneksi, identifikasi perintah FTP yang digunakan, dan uji akses user ainur.

- file punya eru
- DARI SINI BUKA WIRESHARK switch 1 & manwe
- node manwe -> ftp eru -> login ainur -> get kitab
- ubah akses ainur read only lewat eru
- node manwe -> ftp eru -> login ainur -> get kitab atau delete/put

```

kitab punya eru (download link ke eru)

baru download dari manwe pake ftp


wget --no-check-certificate "https://docs.google.com/uc?export=download&id=11ua2KgBu3MnHEIjhBnzqqv2RMEiJsILY" -O kitab_ciptaan.zip
ini di shared folder

capture
ftp ip
ftp> get kitab_ciptaan.zip
local: kitab_ciptaan.zip remote: kitab_ciptaan.zip
229 Entering Extended Passive Mode (|||41034|)
150 Opening BINARY mode data connection for kitab_ciptaan.zip (704 bytes).
100% |*******************************|   704        4.06 MiB/s    00:00 ETA
226 Transfer complete.
704 bytes received in 00:00 (856.16 KiB/s)

chmod 400 folder shared

```

## 10. Melkor yang marah karena tidak diberi akses, mencoba melakukan serangan dengan mengirimkan banyak sekali request ke server Eru. Gunakan command ping dari node Melkor ke node Eru dengan jumlah paket yang tidak biasa (spam ping misalnya 100 paket). Amati hasilnya, apakah ada packet loss? Catat average round trip time untuk melihat apakah serangan tersebut mempengaruhi kinerja Eru.

```
wireshark melkor dan switch
pingggg

```

## 11. Sebelum era koneksi aman, Eru sering menyelinap masuk ke wilayah Melkor. Eru perlu masuk ke node tersebut untuk memeriksa konfigurasi, namun ia tahu Melkor mungkin sedang memantau jaringan. Buktikan kelemahan protokol Telnet dengan membuat akun dan password baru di node Melkor kemudian menangkap sesi login Eru ke node Melkor menggunakan Wireshark. Tunjukkan bagaimana username dan password dapat terlihat sebagai plain text. 


## 12. Eru mencurigai Melkor menjalankan beberapa layanan terlarang di node-nya. Lakukan pemindaian port sederhana dari node Eru ke node Melkor menggunakan Netcat (nc) untuk memeriksa port 21, 80, dalam keadaan terbuka dan port rahasia 666 dalam keadaan tertutup.


## 13. Setelah insiden penyadapan Telnet, Eru memerintahkan semua koneksi administratif harus menggunakan SSH (Secure Shell) untuk mengamankan jaringan. Lakukan koneksi SSH dari node Varda ke Eru. Tangkap sesi tersebut menggunakan Wireshark. Analisis dan jelaskan mengapa username dan password tidak dapat dilihat seperti pada sesi Telnet. Tunjukkan paket-paket terenkripsi dalam hasil capture sebagai bukti keamanan SSH.


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








