require_dependency 'time_entry'

module RedmineEnforceTimeEntry
  module Patches
    module TimeEntryPatch
      def self.included(base)
        base.extend(ClassMethods)

        base.send(:include, InstanceMethods)

        base.class_eval do
          unloadable
          alias_method_chain :validate_time_entry, :max_hours_per_day
        end

      end

      module ClassMethods
      end

      module InstanceMethods
        def validate_time_entry_with_max_hours_per_day
          if hours
            max_hours_per_day = Setting[:plugin_redmine_enforce_time_entry]['time_entry']['max_hours_per_day']
            if hours_changed?
              hours_currently_logged = 0.0
              if user_id && spent_on
                hours_currently_logged = TimeEntry.where(user_id: user_id, spent_on: spent_on).where.not(id: id)
                                                  .sum(:hours).to_f
              end
              if hours_currently_logged + hours > max_hours_per_day.to_f
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

