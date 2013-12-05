class CourseImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  
  version :thumb do
    process :resize_to_fill => [220, 220]
  end

  version :small_thumb, :from_version => :thumb do
    process :resize_to_fill => [100, 100]
  end
end
