ActiveAdmin.register Item do
    actions :all
    permit_params :name

    filter :name, filters: [:contains]
    filter :level, filters: [:greater_than, :less_than]

    config.sort_order = "name_asc"
    index do
        column "Name" do |item|
            link_to item.name, [:admin, item]
        end
        column "Recipes" do |item|
            item.recipes.size
        end
    end

    show do
        attributes_table do
            row :name
            row :recipes do
                table do
                    tr do
                        th { "Card 1" }
                        th { "Card 2" }
                        th { "Card 3" }
                        th { "Card 4" }
                        th { "Card 5" }
                    end
                    resource.recipes.each do |recipe|
                        tr do
                            td { link_to recipe.card1.name, [:admin, recipe.card1] }
                            td { link_to recipe.card2.name, [:admin, recipe.card2] }
                            td { link_to recipe.card3.name, [:admin, recipe.card3] }
                            td { link_to recipe.card4.name, [:admin, recipe.card4] }
                            td { link_to recipe.card5.name, [:admin, recipe.card5] }
                        end
                    end
                end
            end
        end
    end

    form html: { enctype: "multipart/form-data" } do |f|
      f.inputs "Details" do
        f.input :name, as: :string
      end
      f.actions
    end
end