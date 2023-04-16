class AddCountryCodeToLocation < ActiveRecord::Migration[6.1]
  def change
    add_column :locations, :country_code, :string
  end
end
