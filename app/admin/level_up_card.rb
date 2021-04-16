ActiveAdmin.register LevelUpCard do
    menu priority: 3, label: "Cartes de niveau"
    
    actions :all, except: [:show]

    permit_params :card_id, :level
    
    filter :name, filters: [:contains], label: "Nom"
    filter :level, filters: [:greater_than, :less_than], label: "Niveau"
    
    config.sort_order = "level_asc"
    index download_links: false do
        column "Nom" do |level_up_card|
            link_to level_up_card.card.name, [:admin, level_up_card.card]
        end
        column "Niveau", sortable: "level" do
            |level_up_card| "#{level_up_card.level - 1} ➜ #{level_up_card.level}"
        end
        actions
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
            if params[:card_id]
                f.input :card, collection: Card.order(:name), selected: params[:card_id], input_html: { class: "select2" }, label: "Carte"
            else
                f.input :card, collection: Card.order(:name), input_html: { class: "select2" }, label: "Carte"
            end
            f.input :level, as: :number, label: "Niveau"
        end
        f.actions
    end
end