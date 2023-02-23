class CreateValuations < ActiveRecord::Migration[6.0]
  def change
    create_table :valuations do |t|
      t.belongs_to :question
      t.boolean :is_positive
      t.timestamps
    end
  end
end
