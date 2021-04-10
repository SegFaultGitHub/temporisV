ActiveAdmin.register_page "Dashboard" do
    menu priority: 1
    
    content do
        panel "Accès" do
            div do
                span { "Envoyez moi un message sur Discord (" }
                b { "SegFault#5814" }
                span { ") avec votre pseudo pour avoir accès à toutes les fonctionnalités !" }
            end
        end if current_user.is_guest?
        panel "Statistiques" do
            div { span { "Par " } + b { "SegFault#5814" } }
            br
            width = 200
            table do
                tr do
                    td(width: width, align: "right") { b { "Nombre d'inscrits" } }
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
                    td(width: width, align: "right") { b { "Nombre d'idoles" } }
                    td { number_with_delimiter(Idol.count, delimiter: " ") }
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
                    td(width: width, align: "right") { b { "Idoles avec recette" } }
                    td do
                        count = Idol.all.reject { |item| item.recipe_count == 0 }.size
                        "#{number_with_delimiter(count, delimiter: " ")} / #{number_with_delimiter(Idol.count, delimiter: ' ')} (#{(count.to_f / Idol.count.to_f * 100).round(4)}%)"
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
                td do
                    table class: :index_table do
                        thead do
                            th { link_to "Cartes", admin_cards_path }
                        end
                        tbody do
                            even = false
                            Card.order('updated_at DESC').first(10).each do |card|
                                tr(class: even ? :even : nil) { td { link_to card.name, [:admin, card] } }
                                even = !even
                            end
                        end
                    end
                end
                td do
                    table class: :index_table do
                        thead do
                            th { link_to "Équipements", admin_equipment_index_path }
                        end
                        tbody do
                            even = false
                            Equipment.order('updated_at DESC').first(10).each do |equipment|
                                tr(class: even ? :even : nil) { td { link_to equipment.name, [:admin, equipment] } }
                                even = !even
                            end
                        end
                    end
                end
                td do
                    table class: :index_table do
                        thead do
                            th { link_to "Consommables", admin_consumables_path }
                        end
                        tbody do
                            even = false
                            Consumable.order('updated_at DESC').first(10).each do |consumable|
                                tr(class: even ? :even : nil) { td { link_to consumable.name, [:admin, consumable] } }
                                even = !even
                            end
                        end
                    end
                end
                td do
                    table class: :index_table do
                        thead do
                            th { link_to "Idoles", admin_consumables_path }
                        end
                        tbody do
                            even = false
                            Idol.order('updated_at DESC').first(10).each do |consumable|
                                tr(class: even ? :even : nil) { td { link_to consumable.name, [:admin, consumable] } }
                                even = !even
                            end
                        end
                    end
                end
                td do
                    table class: :index_table do
                        thead do
                            th { link_to "Recette", admin_recipes_path }
                            th {}
                        end
                        tbody do
                            even = false
                            Recipe.order('updated_at DESC').first(10).each do |recipe|
                                tr(class: even ? :even : nil) do
                                    td { link_to recipe.item.name, [:admin, recipe] }
                                    td { recipe.item.descriptive_type }
                                end
                                even = !even
                            end
                        end
                    end
                end
                td do
                    table class: :index_table do
                        thead do
                            th { link_to "Utilisateurs", admin_users_path }
                        end
                        tbody do
                            even = false
                            User.order('created_at DESC').first(10).each do |user|
                                tr(class: even ? :even : nil) do
                                    td { link_to user.email, [:admin, user] }
                                    even = !even
                                end
                            end
                        end
                    end
                end if current_user.is_admin?
            end
        end
    end
end