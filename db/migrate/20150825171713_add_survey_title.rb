class AddSurveyTitle < ActiveRecord::Migration
  def change
    add_column(:surveys, :title, :string)

    remove_column(:surveys, :question_id)
    remove_column(:surveys, :answer_id)

    change_table :surveys do |t|
      t.timestamps
    end

    change_table :questions do |t|
      t.timestamps
    end

    change_table :answers do |t|
      t.timestamps
    end
  end
end
