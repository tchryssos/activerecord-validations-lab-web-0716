# class ClickBaitValidator < ActiveModel::Validator
#   def validate(post)
#     click_bait=["Won't Believe", "Secret","Top \d", "Guess"]
#     unless click_bait.any?{|bait| post.title.include? bait}
#       post.errors[:title] << 'Must have a clickbait title!'
#     end
#   end
# en

class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: {minimum: 250}
  validates :summary, length: {maximum: 250}
  validates :category, inclusion: {in: %w(Fiction Non-Fiction)}
  validate :click_bait
  # validates :title, inclusion: {in: ["Won't Believe", "Secret","Top \d", "Guess"]}

  def click_bait
    self.title ||= "Dang"
    click_bait=["Won't Believe", "Secret","Top \d", "Guess"]
    unless click_bait.any?{|bait| self.title.include? bait}
      errors.add(:title, "Your title must be more click-baity!")
    end
  end

end
