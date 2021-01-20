module MapHelper
  def address_value(address)
    return address.present? ? address[:address] : "東京都渋谷区"
  end
end
