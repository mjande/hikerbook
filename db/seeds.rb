# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create some default users
User.create(username: 'Chris Smith', email: 'chris@example.com', password: 'password')
User.create(username: 'Mary Murphy', email: 'mary@example.com', password: 'password')
User.create(username: 'James Jameson', email: 'james@example.com', password: 'password')
