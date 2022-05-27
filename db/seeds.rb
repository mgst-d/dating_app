# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
hobby_list = ['Cooking','Reading', 'Traveling', 'Video gaming', 'Photography', 'Music', 'Sport', 'Board games', 'Gardening', 'Fishing']
work_list = ['Healthcare', 'Education', 'Sales', 'Sports', 'Marketing', 'IT', 'Driver', 'Insurance', 'Bank', 'Business', 'Art', 
             'Construction', 'Rescuer', 'Police', 'Army', 'Beauty', 'TV and radio', 'Industry', 'Fermer', 'Other']

def essence_create(model, title_list_array)
  title_list_array.each do |title|
    model.create(title: title)
  end
end

essence_create(Hobby, hobby_list)
essence_create(Work, work_list)