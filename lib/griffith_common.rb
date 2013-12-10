require "griffith_common/engine"
require "griffith_common/table_builder"
require "griffith_common/calender_builder"
require "griffith_common/list_table_builder"
require 'griffith_common/state_machine_mixins'

module GriffithCommon
  ActionView::Base.send :include, GriffithCommon::TableBuilder
  ActionView::Base.send :include, GriffithCommon::CalendarBuilder
  ActionView::Base.send :include, GriffithCommon::ListTableBuilder

  # DateTime Formats
  Time::DATE_FORMATS[:gtime]           = '%l:%M %p'
  Time::DATE_FORMATS[:gtime_short]     = '%I:%M'
  Time::DATE_FORMATS[:gdate]           = '%m-%d'
  Time::DATE_FORMATS[:gdatetime]       = '%A, %b %e, %Y at %l:%M %p'
  Time::DATE_FORMATS[:gdatetime_short] = '%m-%d %I:%M %p'
  Time::DATE_FORMATS[:gdatetime_long]  = '%A, %B %d, %Y at %I:%M %p'
end
