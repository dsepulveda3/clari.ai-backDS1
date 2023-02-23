class CreateFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbacks do |t|
      t.belongs_to :question
      t.text :feedback
      t.timestamps

    end
  end
end
