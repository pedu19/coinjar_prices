class CreatePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :prices do |t|
      t.string :symbol
      t.float :last
      t.float :bid
      t.float :ask
      t.float :change_24h
      t.datetime :current_time
      t.float :prev_close
      t.integer :session
      t.string :status
      t.datetime :transition_time
      t.float :volume
      t.float :volume_24h
      t.datetime :timestamp

      t.timestamps
    end
  end
end
