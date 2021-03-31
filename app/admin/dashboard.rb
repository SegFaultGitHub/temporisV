ActiveAdmin.register_page "Dashboard" do
    menu priority: 1, label: "Dashboard"
    
    content do
        panel "Statistiques" do
            ul do
                li { "Nombre de cartes : #{Card.count}" }
                li { "Nombre d'items : #{Item.count}" }
                li { "Nombre de recettes : #{Recipe.count}" }
            end
        end
        panel "Derniers ajouts" do
            panel "Cartes" do
                ul do
                    Card.order('created_at DESC').last(10).each do |card|
                        li { link_to card.name, [:admin, card] }
                    end
                end
            end
            panel "Items" do
                ul do
                    Item.order('created_at DESC').last(10).each do |item|
                        li { link_to item.name, [:admin, item] }
                    end
                end
            end
            panel "Recettes" do
                ul do
                    Recipe.order('created_at DESC').last(10).each do |recipe|
                        li { link_to recipe.item.name, [:admin, recipe] }
                    end
                end
            end
        end
    end
end
