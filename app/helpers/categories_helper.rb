module CategoriesHelper
  def categories_list(categories)
    categories_list= []
    categories.each do |category|
      categories_list.push([category.name, category.id])
    end
    return categories_list
  end
end
