class CreateCompaniesUsers < ActiveRecord::Migration
  def change
    create_table :companies_users, id: false do |t|
      t.references :company, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
    end
  end
end
