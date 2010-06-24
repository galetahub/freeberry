class FreeberryCreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string   :user_name,        :limit => 50
      t.string   :user_email,       :limit => 50
      t.text     :content,                                        :null => false
      t.text     :content_html
      t.integer  :commentable_id,                 :default => 0,  :null => false
      t.string   :commentable_type, :limit => 15, :default => "", :null => false
      t.boolean  :is_follow,                      :default => false

      t.integer  :author_id
      t.string   :author_type,      :limit => 25
    
      t.timestamps
    end
    
    add_index :comments, [:author_type, :author_id], :name => "fk_author"
    add_index :comments, [:commentable_type, :commentable_id], :name => "fk_commentable"
  end

  def self.down
    drop_table :comments
  end
end
