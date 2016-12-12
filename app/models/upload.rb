class Upload < ApplicationRecord
  mount_uploader :name, ImageUploader


  def phash!
    image = open(self.name.url)
    IO.copy_stream(image, 'temp-images/image.png')
    phash_image = Phashion::Image.new('temp-images/image.png')
    self.assign_attributes(fingerprint: phash_image.fingerprint)
  end

end
