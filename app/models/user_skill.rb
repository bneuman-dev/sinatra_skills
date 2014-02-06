class UserSkill < ActiveRecord::Base
  belongs_to :user 
  belongs_to :skill
  validates :years_exp, :presence => true
  validates :skill, uniqueness: { scope: :user }
  validates_inclusion_of :formal, :in => [true, false]
  # Remember to create a migration!
end
