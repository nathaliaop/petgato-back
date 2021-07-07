class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.integer :reportable_id
      t.string :reportable_type

      t.timestamps
    end
  end
end
