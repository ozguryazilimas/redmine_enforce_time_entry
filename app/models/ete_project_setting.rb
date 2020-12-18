
class EteProjectSetting < ActiveRecord::Base

  serialize :status_from
  serialize :status_to

  scope :for_project, -> (project) {
    proj_id = project.is_a?(Class) ? project.id : project
    where(:project_id => proj_id)
  }

  scope :settings_for_project, -> (proj_id) {
    for_project(proj_id).first_or_initialize(RedmineEnforceTimeEntry.default_settings)
  }

end

