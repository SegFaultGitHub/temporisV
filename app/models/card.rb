class Card < ActiveRecord::Base
    validates :name, presence: true
    validates :level, :numericality => { :greater_than_or_equal_to => 1 }

    validate :validate_name
    def validate_name
        errors.add(:name, "Duplicate name") if Card.select do |card|
            card.id != self.id
        end.any? do |card|
            card.name.parameterize() == self.name.parameterize()
        end
    end

    def recipes
        Recipe.where("
            card1_id = ? OR
            card2_id = ? OR
            card3_id = ? OR
            card4_id = ? OR
            card5_id = ?
        ", self.id, self.id, self.id, self.id, self.id)
    end
end
