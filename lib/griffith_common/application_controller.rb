module GriffithCommon
  module ApplicationController

    DEFAULT_ROWS = 15
    MIN_ROWS     = 1
    MAX_ROWS     = 100
    DEFAULT_SORT = 'asc'

    ActionController::Base.helper_method :sort_column, :sort_direction, :current_resource

    def per_page
      if (MIN_ROWS..MAX_ROWS).include? params[:per_page].to_i
        params[:per_page]
      else
        if current_user.try(:per_page).to_i > 0
          current_user.per_page
        else
          DEFAULT_ROWS
        end
      end
    end

    def sort_direction direction = DEFAULT_SORT
      if %w[asc desc].include?(params[:direction])
        params[:direction]
      else
        direction
      end
    end

    def sort_column
      return unless params[:sort].present? && sortable_columns.include?(params[:sort])
      params[:sort]
    end

    def sortable_columns
      klass = params[:controller].classify.constantize

      constant = klass::SORT_COLUMNS if defined? klass::SORT_COLUMNS

      if constant
         klass::SORT_COLUMNS
      else
        klass.search_columns.values
      end
    end

    def sort_column_and_direction
      return unless sort_column.present? && sort_direction.present?
      "#{sort_column} #{sort_direction}"
    end

    def sort_params
      sort_column_and_direction
    end

    def page_params
      { page: params[:page], per_page: per_page }
    end

    def current_resource
      request_path =
        request.path.sub(/\..*/, '').split('/').reject do |p|
          ['new', 'edit', 'event', 'geocode', ''].include?(p)
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
  end
end
