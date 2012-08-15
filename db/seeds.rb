# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'open-uri'
require 'active_record/fixtures'

Nation.delete_all
open("http://openconcept.ca/sites/openconcept.ca/files/country_code_drupal_0.txt") do |nations|
  nations.read.each_line do |nation|
    code, name = nation.chomp.split("|")
    Nation.create!(:name => name, :fips_code => code)
    print "#{name} => #{code}\n"
  end
end


regex = /<tt>(?<ioc_code>.{3})<\/tt><\/td>.<td><a href="(?<wiki_url>.*?)" title="(?<title>.*?)">(?<name>.*?)<\/a><\/td>.<\/tr>$/m
open("http://en.wikipedia.org/wiki/ISO_3166-1_alpha-3") do |nations|
  
  nations.read.scan(regex).each do |nation|
    
    ioc_code, wiki_url,title,name = nation
    n = Nation.find_or_create_by_name(:name => name)
    	n.name = name
    	n.ioc_code = clean(ioc_code)
    	n.wiki_url = wiki_url
    n.save!
    print "    #{name} => #{ioc_code}\n"
  end
end

def clean(code)
	if code == 'UAE'
		'ARE'
	end

	if code == 'FAR'
		'FRO'
	end
	
end