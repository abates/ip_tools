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

module IPTools
  class Protocol
    attr_reader :id, :name, :title, :ports_allowed
    @@protocols = {}

    def self.find id
      self.load[id]
    end

    def self.load
      if (@@protocols.length == 0)
        protocol_descriptors = arr = IO.readlines(File.join(File.dirname(__FILE__), 'protocols.txt'))
        protocol_descriptors.each do |line|
          next if (line =~ /^\s*#/)
          p = line.split(/,/)
          @@protocols[p[1].to_i] = Protocol.new(p)
        end
      end
      @@protocols
    end

    def self.all
      self.load.values
    end

    def initialize(params)
      @name = params[0]
      @id = params[1].to_i
      @title = params[2]
      @ports_allowed = (params[3] == 1 ? true : false)
    end
  end
end
