module MapHelper
  def default_lat_center
    user_signed_in? && current_user.address.present? ? current_user.latitude : 35.581331
  end
    
  def default_lng_center
    user_signed_in? && current_user.address.present? ? current_user.longitude : 139.371256
  end
    
  def address_value(address)
    if address.present?
      return address
    elsif user_signed_in? && current_user.address.present?
      return current_user.address
    else
      return "神奈川県相模原駅"
    end
  end
end
