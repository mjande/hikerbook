# frozen_string_literal: true

# Reset database
User.destroy_all

Dir[Rails.root.join('db/seeds/*.rb')].sort.each do |seed|
  load seed
end
