def item_page(model, type)
    ActiveAdmin.register model do
        menu parent: "Items"
        actions :all
        permit_params :name, :item_type, :level
        
        filter :name, filters: [:contains]
        filter :level, filters: [:greater_than, :less_than]
        filter :recipe_count, filters: [:greater_than, :equals]
        filter :item_type, as: :check_boxes, collection: Item.item_types[type]

        config.sort_order = "name_asc"
        index download_links: false do
            column "Name" do |item|
                link_to item.name, [:admin, item]
            end
            column :item_type
            column :level
            column :recipe_count
        end
        
        show do
            attributes_table do
                row :name
                row :item_type
                row :level
                row :recipes do
                    table do
                        tr do
                            th { "Card 1" }
                            th { "Card 2" }
                            th { "Card 3" }
                            th { "Card 4" }
                            th { "Card 5" }
                            th { "Quantity" }
                        end
                        resource.recipes.each do |recipe|
                            tr do
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
            panel "" do
                button_to "Ajouter une recette", "/admin/recipes/new", method: :get, params: { item_id: resource.id }
            end
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
                f.input :item_type, collection: Item.item_types[type]
                f.input :level, as: :number
            end
            f.actions
        end
    end
end