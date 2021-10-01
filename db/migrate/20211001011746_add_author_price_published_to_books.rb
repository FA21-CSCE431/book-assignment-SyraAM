class AddAuthorPricePublishedToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :author, :string
    add_column :books, :price, :decimal, precision: 16, scale: 2
    add_column :books, :published, :datetime
  end
end
