class Card < ActiveRecord::Base
    validates :name, presence: true
    validates :level, :numericality => { :greater_than_or_equal_to => 1 }

    before_validation :truncate_name
    def truncate_name
        self.name.strip!
    end

    validate :validate_name
    def validate_name
        errors.add(:name, "Duplicate name") if Card.select do |card|
            card.id != self.id
        end.any? do |card|
            card.name.parameterize() == self.name.parameterize()
        end
    end

    has_many :recipes_card1, foreign_key: "card1_id", class_name: "Recipe", dependent: :restrict_with_error
    has_many :recipes_card2, foreign_key: "card2_id", class_name: "Recipe", dependent: :restrict_with_error
    has_many :recipes_card3, foreign_key: "card3_id", class_name: "Recipe", dependent: :restrict_with_error
    has_many :recipes_card4, foreign_key: "card4_id", class_name: "Recipe", dependent: :restrict_with_error
    has_many :recipes_card5, foreign_key: "card5_id", class_name: "Recipe", dependent: :restrict_with_error
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
