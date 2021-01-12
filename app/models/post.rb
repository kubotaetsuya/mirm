class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  has_many  :tag_relationships, dependent: :destroy
  has_many  :tags, through: :tag_relationships

  def save_tags(savepost_tags)
    savepost_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(name: new_name)
    self.tags << post_tag
    end
  end
end
