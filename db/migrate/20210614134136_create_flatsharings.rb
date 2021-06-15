class CreateFlatsharings < ActiveRecord::Migration[6.1]
  def change
    create_table :flatsharings do |t|
      t.string :title
      t.string :description
      t.integer :admin_id
      t.timestamps
    end
  end
end
