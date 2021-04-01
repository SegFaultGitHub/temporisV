ActiveAdmin.register_page "Dashboard" do
    menu priority: 1
    
    content do
        panel "Statistiques" do
            div { span { "Par " } + b { "SegFault#5814" } }
            br
            ul do
                li { b { "Nombre de cartes : " } + span { number_with_delimiter(Card.count, delimiter: ' ') } }
                li { b { "Nombre d'items : " } + span { number_with_delimiter(Item.count, delimiter: ' ') } }
                li { b { "Nombre de recettes : " } + span  { number_with_delimiter(Recipe.count, delimiter: " ") } }
            end
        end
        panel "Couverture" do
            ul do
                li do
                    b { "Items avec recette : " } +
                    span do
                        count = Item.all.reject { |item| item.recipes.empty? }.size
                        "#{number_with_delimiter(count, delimiter: " ")} / #{number_with_delimiter(Item.count, delimiter: ' ')} (#{(count.to_f / Item.count.to_f * 100).round(4)}%)"
                    end
                end
                li do
                    b { "Recettes trouvées : " } +
                    span do
                        "#{number_with_delimiter(Recipe.count, delimiter: " ")} / #{number_with_delimiter(Card.total_recipes, delimiter: ' ')} (#{(Recipe.count.to_f / Card.total_recipes.to_f * 100).round(4)}%)"
                    end
                end
            end
        end
        panel "Derniers ajouts" do
            panel "Cartes" do
                ul do
                    Card.order('updated_at DESC').first(10).each do |card|
                        li { link_to card.name, [:admin, card] }
                    end
                end
            end
            panel "Items" do
                ul do
                    Item.order('updated_at DESC').first(10).each do |item|
                        li { link_to item.name, [:admin, item] }
                    end
                end
            end
            panel "Recettes" do
                ul do
                    Recipe.order('updated_at DESC').first(10).each do |recipe|
                        li { link_to recipe.item.name, [:admin, recipe] }
                    end
                end
            end
        end
    end
end