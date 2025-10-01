# INSTALASI
apt install openbsd-inetd telnetd -y [NODE MELKOR]
apt install telnet -y [NODE ERU]

# ===================== NODE MELKOR ====================

# Membuat user jarkom
adduser jarkom
# Set password jarkom

# Konfigurasi telnet di /etc/inetd.conf
nano /etc/inetd.conf
    telnet stream tcp nowait root /usr/sbin/tcpd /usr/sbin/telnetd #tambahkan ini

# Restart service inetd
service openbsd-inetd restart

# Cek apakah telnet sudah berjalan
ss -tulpn | grep :23

# ===================== NODE ERU =====================

# Telnet ke melkor
telnet 192.214.1.2

# Login dengan user jarkom
# user: jarkom
# pass: aaa