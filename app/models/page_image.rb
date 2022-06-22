class PageImage < ApplicationRecord
  validates :name, presence: true
  belongs_to :book
end
