require "test_helper"

class FieldDiariesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @field_diary = field_diaries(:one)
  end

  test "should get index" do
    get field_diaries_url, as: :json
    assert_response :success
  end

  test "should create field_diary" do
    assert_difference('FieldDiary.count') do
      post field_diaries_url, params: { field_diary: { name: @field_diary.name } }, as: :json
    end

    assert_response 201
  end

  test "should show field_diary" do
    get field_diary_url(@field_diary), as: :json
    assert_response :success
  end

  test "should update field_diary" do
    patch field_diary_url(@field_diary), params: { field_diary: { name: @field_diary.name } }, as: :json
    assert_response 200
  end

  test "should destroy field_diary" do
    assert_difference('FieldDiary.count', -1) do
      delete field_diary_url(@field_diary), as: :json
    end

    assert_response 204
  end
end
