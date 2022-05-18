class Books::PageImagesController < ApplicationController
  def create
    if params[:page_images]
      page_images = Page_image.new(Page_images: params[:page_images])
      page_images.each do |page_image|
        page_image.name = page_image.original_filename
        File.binwrite("public/page_images/#{page_image.name}", page_image.read)
      end
  end
end
