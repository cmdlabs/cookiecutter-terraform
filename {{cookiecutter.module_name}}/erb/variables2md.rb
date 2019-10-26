#!/usr/bin/env ruby

file = ARGV[0] ; result = '' ; data = {}

File.readlines(file).each do |line|
  if line =~ /^variable/
    name = line.split('"')[1]
    data = {:name=>name, :default=>'""'}
  end

  if line =~ /^ +type/
    data[:type] = line =~ /object/ ? 'object' : line.split(' ')[2]
  end

  if line =~ /^ +description/
    data[:description] = line.split('"')[1]
  end

  if line =~ /^ +default/
    data[:default] = line.split('=')[1].gsub(/"/,'').gsub(/^ +/,'').chomp
    data[:default] = '""' if data[:default].empty?
    data[:default] = '(map)' if data[:default] == '{'
  end

  if line =~ /^}/
    data[:required] = data[:default] == '""' ? 'Yes' : 'No'
    string = \
      "|" + data[:name] + \
      "|" + data[:description] + \
      "|" + data[:type] + \
      "|" + data[:default] + \
      "|" + data[:required] + "|\n" 
    result += string
  end
end

puts result
