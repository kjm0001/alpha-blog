class AddDescriptionToArticles < ActiveRecord::Migration
  def change
    # add_column method
    # attributes :table_name  :column_name  :data_type
    add_column :articles, :description, :text
    # created_at (spelled exactly) rails will keep track of this 
    add_column :articles, :created_at, :datetime
    # updated_at (spelled exactly) rails will keep track of this
    add_column :articles, :updated_at, :datetime
  end
end
