class Import < ActiveRecord::Base
  mount_uploader :file, FileUploader
  validates :file, presence: true

  def init_import!
    ImportService.new(self.file.current_path).perform!
  end
end
