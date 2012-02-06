class CarouselGenerator < Rails::Generators::Base
  require 'rails/generators/active_record'
  include Rails::Generators::Migration
  include Thor::Actions

  source_root File.expand_path('../../..', __FILE__) 
  
  def generate_migration
    destination   = File.expand_path('db/migrate/01_create_comfy_carousel.rb', self.destination_root)
    migration_dir = File.dirname(destination)
    destination   = self.class.migration_exists?(migration_dir, 'create_comfy_blog')
  
    if destination
      puts "\e[0m\e[31mFound existing create_comfy_blog.rb migration. Remove it if you want to regenerate.\e[0m"
    else
      migration_template 'db/migrate/01_create_comfy_carousel.rb', 'db/migrate/create_comfy_carousel.rb'
    end
  end
  
  def generate_initialization
    copy_file 'config/initializers/comfy_carousel.rb', 'config/initializers/comfy_carousel.rb'
  end
  
  def show_readme
    readme 'lib/generators/README'
  end
  
  def self.next_migration_number(dirname)
    ActiveRecord::Generators::Base.next_migration_number(dirname)
  end
end