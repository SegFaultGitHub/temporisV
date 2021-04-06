ActiveAdmin.register Card do
    menu parent: "Items"

    actions :all
    permit_params :name, :level

    filter :name, filters: [:contains]
    filter :level, filters: [:greater_than, :less_than]

    scope("Tout") { |scope| scope.where("true") }
    scope("Avec recette") { |scope| scope.where("recipe_count > 0") }
    scope("Sans recette") { |scope| scope.where("recipe_count = 0") }

    config.sort_order = "name_asc"
    index download_links: false do
        column "Name" do |card|
            link_to card.name, [:admin, card]
        end
        column :level
        column :recipe_count
        column "Level-up Card" do |card|
            "#{card.level_up_card.level - 1} ➜ #{card.level_up_card.level}" if card.level_up_card
        end
    end
    
    show do
        attributes_table do
            row :name
            row :level
            row :level_up_card do
                "#{resource.level_up_card.level - 1} ➜ #{resource.level_up_card.level}"
            end if resource.level_up_card
            row :recipes do
                unless resource.recipes.empty?
                    table class: :index_table do
                        thead do
                            th { "Item" }
                            th { "Type" }
                            th { "Card 1" }
                            th { "Card 2" }
                            th { "Card 3" }
                            th { "Card 4" }
                            th { "Card 5" }
                            th { "Quantity" }
                        end
                        tbody do
                            even = false
                            resource.recipes.each do |recipe|
                                tr(class: even ? :even : nil) do
                                    td { link_to recipe.item.name,  [:admin, recipe.item] }
                                    td { recipe.item.descriptive_type }
                                    recipe.cards.each do |card|
                                        if (card.id == resource.id)
                                            td { b { link_to card.name, [:admin, card] } }
                                        else
                                            td { link_to card.name, [:admin, card] }
                                        end
                                    end
                                    td { recipe.quantity }
                                end
                                even = !even
                            end
                        end
                    end
                end
            end
        end
        panel "" do
            button_to "Ajouter une carte de montée de niveau", "/admin/level_up_cards/new", method: :get, params: { card_id: resource.id }
        end unless resource.level_up_card
    end
    
    controller do
        def create
            create! do |success, failure|
                success.html { redirect_to collection_url }
            end
        end
        
        def update
            update! do |success, failure|
                success.html { redirect_to collection_url }
            end
        end
    end
    
    form html: { enctype: "multipart/form-data" } do |f|
        f.inputs "Details" do
            f.input :name, as: :string
            f.input :level, as: :number
        end
        f.actions
    end
end