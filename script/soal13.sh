# Setelah insiden penyadapan Telnet, Eru memerintahkan semua koneksi administratif harus menggunakan SSH (Secure Shell) untuk mengamankan jaringan. Lakukan koneksi SSH dari node Varda ke Eru. Tangkap sesi tersebut menggunakan Wireshark. Analisis dan jelaskan mengapa username dan password tidak dapat dilihat seperti pada sesi Telnet. Tunjukkan paket-paket terenkripsi dalam hasil capture sebagai bukti keamanan SSH.


# ===================== NODE ERU ====================

# Install OpenSSH server
apt install -y openssh-server

# Start SSH service
service ssh start

# Cek listening port
ss -tlnp | grep ':22'

# ===================== NODE VARDA ====================

ssh ainur@192.214.1.1

# user: ainur
# pass: aaa

# Cek di wireshark