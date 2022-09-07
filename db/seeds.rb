# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create some default users
user1 = User.create!(username: 'Chris Smith', email: 'chris@example.com', password: 'password')
user2 = User.create!(username: 'Mary Murphy', email: 'mary@example.com', password: 'password')
user3 = User.create!(username: 'James Jameson', email: 'james@example.com', password: 'password')

user1.posts.create!(trail: 'Yosemite Falls Trail',
                   park: 'Yosemite National Park',
                   description: 'Amazing hike featuring a beautiful view of Yosemite Falls. A must for anyone visiting Yosemite')
user1.posts.create!(trail: 'Grand Prismatic Spring Overlook Trail',
                   park: 'Yellowstone National Park',
                   description: "If you're looking to see the amazing geysers at Yellowstone, check this trail out! Hiking this trail was a blast for me and my children.")
user2.posts.create!(trail: 'Highline Trail',
                   park: 'Glacier National Park',
                   description: 'Beautiful alpine hike with great views of mountains, lakes, and glaciers.')
user2.posts.create!(trail: "Angel's Landing",
                   park: 'Zion National Park',
                   description: 'One of the best trails at Zion NP. Get an early start to avoid the crowds.')
user3.posts.create!(trail: 'Bright Angel Trail',
                   park: 'Grand Canyon National Park',
                   description: "Great views of the Grand Canyon, but this one isn't for beginners. The hike down is easy, but hiking back up can be quite challenging.")
