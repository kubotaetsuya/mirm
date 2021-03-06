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
  validates_format_of :password, with: PASSWORD_REGEX, on: :create

  with_options presence: true do
    validates :password, on: :create
    validates :name
  end

  def self.guest
    find_or_create_by(email: "test@com", name: "guest") do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
