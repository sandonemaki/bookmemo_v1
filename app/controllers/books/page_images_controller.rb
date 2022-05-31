class Books::PageImagesController < ApplicationController
  require 'tmpdir'
  def create
    if params[:page_images]
      # Array
      page_images = PageImage.new(Page_images: params[:page_images])
      page_images.each do |page_image|
        # ファイル名をデータベースに保存
        if page_image.original_filename.include?("\.HEIC$|\.heic$")
          # original_filenameの最後につく.HEIC or .heic を .jpg に置換したファイル PATH
          jpg_filename = "public/page_images/#{page_image.original_filename.sub(/.HEIC$|.heic$/, ".jpg")}"
          # original_filename に.HEIC or .heic が含まれるファイル名を変数に代入
          # heic_filename = paga_image.ogirinal_filename
          page_image.name = jpg_filename
          # original_filenameの最後に .jpg or .png or .pdf が含まれる場合
        elsif page_image.original_filename.include?(/.jpg$|.jpeg$|.png$|.pdf$/)
          page_image.name = page_image.original_filename
        end

        # ファイルの実態を指定の場所に保存
        Dir.mktmpdir do |dir|
          if system('magick identify -format "%m" *.HEIC '==' AVIF')
            # HEIC の実体を一時的なtmpdirに保存
            File.binwrite("#{dir}/#{page_image.name}", page_image.read)
            # tmpdir 下の HEIC 画像の実体をファイル形式 jpg に変換して生成
            system('magick mogrify -format jpg -path "#{dir}"/*.HEIC')
            # tmpdir 下の jpg ファイルを public/page_images 下に移動
            File.rename("#{dir}/*.jpg", "public/page_images/")
            # original_filename のファイル形式が jpg/jpeg/png/pdf の場合
          elsif page_image.original_filename.include?(/.jpg$|.jpeg$|.png$|.pdf$/)
            File.binwrite("public/page_images/#{page_image.original_filename}", page_image.read)
          end # tmpdir を消去
        end

        if page_image.save
          flash[:notice] = "画像を保存しました"
          redirect_to("/books/#{:id}")
        else
          render("books/show")
        end
      end
    end
        # sytstem("magick convert #{heic_filename} #{jpg_filename}")"
  end
end
