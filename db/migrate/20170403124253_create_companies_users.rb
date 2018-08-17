class CreateCompaniesUsers < ActiveRecord::Migration[5.0]
  def change
    return if ActiveRecord::Base.connection.tables.include?("companies_users")

    create_table :companies_users, id: false do |t|
      t.references :company, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
    end
  end
end
