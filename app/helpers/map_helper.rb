module MapHelper
  def default_lat_center
    user_signed_in? && current_user.address.present? ? current_user.latitude : 35.546815
  end
    
  def default_lng_center
    user_signed_in? && current_user.address.present? ? current_user.longitude : 139.359922
  end
    
  def address_value(address)
    if address.present?
      return address
    elsif user_signed_in? && current_user.address.present?
      return current_user.address
    else
      return "神奈川県相模原市"
    end
  end
end
