class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.integer :turn, null: false
      t.integer :faction_id, null: false
      t.float :income
      t.float :total_upkeep
      t.float :research_budget
      t.float :unit_construction
      t.float :infrastructure_spending
      t.float :net_treasury
      t.float :initial_treasury
      t.float :upkeep_rate
    end
  end
end
