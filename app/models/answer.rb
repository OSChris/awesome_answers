class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  
  has_many :comments, dependent: :destroy

  validates :body, presence: {message: "must exist"}

  
end
