class CreateEteProjectSettings < ActiveRecord::Migration[5.2]

  def change
    create_table :ete_project_settings do |t|
      t.integer :project_id
      t.boolean :status_change_only, :default => false
      t.text :status_from
      t.text :status_to

      t.timestamps :null => false
    end

    add_index :ete_project_settings, :project_id, :unique => true
  end

end

