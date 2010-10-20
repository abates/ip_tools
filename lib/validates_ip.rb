require 'ipaddr'

module ActiveRecord
  module Validations
    module ClassMethods
      def validates_ip(*args)
        options = args.extract_options!
        validates_each(args, options) do |model, attr_name, value|
          if (model.respond_to?("#{attr_name}_before_type_cast"))
            address = model.send("#{attr_name}_before_type_cast")
          end
          if (! address.nil? && !address.empty?)
            address = address.strip
            begin
              if (address =~ /^(?:\d{1,3}\.){3}\d{1,3}/) 
                IPAddr.new(address, Socket::AF_INET)
              elsif (address =~ /:/)
                IPAddr.new(address, Socket::AF_INET6)
              else
                model.errors.add(attr_name, "is not a valid IP address")
              end
            rescue Exception => e
              model.errors.add(attr_name, e.message)
            end
          end
        end
      end
    end
  end
end

