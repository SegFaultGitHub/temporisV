ActiveAdmin.register_page "random_recipes" do
    menu parent: "Outils", label: "Recettes aléatoires"
    
    content title: "Recettes aléatoires" do
        panel "Recettes inconnues aléatoires" do
            count = 0
            all_cards = Card.all
            if all_cards.size >= 5
                recipes = []
                while recipes.size < 20
                    break if count >= 10
                    selected_cards = all_cards.sample(5).sort_by(&:name)
                    recipe_exists = Recipe.where(
                        card1: selected_cards[0],
                        card2: selected_cards[1],
                        card3: selected_cards[2],
                        card4: selected_cards[3],
                        card5: selected_cards[4]
                    ).exists?
                    if !recipe_exists and !selected_cards.in? recipes
                        recipes.push(selected_cards)
                        count = 0
                    else
                        count += 1
                    end
                end
                table class: :index_table do
                    thead do
                        th { "Carte #1" }
                        th { "Carte #2" }
                        th { "Carte #3" }
                        th { "Carte #4" }
                        th { "Carte #5" }
                        th {} if (current_user.is_admin? || current_user.is_writer?)
                    end
                    tbody do
                        even = false
                        recipes.each do |recipe|
                            tr(class: even ? :even : nil) do
                                recipe.each do |card|
                                    td { link_to "#{card.pretty_name} - Niv. #{card.level}", [:admin, card] }
                                end
                                td do
                                    button_to "Ajouter une recette", "/admin/recipes/new", method: :get, params: {
                                        card1_id: recipe[0],
                                        card2_id: recipe[1],
                                        card3_id: recipe[2],
                                        card4_id: recipe[3],
                                        card5_id: recipe[4]
                                    }
                                end if (current_user.is_admin? || current_user.is_writer?)
                            end
                            even = !even
                        end
                    end
                end
            end
        end
    end
end