require "test_helper"

class TotalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @total = totals(:one)
  end

  test "should get index" do
    get totals_url
    assert_response :success
  end

  test "should get new" do
    get new_total_url
    assert_response :success
  end

  test "should create total" do
    assert_difference('Total.count') do
      post totals_url, params: { total: {  } }
    end

    assert_redirected_to total_url(Total.last)
  end

  test "should show total" do
    get total_url(@total)
    assert_response :success
  end

  test "should get edit" do
    get edit_total_url(@total)
    assert_response :success
  end

  test "should update total" do
    patch total_url(@total), params: { total: {  } }
    assert_redirected_to total_url(@total)
  end

  test "should destroy total" do
    assert_difference('Total.count', -1) do
      delete total_url(@total)
    end

    assert_redirected_to totals_url
  end
end
