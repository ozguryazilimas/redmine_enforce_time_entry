
namespace :redmine_enforce_time_entry do
  desc 'enable for all active projects'
  task :enable_active_projects, [:status_change_only] => :environment do |t, args|
    change_only = ['no', '0', 'false'].exclude?(args[:status_change_only].to_s.downcase)

    ActiveRecord::Base.transaction do
      Project.active.each do |project|
        puts "Working on #{project.identifier}"

        project.enable_module!(:enforce_time_entry)

        status_ids = WorkflowTransition.where(:tracker_id => project.tracker_ids).distinct.
          pluck(:old_status_id, :new_status_id).flatten.uniq

        ete_setting = EteProjectSetting.where(:project_id => project.id).first_or_initialize
        ete_setting.status_from = status_ids
        ete_setting.status_to = status_ids
        ete_setting.status_change_only = change_only
        ete_setting.save!
      end
    end
  end
end

