ActiveAdmin.register_page "Search recipes" do
    menu parent: "Tools"
    
    content do
        panel "Qu'est ce que je peux crafter ?" do
            div { render partial: "search" }
            div do
                if params[:card_ids]
                    card_ids = Card.find(params[:card_ids].split(",")).pluck(:id)
                    if card_ids.size >= 5
                        find_recipe_complete(card_ids)
                    else
                        find_recipe_partial(card_ids)
                    end
                end
            end
        end
    end

    page_action :search, method: :get do
        selected_cards = Card.all.select do |card|
            !!params[card.id]
        end
        redirect_to admin_search_recipes_path(
            card_ids: selected_cards.map(&:id).join(",")
        )
    end
end

def find_recipe_complete(card_ids)
    table_for_recipes(card_ids, Recipe.select do |recipe|
        recipe.card_ids.all? { |card_id| card_ids.include? card_id }
    end)    
end

def find_recipe_partial(card_ids)
    table_for_recipes(card_ids, Recipe.select do |recipe|
        card_ids.all? { |card_id| recipe.card_ids.include? card_id }
    end)
end

def table_for_recipes(card_ids, recipes)
    span do
        b { number_with_delimiter(recipes.count, delimiter: ' ') }
        span { " recette#{"s" if recipes.count > 1} trouvée#{"s" if recipes.count > 1}" }
    end
    table class: :index_table do
        thead do
            tr do
                th { "Item" }
                th { "Type" }
                th { "Card 1" }
                th { "Card 2" }
                th { "Card 3" }
                th { "Card 4" }
                th { "Card 5" }
                th { "Quantity" }
            end
        end
        tbody do
            even = false
            recipes.each do |recipe|
                tr(class: even ? :even : nil) do
                    td { link_to recipe.item.name, [:admin, recipe.item] }
                    td { recipe.item.descriptive_type }
                    recipe.cards.partition { |card| card_ids.include?(card.id) }.each do |partition|
                        partition.each do |card|
                            if card_ids.include? card.id
                                td { link_to card.name, [:admin, card] }
                            else
                                td { s { link_to card.name, [:admin, card] } }
                            end
                        end
                    end
                    td { recipe.quantity }
                end
                even = !even
            end
        end
    end
end