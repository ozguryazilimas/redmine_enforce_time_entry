module RedmineEnforceTimeEntry
  module Hooks
    class ControllerIssuesEditBeforeSaveHook < ::Redmine::Hook::ViewListener

      def controller_issues_edit_before_save(context={})
        return '' unless context[:project].module_enabled?('enforce_time_entry')

        time_entry_param = context[:params][:time_entry]

        # if all values are in we are good to go
        return '' if ete_time_entry_param_has_all_values(time_entry_param)

        # check if user has to enter time entry
        return '' unless ete_user_needs_to_enter_time_entry(context[:project])

        settings = EteProjectSetting.settings_for_project(context[:project])

        # we have issue object already altered but not saved
        old_issue_status_id = context[:issue].status_id_was.to_s
        new_issue_status_id = context[:params][:issue][:status_id].to_s

        return '' unless ete_status_changes_match_settings(settings, old_issue_status_id, new_issue_status_id)

        # none of the checks passed, this user has to log time
        context[:controller].flash.now[:error] = l('redmine_enforce_time_entry.missing_spent_time')
        raise ActiveRecord::Rollback
      end

      def ete_time_entry_param_has_all_values(time_entry_param)
        return false if time_entry_param.blank?

        # time_entry_param[:comments].present?
        time_entry_param[:hours].present? && time_entry_param[:activity_id].present?
      end

      def ete_status_changes_match_settings(settings, old_id, new_id)
        # check if we want to track time_entry only on status changes
        return false if settings[:status_change_only] && (old_id == new_id)

        # if old or new issue status is not in the list we care, we do not need to track time_entry
        settings[:status_from].include?(old_id) || settings[:status_to].include?(new_id)
      end

      def ete_user_needs_to_enter_time_entry(project)
        usr = User.current

        # if user is not allowed to log time, we do not need to enforce time entry
        return false unless usr.allowed_to?(:log_time, project)

        !usr.allowed_to?(:ete_can_skip_log_time, project)
      end
    end
  end
end

