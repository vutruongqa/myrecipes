class ChangeColumnInRecipesSecond < ActiveRecord::Migration[5.0]
  def change
    change_column :recipes, :description, :text
  end
end
