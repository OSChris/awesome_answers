class Answer < ActiveRecord::Base
  belongs_to :question

  validates :body, presence: {message: "must exist"}

  
end
