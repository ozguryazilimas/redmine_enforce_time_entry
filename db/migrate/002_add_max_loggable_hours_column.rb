class AddMaxLoggableHoursColumn < ActiveRecord::Migration

  def change
    add_column :ete_project_settings, :limit_daily, :decimal
  end

end

