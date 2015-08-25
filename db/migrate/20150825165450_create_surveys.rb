class CreateSurveys < ActiveRecord::Migration
  def change
      create_table(:surveys) do |t|
          t.column(:question_id, :int)
          t.column(:answer_id, :int)
      end
  end
end
