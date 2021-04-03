ActiveAdmin.register_page "Dashboard" do
    menu priority: 1
    
    content do
        panel("Statistiques") do
            div { span { "Par " } + b { "SegFault#5814" } }
            br
            width = 200
            table do
                tr do
                    td(width: width, align: "right") { b { "Nombre d'inscrits'" } }
                    td { number_with_delimiter(User.count, delimiter: ' ') }
                end
            end
            table do
                tr do
                    td(width: width, align: "right") { b { "Nombre de cartes" } }
                    td { number_with_delimiter(Card.count, delimiter: ' ') }
                end
                tr do
                    td(width: width, align: "right") { b { "Nombre d'équipements" } }
                    td { number_with_delimiter(Equipment.count, delimiter: ' ') }
                end
                tr do
                    td(width: width, align: "right") { b { "Nombre de consommables" } }
                    td { number_with_delimiter(Consumable.count, delimiter: " ") }
                end
                tr do
                    td(width: width, align: "right") { b { "Nombre de recettes" } }
                    td { number_with_delimiter(Recipe.count, delimiter: ' ') }
                end
            end
            table do
                tr do
                    td(width: width, align: "right") { b { "Cartes trouvées" } }
                    td do
                        "#{number_with_delimiter(Card.count, delimiter: " ")} / #{number_with_delimiter(642, delimiter: ' ')} (#{(Card.count.to_f / 642.0 * 100).round(4)}%)"
                    end
                end
                tr do
                    td(width: width, align: "right") { b { "Équipements avec recette" } }
                    td do
                        count = Equipment.all.reject { |item| item.recipe_count == 0 }.size
                        "#{number_with_delimiter(count, delimiter: " ")} / #{number_with_delimiter(Equipment.count, delimiter: ' ')} (#{(count.to_f / Equipment.count.to_f * 100).round(4)}%)"
                    end
                end
                tr do
                    td(width: width, align: "right") { b { "Consommables avec recette" } }
                    td do
                        count = Consumable.all.reject { |item| item.recipe_count == 0 }.size
                        "#{number_with_delimiter(count, delimiter: " ")} / #{number_with_delimiter(Consumable.count, delimiter: ' ')} (#{(count.to_f / Consumable.count.to_f * 100).round(4)}%)"
                    end
                end
                tr do
                    td(width: width, align: "right") { b { "Recettes trouvées" } }
                    td do
                        "#{number_with_delimiter(Recipe.count, delimiter: " ")} / #{number_with_delimiter(Card.total_recipes, delimiter: ' ')} (#{(Recipe.count.to_f / Card.total_recipes.to_f * 100).round(4)}%)"
                    end
                end
            end
        end
        panel "Derniers ajouts" do
            table do
                tr do
                    td do
                        panel(link_to "Cartes", admin_cards_path) do
                            ul do
                                Card.order('updated_at DESC').first(10).each do |card|
                                    li { link_to card.name, [:admin, card] }
                                end
                            end
                        end
                    end
                    td do
                        panel(link_to "Equipement", admin_equipment_index_path) do
                            ul do
                                Equipment.order('updated_at DESC').first(10).each do |equipment|
                                    li { link_to equipment.name, [:admin, equipment] }
                                end
                            end
                        end
                    end
                    td do
                        panel(link_to "Consommables", admin_consumables_path) do
                            ul do
                                Consumable.order('updated_at DESC').first(10).each do |consumable|
                                    li { link_to consumable.name, [:admin, consumable] }
                                end
                            end
                        end
                    end
                    td do
                        panel(link_to "Recettes", admin_recipes_path) do
                            ul do
                                Recipe.order('updated_at DESC').first(10).each do |recipe|
                                    li { link_to recipe.item.descriptive_name, [:admin, recipe] }
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end