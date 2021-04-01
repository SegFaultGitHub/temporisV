ActiveAdmin.register Card do
    actions :all
    permit_params :name, :level

    filter :name, filters: [:contains]
    filter :level, filters: [:greater_than, :less_than]
    
    config.sort_order = "name_asc"
    index do
        column "Name" do |card|
            link_to card.name, [:admin, card]
        end
        column :level
        column :recipes do |card|
            card.recipes.size
        end
    end
    
    show do
        attributes_table do
            row :name
            row :level
            row :recipes do
                ul do
                    resource.recipes.each do |recipe|
                        li { link_to recipe.item.name, [:admin, recipe] }
                    end
                end
            end
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
            f.input :level, as: :number
        end
        f.actions
    end
end