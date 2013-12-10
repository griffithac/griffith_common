require 'griffith_common/table_builder'
require 'griffith_common/calendar_builder'
require 'griffith_common/list_table_builder'
require 'griffith_common/bootstrap_helpers'
require 'griffith_common/will_paginate_twitter_bootstrap'


module GriffithCommon
  module ApplicationHelper
    
    include GriffithCommon::TableBuilder
    include GriffithCommon::CalendarBuilder
    include GriffithCommon::ListTableBuilder
    include GriffithCommon::BootstrapHelpers
    include GriffithCommon::WillPaginateTwitterBootstrap::Helper


    def errors object
      render 'errors', object: object
    end


    def current_model
      params[:controller].singularize
    end
    

    def current_controller
      params[:controller]
    end


    def current_action
      params[:action]
    end


    def submit_search_tag
      button_tag(type: 'submit', class: 'btn btn-default') do
        icon(:search)
      end
    end


    def full_text_search_tag
      text_field_tag :q, params[:q], class: 'search-query', 
                                     placeholder: 'Full Text Search'
    end


    def search_column_options clazz = nil
      clazz ||= get_class(params[:controller].to_s.classify)
      columns = {}
      if clazz.respond_to? :search_columns
        clazz.search_columns.map do |title, column| 
          columns[title.to_s.titleize] = column.to_s
        end
      else
        columns['All'] = nil
      end
      return columns
    end


    def sortable title, label = nil
      column = 
        get_class(params[:controller].to_s.classify).search_columns[title.to_sym]
      
      label ||= title.to_s.titleize
      
      css_class = if column.to_s == sort_column.to_s
        "current #{sort_direction}" 
      else 
        nil
      end

      direction = if column.to_s == sort_column.to_s && sort_direction == "asc" 
        "desc"
      else 
        "asc"
      end

      link_to label, params.merge(sort:      column, 
                                  direction: direction, 
                                  page:      nil), { class: css_class }
    end


    def current_app
      case Rails.application.class.parent_name
      when 'GriffithindCo'  then 'Griffith'
      when 'GriffithindNet' then 'Griffith'
      when 'GriffithindCom' then 'Griffith'
      when 'WslservicesCo'  then 'WSL'
      when 'WslservicesNet' then 'WSL'
      when 'WslservicesCom' then 'WSL'
      else 'Unknown App'
      end
    end


    def brand_for_site
      case request.host
      when 'localhost'       then "#{current_app} Dev"
      when 'griffithind.co'  then 'Griffith'
      when 'griffithind.net' then 'Griffith'
      when 'griffithind.com' then 'Griffith'
      when 'wslservices.co'  then 'WSL, Inc.'
      when 'wslservices.net' then 'WSL, Inc.'
      when 'wslservices.com' then 'WSL, Inc.'
      else 'Unknown Site'
      end
    end


    def current_page_title
      case current_controller
      when 'sessions'
        "#{brand_for_site} - Login" 
      when 'static_pages'
        "#{brand_for_site} - #{current_action.titleize}"         
      else 
        "#{brand_for_site} - #{current_controller.titleize.pluralize}" 
      end
    end


    def index_edit_button model
      if can? :edit, model
        link_to(icon(:edit), 
                eval("edit_#{model.class.to_s.underscore}_path(#{model.id})"), 
                class: 'btn btn-default btn-xs') 
      end
    end


    def index_destroy_button model, message = 'Are you sure?'
      if can? :delete, model
        link_to( icon(:times), model, data: { confirm: message }, 
                                      method: :delete, 
                                      class: 'btn btn-xs btn-danger' )
      end
    end


    def tag_list(model)
      list = ''
      model.tags.map(&:name).each do |item|
        list += "<span class='label label-info'>#{icon(:tag)} #{item}</span> " 
      end
      list.html_safe
    end


    def add_button
      button_tag(type: :submit, class: 'btn btn-primary') { icon(:plus) }
    end

 
    def remove_button model
      link_to icon(:times), model, data: { confirm: 'Are you sure?' }, 
                                   method: :delete, 
                                   class: 'btn btn-xs btn-danger', 
                                   style: 'margin-left: 12px;', 
                                   remote: true
    end


    ## Payroll Helper
    def formatted_rate pay_rate
      if PayRate.rate_types[pay_rate.rate_type] == :amount
        number_to_currency(pay_rate.rate)
      else
        number_to_percentage(pay_rate.rate, precision: 2)
      end
    end


    def hours_mins mins # Pretty print time in hours and mins
      hours = (mins / 60)
      min  = mins % 60
      "#{hours}:#{min.to_s.rjust(2,'0')}"
    end


    def full_address address
      content_tag :div do
        content_tag( :div, address.line1 ) +
        ( address.line2 ? content_tag( :div, address.line2 ) : " " ) +
        content_tag( :div, address.zip_code.city_state_zip )
      end
    end


    def yes_no val
      val ? 'yes' : 'no'
    end


    def index_edit_button model
      if can? :edit, model
        link_to(icon(:edit), 
                eval("edit_#{model.class.to_s.underscore}_path(#{model.id})"), 
                class: 'btn btn-default btn-xs' )
      end
    end

    
    def index_destroy_button model, message = 'Are you sure?'
      if can? :delete, model
        link_to(icon(:times), 
                model, 
                data: { confirm: message }, 
                method: :delete,
                class: 'btn btn-xs btn-danger') 
      end
    end


    def tag_list(model)
      list = ''
      model.tags.map(&:name).each do |item|
        list += "<span class='label label-info'>#{icon(:tag)} #{item}</span> " 
      end
      list.html_safe
    end

  
    def valid_path? path, method
      begin
        Rails.application.routes.recognize_path(path, method: method)
      rescue
        false
      end
    end


    def print(field)
       "<tr><th>#{field.to_s.humanize}</th><td>#{@object.send(field)}</td></tr>"
    end

    
    def admin_debug
      if logged_in? && 
         current_user.admin? && 
         current_user.full_name == 'Griffith, Andrew'
      then
        debug(params) +
        debug(eval("@#{params[:controller].downcase.singularize}")) +
        debug(eval("@#{params[:controller].downcase.pluralize}"))
      end
    end

    
    def search_query_tag
      text_field_tag :q, params[:q], placeholder: 'Enter Search Query'
    end
    

    def submit_search_tag
      button_tag(type: 'submit', class: 'btn btn-default') do
        icon(:search)
      end
    end


    private

    def get_class target_clazz
      ActiveRecord::Base.subclasses.each do |clazz|
       if clazz.to_s == target_clazz
         return clazz
       end
      end    
    end

  end
end