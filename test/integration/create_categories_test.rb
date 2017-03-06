require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create(username: "john", 
            email: "john@email.com", password: "password", admin: true)
  end
  
  test "get new category form and create category" do
    ## simulate user login without directly accessing session hash
    ## create a method for this on the test_helper.rb 
    sign_in_as(@user, "password")
    
    ## going to new category path
    get new_category_path  
    ## getting new form
    assert_template 'categories/new'
    ## posting to the new form and creating a new category called sports
    ## 
    assert_difference 'Category.count', 1 do
      post_via_redirect categories_path, category: {name: "sports"}
    end
    ## redirecting to the index page
    assert_template 'categories/index'
    ## and the index page should now have sports displayed in the page
    assert_match "sports", response.body
  end
  
  test "invalid category submission results in failure" do
    ## simulate user login without directly accessing session hash
    sign_in_as(@user, "password")
    
    ## going to new category path
    get new_category_path  
    ## getting new form
    assert_template 'categories/new'
    ## posting to the new form and creating a new category called sports
    ## 
    assert_no_difference 'Category.count' do
      ## no redirection
      post categories_path, category: {name: " "}
    end
    ## redirecting to the new page
    assert_template 'categories/new'
    ## looking for the existence of these 2 items
    ## comes from views=>shared=>_errors.html.erb 
    ## referencing the errors partial
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  
  
end