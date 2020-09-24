class AddRefToContactPersons < ActiveRecord::Migration[6.0]
  def change
    add_reference :contacts, :company, null: false, foreign_key: true
  end
end
