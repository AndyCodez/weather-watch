class RenameCityToLocation < ActiveRecord::Migration[6.1]
  def change
    rename_table :cities, :locations
  end
end
