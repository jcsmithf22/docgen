class AddCompletionToReports < ActiveRecord::Migration[7.1]
  def change
    add_column :reports, :completion, :string
  end
end
