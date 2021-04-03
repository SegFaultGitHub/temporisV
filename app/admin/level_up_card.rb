ActiveAdmin.register LevelUpCard do
    menu priority: 2
    
    actions :all
    permit_params :card_id, :level
    
    filter :name, filters: [:contains]
    filter :level, filters: [:greater_than, :less_than]
    filter :recipe_count, filters: [:greater_than, :equals]
    
    config.sort_order = "level_asc"
    index download_links: false do
        column "Name" do |level_up_card|
            link_to level_up_card.card.name, [:admin, level_up_card.card]
        end
        column :level do
            |level_up_card| "#{level_up_card.level - 1} ➜ #{level_up_card.level}"
        end
    end
    
    show do
        attributes_table do
            row :card
            row :level
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
            if params[:card_id]
                f.input :card, collection: Card.order(:name), selected: params[:card_id], input_html: { disabled: true }
            else
                f.input :card, collection: Card.order(:name)
            end
            f.input :level, as: :number
        end
        f.actions
    end
end