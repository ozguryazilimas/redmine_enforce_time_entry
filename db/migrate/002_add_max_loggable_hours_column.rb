class AddMaxLoggableHoursColumn < ActiveRecord::Migration[5.2]

  def change
    add_column :ete_project_settings, :limit_daily, :decimal
  end

end

