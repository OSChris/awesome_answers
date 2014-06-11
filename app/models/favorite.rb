class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  # validate the uniqueness of a favorite 
  validates :user_id, uniqueness: {scope: :question_id}

end
