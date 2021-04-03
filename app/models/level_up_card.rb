class LevelUpCard < ActiveRecord::Base
    belongs_to  :card
    validates   :level,     presence: true
    validates   :level,     numericality: { :greater_than_or_equal_to => 2 }
    validates   :level,     uniqueness: true
    validates   :card_id,   uniqueness: true
end