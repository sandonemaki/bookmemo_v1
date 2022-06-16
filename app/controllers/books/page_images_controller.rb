class Books::PageImagesController < ApplicationController
  require 'tmpdir'
  require 'fileutils'
  def create
    if params[:page_images]
      page_files = params[:page_images]
      book_id = params[:id]

      # 以下にディレクトリがなければ作成
      FileUtils.mkdir_p("public/page_images/#{book_id}/")
      num = 0

      page_files.each do |page_file|
      page_image = PageImage.new
      num += 1
      page_image.name = ["public/book/#{book_id}/page_images/", num.to_s].join
      puts "------------"
      puts page_image
      puts page_image.name
      puts "------------"

      page_file_ext = File.extname(page_file.original_filename)
        # ファイル名をデータベースに保存
        if page_file_ext.match("\.HEIC$|\.heic$")
          # original_filenameの最後につく.HEIC or .heic を .jpg に置換したファイル PATH
          #jpg_filename =
          #  "public/page_images/#{book_id}/#{page_file.original_filename.sub(/.HEIC$|.heic$/, ".jpg")}"
          #page_image.name = jpg_filename
          # 実体の保存
          Dir.mktmpdir do |tmpdir|
            File.binwrite("#{tmpdir}/#{page_file.original_filename}", page_file.read)
            # dir 下の HEIC 画像の実体をファイル形式 jpg に変換して生成
            system('magick mogrify -format jpg '+tmpdir+'/*.HEIC')
            FileUtils.mv(Dir.glob("#{tmpdir}/*.jpg"), "public/page_images/#{book_id}/")
        end #tmpdirの消去

        # original_filenameの最後に .jpg or .png or .pdf が含まれる場合
        elsif page_file_ext.downcase.match(/.jpg$|.jpeg$|.png$|.pdf$/)
          # page_image.name = "public/page_images/#{book_id}/#{page_file.original_filename}"
          # 実体の保存
          File.binwrite("public/page_images/#{book_id}/#{page_file.original_filename}", page_file.read)
        end

        # page_image_params = page_files.merge({image_file_name: page_file.original_filename})

        # DBに保存
        if page_image.save
          flash[:notice] = "画像を保存しました"
          redirect_to("/books/#{:id}")
        else
          flash.now[:danger] = "保存できませんでした"
          render(plain: "okss")
          # render("books/show")
        end
      end
    end
  end
end
        #  # ファイルの実態を指定の場所に保存
        #  if page_file_ext.match("\.HEIC$|\.heic$") # system('magick identify -format '+tmpdir+'/*.HEIC')
        #    Dir.mktmpdir do |tmpdir|
        #      File.binwrite("#{tmpdir}/#{page_file.original_filename}", page_file.read)
        #      # dir 下の HEIC 画像の実体をファイル形式 jpg に変換して生成
        #      system('magick mogrify -format jpg '+tmpdir+'/*.HEIC')
        #      FileUtils.mv(Dir.glob("#{tmpdir}/*.jpg"), "public/page_images/#{book_id}/")
        #    end #tmpdirの消去
        #  # original_filename のファイル形式が jpg/jpeg/png/pdf の場合
        #  elsif page_file_ext.downcase.match(/.jpg$|.jpeg$|.png$|.pdf$/)
        #    File.binwrite("public/page_images/#{book_id}/#{page_file.original_filename}", page_file.read)
        #  end
