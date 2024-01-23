class ChangeProblemDescriptionToText < ActiveRecord::Migration[7.1]
  def change
    change_column :reports, :problem_description, :text
  end
end
