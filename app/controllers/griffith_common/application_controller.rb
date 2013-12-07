module GriffithCommon
  class ApplicationController < ActionController::Base
  
    helper_method :sort_column, :sort_direction

    def per_page
      params[:per_page] ||= 20
    end
    

    def rows_per_page
      %w[25 50 75 100].include?(params[:per_page]) ? params[:per_page] : per_page
    end


    def sort_direction starting_direction = 'asc'
      if %w[asc desc].include?(params[:direction])
        params[:direction]
      else
        starting_direction
      end
    end


    def sort_column
      if params[:sort].nil?
        default_sort_column
      else
        sortable_columns.include?(params[:sort]) ? params[:sort] : default_sort_column
      end
    end
    

    def default_sort_column
      if sortable_columns.first.nil?
        sortable_columns.second
      else
        sortable_columns.first
      end
    end


    def sortable_columns
      valid_sort_columns = Array.new
      eval("#{params[:controller].classify}.search_columns").each_value do |column|
        valid_sort_columns << column
      end
      return valid_sort_columns
    end

  end
end
