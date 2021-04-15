class Recipe < ActiveRecord::Base
    belongs_to :card1, class_name: "Card"
    belongs_to :card2, class_name: "Card"
    belongs_to :card3, class_name: "Card"
    belongs_to :card4, class_name: "Card"
    belongs_to :card5, class_name: "Card"
    belongs_to :item

    validate :validate_recipe
    before_save :update_item_card_recipe_count
    before_save :sort_cards
    before_save :prevent_creator_id_update
    before_destroy :decrement_item_card_recipe_count

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
    end
    def update_item_card_recipe_count
        before = [
            [Item, changes[:item_id]&.first],
            [Card, changes[:card1_id]&.first],
            [Card, changes[:card2_id]&.first],
            [Card, changes[:card3_id]&.first],
            [Card, changes[:card4_id]&.first],
            [Card, changes[:card5_id]&.first],
        ]
        after = [
            [Item, changes[:item_id]&.last],
            [Card, changes[:card1_id]&.last],
            [Card, changes[:card2_id]&.last],
            [Card, changes[:card3_id]&.last],
            [Card, changes[:card4_id]&.last],
            [Card, changes[:card5_id]&.last],
        ]
        before.each do |model, id|
            object = model.find_by(id: id)
            next unless object
            object.update!(recipe_count: object.recipe_count - 1)
        end
        after.each do |model, id|
            object = model.find_by(id: id)
            next unless object
            object.update!(recipe_count: object.recipe_count + 1)
        end
    end
    def sort_cards
        sorted_cards = cards
        self.card1 = sorted_cards[0]
        self.card2 = sorted_cards[1]
        self.card3 = sorted_cards[2]
        self.card4 = sorted_cards[3]
        self.card5 = sorted_cards[4]
    end
    def prevent_creator_id_update
        return if changes[:creator_id].first.nil?
        self.creator_id = changes[:creator_id].first
    end
    def decrement_item_card_recipe_count
        item.update!(recipe_count: item.recipe_count - 1)
        card1.update!(recipe_count: card1.recipe_count - 1)
        card2.update!(recipe_count: card2.recipe_count - 1)
        card3.update!(recipe_count: card3.recipe_count - 1)
        card4.update!(recipe_count: card4.recipe_count - 1)
        card5.update!(recipe_count: card5.recipe_count - 1)
    end

    def cards
        [card1, card2, card3, card4, card5].compact.uniq.sort_by(&:name)
    end
    def card_ids
        [card1_id, card2_id, card3_id, card4_id, card5_id]
    end

    def save
        super()
    rescue ActiveRecord::RecordNotUnique => e
        fields = [:card1, :card2, :card3, :card4, :card5]
        fields.each do |field|
            errors.add(field, "Duplicate recipe")
        end
    end
end
