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
    password: Faker::Lorem.characters( 10 )

  )

  user.skip_confirmation!
  user.save!

end
users = User.all

# Create Topics
15.times do

  Topic.create!(

    name:        Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph

    )

end
topics = Topic.all

# Create Posts
200.times do

  post = Post.create!(

    user:  users.sample,
    topic: topics.sample,
    title: Faker::Lorem.sentence,
    body:  Faker::Lorem.paragraph

  )

  post.update_attributes!( created_at: rand( 10.minutes .. 1.year ).ago )
  post.create_vote
  post.update_rank

end
posts = Post.all

# Create Comments
400.times do

  Comment.create!(

    post: posts.sample,
    user: users.sample,
    body: Faker::Lorem.paragraph

  )

end

# Create 'Admin User'
admin = User.new(

  name:     'Admin User',
  email:    'admin@example.com',
  password: 'helloworld',
  role:     'admin'

)
admin.skip_confirmation!
admin.save!

# Create 'Moderator'
moderator = User.new(

  name:     'Moderator User',
  email:    'moderator@example.com',
  password: 'helloworld',
  role:     'moderator'

)
moderator.skip_confirmation!
moderator.save!

# Create 'Member'
member = User.new(

  name:     'Member User',
  email:    'member@example.com',
  password: 'helloworld',
  role:     'member'

)
member.skip_confirmation!
member.save!

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
