ActiveAdmin.register Card do
    menu parent: "Items"

    actions :all
    permit_params :name, :level

    filter :name, filters: [:contains]
    filter :level, filters: [:greater_than, :less_than]
    filter :recipe_count, filters: [:greater_than, :equals]

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
                    table do
                        tr do
                            th { "Item" }
                            th { "Card 1" }
                            th { "Card 2" }
                            th { "Card 3" }
                            th { "Card 4" }
                            th { "Card 5" }
                            th { "Quantity" }
                        end
                        resource.recipes.each do |recipe|
                            tr do
                                td { link_to recipe.item.name,  [:admin, recipe.item] }
                                td { link_to recipe.card1.name, [:admin, recipe.card1] }
                                td { link_to recipe.card2.name, [:admin, recipe.card2] }
                                td { link_to recipe.card3.name, [:admin, recipe.card3] }
                                td { link_to recipe.card4.name, [:admin, recipe.card4] }
                                td { link_to recipe.card5.name, [:admin, recipe.card5] }
                                td { recipe.quantity }
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