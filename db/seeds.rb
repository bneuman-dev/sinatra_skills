require 'faker'

# create a few users
User.create :name => 'Dev Bootcamp Student', :email => 'me@example.com', :password => 'password'
5.times do
  User.create :name => Faker::Name.name, :email => Faker::Internet.email, :password => 'password'
end

# create a few technical skills
computer_skills = %w(Ruby Sinatra Rails JavaScript jQuery HTML CSS)
computer_skills.each do |skill|
  Skill.create :name => skill, :context => 'technical'
end

# create a few creative skills
design_skills = %w(Photoshop Illustrator Responsive-Design)
design_skills.each do |skill|
  Skill.create :name => skill, :context => 'creative'
end

#link up a few user skills
user = User.first
skill = Skill.first
user_skill = user.add_skill(skill: skill, years_exp: 3, formal: false)

puts "Added user_skill with 'false' value for formal: "
puts user_skill

skill = Skill.last
user.add_skill(skill: skill, years_exp: 5, formal: true)
puts "Added user_skill with 'true' value for formal: "
puts user_skill

user = User.last
skill = Skill.first
user_skill = user.add_skill(skill: skill, formal: true)

puts "Tried to add user_skill with no years_exp value: "
puts user_skill

user_skill = user.add_skill(skill: skill, years_exp: 5)

puts "Tried to add user_skill with no 'formal' value: "
puts user_skill

10.times do
  user = User.find(rand(1..6))
  skill = Skill.find(rand(1..10))
  years = rand(1..10)
  user.add_skill(skill: skill, years_exp: years, formal: false)
end


# TODO: create associations between users and skills
