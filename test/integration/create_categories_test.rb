require 'rails-controller-testing'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  test "get new category form and create category" do
    get new_category_path #user goes to the new category path
    assert_template 'categories/new' #user gets the new form
    assert_difference 'Category.count', 1 do #user posts to the new form
      post categories_path, params: {category: {name: "sports"}} #user creates the new category
      follow_redirect!
    end
    assert_template 'categories/index' #user gets redirected to the index page
    assert_match "sports", response.body #user shold see the new category displayed
  end

  test "invalid category submission results in failure" do
    get new_category_path 
    assert_template 'categories/new' 
    assert_no_difference 'Category.count' do 
      post categories_path, params: {category: {name: " "}} 
    end
    assert_template 'categories/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

end