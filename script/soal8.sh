
# Jika jaringan terputus, kita harus ulang bagian no 7 yang 
# membuat user, membuat folder shared dan atur config

# ==================== NODE ERU =====================
service vsftpd start

# ==================== NODE ULMO =====================

# Download file zip berisi 2 file mendung.png dan cuaca.txt
wget --no-check-certificate "https://docs.google.com/uc?export=download&id=11ra_yTV_adsPIXeIPMSt0vrxCBZu0r33" -O cuaca.zip
unzip cuaca.zip -d cuaca
mv cuaca/mendung.png .
mv cuaca/cuaca.txt .
rm -r cuaca
rm cuaca.zip

# Login ke ftp server eru
ftp 192.214.2.1
# user: ainur
# pass: aaa
ftp> put mendung.png
# transfer complete
ftp> put cuaca.txt
# transfer complete

# Cek di eru
ls -la /srv/ftp/shared
# terdapat 2 file mendung.png dan cuaca.txt