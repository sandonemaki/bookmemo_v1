class Book < ApplicationRecord
  validates :book_title, presence: {message: "本のタイトルを入力してください"} #uniqueness: { scope: :book }
  validates :author, presence: {message: "著者を入力してください"}
end
