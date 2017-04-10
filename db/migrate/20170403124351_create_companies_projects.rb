class CreateCompaniesProjects < ActiveRecord::Migration
  def change
    create_table :companies_projects, id: false do |t|
      t.references :company, index: true, foreign_key: true
      t.references :project, index: true, foreign_key: true
    end
  end
end
