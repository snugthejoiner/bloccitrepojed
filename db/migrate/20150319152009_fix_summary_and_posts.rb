class FixSummaryAndPosts < ActiveRecord::Migration
  def change
    add_reference :summaries, :post, index: true
    remove_column :posts, :summary_id
  end
end
