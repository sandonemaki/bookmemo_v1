class CreateBook
  attr_reader :book_title, :author

  def initialize(book_title:, author:)
    @book_title = book_title
    @author = author
  end
end

