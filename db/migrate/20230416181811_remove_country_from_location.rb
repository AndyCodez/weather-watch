class RemoveCountryFromLocation < ActiveRecord::Migration[6.1]
  def change
    remove_column :locations, :country
  end
end
