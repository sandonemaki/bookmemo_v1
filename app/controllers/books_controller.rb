class BooksController < ApplicationController
  require "fileutils"
  def index
    books = Book.all.order(created_at: :desc).pluck(:book_title, :author, :id)
    books_view_model = books.map do |book|
      BooksIndex.new(book_title: book[0], author: book[1], id: book[2])
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
      FileUtils.mkdir_p("public/page_images/#{book.id}")
      redirect_to("/")
    else
      book_title = book.book_title
      book_author = book.author
      create_book_view_model = CreateBook.new(book_title: book_title, author: book_author)
      render("new", locals:{book: create_book_view_model})
    end
  end

  def show
    book = Book.find_by(id: params[:id])
   # if FileTest.exist?("public/page_images/#{book.id}/")
    filepaths = Dir.glob("public/page_images/#{book.id}/*")
      .sort_by { |page_file| File.mtime(page_file) }.reverse
    page_files = filepaths.map {|f| f.gsub(/public\/page_images\/#{book.id}\//, '')}
    # else
      # puts "falseだったとき"
      # puts "public/page_images/#{book.id}/ディレクトリを作成する"
      # []
    # end
    show_book = ShowBook.new(
      book_title: book.book_title,
      author: book.author,
      id: book.id,
      page_files: page_files,
    )
    render("show", locals: {book: show_book})
  end
end
