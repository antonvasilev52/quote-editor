class Quote < ApplicationRecord
  validates :name, presence: true

  scope :ordered, -> { order(id: :desc) }

  belongs_to :company
  belongs_to :user

  # after_create_commit -> { broadcast_prepend_to "quotes", partial: "quotes/quote", locals: { quote: self } }
  #  this ↑ is equivalent of after_create_commit -> { broadcast_prepend_to "quotes" }

  # after_create_commit -> { broadcast_prepend_to "quotes" }
  # after_update_commit -> { broadcast_replace_to "quotes" }
  # after_destroy_commit -> { broadcast_remove_to "quotes" }

  # It is possible to improve the performance of this code by making the broadcasting part asynchronous
  # using background jobs. To do this, we only have to update the content of our callbacks
  # to use their asynchronous equivalents:

  # after_create_commit -> { broadcast_prepend_later_to "quotes" }
  # after_update_commit -> { broadcast_replace_later_to "quotes" }
  # after_destroy_commit -> { broadcast_remove_to "quotes" }

  # Those three callbacks are equivalent to the following single line:

  # broadcasts_to ->(quote) { "quotes" }, inserts_by: :prepend
  # for each company to have its own stream, we'll update it to this:

  broadcasts_to ->(quote) { [quote.company, "quotes"] }, inserts_by: :prepend

end