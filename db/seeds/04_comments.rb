sample_user = User.find_by(email: 'user@example.com')
james = User.find_by(email: 'james@example.com')
mary = User.find_by(email: 'mary@example.com')
shawn = User.find_by(email: 'shawn@example.com')
lauren = User.find_by(email: 'lauren@example.com')

grand_canyon = james.posts.first
grand_canyon.comments.create(user: sample_user, body: 'Wow, what an incredible view!')
grand_canyon.comments.create(user: mary, body: "I've been meaning to get out there for a while. Glad you had a good time!")
grand_canyon.comments.create(user: shawn, body: "Looks great. Where did you stay while you were down there?")
grand_canyon.comments.create(user: james, body: "We stayed at the North Rim Campground. It was close to some great trails and very well maintained.")
grand_canyon.comments.create(user: lauren, body: 'Another nice campground is Desert View. We stayed there last fall.')

glacier = mary.posts.first
glacier.comments.create(user: james, body: 'You hiked all the way up there?! Fantastic!')
glacier.comments.create(user: sample_user, body: "We're going up there next month!")
glacier.comments.create(user: mary, body: 'Hope you have an awesome time, I know we did!')
glacier.comments.create(user: james, body: 'I am so jealous!')

zion = mary.posts.last
zion.comments.create(user: sample_user, body: 'Wish I knew that before we went. It was so crowded!')

yosemite = sample_user.posts.first
yosemite.comments.create(user: lauren, body: 'Wow that pic is incredible! We went up last summer, but I want to go back to see those beautiful fall colors.')
yosemite.comments.create(user: shawn, body: 'This was an awesome trip. Thanks for inviting me!')
yosemite.comments.create(user: mary, body: 'Adding this to my bucket list!')
yosemite.comments.create(user: james, body: 'I love a good waterfall')