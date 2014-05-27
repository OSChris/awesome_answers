class Question < ActiveRecord::Base
  
  validates :title, :description,
              presence: {message: "must be provided"},
              uniqueness: true

  validates :title, uniqueness: {scope: :description}

  validate :stop_words

  before_save :sanitize_title

  scope :recent, -> { where(["created_at > ?", 3.days.ago]) }
  scope :recent_ten, -> { order("created_at DESC").limit(10) }

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
