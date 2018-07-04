module DslBase
  @@defined = []

  def define(&proc)
    item = new
    item.instance_eval &proc
    @@defined.push item

    puts "Loading: %-10s - %-40s [%04d]" % [name, item.name, @@defined.count]

    item
  end

  def count
    @@defined.count
  end


  def attribute(attr)
    define_method(attr) do |val=nil|
      @attributes ||= {}
      val.nil? ? @attributes[attr] : @attributes[attr] = val
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
end
