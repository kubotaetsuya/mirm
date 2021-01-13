class Comment < ApplicationRecord
  belongs_to :post # tweetsテーブルとのアソシエーション
  belongs_to :user  # usersテーブルとのアソシエーション
  validates :text, presence: true
end
