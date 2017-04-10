class CreateCompaniesProjects < ActiveRecord::Migration
  def change
    return if ActiveRecord::Base.connection.tables.include?("companies_projects")

    create_table :companies_projects, id: false do |t|
      t.references :company, index: true, foreign_key: true
      t.references :project, index: true, foreign_key: true
    end
  end
end
