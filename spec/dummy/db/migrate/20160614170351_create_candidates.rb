class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.references :organization, index: true, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :email
      t.timestamps null: false
    end
  end
end
