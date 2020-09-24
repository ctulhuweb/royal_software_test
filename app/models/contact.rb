class Contact < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :company
end
