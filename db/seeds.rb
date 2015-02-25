# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
EndUser.delete_all
Doodle.delete_all


u1 = User.create(email: "admin@admin.se", password: "hejhej", password_confirmation: "hejhej", webbsite_url: "www.hejhej.se", website_name: "hejhej-siten", is_user_admin: true)

EndUser.create(email: "hej@hej.se", password: "hejhej", password_confirmation: "hejhej", username: "hejhej", bio_text: "hejhej bio text")
EndUser.create(email: "hej2@hej.se", password: "hejhej", password_confirmation: "hejhej", username: "hejhej2", bio_text: "hejhej bio text")

d = Doodle.create(doodle_text: "hejhej doodle text")
EndUser.first.doodles << d

d = Doodle.create(doodle_text: "hejhej doodle text till user 2")
EndUser.last.doodles << d