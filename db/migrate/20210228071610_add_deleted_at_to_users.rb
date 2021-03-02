class AddDeletedAtToUsers < ActiveRecord::Migration[5.1]
  # 論理削除カラム
  def change
    # add_column :users, :deleted_at, :datetime
    add_index :users, :deleted_at
  end
end
