# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

e = Event.create(name: "sample event")
EventsBaseIngredient.create(event_id: e.id, base_ingredient_id: 3)
EventsBaseIngredient.create(event_id: e.id, base_ingredient_id: 1)
EventsBaseIngredient.create(event_id: e.id, base_ingredient_id: 38)
EventsBaseIngredient.create(event_id: e.id, base_ingredient_id: 7)
EventsBaseIngredient.create(event_id: e.id, base_ingredient_id: 21)
EventsBaseIngredient.create(event_id: e.id, base_ingredient_id: 20)
EventsBaseIngredient.create(event_id: e.id, base_ingredient_id: 74)
EventsBaseIngredient.create(event_id: e.id, base_ingredient_id: 4)
EventsBaseIngredient.create(event_id: e.id, base_ingredient_id: 15)
EventsBaseIngredient.create(event_id: e.id, base_ingredient_id: 22)
EventsBaseIngredient.create(event_id: e.id, base_ingredient_id: 27)
EventsBaseIngredient.create(event_id: e.id, base_ingredient_id: 36)