class BooksController < ApplicationController
  def index
    books = Book.all.order(created_at: :desc).pluck(:book_title, :author)
    books_view_model = books.map do |book|
      BooksIndex.new(book_title: book[0], author: book[1])
    end
    render("index", locals:{books: books_view_model})
  end

  def new
    book = Book.new #Book<ActiveRecord>
    book_title = book.book_title #String
    book_author = book.author #String
    create_book_view_model = CreateBook.new(book_title: book_title, author: book_author)
    render("new", locals:{book: create_book_view_model})
  end

  def create
    book = Book.new(
    book_title: params[:book_title],
    author: params[:author]
    )
    if book.save
      redirect_to("/")
    else
      book_title = book.book_title
      book_author = book.author
      create_book_view_model = CreateBook.new(book_titile: book_title, author: book_author)
      render("new", locals: {task: create_book_view_model})
    end
  end



end
