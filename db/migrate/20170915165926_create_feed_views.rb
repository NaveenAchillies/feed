class CreateFeedViews < ActiveRecord::Migration[5.0]
  def change
    create_table :feed_views do |t|
      t.references :user, :index => true, :null=>false
      t.references :post, :index => true, :null=>false
      t.timestamps
    end
  end
end
