require "test_helper"

class FarmingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @farming = farmings(:one)
  end

  test "should get index" do
    get farmings_url, as: :json
    assert_response :success
  end

  test "should create farming" do
    assert_difference('Farming.count') do
      post farmings_url, params: { farming: { name: @farming.name } }, as: :json
    end

    assert_response 201
  end

  test "should show farming" do
    get farming_url(@farming), as: :json
    assert_response :success
  end

  test "should update farming" do
    patch farming_url(@farming), params: { farming: { name: @farming.name } }, as: :json
    assert_response 200
  end

  test "should destroy farming" do
    assert_difference('Farming.count', -1) do
      delete farming_url(@farming), as: :json
    end

    assert_response 204
  end
end
