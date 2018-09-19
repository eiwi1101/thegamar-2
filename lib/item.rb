class Item
  include DslBase

  attributes :name,
             :description,
             :stack_count,
             :unique_count,
             :value
end
