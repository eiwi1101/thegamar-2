module InventoryHelper
  def find_item(name)
    return if name.nil?

    raise GameError.new "I can't find #{name}."
  end
end
