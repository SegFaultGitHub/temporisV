ActiveAdmin.register_page "Random recipes" do
    menu priority: 3
    
    content do
        panel "Recettes inconnues aléatoires" do
            count = 0
            all_cards = Card.all
            recipes = []
            while recipes.size < 10
                break if count >= 10
                selected_cards = all_cards.sample(5)
                recipe_exists = Recipe.any? { |r| r.cards == selected_cards }
                if !recipe_exists
                    recipes.push(selected_cards)
                    count = 0
                else
                    count += 1
                end
            end
            table do
                tr do
                    th { "Card 1" }
                    th { "Card 2" }
                    th { "Card 3" }
                    th { "Card 4" }
                    th { "Card 5" }
                    th {} if (current_user.is_admin? || current_user.is_writer?)
                end
                recipes.each do |recipe|
                    tr do
                        recipe.each do |card|
                            td { link_to card.name, [:admin, card] }
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
                end
            end
        end
    end
end