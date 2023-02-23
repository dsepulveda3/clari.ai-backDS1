class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.text :content
      t.text :answer
      t.boolean :useful
      t.timestamps
    end
  end
end
