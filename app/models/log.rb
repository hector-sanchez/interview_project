class Log < ApplicationRecord
  scope :group_count_by_year, ->{ group(:year).count }
  scope :group_count_by_processed_as, ->{ group(:processed_as).count }

  enum processed_as: %i[exact calculated]
end
