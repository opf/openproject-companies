class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    return if ActiveRecord::Base.connection.tables.include?("companies")

    create_table :companies do |t|
      t.string :name
      t.string :identifier
      t.string :short_description
      t.text :description
      t.string :url
    end
  end
end
