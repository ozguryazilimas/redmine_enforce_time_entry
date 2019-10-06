require_dependency 'projects_helper'


module RedmineEnforceTimeEntry
  module Patches
    module ProjectsHelperPatch
      def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do
          alias_method :project_settings_tabs_without_redmine_enforce_time_entry, :project_settings_tabs
          alias_method :project_settings_tabs, :project_settings_tabs_with_redmine_enforce_time_entry
        end
      end

      module InstanceMethods

        def project_settings_tabs_with_redmine_enforce_time_entry
          tabs = project_settings_tabs_without_redmine_enforce_time_entry

          return tabs unless @project.module_enabled?('enforce_time_entry')
          return tabs unless User.current.allowed_to?(:edit_project, @project)
          tabs << {
            :name => 'ete_project_settings',
            :action => :ete_manage_project_settings,
            :partial => 'projects/ete_project_settings',
            :label => 'redmine_enforce_time_entry.settings.label_enforce_time_entry'
          }

          tabs
        end

      end

    end
  end
end

