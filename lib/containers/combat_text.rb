class CombatText
  include DslBase

  attributes :hit,
             :miss,
             :critical

  validates :hit, presence: true
  validates :miss, presence: true
  validates :critical, presence: true
end
