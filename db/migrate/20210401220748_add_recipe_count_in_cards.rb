class AddRecipeCountInCards < ActiveRecord::Migration[6.1]
  def change
    add_column :cards, :recipe_count, :integer, default: 0
  end
end
