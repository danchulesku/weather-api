module Weather
  class DeleteOldDataJob < ApplicationJob
    queue_as :default

    def perform
      ids_to_delete = Forecast.order(:created_at).first(48).pluck(:id)
      Forecast.where(id: ids_to_delete).delete_all
    end
  end
end
