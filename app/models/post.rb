class Post < ApplicationRecord
  belongs_to :user # userテーブルとのアソシエーション
  has_one_attached :image  # 投稿された写真とのアソシエーション

  has_many  :tag_relationships, dependent: :destroy # タグ付機能
  has_many  :tags, through: :tag_relationships # タグ付機能

  has_many :comments  # commentsテーブルとのアソシエーション
  
  def save_tags(savepost_tags)
    savepost_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(name: new_name)
    self.tags << post_tag
    end
  end
end
