puts `clear`
puts `convert --version`

# require 'rmagick'
require 'pry'
require 'mini_magick'
require 'active_support/concern'
require 'carrierwave/processing/mini_magick'
root_path = File.expand_path File.dirname File.dirname __FILE__

# cleanup folders
FileUtils.rm_rf './dest'
FileUtils.mkdir './dest'

FileUtils.rm_rf './tmp'
FileUtils.mkdir './tmp'

# image = MiniMagick::Image.open src
# image.format "gif"
# image.write res

# https://github.com/carrierwaveuploader/carrierwave/blob/master/lib/carrierwave/processing/mini_magick.rb
class ImgProcessor
  include CarrierWave::MiniMagick
  attr_accessor :src_path, :dest_path

  def manipulate!
    image = ::MiniMagick::Image.open src_path

    image.format(@format.to_s.downcase) if @format
    image = yield image
    image.write dest_path
  end
end

img_proc = ImgProcessor.new

# Resize to fit
# 1 
img_proc.src_path  = "#{ root_path }/src/1600x1200.jpg"
img_proc.dest_path = "#{ root_path }/dest/fit_1600x1200_200x200.jpg"

img_proc.resize_to_fit 200, 200

# 2 
img_proc.src_path  = "#{ root_path }/src/1600x1200.jpg"
img_proc.dest_path = "#{ root_path }/dest/fit_1600x1200_100x200.jpg"

img_proc.resize_to_fit 100, 200

# 3 
img_proc.src_path  = "#{ root_path }/src/50x50.jpg"
img_proc.dest_path = "#{ root_path }/dest/fit_50x50_100x200.jpg"

img_proc.resize_to_fit 100, 200

# Resize to fit
# 1
img_proc.src_path  = "#{ root_path }/src/1600x1200.jpg"
img_proc.dest_path = "#{ root_path }/dest/fill_1600x1200_200x200.jpg"

img_proc.resize_to_fill 200, 200

# 2
img_proc.src_path  = "#{ root_path }/src/1600x1200.jpg"
img_proc.dest_path = "#{ root_path }/dest/fill_1600x1200_100x200.jpg"

img_proc.resize_to_fill 100, 200

# 3
img_proc.src_path  = "#{ root_path }/src/1600x1200.jpg"
img_proc.dest_path = "#{ root_path }/dest/fill_1600x1200_200x100.jpg"

img_proc.resize_to_fill 200, 100

# 4
img_proc.src_path  = "#{ root_path }/src/1600x1200.jpg"
img_proc.dest_path = "#{ root_path }/dest/fill_1600x1200_400x100.jpg"

img_proc.resize_to_fill 400, 100

# 5
img_proc.src_path  = "#{ root_path }/src/50x50.jpg"
img_proc.dest_path = "#{ root_path }/dest/fill_50x50_400x100.jpg"

img_proc.resize_to_fill 400, 100