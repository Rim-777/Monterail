class Import < ActiveRecord::Base
  mount_uploader :file, FileUploader

  def init_import!
    ImportService.new(self.file.current_path).perform!
  end
end
