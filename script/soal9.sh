# ==================== NODE ERU =====================

# Dowload file kitab_penciptaan.zip
wget --no-check-certificate "https://docs.google.com/uc?export=download&id=11ua2KgBu3MnHEIjhBnzqqv2RMEiJsILY" -O kitab_penciptaan.zip

# Unzip file kitab_penciptaan.zip
unzip kitab_penciptaan.zip -d kitab_penciptaan

# Pindahkan semua file dari dalam folder kitab_penciptaan ke /srv/ftp/shared
chmod 755 /srv/ftp/shared
chmod -R 744 /srv/ftp/shared/*
chown root:root /srv/ftp/shared

# ==================== NODE MANWE =====================

# Login ke ftp server eru
ftp 192.214.1.1

# user: ainur
# pass: aaa

# Coba get kitab_penciptaan.txt
ftp> get kitab_penciptaan.txt
# transfer complete

# Coba put kitab_penciptaan.txt
ftp> put kitab_penciptaan.txt
# 553 Could not create file.