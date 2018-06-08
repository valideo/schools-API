require 'test_helper'

feature 'Schools' do

  # INDEX
  describe '#index' do
    it 'renvoi 401 quand token vide' do
      get api_v1_schools_path

      assert_equal 401, last_response.status
    end

    it 'renvoi 401 quand mauvais token' do
      get api_v1_schools_path, nil, {'HTTP_AUTHORIZATION' => '34567890'}

      assert_equal 401, last_response.status
    end

    it 'renvoi 200 quand user valid' do
      get api_v1_schools_path, nil, {'HTTP_AUTHORIZATION' => 'valid_token'}

      assert_equal 200, last_response.status
    end

    it 'renvoi toutes les ecoles' do
      get api_v1_schools_path, nil, {'HTTP_AUTHORIZATION' => 'valid_token'}

      assert_equal 2, json_response['schools'].length
    end

    it 'renvoi que les ecoles privees' do
      get api_v1_schools_path, {status: 'private'}, {'HTTP_AUTHORIZATION' => 'valid_token'}

      assert_equal 1, json_response['schools'].length
      assert_equal 'private', json_response['schools'].first['status']
    end

    it 'renvoi que les ecoles publiques' do
      get api_v1_schools_path, {status: 'public'}, {'HTTP_AUTHORIZATION' => 'valid_token'}

      assert_equal 1, json_response['schools'].length
      assert_equal 'public', json_response['schools'].first['status']
    end

  end

  describe "#create" do
    it 'renvoi 201 quand user bien créé' do

      assert_difference "School.all.count" do
        post api_v1_schools_path, {
            'school': {
                'name': 'new school',
                'longitude': 1.0,
                'latitude': 1.0,
                'email': 'name@domain.com'
            }
        }, {'HTTP_AUTHORIZATION' => 'valid_token'}

        assert_equal 201, last_response.status
        assert_equal 'new school', json_response['school']['name']
      end
    end

    it 'renvoi 422 quand mauvais email' do

      assert_no_difference "School.all.count" do
        post api_v1_schools_path, {
            'school': {
                'name': 'new school',
                'longitude': 1.0,
                'latitude': 1.0,
                'email': 'namedomain.com'
            }
        }, {'HTTP_AUTHORIZATION' => 'valid_token'}

        assert_equal 422, last_response.status
      end
    end

    it 'renvoi 422 quand param manquand' do

      assert_no_difference "School.all.count" do
        post api_v1_schools_path, {
            'school': {
                'name': 'test'
            }
        }, {'HTTP_AUTHORIZATION' => 'valid_token'}

        assert_equal 422, last_response.status
      end
    end
  end

  describe "#destroy" do
    it 'renvoi 201 quand bien supprimé' do

      assert_difference "School.all.count", count: -1 do
       delete api_v1_school_path(0), nil, {'HTTP_AUTHORIZATION' => 'valid_token'}

        assert_equal 201, last_response.status
      end
    end
  end

end