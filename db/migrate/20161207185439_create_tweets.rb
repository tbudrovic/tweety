class CreateTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :tweets do |t|
      t.belongs_to :user

      t.string :content

      t.timestamps
    end
  end
end
