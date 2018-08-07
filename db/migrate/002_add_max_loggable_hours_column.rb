class AddMaxLoggableHoursColumn < ActiveRecord::Migration

  def change
    add_column :ete_project_settings, :max_loggable_hours_per_day, :decimal
  end

end

