class Category < ApplicationRecord
  has_many :todo_item
  after_create_commit { broadcast_append_to('categories') }
  after_update_commit { broadcast_replace } # https://github.com/hotwired/turbo-rails/blob/main/app/models/concerns/turbo/broadcastable.rb#L97
  after_destroy_commit { broadcast_remove }
end
