class Item
  include DslBase

  attributes :name,
             :description,
             :stack_count,
             :unique_count,
             :value

  def weapon?
    false
  end

  def equipment?
    false
  end
end
