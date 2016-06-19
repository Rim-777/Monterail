class ImportJob < ActiveJob::Base
  queue_as :default

  def perform(object)
    ImportService.new(object.file.current_path).perform!
  end
end
