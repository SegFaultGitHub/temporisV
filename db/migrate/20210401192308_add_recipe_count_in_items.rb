class AddRecipeCountInItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :recipe_count, :integer, default: 0
  end
end
