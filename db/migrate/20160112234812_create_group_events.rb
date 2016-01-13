class CreateGroupEvents < ActiveRecord::Migration
  def change
    create_table :group_events do |t|
      t.string  :name
      t.text    :description
      t.string  :location
      t.date    :starts_at
      t.date    :ends_at
      t.integer :duration
      t.boolean :is_published, default: false
      t.boolean :is_destroyed, default: false

      t.timestamps null: false
    end
  end
end
