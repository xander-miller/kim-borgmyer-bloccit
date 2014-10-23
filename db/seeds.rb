require 'faker'

# Create Users
# Notes:
#   - Calling 'User.new', instead of 'User.create', we create
#     an instance of User that is not immediately saved to the
#     database.
#
#   - The 'skip_confirmation!' method sets the 'confirmed_at'
#     attribute to avoid triggering a confirmation email when
#     User is saved.
#
#   - The 'save!' method then saves User to the database
5.times do

  user = User.new(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )

  user.skip_confirmation!
  user.save!

end
users = User.all

# Create Posts
50.times do

  Post.create!(
    user:  users.sample,
    title: Faker::Lorem.sentence,
    body:  Faker::Lorem.paragraph
  )

end
posts = Post.all

# Create Comments
100.times do

  Comment.create!(
    post: posts.sample,
    body: Faker::Lorem.paragraph
  )

end

User.first.update_attributes!(

  email:    'Kim.Borgmeyer@gmail.com',
  password: 'ghoti123',
  
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
