namespace :sweatshop do
  
  Folder = "#{RAILS_ROOT}/spec/factories"
  
  desc "Generate factories for all ActiveRecord Models"
  task :generate do
    require "#{RAILS_ROOT}/config/environment"
    
    Dir.mkdir(Folder) unless File.directory?(Folder)
    
    updated_models = []
    
    models.each{ |model| updated_models << model.to_s if generate_factory(model) }

    print_outro(updated_models)
  end
  
  def generate_factory(model)
    name = model.to_s.tableize.singularize
    out_path = "#{Folder}/#{name}.rb"
    
    begin
      out_file = (File.exist?(out_path)) ? File.open(out_path, "w") : File.new(out_path, "w")

      b_var = name[0...1]
      out_file.puts "Factory.define :#{name} do |#{b_var}|"

      model.columns_hash.each_pair do |key, val|
        unless key =~ /^(id|type)$/
          value = case val.type.to_s
            when "string", "text": "'foo'"
            when "integer": 1
            when "float": 1.0
            when "date": "'#{Date.today}'"
            when "datetime", "time", "timestamp": "'#{Time.now}'"
            when "boolean": false
            when "binary": "''"
          end

          out_file.puts "  #{b_var}.#{key} #{value}"
        end
      end

      out_file.puts "end"
      out_file.close
    rescue
      puts "I can't generate a factory for '#{model}'"
      File.delete(out_path)
      false
    end
    
    true
  end
  
  def models
    Dir.glob("#{RAILS_ROOT}/app/models/*.rb").map{|p| File.basename(p, ".rb").camelize.constantize}.select{|m| m < ActiveRecord::Base}
  end
  
  def print_outro(models)
    puts <<-END

Created Factories for: #{models.to_sentence}

Make sure you put the two following lines into spec/spec_helper.rb:
  require 'factory_girl'
  Dir.glob("#{RAILS_ROOT}/spec/factories/*.rb").each {|f| require f }
    END
  end
  
end