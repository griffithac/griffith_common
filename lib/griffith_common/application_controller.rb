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
  end
end
