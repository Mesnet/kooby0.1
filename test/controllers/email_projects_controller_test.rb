require 'test_helper'

class EmailProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @email_project = email_projects(:one)
  end

  test "should get index" do
    get email_projects_url
    assert_response :success
  end

  test "should get new" do
    get new_email_project_url
    assert_response :success
  end

  test "should create email_project" do
    assert_difference('EmailProject.count') do
      post email_projects_url, params: { email_project: { cat: @email_project.cat, email: @email_project.email } }
    end

    assert_redirected_to email_project_url(EmailProject.last)
  end

  test "should show email_project" do
    get email_project_url(@email_project)
    assert_response :success
  end

  test "should get edit" do
    get edit_email_project_url(@email_project)
    assert_response :success
  end

  test "should update email_project" do
    patch email_project_url(@email_project), params: { email_project: { cat: @email_project.cat, email: @email_project.email } }
    assert_redirected_to email_project_url(@email_project)
  end

  test "should destroy email_project" do
    assert_difference('EmailProject.count', -1) do
      delete email_project_url(@email_project)
    end

    assert_redirected_to email_projects_url
  end
end
