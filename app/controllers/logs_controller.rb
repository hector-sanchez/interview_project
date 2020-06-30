class LogsController < ApplicationController
    def index
        @logs = Log.all
        @logs_by_year = Log.group_count_by_year
        @logs_by_processed_as = Log.group_count_by_processed_as
    end
end
