module ApplicationHelper

  def images_urls_from string
    #take "001.jpg 002.jpg 003.jpg" return image_url for each image
    string.split(' ').map do |img|
      asset_url(img)
    end
  end

end
