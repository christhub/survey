class CreateAnswers < ActiveRecord::Migration
  def change
      create_table(:answers) do |t|
          t.column(:text, :string)
          t.column(:question_id, :int)
          t.column(:survey_id, :int)
      end
  end
end
