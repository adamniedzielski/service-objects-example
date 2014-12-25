class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title
      t.text :body
      t.string :status

      t.timestamps null: false
    end
  end
end
