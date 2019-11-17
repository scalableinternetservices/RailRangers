class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.integer :requester_id
      t.integer :requestee_id
      t.boolean :accepted, default: false

      t.timestamps
    end
    add_index :requests, :requester_id
    add_index :requests, :requestee_id
  end
end
