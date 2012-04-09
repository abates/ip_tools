require 'ipaddr'

module ActiveRecord
  module Validations
    module ClassMethods
      def validates_protocol(*args)
        options = args.extract_options!
        validates_each(args, options) do |model, attr_name, value|
          #if (model.respond_to?("#{attr_name}_before_type_cast"))
          #  protocol_id = model.send("#{attr_name}_before_type_cast")
          #end
          if (! value.nil?)
            protocol = Protocol.find(value)
            if (protocol.nil?)
              model.errors.add(attr_name, "is invalid")
            end
          end
        end
      end
    end
  end
end

