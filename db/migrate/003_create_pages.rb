class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :edited_by, :null => false
      t.string :title, :null => false, :unique => true
      t.string :slug, :null => false, :unique => true
      t.text :content, :null => false

      t.timestamps
    end
  end
end
