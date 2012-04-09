module ProtocolHelper
  def protocol_name id
    p = Protocol.find(id)
    if (p.nil?)
      return ""
    end
    return p.name
  end
end

module ActionView
  module Helpers
    module FormHelper
      def protocol_select object_name, method, selected=nil, options = {} 
        option_tags = options_from_collection_for_select(Protocol.all, :id, :title, selected)
        if (options[:builder].nil?)
          select(object_name, method, option_tags)
        else
          options[:builder].select(method, option_tags)
        end
      end
    end

    class FormBuilder
      def protocol_select method
        @template.protocol_select(@object_name, method, @object.send(method), {:builder => self})
      end
    end
  end
end
