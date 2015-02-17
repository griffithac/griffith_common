# Require all gems here
require 'bootstrap-sass'
require 'autoprefixer-rails'
require 'bootstrap-datepicker-rails'
require 'font-awesome-rails'
require 'simple_form'
require 'will_paginate'
require 'select2-rails'
require 'state_machine'

module GriffithCommon
  if defined?(Rails)
    require 'griffith_common/table_builder'
    require 'griffith_common/calendar_builder'
    require 'griffith_common/list_table_builder'
    require 'griffith_common/bootstrap_helpers'
    require 'griffith_common/will_paginate_twitter_bootstrap'
    require 'griffith_common/formatting_helpers'
    require 'griffith_common/application_helper'
    require 'griffith_common/application_controller'
    require 'griffith_common/engine'
    require 'griffith_common/validators/email_validator'
    require 'griffith_common/validators/phone_number_validator'
  else
    throw 'GriffithCommon not loading'
  end
end
