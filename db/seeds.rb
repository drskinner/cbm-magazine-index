# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Role.destroy_all

Role.create! [{ name: 'gsa', position: 99 },
              { name: 'archivist', position: 80 },
              { name: 'guest', position: 10 }]

puts "Set up #{Role.count} roles."

if Magazine.count.zero?
  %w[ahoy cbm cbm_micro power_play cbm_world gazette compute diehard geoworld info run torpet tpug transactor].each do |s|
    Magazine.create!(
      slug: s,
      name: I18n.t("magazine.name.#{s}"),
      alpha_guide: I18n.t("magazine.name.#{s}").downcase.gsub('the ', '')
    )
  end
  puts "Created #{Magazine.count} magazines."
else
  puts 'Magazines have already been seeded.'
end
