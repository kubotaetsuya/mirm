class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :comments # commentsテーブルとのアソシエーション
  has_many :posts # postsテーブルとのアソシエーション
  has_one_attached :avatar  # ユーザーの画像とのアソシエーション
end
