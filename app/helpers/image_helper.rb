module ImageHelper
  
  def image_resize(src, w, h, dest)
    
    w = w.to_s
    h = h.to_s
    
    require 'mini_magick'
    image = MiniMagick::Image.from_file(src)
    w1,h1 = image['%w %h'].split
    cur_w = w1.to_f
    cur_h = h1.to_f
    if cur_w < cur_h
      remove = ((cur_h - cur_w)/2).round
      image.shave "0x#{remove}"
    elsif cur_w > cur_h
      remove = ((cur_w - cur_h)/2).round
      image.shave "#{remove}x0"
    end
    image.resize "#{w}x#{h}"
    image.write dest
  end
  
  def thumbnailize_name(filename,w,h)
    if filename.match("^thumb_[0-9]{4}x[0-9]{4}_")
      return "thumb_"+sprintf("%04d",w.to_i)+"x"+sprintf("%04d",h.to_i)+"_"+filename["thumb_wwwwxhhhh_".length..-1]
    else
      return "thumb_"+sprintf("%04d",w.to_i)+"x"+sprintf("%04d",h.to_i)+"_"+filename
    end
  end
  
  def dethumbnailize_name(filename)
    if filename.match("^thumb_[0-9]{4}x[0-9]{4}_")
      return filename["thumb_wwwwxhhhh_".length..-1]
    else
      return filename
    end
  end
  
end