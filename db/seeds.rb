# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'open-uri'
require 'active_record/fixtures'

def clean(code)

  translator = {
    'ARE' => 'UAE',
    'FRO' => 'FAR',
    'SAU' => 'KSA',
    'MUS' => 'MRI',
    'DEU' => 'GER',
    'LKA' => 'SRI',
    'MRT' => 'MTN',
    'VUT' => 'VAN',
    'IRN' => 'IRI',
    'HRV' => 'CRO',
    'SVN' => 'SLO',
    'PHL' => 'PHI',
    'ZAF' => 'RSA',
    'ZMB' => 'ZAM',
    'BMU' => 'BER',
    'SGP' => 'SIN',
    'GTM' => 'GUA',
    'LBN' => 'LIB',
    'NGA' => 'NGR',
    'GRC' => 'GRE',
    'SLV' => 'ESA',
    'LBY' => 'LBA',
    'NLD' => 'NED',
    'HND' => 'HON',
    'VGB' => 'ISV',
    'VIR' => 'ISV',
    'WSM' => 'ASA',
    'KWT' => 'KUW',
    'IDN' => 'INA',
    'PSE' => 'PLE',
    'AGO' => 'ANG',
    'KHM' => 'CAM',
    'PRY' => 'PAR',
    'URY' => 'URU',
    'PRT' => 'POR',
    }
  
  if translator.has_key?(code)
    return  translator[code]
  else
    return code
  end
  
end


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
    n = Nation.find_by_sql(["select * from nations where name like ?", "%#{name}%"]).first
    if n        
      	n.name = name
      	n.ioc_code = clean(ioc_code)
      	n.wiki_url = wiki_url
        print "    #{n.name} => #{n.ioc_code}\n"
      n.save!
    else
      print "couldnt find '#{name}'\n"
    end
    
  end
end

