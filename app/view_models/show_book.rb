class ShowBook
  attr_reader :book_title, :author, :id, :page_files

  def initialize(book_title:, author:, id:, page_files:)
    @book_title = book_title
    @author = author
    @id = id
    @page_files = page_files
  end
end
