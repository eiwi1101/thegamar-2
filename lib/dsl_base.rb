module DslBase
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    attr_accessor :defined

    def define(const_symbol=nil, &proc)
      const = const_symbol.to_s

      item = new
      item.instance_eval &proc

      self.defined ||= []
      self.defined.push item

      puts "Loading: %-10s - %-40s [%04d]" % [name, item.name, self.defined.count]

      if const.nil?
        raise "DEPRECATION - #{item.name} should use define :CONST syntax."
      elsif (Kernel.const_get(const) rescue nil)
        raise "ERROR - #{item.name} redefines const #{const}!"
      else
        Kernel.const_set const, item
      end

      item
    end

    def count
      self.defined.count
    end

    def attribute(attr)
      define_method(attr) do |val=nil|
        @attributes ||= {}
        val.nil? ? _process_attribute(@attributes[attr]) : @attributes[attr] = val
      end
    end

    def attributes(*attrs)
      attrs.each { |a| attribute(a) }
    end

    def container(name, container)
      define_method(name) do |&block|
        @containers ||= {}

        if block
          @containers[name] = block
        else
          inst = container.new
          inst.instance_eval &@containers[name]
          inst
        end
      end
    end

    def containers(containers)
      containers.each do |name, container|
        container name, container
      end
    end
  end


  def player
    PlayerState.instance
  end

  def properties
    (@attributes || {}).merge (@containers || {})
  end

  def any?
    properties.any?
  end

  def [](attribute)
    self.send(attribute)
  end

  private

  def _process_attribute(attr)
    if attr.is_a? String
      attr.squish
    else
      attr
    end
  end
end
