require_dependency 'projects_controller'


module RedmineEnforceTimeEntry
  module Patches
    module ProjectsControllerPatch
      def self.included(base)
        base.extend(ClassMethods)
        base.send(:include, InstanceMethods)
        base.class_eval do
          unloadable
        end
      end

      module ClassMethods

      end

      module InstanceMethods

        def ete_project_settings
          @settings = params[:settings][:enforce_time_entry]

          RedmineEnforceTimeEntry.default_settings.each do |k, v|
            @settings[k] ||= v
          end

          project_setting = EteProjectSetting.for_project(@project).first_or_initialize
          project_setting.assign_attributes(@settings)

          if project_setting.save!
            flash[:notice] = l(:notice_successful_update)
          else
            flash[:error] = l('redmine_enforce_time_entry.settings.error_update_not_successful')
          end

          redirect_to settings_project_path(@project, :tab => 'ete_project_settings')
        end

      end

    end
  end
end

