# frozen_string_literal: true

sample_user = User.find_by(username: 'Sample User')
mary = User.find_by(username: 'Mary Murphy')
james = User.find_by(username: 'James Jameson')

# Create some initial posts
yosemite = sample_user.posts.create!(trail: 'Yosemite Falls Trail',
                          park: 'Yosemite National Park',
                          description: 'Amazing hike featuring a beautiful view of Yosemite Falls. A must for anyone visiting Yosemite.')
io = URI.parse('https://hikerbook.s3.us-east-2.amazonaws.com/seed_files/yosemite_image.jpg').open
yosemite.image.attach(io:, filename: 'yosemite_image.jpg')

sample_user.posts.create!(trail: 'Grand Prismatic Spring Overlook Trail',
                          park: 'Yellowstone National Park',
                          description: "If you're looking to see the amazing geysers at Yellowstone, check this trail out! Hiking this trail was a blast for me and my wife.")

glacier = mary.posts.create!(trail: 'Highline Trail',
                   park: 'Glacier National Park',
                   description: 'Beautiful alpine hike with great views of mountains, lakes, and glaciers.')
io = URI.parse('https://hikerbook.s3.us-east-2.amazonaws.com/seed_files/glacier_image.jpg').open
glacier.image.attach(io:, filename: 'glacier_image.jpg')
      
mary.posts.create!(trail: "Angel's Landing",
                   park: 'Zion National Park',
                   description: 'One of the best trails at Zion NP. Get an early start to avoid the crowds.')

grand_canyon = james.posts.create!(trail: 'Bright Angel Trail',
                    park: 'Grand Canyon National Park',
                    description: "Great views of the Grand Canyon, but this one isn't for beginners. The hike down is easy, but hiking back up can be quite challenging.")
io = URI.parse('https://hikerbook.s3.us-east-2.amazonaws.com/seed_files/grand_canyon_image.jpg').open
grand_canyon.image.attach(io:, filename: 'grand_canyon_image.jpg')
