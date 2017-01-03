require 'redmine'
require 'redmine_enforce_time_entry'

Redmine::Plugin.register :redmine_enforce_time_entry do
  name 'Redmine Enforce Time Entry Plugin'
  author 'Onur Kucuk'
  description 'Force users to enter time entries'
  version '0.5.0'
  url 'http://www.ozguryazilim.com.tr'
  author_url 'http://www.ozguryazilim.com.tr'
  requires_redmine :version_or_higher => '3.0.3'

  project_module :enforce_time_entry do
    permission :ete_can_skip_log_time, {:projects => [:ete_project_settings]}, :require => :member
  end
end

Rails.configuration.to_prepare do
  [
    [ProjectsController, RedmineEnforceTimeEntry::Patches::ProjectsControllerPatch],
    [ProjectsHelper, RedmineEnforceTimeEntry::Patches::ProjectsHelperPatch]
  ].each do |classname, modulename|
    unless classname.included_modules.include?(modulename)
      classname.send(:include, modulename)
    end
  end

end

