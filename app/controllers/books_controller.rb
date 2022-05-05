class BooksController < ApplicationController
  def index
    books = Book.all.order(created_at: :desc).pluck(:book_title, :author, :id)
    books_view_model = books.map do |book|
      show_book = BooksIndex.new(book_title: book[0], author: book[1], id: book[2])
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
      create_book_view_model = CreateBook.new(book_title: book_title, author: book_author)
      render("new", locals:{book: create_book_view_model})
    end
  end

  def show
    book = Book.find_by(id: params[:id])
    book_title = book.book_title
    book_author = book.author
    book_id = book.id
    show_book = ShowBook.new(book_title: book_title, author: book_author, id: book_id)
    render("show", locals:{book: show_book})
  end


  def page_image_update
    if params[:page_image]
      book = Book.find_by(id: params[:id])
      # book.id.jpgという名前でbooksテーブルの画像名カラムに保存
      book.page_image_name = "#{book.id}.jpg"
      # viewから受け取ったpage_imageという名前の画像を変数に保存
      page_image = params[:page_image]
      # 変数page_imageに対してreadメソッドを用いて画像データを取得
      # ファイルの場所を指定して, ファイルの中身を作成
      File.binwrite("public/page_images/#{book.id}", page_image.read)
      # book_id = book.id
      # viewに渡す分だけShowBookクラスで初期化する
      # page_image_update = PageImageUpdate.new(id: book_id)
      # render("show", locals:{page_image: page_image_update})
      redirect_to(request.referer)
    end
  end
end
