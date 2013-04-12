# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

#Languages Catalog
Language.destroy_all
languages = Language.create([{:name=>'English',:approved_flag=>true},{:name=>'Spanish',:approved_flag=>true}])
languages.each do |language| language.save end
