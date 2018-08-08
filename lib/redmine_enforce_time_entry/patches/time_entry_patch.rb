require_dependency 'time_entry'

module RedmineEnforceTimeEntry
  module Patches
    module TimeEntryPatch
      def self.included(base)
        base.extend(ClassMethods)

        base.send(:include, InstanceMethods)

        base.class_eval do
          unloadable
          validate :should_not_exceed_max_loggable_hours
        end

      end

      module ClassMethods
      end

      module InstanceMethods
        def should_not_exceed_max_loggable_hours
          if hours
            project_settings = EteProjectSetting.settings_for_project(project_id)
            max_hours_per_day_for_project = project_settings['limit_daily']
            max_hours_per_day_global = Setting[:plugin_redmine_enforce_time_entry]['time_entry']['limit_daily'].to_f
            max_hours_per_day = [max_hours_per_day_for_project, max_hours_per_day_global].compact.min

            if hours_changed?
              hours_currently_logged = 0.0
              if user_id && spent_on
                hours_currently_logged = TimeEntry.where(user_id: user_id, spent_on: spent_on).where.not(id: id)
                                                  .sum(:hours).to_f
              end
              if hours_currently_logged + hours > max_hours_per_day
                errors.add :base, l('redmine_enforce_time_entry.settings.time_entry.exceeds_max_loggable_hours',
                                    hours_currently_logged: format_hours(hours_currently_logged),
                                    max_hours_per_day: format_hours(max_hours_per_day))
              end
            end
          end
        end
      end
    end
  end
end

