def item_page(model, label)
    ActiveAdmin.register model do
        menu parent: "Objets", label: label

        actions :all
        permit_params :name, :item_type, :level
        
        filter :name, filters: [:contains], label: "Nom"
        filter :level, filters: [:greater_than, :less_than], label: "Niveau"
        filter :item_type, as: :check_boxes, collection: model.item_types, label: "Type"

        scope("Tout") { |scope| scope.where("true") }
        scope("Avec recette") { |scope| scope.where("recipe_count > 0") }
        scope("Sans recette") { |scope| scope.where("recipe_count = 0") }

        config.sort_order = "name_asc"
        index download_links: false do
            column "Nom", sortable: "items.name" do |item|
                link_to item.name, [:admin, item]
            end
            column "Type", sortable: "item_type", &:item_type
            column "Niveau", sortable: "level", &:level
            column "Nombre de recettes", sortable: "recipe_count", &:recipe_count
            column do |item|
                link_to "Ajouter une recette", "/admin/recipes/new?item_id=#{item.id}", class: "button_to"
            end if (current_user.is_admin? || current_user.is_writer?)
        end
        
        show do
            attributes_table do
                row "Nom", &:name
                row "Type", &:item_type
                row "Niveau", &:level
                row "Recettes" do
                    unless resource.recipes.empty?
                        table class: :index_table do
                            thead do
                                th { "Carte #1" }
                                th { "Carte #2" }
                                th { "Carte #3" }
                                th { "Carte #4" }
                                th { "Carte #5" }
                                th { "Quantité" }
                            end
                            tbody do
                                even = false
                                resource.recipes.each do |recipe|
                                    tr(class: even ? :even : nil) do
                                        td { link_to recipe.card1.name, [:admin, recipe.card1] }
                                        td { link_to recipe.card2.name, [:admin, recipe.card2] }
                                        td { link_to recipe.card3.name, [:admin, recipe.card3] }
                                        td { link_to recipe.card4.name, [:admin, recipe.card4] }
                                        td { link_to recipe.card5.name, [:admin, recipe.card5] }
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
                button_to "Ajouter une recette", "/admin/recipes/new", method: :get, params: { item_id: resource.id }
            end if (current_user.is_admin? || current_user.is_writer?)
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
            f.inputs "Détails" do
                f.input :name, as: :string, label: "Nom"
                f.input :item_type, collection: model.item_types, input_html: { class: "select2" }, label: "Type"
                f.input :level, as: :number, label: "Niveau"
            end
            f.actions
        end
    end
end