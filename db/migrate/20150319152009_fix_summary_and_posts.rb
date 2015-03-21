class FixSummaryAndPosts < ActiveRecord::Migration
  def change
    add_reference :summaries, :post, index: true
  end
end
