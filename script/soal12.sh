# Eru mencurigai Melkor menjalankan beberapa layanan terlarang di node-nya. Lakukan pemindaian port sederhana dari node Eru ke node Melkor menggunakan Netcat (nc) untuk memeriksa port 21, 80, dalam keadaan terbuka dan port rahasia 666 dalam keadaan tertutup.


# ===================== NODE MELKOR ====================

# Install vsftpd
apt install vsftpd -y
# Start vsftpd service
service vsftpd start

# Install apache2
apt install -y apache2
# Start apache2 service
service apache2 start

# Cek listening port
ss -tlnp | grep ':80'
ss -tulpn | grep :21
ss -tulpn | grep :666

# ===================== NODE ERU =====================

# Install netcat
apt install -y netcat-openbsd

# Cek port 21, 80, 666 
nc -vz -w 2 192.214.1.2 21
nc -vz -w 2 192.214.1.2 80
nc -vz -w 2 192.214.1.2 666
