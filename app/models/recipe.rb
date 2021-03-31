class Recipe < ActiveRecord::Base
    belongs_to :card1, class_name: "Card"
    belongs_to :card2, class_name: "Card"
    belongs_to :card3, class_name: "Card"
    belongs_to :card4, class_name: "Card"
    belongs_to :card5, class_name: "Card"
    belongs_to :item

    validate :validate_recipe
    def validate_recipe
        fields = [:card1, :card2, :card3, :card4, :card5]
        if self.cards.size != 5
            i = 0
            all_cards = [self.card1, self.card2, self.card3, self.card4, self.card5]
            errored_fields = []
            all_cards.each do |card|
                other_cards = [*all_cards[0...i], *all_cards[(i+1)...5]]
                errored_fields.push(fields[i]) if other_cards.include? card
                i += 1
            end
            errored_fields.each { |field| errors.add(field, "All cards must be distinct") }
        end
        fields.each do |field|
            errors.add(field, "Duplicate recipe")
        end if Recipe.select do |recipe|
            recipe.id != self.id
        end.any? do |recipe|
            recipe.cards == self.cards
        end
    end

    def cards
        [card1, card2, card3, card4, card5].compact.uniq.sort_by(&:name)
    end
end
