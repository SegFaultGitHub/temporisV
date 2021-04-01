class Item < ActiveRecord::Base
    validates :name, presence: true

    has_many :recipes, dependent: :restrict_with_error

    before_validation :truncate_name
    validate :validate_name
    validate :validate_item_class

    def truncate_name
        self.name.strip!
    end
    def validate_name
        errors.add(:name, "Duplicate name") if Item.select do |item|
            item.id != self.id
        end.any? do |item|
            item.name.parameterize() == self.name.parameterize()
        end
    end
    def validate_item_class
        errors.add(:item_class, "Item class not allowed") unless self.item_class.in? Item.item_classes
    end

    class << self
        def item_classes
            [
                "Amulettes",
                "Sac à dos",
                "Bottes",
                "Haches",
                "Prysmaradites",
                "Arcs",
                "Faux",
                "Capes",
                "Marteaux",
                "Trophées",
                "Épée ",
                "Coiffes",
                "Dagues",
                "Anneaux",
                "Baguettes",
                "Ceintures",
                "Boucliers",
                "Épées",
                "Pierres d'âmes",
                "Bâtons",
                "Dofus",
                "Pelles",
                "Pioches"
            ]
        end
    end
end
