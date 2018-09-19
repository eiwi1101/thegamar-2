module InventoryHelper
  def find_item(name)
    return if name.nil?

    item_scope = self.equipment.to_h.values

    matches = item_scope.select { |item| item.name =~ /#{Regexp.escape(name)}/i }

    if matches.empty?
      raise GameError.new "I can't find #{name}."
    elsif matches.many?
      options = matches.collect(&:name).to_sentence(two_words_connector: ' or ', last_word_connector: ', or ')
      raise GameError.new "Did you mean: #{options}?"
    else
      matches.first
    end
  end
end
