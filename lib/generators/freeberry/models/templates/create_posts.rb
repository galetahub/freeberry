class FreeberryCreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :structure_id
      t.string :title, :null => false
      t.string :slug, :limit=>40, :null=>false
      t.text :content
      
      t.integer :kind, :limit => 1, :default => 0
      t.integer :comments_count, :default=>0
      t.integer :year, :limit => 4
      
      t.datetime :published_at
      t.timestamps
    end
    
    add_index :posts, :structure_id, :name => "fk_structure"
    add_index :posts, :year
  end

  def self.down
    drop_table :posts
  end
end
