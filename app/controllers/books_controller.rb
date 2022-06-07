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
    book_title = book.book_title
    book_author = book.author
    book_id = book.id
    if FileTest.exist?("public/page_images/#{book.id}/")
      page_files = Dir.glob("public/page_images/#{book.id}/*").sort_by { |fn| File.mtime(fn) }
    end
    show_book = ShowBook.new(book_title: book_title, author: book_author, id: book_id, page_files: page_files)
    render("show", locals:{book: show_book})
  end


  # def page_image_update
    # if params[:page_images]
      # book = Book.find_by(id: params[:id])
      # page_images = params[:page_images]
      # page_images.each {|page_image|
        # book.page_image_name = page_image.original_filename
        # File.binwrite("public/page_images/#{book.page_image_name}", page_image.read)
      # }
    # end
    # if book.save
      # redirect_to(request.referer)
    # else
      # page_image_update = PageImageUpdate.new(page_images: page_images)
      # render("show", locals:{book: page_image_update})
    # end
  # end
end
