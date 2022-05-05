class AddPageImageNameToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :page_image_name, :string
  end
end
