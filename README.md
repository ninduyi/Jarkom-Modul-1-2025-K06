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











