module GriffithCommon
  module ApplicationController #< ActionController::Base

    DEFAULT_ROWS = 15
    MIN_ROWS     = 1
    MAX_ROWS     = 100
    DEFAULT_SORT = 'asc'

    ActionController::Base.helper_method :sort_column, :sort_direction

    def per_page
      if (MIN_ROWS..MAX_ROWS).include? params[:per_page].to_i
        params[:per_page]
      else
        DEFAULT_ROWS
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
      if params[:sort].present? && sortable_columns.include?(params[:sort])
        params[:sort]
      else
        default_sort_column
      end
    end

    def default_sort_column
      sortable_columns.compact.first
    end

    def sortable_columns
      eval("#{params[:controller].classify}.search_columns").values
    end

  end
end
