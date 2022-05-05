class ShowBook
  attr_reader :book_title, :author, :id

  def initialize(book_title:, author:, id:)
    @book_title = book_title
    @author = author
    @id = id
  end
end
