require 'test_helper'

class FilmsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:films)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_film
    assert_difference('Film.count') do
      post :create, :film => { }
    end

    assert_redirected_to film_path(assigns(:film))
  end

  def test_should_show_film
    get :show, :id => films(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => films(:one).id
    assert_response :success
  end

  def test_should_update_film
    put :update, :id => films(:one).id, :film => { }
    assert_redirected_to film_path(assigns(:film))
  end

  def test_should_destroy_film
    assert_difference('Film.count', -1) do
      delete :destroy, :id => films(:one).id
    end

    assert_redirected_to films_path
  end
end
