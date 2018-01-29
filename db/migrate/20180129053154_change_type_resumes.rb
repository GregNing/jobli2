class ChangeTypeResumes < ActiveRecord::Migration[5.1]
  def change
    change_column :resumes, :job_id, :integer
  end
end
