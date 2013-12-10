module GriffithCommonFull
  module ListTableBuilder
    
    ## add instance methods to class
    def self.included(base)
      base.send :include, ListTableBuilder
    end
    
    module ListTableBuilder
      include ::ActionView::Helpers::TagHelper
      
      def list_table_for collection, options = {}
        options = { class: 'table table-hover', allow_nils: false }.merge(options)

        raise ArgumentError, "Missing block" unless block_given?
        @allow_nils = options[:allow_nils]
        @collection = collection
        content_tag :table , class: "#{options[:class]}" do
          yield(collection)
        end.html_safe
      end
      
      def list_table_tag(options = {}, &block)
        raise ArgumentError, "Missing block" unless block_given?      
        content_tag :table , class: "#{options[:class]}" do |t|
          yield
        end.html_safe
      end 
      
      def item attribute, value = nil, options = {}
        
        if @allow_nils == false
          unless nil_row?(attribute, value)
            if value.nil? && @collection && attribute.class == Symbol then
              title = attribute.to_s.titleize
              content_tag :tr do
                content_tag( :th, title, class: options[:th_class] ) +
                content_tag( :td, eval("@collection.#{attribute}") )
              end
            else
              title = attribute.to_s.titleize
              content_tag :tr do
                content_tag( :th, title, class: options[:th_class] ) +
                content_tag( :td, value, class: options[:td_class] )
              end
            end
          end
        end
      end

      private 

      def nil_row? attribute, value
        case
        when value.present?
          return false
        when attribute.class == Symbol && eval("@collection.#{attribute}").present?
          return false
        else
          return true
        end
      end
      
    end
    
  end
end