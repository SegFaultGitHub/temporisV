ActiveAdmin.register_page "Search recipes" do
    menu priority: 3
    
    content do
        panel "Qu'est ce que je peux crafter ?" do
            div { render partial: "search" }
            div do
                if params[:card_ids]
                    cards = Card.find(params[:card_ids].split(","))
                    if params[:complete]
                        find_recipe_complete(cards)
                    else
                        find_recipe_partial(cards)
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
            complete: params[:complete],
            card_ids: selected_cards.map(&:id).join(",")
        )
    end
end

def find_recipe_complete(cards)
    recipes = Recipe.select do |recipe|
        recipe.cards.all? { |card| cards.include? card }
    end
    table do
        tr do
            th { "Item" }
            th { "Card 1" }
            th { "Card 2" }
            th { "Card 3" }
            th { "Card 4" }
            th { "Card 5" }
        end
        recipes.each do |recipe|
            tr do
                td { link_to recipe.item.name, [:admin, recipe.item] }
                [recipe.card1, recipe.card2, recipe.card3, recipe.card4, recipe.card5].each do |card|
                    if cards.include? card
                        td { link_to card.name, [:admin, card] }
                    else
                        td { s { link_to card.name, [:admin, card] } }
                    end
                end
            end
        end
    end
end

def find_recipe_partial(cards)
    recipes = Recipe.select do |recipe|
        recipe.cards.any? { |card| cards.include? card }
    end
    table do
        tr do
            th { "Item" }
            th { "Card 1" }
            th { "Card 2" }
            th { "Card 3" }
            th { "Card 4" }
            th { "Card 5" }
        end
        recipes.each do |recipe|
            tr do
                td { link_to recipe.item.name, [:admin, recipe.item] }
                [recipe.card1, recipe.card2, recipe.card3, recipe.card4, recipe.card5].each do |card|
                    if cards.include? card
                        td { link_to card.name, [:admin, card] }
                    else
                        td { s { link_to card.name, [:admin, card] } }
                    end
                end
            end
        end
    end
end