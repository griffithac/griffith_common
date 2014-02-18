require './lib/griffith_common/version'

Gem::Specification.new do |s|
  s.name = "griffith_common"
  s.version = GriffithCommon::VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Andrew Griffith"]
  s.date = "2014-01-25"
  s.description = "Description of GriffithCommon."
  s.email = ["griffithac@gmail.com"]
  s.executables = ["rails"]
  s.files = [".gitignore", ".rvmrc", "Gemfile", "Gemfile.lock", "MIT-LICENSE", "README.rdoc", "Rakefile", "app/assets/images/griffith_common/.keep", "app/assets/javascripts/griffith_common/.keep", "app/assets/javascripts/griffith_common/global-after.js.coffee", "app/assets/javascripts/griffith_common/global-before.js.coffee", "app/assets/stylesheets/griffith_common/.keep", "app/assets/stylesheets/griffith_common/global.css.scss", "app/controllers/.keep", "app/helpers/.keep", "app/mailers/.keep", "app/models/.keep", "app/views/.keep", "app/views/application/_action_bar.html.haml", "app/views/application/_action_bar_blank.html.haml", "app/views/application/_back_buttons.html.haml", "app/views/application/_index_search.html.haml", "app/views/application/_index_search_blank.html.haml", "app/views/application/_paginate.html.haml", "app/views/application/_pagination_bar.html.haml", "bin/rails", "config/initializers/will_paginate.rb", "config/routes.rb", "griffith_common.gemspec", "lib/griffith_common.rb", "lib/griffith_common/application_controller.rb", "lib/griffith_common/application_helper.rb", "lib/griffith_common/bootstrap_helpers.rb", "lib/griffith_common/calendar_builder.rb", "lib/griffith_common/engine.rb", "lib/griffith_common/list_table_builder.rb", "lib/griffith_common/table_builder.rb", "lib/griffith_common/version.rb", "lib/griffith_common/will_paginate_twitter_bootstrap.rb", "lib/tasks/griffith_common_tasks.rake", "test/dummy/README.rdoc", "test/dummy/Rakefile", "test/dummy/app/assets/images/.keep", "test/dummy/app/assets/javascripts/application.js", "test/dummy/app/assets/stylesheets/application.css", "test/dummy/app/controllers/application_controller.rb", "test/dummy/app/controllers/concerns/.keep", "test/dummy/app/helpers/application_helper.rb", "test/dummy/app/mailers/.keep", "test/dummy/app/models/.keep", "test/dummy/app/models/concerns/.keep", "test/dummy/app/views/layouts/application.html.erb", "test/dummy/bin/bundle", "test/dummy/bin/rails", "test/dummy/bin/rake", "test/dummy/config.ru", "test/dummy/config/application.rb", "test/dummy/config/boot.rb", "test/dummy/config/database.yml", "test/dummy/config/environment.rb", "test/dummy/config/environments/development.rb", "test/dummy/config/environments/production.rb", "test/dummy/config/environments/test.rb", "test/dummy/config/initializers/backtrace_silencers.rb", "test/dummy/config/initializers/filter_parameter_logging.rb", "test/dummy/config/initializers/inflections.rb", "test/dummy/config/initializers/mime_types.rb", "test/dummy/config/initializers/secret_token.rb", "test/dummy/config/initializers/session_store.rb", "test/dummy/config/initializers/wrap_parameters.rb", "test/dummy/config/locales/en.yml", "test/dummy/config/routes.rb", "test/dummy/lib/assets/.keep", "test/dummy/log/.keep", "test/dummy/public/404.html", "test/dummy/public/422.html", "test/dummy/public/500.html", "test/dummy/public/favicon.ico", "test/griffith_common_test.rb", "test/integration/navigation_test.rb", "test/test_helper.rb"]
  s.homepage = "http://www.griffithind.com"
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new("~> 2.0")
  s.rubygems_version = "2.1.11"
  s.summary = "Summary of GriffithCommon."
  s.test_files = ["test/dummy/README.rdoc", "test/dummy/Rakefile", "test/dummy/app/assets/images/.keep", "test/dummy/app/assets/javascripts/application.js", "test/dummy/app/assets/stylesheets/application.css", "test/dummy/app/controllers/application_controller.rb", "test/dummy/app/controllers/concerns/.keep", "test/dummy/app/helpers/application_helper.rb", "test/dummy/app/mailers/.keep", "test/dummy/app/models/.keep", "test/dummy/app/models/concerns/.keep", "test/dummy/app/views/layouts/application.html.erb", "test/dummy/bin/bundle", "test/dummy/bin/rails", "test/dummy/bin/rake", "test/dummy/config.ru", "test/dummy/config/application.rb", "test/dummy/config/boot.rb", "test/dummy/config/database.yml", "test/dummy/config/environment.rb", "test/dummy/config/environments/development.rb", "test/dummy/config/environments/production.rb", "test/dummy/config/environments/test.rb", "test/dummy/config/initializers/backtrace_silencers.rb", "test/dummy/config/initializers/filter_parameter_logging.rb", "test/dummy/config/initializers/inflections.rb", "test/dummy/config/initializers/mime_types.rb", "test/dummy/config/initializers/secret_token.rb", "test/dummy/config/initializers/session_store.rb", "test/dummy/config/initializers/wrap_parameters.rb", "test/dummy/config/locales/en.yml", "test/dummy/config/routes.rb", "test/dummy/lib/assets/.keep", "test/dummy/log/.keep", "test/dummy/public/404.html", "test/dummy/public/422.html", "test/dummy/public/500.html", "test/dummy/public/favicon.ico", "test/griffith_common_test.rb", "test/integration/navigation_test.rb", "test/test_helper.rb"]

  s.add_runtime_dependency('will_paginate', ["~> 3.0.5"])
  s.add_runtime_dependency('bootstrap-sass', ["~> 3.1.1"])
  s.add_runtime_dependency('font-awesome-sass')
  s.add_runtime_dependency('bootstrap-datepicker-rails')
  s.add_runtime_dependency('simple_form')
  s.add_development_dependency('sqlite3', [">= 0"])
  s.add_development_dependency('pry', [">= 0"])
  
end
