class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :user, :index => true, :null=>false
      t.references :post, :index => true, :null=>false
      t.text :notes
      t.timestamps
    end
  end
end
