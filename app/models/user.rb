class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_questions, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorited_questions, through: :favorites, 
                                    source: :question

  def name_display 
    if first_name || last_name
      ["#{first_name}", "#{last_name}"].map(&:capitalize).join(" ").squeeze(" ").strip
    else
      email
    end
  end
  
end
