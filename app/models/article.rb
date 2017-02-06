class Article < ActiveRecord::Base
  # Ensures that a title, description has value before saving to database
  # Ensure the title, description has a min/max lenght
  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 300 }
  
end  