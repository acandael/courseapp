class VideoUrlUploader < CarrierWave::Uploader::Base

  def store_dir
    'videos'
  end

end
