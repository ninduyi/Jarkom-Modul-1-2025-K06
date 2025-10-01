# ===================== NODE ERU =====================

# Instalasi
apt update
apt install vsftpd -y

# Membuat user ftp
adduser ainur
adduser melkor

# Membuat direktori untuk ftp
mkdir -p /srv/ftp/shared

# Set permission direktori ftp
chown -R ainur:ainur /srv/ftp/shared
chmod 700 /srv/ftp/shared

# Konfigurasi vsftpd
nano /etc/vsftpd.conf
    local_enable=YES
    write_enable=YES
    chroot_local_user=YES
    allow_writeable_chroot=YES

# Restart service vsftpd
service vsftpd restart

# Atur home directory khusus user ainur agar diarahkan ke /srv/ftp/shared
usermod -d /srv/ftp/shared ainur

# Coba membuat file di direktori shared 
echo "halo" > /srv/ftp/shared/halo.txt


# ==================== NODE MANWE =====================

# Instalasi ftp client
apt install ftp -y

# Coba koneksi ke server ftp eru
ftp 192.214.1.1

# Login dengan user ainur
# user: ainur
# pass: aaa
ftp> ls
# halo.txt
ftp> get halo.txt
# transfer complete
ftp> bye
# Goodbye

# Login dengan user melkor
# user: melkor
# pass: aaa
ftp> ls
# tidak ada file
ftp> get halo.txt
# 550 halo.txt Failed to open file.
ftp> bye
# Goodbye
