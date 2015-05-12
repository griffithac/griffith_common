# This module could be included in any active record model where there is both a creator_id and a updater_id.
# All ownership logic should be included here.

module Ownership
  module Model
    def self.included(base)
      base.instance_eval do
        belongs_to :creator, :class_name => 'User', :foreign_key => 'creator_id'
        belongs_to :updater, :class_name => 'User', :foreign_key => 'updater_id'
      end
    end

    def creator?(user)
      creator_id == user.id
    end

    def updater?(user)
      updater_id == user.id
    end

    def current_user_id
      @current_user_id
    end

    def current_user_id=(val)
       @current_user_id = val
       if creator_id.nil?
         self[:creator_id] = val
         self[:updater_id] = val
       else
         self[:updater_id] = val
       end
    end
  end

  module Controller
    def self.included(base)
      base.class_eval do
        before_filter :add_ownership_to_params
        def add_ownership_to_params
          if current_user.nil?
            access_denied
          else
          model_key = self.class.to_s.gsub(/sController/, '').underscore.to_sym
          unless params and params['action'] == 'index'
            if params[model_key].present? && current_user
              params[model_key][:current_user_id] = current_user.id.to_s
            end
            params[:current_user_id] = current_user.id.to_s
          end
          end
        end
      end
    end
  end

  module Helper
    def creator_time_stamp model, style = :short
      if model.creator
        time_stamp model.created_at, model.creator, style
      else
        time_stamp model.created_at
      end
    end

    def updater_time_stamp model, style = :short
      if model.updater
        time_stamp model.updated_at, model.updater, style
      else
        time_stamp model.updated_at
      end
    end

    def time_stamp datetime, user = nil, style = :short
      if user.nil?
        case style
        when :short
          "<span>#{datetime.to_s(:gdatetime_short)}</span>".html_safe
        when :long
          "<span>#{datetime.to_s(:gdatetime_long)}</span>".html_safe
        end
      elsif user.class == User && datetime.class == ActiveSupport::TimeWithZone
        case style
        when :short
          "<span>#{user.initials} - #{datetime.to_s(:gdatetime_short)}</span>".html_safe
        when :long
          "<span>#{user.name} - #{datetime.to_s(:gdatetime_long)}</span>".html_safe
        end
      end
    end
  end
end
