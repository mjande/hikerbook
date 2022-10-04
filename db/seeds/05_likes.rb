sample_user = User.find_by(email: 'user@example.com')
james = User.find_by(email: 'james@example.com')
mary = User.find_by(email: 'mary@example.com')
shawn = User.find_by(email: 'shawn@example.com')
lauren = User.find_by(email: 'lauren@example.com')

grand_canyon = james.posts.first
grand_canyon.likes.create(user: sample_user)
grand_canyon.likes.create(user: mary)
grand_canyon.likes.create(user: shawn)
grand_canyon.likes.create(user: lauren)

glacier = mary.posts.first
glacier.likes.create(user: sample_user)
glacier.likes.create(user: james)

yosemite = sample_user.posts.first
yosemite.likes.create(user: james)
yosemite.likes.create(user: mary)
yosemite.likes.create(user: shawn)
