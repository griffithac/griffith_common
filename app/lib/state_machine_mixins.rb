module StateMachineMixins
  
  module Model
    

    def self.included(base)
      base.class_eval do
        def self.state_names
          ary = self.states_map
          ary.prepend [ 'All', nil ]
          Hash[*ary.flatten]
        end
        
        def self.states_map
          ary = self.states.map { |key, val| [ key.to_s.titleize, val ] }
        end

      end
    end


    def current_state
      self.human_state_name.titleize
    end

    def call_event params
      if ( eval params[:event] if self.state_events.include?(params[:event].to_sym) )
        if self.respond_to? :current_user_id
          self.current_user_id = params[:current_user_id].to_i
          self.send(:set_creator_and_updater)
          self.save
        end
      end
    end

    def event_names
      ary = self.state_events.map { |val| [ val.to_s.titleize, val ] }
      Hash[*ary.flatten]
    end

  end

  module Helper

    def state_changer model
      html = ''
      model.state_events.each do |event|
        if eval("model.can_#{event.to_s}?")
          html += link_to(event.to_s.titleize, eval("event_#{model.class.to_s.underscore}_path(model, event: :#{event})"), class: 'btn btn-primary')
          html += content_tag :br
        end
      end
      html.html_safe
    end

    def state_label model
      content_tag(:div, class: state_class(model)) do 
        model.current_state 
      end
    end

    private
    
    def state_class model 
      case model.current_state
      when 'To Be Processed'        then 'label label-info'
      when 'Open'                   then 'label label-info'
      when 'Workflowed'             then 'label label-warning'
      when 'Archived'               then 'label label-default'
      when 'Closed'                 then 'label label-default'
      when 'Question Asked'         then 'label label-warning'
      when 'Requires Clarification' then 'label label-info'
      when 'Question Answered'      then 'label label-success'
      when 'Incomplete'             then 'label label-warning'
      when 'Complete'               then 'label label-default'
      else 'label label-default'
      end  
    end
  
  end

end