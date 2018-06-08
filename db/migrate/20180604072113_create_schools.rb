class CreateSchools < ActiveRecord::Migration[5.1]
  def change
    create_table :schools do |t|
      t.string :name
      t.string :address
      t.string :zip_code
      t.string :city
      t.string :opening_hours
      t.string :phone
      t.string :email
      t.float :latitude
      t.float :longitude
      t.integer :students_count
      t.string :status
      t.timestamps
    end
  end
end
