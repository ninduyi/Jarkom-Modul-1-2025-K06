# Jarkom-Modul-1-2025-K06
1. Untuk mempersiapkan pembuatan entitas selain mereka, Eru yang berperan sebagai Router membuat dua Switch/Gateway. Dimana Switch 1 akan menuju ke dua Ainur yaitu Melkor dan Manwe. Sedangkan Switch 2 akan menuju ke dua Ainur lainnya yaitu Varda dan Ulmo. Keempat Ainur tersebut diberi perintah oleh Eru untuk menjadi Client.

intinya : 
Router (Eru) bikin 2 Switch
Switch 1 => Melkor & Manwe (as Client)
Switch 2 => Varda & Ulmo (as Client)

	SCREENSHOT : 

<img width="749" height="501" alt="image" src="https://github.com/user-attachments/assets/962767f2-dd7e-4d71-a08f-8bac84ffff9f" />


2. Karena menurut Eru pada saat itu Arda (Bumi) masih terisolasi dengan dunia luar, maka buat agar Eru dapat tersambung ke internet.

caranya : 
	Tambahkan NAT
	ping google.com

Node NAT digunakan sebagai penghubung antara jaringan virtual GNS3 dan jaringan Internet. Tanpa NAT, router Eru hanya berfungsi menghubungkan client dalam jaringan lokal, tetapi tidak dapat meneruskan paket ke luar.

	SCREENSHOT : 
Sebelum menambahkan NAT :  
<img width="711" height="48" alt="image" src="https://github.com/user-attachments/assets/027e3c63-c9a2-42de-8b1c-60e17293b446" />  
Sesudah ditambahkan:  
<img width="628" height="458" alt="image" src="https://github.com/user-attachments/assets/f5683653-35cc-4bb8-b398-62c3f9b16a4d" />  
<img width="802" height="161" alt="image" src="https://github.com/user-attachments/assets/931c63d5-64ec-4fcb-8869-104eec214794" />  
3. Sekarang pastikan agar setiap Ainur (Client) dapat terhubung satu sama lain.  
<img width="505" height="475" alt="image" src="https://github.com/user-attachments/assets/fef55ca9-6366-4417-b2fc-21631003f9f6" />

Config Eru
```
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

Config Melkor
```
auto eth0
iface eth0 inet static
	address 192.214.1.2
	netmask 255.255.255.0
	gateway 192.214.1.1
```
Config Manwe
```
auto eth0
iface eth0 inet static
	address 192.214.1.3
	netmask 255.255.255.0
	gateway 192.214.1.1
```
Config Varda
```
auto eth0
iface eth0 inet static
	address 192.214.2.2
	netmask 255.255.255.0
	gateway 192.214.2.1
```
Config Ulmo
```
auto eth0
iface eth0 inet static
	address 192.214.2.3
	netmask 255.255.255.0
	gateway 192.214.2.1
```  

4. Setelah berhasil terhubung, sekarang Eru ingin agar setiap Ainur (Client) dapat mandiri. Oleh karena itu pastikan agar setiap Client dapat tersambung ke internet.  
Router Eru
Ketikkan iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s [Prefix IP].0.0/16  
<img width="810" height="249" alt="image" src="https://github.com/user-attachments/assets/cbd6790b-e927-4c51-9820-990945c40e44" />
Ketikkan command cat /etc/resolv.conf di Eru  
<img width="438" height="43" alt="image" src="https://github.com/user-attachments/assets/6965a20f-4619-4dd8-9321-e6336ed217a8" />
Lalu ketikkan command
```
echo nameserver 192.168.122.1 > /etc/resolv.conf
```
pada node yang lainnya 





















