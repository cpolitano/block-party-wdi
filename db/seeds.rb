# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

blocks = Block.create([
  { name: 'anonymous', screen_name: 'troll1', created_at: '10-25-14' },
  { name: 'gr123', screen_name: 'gr123', created_at: '10-21-14' },
  { name: 'teradactyl', screen_name: 'teradactyl83', created_at: '10-27-14' }
  ])
