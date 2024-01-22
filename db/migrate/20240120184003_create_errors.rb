class CreateErrors < ActiveRecord::Migration[7.1]
  def change
    create_table :errors do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
