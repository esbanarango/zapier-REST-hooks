class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.references :organization, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
