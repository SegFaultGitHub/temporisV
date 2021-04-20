ActiveAdmin.register Card do
    menu parent: "Objets"

    actions :all
    permit_params :name, :level, :color, :super_card

    filter :name, filters: [:contains], label: "Nom"
    filter :level, filters: [:greater_than, :less_than], label: "Niveau"
    filter :color, as: :check_boxes, collection: Card.colors, label: "Couleur"
    filter :super_card, label: "Super carte"

    scope("Tout") { |scope| scope.where("true") }
    scope("Avec recette") { |scope| scope.where("recipe_count > 0") }
    scope("Sans recette") { |scope| scope.where("recipe_count = 0") }

    config.sort_order = "name_asc"
    index download_links: false do
        column "Nom", sortable: "name" do |card|
            link_to card.pretty_name, [:admin, card]
        end
        column "Niveau", sortable: "level", &:level
        column "Couleur", sortable: "color", &:color
        column "Super carte", sortable: "super_card", &:super_card
        column "Nombre de recettes", sortable: "recipe_count", &:recipe_count
        column "Carte de niveau" do |card|
            "#{card.level_up_card.level - 1} ➜ #{card.level_up_card.level}" if card.level_up_card
        end
    end
    
    show do
        attributes_table do
            row "Nom", &:name
            row "Niveau", &:level
            row "Couleur", &:color
            row "Super carte", &:super_card
            row "Carte de niveau" do
                "#{resource.level_up_card.level - 1} ➜ #{resource.level_up_card.level}"
            end if resource.level_up_card
            row "Recettes" do
                unless resource.recipes.empty?
                    table class: :index_table do
                        thead do
                            th { "Objet" }
                            th { "Type" }
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
                                    td { link_to recipe.item.name,  [:admin, recipe.item] }
                                    td { recipe.item.descriptive_type }
                                    recipe.cards.each do |card|
                                        if (card.id == resource.id)
                                            td { b { link_to "#{card.pretty_name} - Niv. #{card.level}", [:admin, card] } }
                                        else
                                            td { link_to "#{card.pretty_name} - Niv. #{card.level}", [:admin, card] }
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
            button_to "Ajouter une carte de niveau", "/admin/level_up_cards/new", method: :get, params: { card_id: resource.id }
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
        f.inputs "Détails" do
            f.input :name, as: :string, label: "Nom"
            f.input :level, as: :number, label: "Niveau"
            f.input :color, as: :select, collection: Card.colors, label: "Couleur"
            f.input :super_card, as: :boolean, label: "Super carte"
        end
        f.actions
    end
end