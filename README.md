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
- Node Melkor  
<img width="656" height="54" alt="image" src="https://github.com/user-attachments/assets/ef8b93e8-0e1d-4fb6-a581-f8b7768adce4" />  
- Node Manwe  
<img width="653" height="57" alt="image" src="https://github.com/user-attachments/assets/acd46a0d-a16f-4b33-be85-b1e984997961" />  
- Node Varda  
<img width="655" height="57" alt="image" src="https://github.com/user-attachments/assets/2a5be5da-5f41-41dd-9efc-ccb46da50c21" />  
- Node Ulmo  
<img width="653" height="56" alt="image" src="https://github.com/user-attachments/assets/693e9f7f-3ca4-4df6-99fe-9cedeef8001a" />  

Coba ping google.com  
<img width="817" height="165" alt="image" src="https://github.com/user-attachments/assets/dab11896-435a-4ce9-966b-f18e99e368bd" />  


## 5. 




