class Item < ActiveRecord::Base
    validates :name, presence: true
    validates :name, uniqueness: { scope: :type }

    has_many :recipes, dependent: :restrict_with_error

    before_validation :truncate_name
    validate :validate_name
    validate :validate_item_type

    def truncate_name
        self.name.strip!
    end
    def validate_name
        errors.add(:name, "Duplicate name") if Item.select do |item|
            item.id != self.id
        end.any? do |item|
            item.name.parameterize() == self.name.parameterize() && item.type == self.type
        end
    end
    def validate_item_type
        if self.item_type.in? Item.item_types[:equipments]
            self.type = "Equipment"
        elsif self.item_type.in? Item.item_types[:consumables]
            self.type = "Consumable"
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

    class << self
        def item_types
            {
                equipments: [
                    "Amulette",
                    "Anneau",
                    "Arc",
                    "Baguette",
                    "Bâton",
                    "Bottes",
                    "Bouclier",
                    "Cape",
                    "Ceinture",
                    "Coiffe",
                    "Dagues",
                    "Dofus",
                    "Épée",
                    "Faux",
                    "Hache",
                    "Marteau",
                    "Pelle",
                    "Pioche",
                    "Prysmaradite",
                    "Sac à dos",
                    "Trophée"
                ],
                consumables: [
                    "Bière",
                    "Boisson",
                    "Boîte de fragments",
                    "Bourse de Kamas",
                    "Cadeau",
                    "Coffre",
                    "Conteneur",
                    "Fée d'artifice",
                    "Friandise",
                    "Mimibiote",
                    "Mots de haïku",
                    "Objet d'élevage",
                    "Objet utilisable",
                    "Pain",
                    "Parchemin d'attitude",
                    "Parchemin de caractéristique",
                    "Parchemin de recherche",
                    "Parchemin de sortilège",
                    "Parchemin de titre",
                    "Parchemin d'émoticônes",
                    "Parchemin d'expérience",
                    "Parchemin d'ornement",
                    "Pierre magique",
                    "Poisson comestible",
                    "Popoche de Havre-Sac",
                    "Potion",
                    "Potion d'attitude",
                    "Potion de conquête",
                    "Potion de familier",
                    "Potion de montilier",
                    "Potion de monture",
                    "Potion de téléportation",
                    "Potion d'oubli Percepteur",
                    "Viande comestible"
                ]
            }
        end
    end
end
