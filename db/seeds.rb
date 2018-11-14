# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts Rails.root.join('db', 'seeds.rb')
env_seed_file = Rails.root.join('db', 'seeds', Rails.env + '.rb')
puts env_seed_file
require env_seed_file if File.file?(env_seed_file)
