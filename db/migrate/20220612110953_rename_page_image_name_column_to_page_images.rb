class RenamePageImageNameColumnToPageImages < ActiveRecord::Migration[5.2]
  def change
    rename_column :page_images, :page_image_name, :name
  end
end
