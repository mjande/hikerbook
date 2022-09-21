// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import "@hotwired/turbo-rails"
import "controllers"

// Temporary script for deactivating Turbo across the whole app (for testing compatibility with old browsers)
import { Turbo } from '@hotwired/turbo-rails'
Turbo.session.drive = false
