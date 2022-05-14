class CreatePageImages < ActiveRecord::Migration[5.2]
  def change
    create_table :page_images do |t|
      t.string :page_image_name
      execute 'DELETE FROM books;'
      t.references :book, foreign_key: true
      t.timestamps
    end
  end
end
