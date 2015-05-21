module GriffithCommon
  module ApplicationHelper
    include GriffithCommon::TableBuilder
    include GriffithCommon::CalendarBuilder
    include GriffithCommon::ListTableBuilder
    include GriffithCommon::BootstrapHelpers
    include GriffithCommon::WillPaginateTwitterBootstrap::Helper
    include FormattingHelpers

    # used in testing to check to this file has been loaded
    def gem_loaded?
      true
    end

    def errors(object)
      render 'errors', object: object
    end

    def flash_class(name)
      class_name = case name.to_sym
                   when :notice  then 'success'
                   when :success then 'success'
                   when :primary then 'primary'
                   when :info    then 'info'
                   when :warning then 'warning'
                   when :danger  then 'danger'
                   else 'info'
                   end
      "center alert alert-#{ class_name }"
    end

    def current_model
      current_controller.singularize
    end

    def current_object
      model_var = "@#{current_model}"
      controller_var = "@#{params[:controller].singularize}"

      if instance_variables.include?(model_var.to_sym)
        instance_variable_get model_var
      elsif instance_variables.include?(controller_var.to_sym)
        instance_variable_get controller_var
      end
    end

    def current_model_title(title = nil)
      if title.present?
        title
      else
        current_controller.singularize.titleize
      end
    end

    def current_model_class
      current_controller.classify.constantize
    end

    def current_controller
      if params[:type].present?
        params[:type].underscore.pluralize
      else
        params[:controller].to_s
      end
    end

    def edit_current_resource_path
      polymorphic_url([:edit, current_resource].flatten)
    end

    def current_resource
      request_path =
        request.path.split('/').reject do |p|
          ['new', 'edit', 'event', ''].include?(p)
        end

      case request_path.count
      when 1,2
         request_path[0].to_sym
      when 3,4
         [request_path[0].singularize.classify.constantize.find(request_path[1]), request_path[2].to_sym]
      else
        raise 'resource can not be inferred'
      end

    end

    def current_action
      params[:action].to_s
    end

    def search_column_options(clazz = nil)
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

    def sortable(title, label = nil)
      column =
        get_class(
          params[:controller].to_s.classify
        ).search_columns[title.to_sym]

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
      app = Rails.application.class.parent_name
      case
      when app.match('Griffith')    then 'Griffith'
      when app.match('Wslservices') then 'WSL'
      else 'Unknown App'
      end
    end

    def brand_for_site
      host = request.host
      case
      when host.match('localhost')   then "#{current_app} Dev"
      when host.match('griffithind') then 'Griffith'
      when host.match('wslservices') then 'WSL, Inc.'
      when host.match('flooring2') then "f&sub2;"
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

    def index_buttons(models)
      index_show_button(models) + '<span> </span>'.html_safe +
      index_edit_button(models) + '<span> </span>'.html_safe +
      index_destroy_button(models)
    end

    def index_show_button(models)
      models         = [models].flatten
      primary_model  = models.last
      path_partial   = models.map(&:class).map(&:to_s).map(&:underscore).join('_')
      if can? :read, primary_model
        link_to(icon('external-link'),
                send("#{path_partial}_path", *models),
                     class: 'btn btn-info btn-xs',
                     target: '_blank')
      end
    end

    def index_edit_button(models)
      models         = [models].flatten
      primary_model  = models.last
      path_partial   = models.map(&:class).map(&:to_s).map(&:underscore).join('_')
      if can? :edit, primary_model
        link_to(icon(:edit),
                send("edit_#{path_partial}_path", *models),
                class: 'btn btn-default btn-xs')
      end
    end

    def index_destroy_button(models, message = 'Are you sure?')
      models         = [models].flatten
      primary_model  = models.flatten.last
      if can? :delete, [models].flatten.last
        link_to(icon(:times), models, data: { confirm: message },
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

    def search_query_tag opts = {}
      opts = { placeholder: 'Enter Search Query' }.merge(opts)
      text_field_tag :q, params[:q], placeholder: opts[:placeholder]
    end

    def submit_search_tag
      button_tag(type: 'submit', class: 'btn btn-default') do
        icon(:search)
      end
    end

    def full_text_search_tag opts = {}
      opts = { placeholder: 'Full Text Search' }.merge(opts)
      text_field_tag :q, params[:q], class: 'search-query',
                                     placeholder: opts[:placeholder]
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
