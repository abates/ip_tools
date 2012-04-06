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


class Protocol
  attr_reader :id, :name, :title, :ports_allowed
  def self.all
    protocols = Array.new
    protocol_descriptors = arr = IO.readlines(File.join(File.dirname(__FILE__), 'protocols.txt'))
    protocol_descriptors.each do |line|
      next if (line =~ /^\s*#/)
      p = line.split(/,/)
      protocols.push(Protocol.new(p))
    end
    protocols
  end

  def initialize(params)
    @name = params[0]
    @id = params[1]
    @title = params[2]
    @ports_allowed = (params[3] == 1 ? true : false)
  end
end

