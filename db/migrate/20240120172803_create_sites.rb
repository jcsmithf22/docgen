class CreateSites < ActiveRecord::Migration[7.1]
  def change
    create_table :sites do |t|
      t.string :name
      t.string :country
      t.string :city

      t.timestamps
    end
  end
end
