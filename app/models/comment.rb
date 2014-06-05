class Comment < ActiveRecord::Base
  belongs_to :answer
  belongs_to :user

  validates :body, presence: true
end
