class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :identifier
      t.string :short_description
      t.text :description
      t.string :url
    end
  end
end
