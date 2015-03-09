require 'faker'

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
 
 # Note: by calling `User.new` instead of `create`,
 # we create an instance of User which isn't immediately saved to the database.
 
 # The `skip_confirmation!` method sets the `confirmed_at` attribute
 # to avoid triggering an confirmation email when the User is saved.
 
 # The `save` method then saves this User to the database.

# create posts
  50.times do
      Post.create!(
          user:   users.sample,
          title: Faker::Lorem.sentence,
          body:   Faker::Lorem.paragraph
        )  
 end
 posts = Post.all
 
# create comments
 100.times do
     Comment.create!(
           # user: users.sample,   # we have not yet associated Users with Comments
         post: posts.sample,
         body: Faker::Lorem.paragraph
         )
 end

#     Post.create!(
#         title: 'Jed',
#         body: 'a manual post from Jed'
#         )  


 user = User.first
 user.skip_reconfirmation!
 user.update_attributes!(
   email: 'joiner@jedparish.com',
   password: 'O!Ic2bian2015'
 )
 
puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"