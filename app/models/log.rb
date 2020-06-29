class Log < ApplicationRecord
  enum processed_as: %i[exact calculated]
end
