
# Config Eru
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

# Config Melkor
auto eth0
iface eth0 inet static
	address 192.214.1.2
	netmask 255.255.255.0
	gateway 192.214.1.1

# Config Manwe
auto eth0
iface eth0 inet static
	address 192.214.1.3
	netmask 255.255.255.0
	gateway 192.214.1.1

# Config Varda
auto eth0
iface eth0 inet static
	address 192.214.2.2
	netmask 255.255.255.0
	gateway 192.214.2.1

# Config Ulmo
auto eth0
iface eth0 inet static
	address 192.214.2.3
	netmask 255.255.255.0
	gateway 192.214.2.1
