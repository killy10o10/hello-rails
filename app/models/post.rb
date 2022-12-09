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

  validates :title, presence: true, length: {maximum: 250}
  validates :comments_counter, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :likes_counter, numericality: {only_integer: true, greater_than_or_equal_to: 0}
end
