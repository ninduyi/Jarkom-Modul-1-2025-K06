# ===================== NODE MANWE =====================

# Instalasi
apt update 
apt install unzip

# Download file & unzip serta hapus file tidak perlu
wget --no-check-certificate "https://docs.google.com/uc?export=download&id=1bE3kF1Nclw0VyKq4bL2VtOOt53IC7lG5" -O traffic.zip && 
unzip traffic.zip -d traffic && 
mv traffic/traffic.sh . && 
rm traffich.zip && rm -r traffic

# Ubah permission file traffic.sh
chmod +x traffic.sh

# Jalankan script traffic.sh
./traffic.sh 
