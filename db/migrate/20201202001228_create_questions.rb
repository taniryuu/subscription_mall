class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.text :detail
      t.text :answer

      t.timestamps
    end
  end
end
