class AddPromptToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :prompt, :text
  end
end
