class Question < ActiveRecord::Base

  belongs_to :user

  has_many :answers, dependent: :destroy

  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations
  
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites, dependent: :destroy
  
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes,
                          source: :user
  
  delegate :name_display, to: :user, prefix: true

  # validations
  validates :title, :description,
              presence: {message: "must be provided"},
              uniqueness: true

  validates :title, uniqueness: {scope: :description}
  validate :stop_words
  before_save :sanitize_title

  scope :recent, -> { where(["created_at > ?", 3.days.ago]) }
  scope :recent_ten, -> { order("created_at DESC").limit(10) }

  def favorited_by?(user)
    favorites.exists?(user: user)
  end

  def liked_by?(user)
    likes.exists?(user: user)
  end

  private

  def stop_words
    if title.include? "question"
      errors.add(:title, "can't contain the word 'question'")
    end
  end



  def sanitize_title
    self.title = title.squeeze(" ").strip.capitalize
  end

end
