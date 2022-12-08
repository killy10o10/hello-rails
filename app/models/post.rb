class Post < ApplicationRecord
  has_many :likes
  has_many :comments
  belongs_to :author, class_name: 'User'

  def recent_comments
    comments.order(created_at: :desc ).limit(5)
  end

  after_save :update_posts_counter
  def update_posts_counter
    author.update(posts_counter: author.posts.size)
  end
end
