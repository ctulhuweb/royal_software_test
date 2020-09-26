class AddIndexToComapanies < ActiveRecord::Migration[6.0]
  def change
    add_index :companies, :name
  end
end
