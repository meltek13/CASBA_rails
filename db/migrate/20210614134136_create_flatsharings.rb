class CreateFlatsharings < ActiveRecord::Migration[6.1]
  def change
    create_table :flatsharings do |t|
      t.string :title
      t.string :description
      t.integer :admin_id
      t.text :pending_invitation
<<<<<<< HEAD
=======
<<<<<<< HEAD
      t.text :flat_mate

=======
      t.belongs_to :user, index: true
>>>>>>> 2dffa9d6239fa3c83fecb66151bd9887e28825e2
      t.text :flat_mate
>>>>>>> 7a350d47056d2c7b2966096425e5805b0884a4aa

      t.timestamps
    end
  end
end
