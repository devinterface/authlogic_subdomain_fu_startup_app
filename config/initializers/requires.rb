Dir[File.join(RAILS_ROOT, 'lib', '*.rb')].each do |f|
  require f
end
