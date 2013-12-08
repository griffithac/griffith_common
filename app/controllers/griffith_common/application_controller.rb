module GriffithCommon
  class ApplicationController < ActionController::Base
  
    helper_method :sort_column, :sort_direction

    def per_page
      params[:per_page] ||= 25
    end
    

    def rows_per_page
      if params[:per_page].present?
        params[:per_page]
      else
        per_page
      end
    end


    def sort_direction starting_direction = 'asc'
      if %w[asc desc].include?(params[:direction])
        params[:direction]
      else
        starting_direction
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
      sortable_columns.each { |column| return column if column.present? }
    end

    def sortable_columns
      valid_sort_columns = []
      columns = eval("#{params[:controller].classify}.search_columns")
      columns.each_value do |column|
        valid_sort_columns << column
      end
      valid_sort_columns
    end

  end
end
