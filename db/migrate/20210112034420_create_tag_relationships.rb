class CreateTagRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :tag_relationships do |t|
      t.references :post, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
    #  タグ検索機能実装のためnameにindexを付与,unipue:tureで同じ名前のタグを保存できないようにしている
      add_index :tag_relationships, [:post_id,:tag_id],unique: true
  end
end
