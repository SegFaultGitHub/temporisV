ActiveAdmin.register Recipe do
    actions :all
    permit_params :item_id, :card1_id, :card2_id, :card3_id, :card4_id, :card5_id, :quantity

    before_filter :skip_sidebar!, :only => :index
    
    index do
        column "Item" do |recipe|
            link_to recipe.item.name, [:admin, recipe]
        end
        column :quantity
        column "Card 1" do |recipe|
            link_to recipe.card1.name, [:admin, recipe.card1]
        end
        column "Card 2" do |recipe|
            link_to recipe.card2.name, [:admin, recipe.card2]
        end
        column "Card 3" do |recipe|
            link_to recipe.card3.name, [:admin, recipe.card3]
        end
        column "Card 4" do |recipe|
            link_to recipe.card4.name, [:admin, recipe.card4]
        end
        column "Card 5" do |recipe|
            link_to recipe.card5.name, [:admin, recipe.card5]
        end
    end
    
    show do
        attributes_table do
            row :item do
                link_to resource.item.name, [:admin, resource.item]
            end
            row :quantity
            row :cards do
                table do
                    tr do
                        th { "Card 1" }
                        th { "Card 2" }
                        th { "Card 3" }
                        th { "Card 4" }
                        th { "Card 5" }
                    end
                    tr do
                        td { link_to resource.card1.name, [:admin, resource.card1] }
                        td { link_to resource.card2.name, [:admin, resource.card2] }
                        td { link_to resource.card3.name, [:admin, resource.card3] }
                        td { link_to resource.card4.name, [:admin, resource.card4] }
                        td { link_to resource.card5.name, [:admin, resource.card5] }
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
            f.input :item, collection: Item.order(:name), selected: params[:item_id]
            f.input :card1, collection: Card.order(:name)
            f.input :card2, collection: Card.order(:name)
            f.input :card3, collection: Card.order(:name)
            f.input :card4, collection: Card.order(:name)
            f.input :card5, collection: Card.order(:name)
            f.input :quantity, as: :number, default: 1
        end
        f.actions
    end
end