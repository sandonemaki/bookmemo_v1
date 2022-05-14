class RemovePageImageNameToBooks < ActiveRecord::Migration[5.2]
  def change
    remove_column :books, :page_image_name, :string
  end
end
