class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.references :user, :index => true, :null=>false
      t.text :notes
      t.timestamps
    end
  end
end
