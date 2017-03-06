class Article < ActiveRecord::Base
  # Setting up relationship to many articles to single user
  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories
  
  # Ensures that a title, description has value before saving to database
  # Ensure the title, description has a min/max length
  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 300 }
  validates :user_id, presence: true
  
end  