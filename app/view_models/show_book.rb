class ShowBook
  attr_reader :book_title, :author, :id, :page_image_name

  def initialize(book_title:, author:, id:, page_image_name:)
    @book_title = book_title
    @author = author
    @id = id
    @page_image_name = page_image_name
  end
end
