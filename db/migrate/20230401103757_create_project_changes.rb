class CreateProjectChanges < ActiveRecord::Migration[7.0]
  def change
    create_table :project_changes do |t|
      t.references :project, null: false, foreign_key: true
      t.string :old_status
      t.string :new_status
      t.string :comment
      t.timestamps
    end
  end
end
