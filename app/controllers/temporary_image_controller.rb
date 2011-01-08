class TemporaryImageController < ApplicationController
 include ImageHelper
 protect_from_forgery :except=>[:index]
 skip_before_filter :decode_signed_request
 skip_before_filter :require_basic_information_permission
 
 def index

    return_json = upload_temporary_image(params[:Filedata])

    response.headers['Content-type'] = 'text/plain; charset=utf-8'
    render :json=>return_json
  end
  
  def upload_temporary_image(image_data)
    temp_image = TemporaryImage.new
    temp_image.name = ""
    temp_image.created_date = Time.now
    
    if !temp_image.save
      return {:ok=>false, :error_message=>"The database has failed."}
    end
    
    begin
      
      ext = File.extname( image_data.original_filename ).sub( /^\./, "" ).downcase
      
      temp_image.name = "temp_"+temp_image.id.to_s+"."+ext
      
      ext = ext.downcase
        
      if !["jpg","jpeg","gif","png"].include?(ext)
        return {:ok=>false, :error_message=>"The extension ("+ext+") is not allowed."}
      end
      
      input_file_stream = image_data.read
      
      if !temp_image.save
        return {:ok=>false, :error_message=>"The database has failed."}
      end
    
      File.open(File.join("public/uploads/temp",temp_image.name), "wb") { |f| 
        f.write(input_file_stream) 
      }
      

      image_resize("public/uploads/temp/"+temp_image.name, 112, 112, "public/uploads/temp/"+thumbnailize_name(temp_image.name,112,112))
      
      return {:ok=>true, :filename=>thumbnailize_name(temp_image.name,112,112)}
    rescue Exception=>e
      
      if temp_image.name != ""
        begin
          File.delete(File.join("public/uploads/temp",temp_image.name))
        rescue Exception=>ex
      end
      
       begin
          File.delete(File.join("public/uploads/temp",thumbnailize_name(temp_image.name,112,112)))
        rescue Exception=>ex
        end
      end
      
      return {:ok=>false, :error_message=>"The uploading has failed. Please try again. "+e}
    end
    

  end
  
end
