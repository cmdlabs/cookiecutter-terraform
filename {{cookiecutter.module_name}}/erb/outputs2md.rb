#!/usr/bin/env ruby

file = ARGV[0] ; result = '' ; data = {}

File.readlines(file).each do |line|
  if line =~ /^output/
    name = line.split('"')[1]
    data = {:name=>name}
  end

  if line =~ /description/
    data[:description] = line.split('"')[1]
  end

  if line =~ /^}/
    data[:required] = data[:default] == '' ? 'Yes' : 'No'
    string = \
      "|" + data[:name] + \
      "|" + data[:description] + "|\n" 
    result += string
  end
end

puts result
