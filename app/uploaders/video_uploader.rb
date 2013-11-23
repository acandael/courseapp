class VideoUploader < CarrierWave::Uploader::Base

  include CarrierWave::MimeTypes
  process :set_content_type
  
  def extension_white_list
    %w(mp4)
  end
end
