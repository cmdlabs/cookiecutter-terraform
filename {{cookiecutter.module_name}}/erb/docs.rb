require 'erb'
template = File.read('erb/README.erb')
renderer = ERB.new(template, nil, '-')
File.write('README.md', renderer.result())
