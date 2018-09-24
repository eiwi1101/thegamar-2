module DslBase
  VALID_FLAGS = [
      :death
  ]

  attr_accessor :const

  def self.included(base)
    base.include ActiveModel::Validations
    base.extend ClassMethods
  end

  module ClassMethods
    attr_accessor :defined
    attr_accessor :defaults

    def validates(field, options={})
      default = options.delete(:default)
      self.defaults ||= {}
      self.defaults[field] ||= default
      super(field, options) if options.any?
    end

    def define(const_symbol=nil, &proc)
      const = const_symbol.to_s

      item = new
      item.const = const
      item.instance_eval &proc
      item.set_defaults!

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

      item.post_initialize
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

    def container(name, container, options = {})
      define_method(name) do |&block|
        @containers ||= {}

        if block
          @containers[name] = block
        else
          if (proc = @containers[name])
            if proc.is_a? Proc
              inst = options[:container] ? container.new(*options[:container]) : container.new

              inst.instance_eval &proc
              @containers[name] = inst
            else
              proc
            end
          else
            nil
          end
        end
      end

      validate name do
        inst = self.send(name)

        if inst.respond_to? :valid? and inst.invalid?
          inst.errors.each do |field, error|
            self.errors.add name.to_s + '.' + field.to_s, error
          end
        end
      end

      if options[:required]
        validates_presence_of name, message: "is a required #{container} container"
      end
    end

    def containers(containers)
      containers.each do |name, container|
        container name, container
      end
    end

    def validate_all!
      valid = true
      self.defined.each do |k, v|
        if v.invalid?
          valid = false
          puts "#{k} is invalid: #{v.errors.full_messages}"
        end
      end
      valid
    end
  end


  def post_initialize
    true
  end

  def reset!
    post_initialize
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

  def to_s
    "%s(%s)" % [
        self.class.name,
        self.const
    ]
  end

  alias :inspect :to_s

  def set_defaults!
    @attributes ||= {}

    klass = self.class
    defaults = {}

    begin
      defaults.merge! klass.defaults || {}
      klass = klass.parent
    end while klass.respond_to? :defaults

    defaults.each do |key, value|
      @attributes[key] ||= value
    end
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
