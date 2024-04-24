class Price < ApplicationRecord
    validates :last, presence: true
    validates :bid, presence: true
    validates :ask, presence: true

end
