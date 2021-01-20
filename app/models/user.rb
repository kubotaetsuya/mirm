class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
        
  has_many :comments # commentsテーブルとのアソシエーション
  has_many :posts # postsテーブルとのアソシエーション
  has_one_attached :avatar  # ユーザーの画像とのアソシエーション

  validates :email, uniqueness:true

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX

  with_options presence: true do
    validates :password
    validates :name
  end

end
