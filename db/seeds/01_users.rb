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
Friendship.create(user1: james, user2: mary)
Friendship.create(user1: james, user2: shawn)
Friendship.create(user1: james, user2: lauren)

# Add some default friend requests
FriendRequest.create(sender: mani, receiver: sample_user)
FriendRequest.create(sender: sylvia, receiver: sample_user)
FriendRequest.create(sender: sample_user, receiver: mona)
FriendRequest.create(sender: sample_user, receiver: otto)
