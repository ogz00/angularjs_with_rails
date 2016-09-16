# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# 20.times do |i|
#   User.create!(
#       first_name: Faker::Name.first_name,
#       last_name: Faker::Name.last_name,
#       password: Faker::Internet.password(8),
#       username: "#{Faker::Internet.user_name}#{i}",
#       email: Faker::Internet.user_name + i.to_s +
#           "@#{Faker::Internet.domain_name}",
#       gender: 'female'
#   )
# end


# 30.times do |i|
#   Puzzle.create!(
#       no: Faker::Number.number(2),
#       name: Faker::Hipster.sentence(2),
#       date: Faker::Date.between(1.year.ago, Date.today),
#       question: Faker::Hipster.paragraph(3, true, 4),
#       answer: Faker::Number.between(1, 9999),
#       maraton: Faker::Date.between(1.year.ago, Date.today),
#       isTabled: Faker::Boolean.boolean(0.5),
#       year: 2016,
#       timestamp: Faker::Time.between(1.year.ago, Date.today, :all)
#   )
# end
#
# 50.times do |i|
#   Comment.create!(
#       user_id: Faker::Number.between(1, 30),
#       puzzle_id: Faker::Number.between(171, 200),
#       subject: Faker::Hipster.sentence(3),
#       message: Faker::Hipster.paragraph(2, true, 3),
#       publish: Faker::Boolean.boolean(1),
#       isCommentTop: Faker::Boolean.boolean(1),
#   )
# end


User.create!(
    first_name:'test',
    last_name:'tess',
    email: 'test@test.com',
    password: '123123123',
    username:'test',
    gender:'female'
)
