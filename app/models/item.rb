class Item < ActiveRecord::Base
    validates :name, presence: true

    has_many :recipes

    validate :validate_name
    def validate_name
        errors.add(:name, "Duplicate name") if Item.select do |item|
            item.id != self.id
        end.any? do |item|
            item.name.parameterize() == self.name.parameterize()
        end
    end
end
