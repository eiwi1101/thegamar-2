module DslBase
  attr_accessor :defined

  def define(&proc)
    item = new
    item.instance_eval &proc

    self.defined ||= []
    self.defined.push item

    puts "Loading: %-10s - %-40s [%04d]" % [name, item.name, self.defined.count]

    item
  end

  def count
    self.defined.count
  end


  def attribute(attr)
    define_method(attr) do |val=nil|
      @attributes ||= {}
      val.nil? ? self.class._process_attribute(@attributes[attr]) : @attributes[attr] = val
    end
  end

  def attributes(*attrs)
    attrs.each { |a| attribute(a) }
  end

  def container(name, container)

  end

  def containers(containers)
    containers.each do |name, container|
      container name, container
    end
  end

  def _process_attribute(attr)
    if attr.is_a? String
      attr.squish
    else
      attr
    end
  end
end
