require 'resolv'

class String
  def to_ip
    begin
      if (self =~ /^(?:\d{1,3}\.){3}\d{1,3}/)
        return IPAddr.new(self, Socket::AF_INET)
      elsif (self =~ /:/)
        return IPAddr.new(self, Socket::AF_INET6)
      else
        return Resolv.getaddress self
      end
    rescue
    end
    nil
  end
end

