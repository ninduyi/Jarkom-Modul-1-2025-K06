# ============ ROUTER ERU ============
# iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s [Prefix IP].0.0/16
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.214.0.0/16

# Ketikkan command cat /etc/resolv.conf di Eru
cat /etc/resolv.conf

# Lalu ketikkan command 
echo nameserver 192.168.122.1 > /etc/resolv.conf
# pada node yang lainnya (Melkor, Manwe, Varda, Ulmo)

# Cek dengan ping google.com
ping -c 5 google.com