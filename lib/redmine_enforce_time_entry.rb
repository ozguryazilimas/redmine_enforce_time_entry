require 'redmine_enforce_time_entry/hooks/controller_issues_edit_before_save_hook'

module RedmineEnforceTimeEntry

  def self.default_settings
    {
      :status_change_only => false,
      :status_from => [],
      :status_to => []
    }
  end

end

