Genre.destroy_all

# Seed data
genres = [
  { name: 'Action' },
  { name: 'Adventure' },
  { name: 'Animation' },
  { name: 'Comedy' },
  { name: 'Crime' }
]

# Insert data into the database
genres.each do |genre|
  Genre.create(genre)
end

puts "Seeded #{Genre.count} genres."