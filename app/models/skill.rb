class Skill < ActiveRecord::Base
  VALID_CONTEXTS = %w(technical creative)

  validates :name, :presence => true
  validate :validate_context
  has_many :user_skills
  has_many :users, through: :user_skills

  def years(user)
    self.user_skills.find_by(user: user).years_exp
  end

  def formal(user)
    self.user_skills.find_by(user: user).formal ? "yes" : "no"
  end

  private
  def validate_context
    p self.context
    self.errors[:context] = "must be one of: #{VALID_CONTEXTS.join(', ')}" unless VALID_CONTEXTS.include? self.context
  end
end
