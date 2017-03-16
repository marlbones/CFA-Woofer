class Post < ApplicationRecord
  belongs_to :user

  acts_as_likeable

  # def self.find_jamie_is_cool
  #   where(content: "Jamie is cool")
  # end
  #
  # Post.find_jamie_is_cool => []
end
