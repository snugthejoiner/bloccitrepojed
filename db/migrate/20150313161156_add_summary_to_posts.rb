class AddSummaryToPosts < ActiveRecord::Migration
  def change
    add_reference :posts, :post, index: true
    add_foreign_key :posts, :posts
  end
end
