# frozen_string_literal: true

acadia = Park.create(name: 'Acadia National Park')
io = URI.parse('https://hikerbook.s3.us-east-2.amazonaws.com/seed_files/acadia_image.jpg').open
acadia.image.attach(io:, filename: 'acadia_image.jpg')

olympic = Park.create(name: 'Olympic National Park', url: 'https://www.nps.gov/olym/index.htm')
io = URI.parse('https://hikerbook.s3.us-east-2.amazonaws.com/seed_files/olympic_image.jpg').open
olympic.image.attach(io:, filename: 'olympic_image.jpg')

yellowstone = Park.create(name: 'Yellowstone National Park', url: 'https://www.nps.gov/yell/index.htm')
io = URI.parse('https://hikerbook.s3.us-east-2.amazonaws.com/seed_files/yellowstone_image.jpg').open
yellowstone.image.attach(io:, filename: 'yellowstone_image.jpg')

rainer = Park.create(name: 'Mount Rainier National Park', url: 'https://www.nps.gov/mora/index.htm')
io = URI.parse('https://hikerbook.s3.us-east-2.amazonaws.com/seed_files/mount_rainer_image.jpg').open
rainer.image.attach(io:, filename: 'mount_rainer_image.jpg')

denali = Park.create(name: 'Denali National Park and Preserve', url: 'https://www.nps.gov/dena/index.htm')
io = URI.parse('https://hikerbook.s3.us-east-2.amazonaws.com/seed_files/denali_image.jpg').open
denali.image.attach(io:, filename: 'denali_image.jpg')
