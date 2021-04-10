class Item < ActiveRecord::Base
    validates :name, presence: true
    validates :name, uniqueness: { scope: :type }

    has_many :recipes, dependent: :restrict_with_error

    before_validation :truncate_name
    validate :validate_name
    validate :validate_item_type

    def truncate_name
        self.name.strip!
        self.name.gsub!(/\s+/, "  ")
        self.name.gsub!(/(^\[|\]$)/, '')
    end
    def validate_name
        errors.add(:name, "Duplicate name") if Item.select do |item|
            item.id != self.id
        end.any? do |item|
            item.name.parameterize() == self.name.parameterize() && item.type == self.type
        end
    end
    def validate_item_type
        if self.item_type.in? Equipment.item_types
            self.type = "Equipment"
        elsif self.item_type.in? Consumable.item_types
            self.type = "Consumable"
        elsif self.item_type.in? Idol.item_types
            self.type = "Idol"
        else
            errors.add(:item_type, "Item type not allowed")
        end
    end

    def descriptive_name
        "#{name} - #{descriptive_type}"
    end
    def descriptive_type
        "#{item_type} Niv. #{level}"
    end
end
