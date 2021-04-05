ActiveAdmin.register_page "Unknown recipes" do
    menu parent: "Tools"
    
    content do
        panel "Recettes inconnues" do
            div { render partial: "form_unknown" }
            div do
                if params[:card_ids]
                    cards = Card.find(params[:card_ids].split(",")).sort_by(&:name)
                    if cards.size > 5 and cards.size <= 10
                        find_unknown_recipes(cards)
                    else
                        div { "⚠️ Sélectionnez entre 6 et 10 cartes !" }
                    end
                end
            end
        end
    end

    page_action :search, method: :get do
        selected_cards = Card.all.select do |card|
            !!params[card.id]
        end
        redirect_to admin_unknown_recipes_path(
            card_ids: selected_cards.map(&:id).join(",")
        )
    end
end

def find_unknown_recipes(cards)
    recipes = cards.combination(5).to_a
    all_recipes = Recipe.all
    unknown_recipes = recipes.map do |recipe|
        next if all_recipes.any? { |known_recipe| known_recipe.card_ids == recipe.pluck(:id) }
        recipe
    end.compact
    table_for_unknown_recipes(cards, unknown_recipes)   
end

def table_for_unknown_recipes(cards, recipes)
    span do
        b { number_with_delimiter(recipes.count, delimiter: ' ') }
        span { " recette#{"s" if recipes.count > 1} inconnue#{"s" if recipes.count > 1}" }
    end
    table class: :index_table do
        thead do
            tr do
                th { "Card 1" }
                th { "Card 2" }
                th { "Card 3" }
                th { "Card 4" }
                th { "Card 5" }
                th {} if (current_user.is_admin? || current_user.is_writer?)
            end
        end
        tbody do
            even = false
            recipes.each do |recipe|
                tr(class: even ? :even : nil) do
                    recipe.each do |card|
                        td { link_to card.name, [:admin, card] }
                    end
                    td do
                        button_to "Ajouter une recette", "/admin/recipes/new", method: :get, params: {
                            card1_id: recipe[0].id,
                            card2_id: recipe[1].id,
                            card3_id: recipe[2].id,
                            card4_id: recipe[3].id,
                            card5_id: recipe[4].id
                        }
                    end if (current_user.is_admin? || current_user.is_writer?)
                end
                even = !even
            end
        end
    end
end