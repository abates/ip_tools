require "ipaddr"
require "netmask_tools"

ip = IPAddr.new("192.168.1.0/24", Socket::AF_INET)

print "#{ip.netmask}\n"
print "#{ip.broadcast}\n";
print "#{ip.prefix}\n";


