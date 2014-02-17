module GriffithCommon

  if defined?(Rails)
    require 'griffith_common/table_builder'
    require 'griffith_common/calendar_builder'
    require 'griffith_common/list_table_builder'
    require 'griffith_common/bootstrap_helpers'
    require 'griffith_common/will_paginate_twitter_bootstrap'
    require 'griffith_common/application_helper'
    require 'griffith_common/application_controller'
    require "griffith_common/engine"
  else
    throw 'GriffithCommon not loading'
  end

end
