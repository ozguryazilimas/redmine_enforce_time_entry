require_dependency 'projects_helper'


module RedmineEnforceTimeEntry
  module Patches
    module ProjectsHelperPatch

      def project_settings_tabs
        tabs = super

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

ProjectsController.helper(RedmineEnforceTimeEntry::Patches::ProjectsHelperPatch)

