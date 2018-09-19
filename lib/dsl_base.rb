module DslBase
  VALID_FLAGS = [
      :death
  ]

  attr_accessor :const

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    attr_accessor :defined

    def define(const_symbol=nil, &proc)
      const = const_symbol.to_s

      item = new
      item.const = const
      item.instance_eval &proc

      self.defined ||= {}
      self.defined[const] = item

      puts "Loading: %-10s - %-25s %15s [%04d]" % [name, item.name, const, self.defined.count]

      if const.nil?
        raise "DEPRECATION - #{item.name} should use define :CONST syntax."
      elsif (Kernel.const_get(const) rescue nil)
        raise "ERROR - #{item.name} redefines const #{const}!"
      else
        Kernel.const_set const, item
      end

      item
    end

    def lookup(const)
      self.defined[const]
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


  def properties
    (@attributes || {}).merge (@containers || {})
  end

  def any?
    properties.any?
  end

  def [](attribute)
    self.send(attribute)
  end


  def flags(*flags)
    flags.each { |f| _check_flag(f) }
    @flags ||= []
    @flags.push *flags.collect(&:to_sym)
  end

  def flagged?(flag)
    _check_flag(flag)
    @flags&.include? flag.to_sym
  end

  private

  def _process_attribute(attr)
    if attr.is_a? String
      attr.squish
    else
      attr
    end
  end

  def _check_flag(flag)
    unless VALID_FLAGS.include? flag.to_sym
      raise "#{flag} is not a valid flag."
    end
  end
end
