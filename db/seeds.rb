# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

5.times do |i|
  Band.create!(name: "Band #{i}")
end

5.times do |i|
  5.times do |j|
    Album.create(name: "Album #{j}", band_id: i, recording_type: 'Studio')
    5.times do |x|
      Track.create(name: "track #{x}", album_id: j)
    end
  end
end
