# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Reset database
User.destroy_all

# Create some default users
sample_user = User.create!(username: 'Sample User', email: 'user@example.com', password: 'password')
io = URI.parse('https://hikerbook.s3.us-east-2.amazonaws.com/seed_files/sample_user_avatar.jpg').open
sample_user.avatar.attach(io:, filename: 'sample_user_avatar.jpg')

mary = User.create!(username: 'Mary Murphy', email: 'mary@example.com', password: 'password')
io = URI.parse('https://hikerbook.s3.us-east-2.amazonaws.com/seed_files/mary_avatar.jpg').open
mary.avatar.attach(io:, filename: 'mary_avatar.jpg')

james = User.create!(username: 'James Jameson', email: 'james@example.com', password: 'password')
io = URI.parse('https://hikerbook.s3.us-east-2.amazonaws.com/seed_files/james_avatar.jpg').open
james.avatar.attach(io:, filename: 'james_avatar.jpg')

shawn = User.create(username: 'Shawn Whinery', email: 'shawn@example.com', password: 'password')
io = URI.parse('https://hikerbook.s3.us-east-2.amazonaws.com/seed_files/shawn_avatar.jpg').open
shawn.avatar.attach(io:, filename: 'shawn_avatar.jpg')

lauren = User.create(username: 'Lauren Van Daele', email: 'lauren@example.com', password: 'password')
io = URI.parse('https://hikerbook.s3.us-east-2.amazonaws.com/seed_files/lauren_avatar.jpg').open
lauren.avatar.attach(io:, filename: 'lauren_avatar.jpg')

mani = User.create(username: 'Mani Andreas', email: 'mani@example.com', password: 'password')
sylvia = User.create(username: 'Sylvia Samuel', email: 'sylvia@example.com', password: 'password')
mona = User.create(username: 'Mona Vukovic', email: 'mona@example.com', password: 'password')
otto = User.create(username: 'Otto Piotrowski', email: 'otto@example.com', password: 'password')
User.create(username: 'Dexter Chen', email: 'dexter@example.com', password: 'password')
User.create(username: 'Mladen Rosenberg', email: 'mladen@example.com', password: 'password')

# Add default friendships
Friendship.create(user1: sample_user, user2: mary)
Friendship.create(user1: sample_user, user2: james)
Friendship.create(user1: sample_user, user2: shawn)
Friendship.create(user1: sample_user, user2: lauren)

# Add some default friend requests
FriendRequest.create(sender: mani, receiver: sample_user)
FriendRequest.create(sender: sylvia, receiver: sample_user)
FriendRequest.create(sender: sample_user, receiver: mona)
FriendRequest.create(sender: sample_user, receiver: otto)

# Create some initial posts
sample_user.posts.create!(trail: 'Yosemite Falls Trail',
                   park: 'Yosemite National Park',
                   description: 'Amazing hike featuring a beautiful view of Yosemite Falls. A must for anyone visiting Yosemite')
sample_user.posts.create!(trail: 'Grand Prismatic Spring Overlook Trail',
                   park: 'Yellowstone National Park',
                   description: "If you're looking to see the amazing geysers at Yellowstone, check this trail out! Hiking this trail was a blast for me and my children.")
mary.posts.create!(trail: 'Highline Trail',
                   park: 'Glacier National Park',
                   description: 'Beautiful alpine hike with great views of mountains, lakes, and glaciers.')
mary.posts.create!(trail: "Angel's Landing",
                   park: 'Zion National Park',
                   description: 'One of the best trails at Zion NP. Get an early start to avoid the crowds.')
james.posts.create!(trail: 'Bright Angel Trail',
                   park: 'Grand Canyon National Park',
                   description: "Great views of the Grand Canyon, but this one isn't for beginners. The hike down is easy, but hiking back up can be quite challenging.")



