require 'spec_helper'

describe Api::V1::ProblemsController do
  describe "index" do
    context "nearest" do
      it "returns empty json when no problems" do
        get :index, :format => 'json',
                    :type => "nearest"

        response.body.should == '[]'
      end

      it "returns all problem details in the json" do
        create(:problem, :description => "Problem 1", :id => 1,
                       :longitude => 21, :latitude => 41)

        get :index, :format => 'json',
                    :type => "nearest",
                    :longitude => 21.2,
                    :latitude => 41.2

        json = JSON.parse(response.body)

        json[0]['id'].should == 1
        json[0]['longitude'].should == '21'
        json[0]['latitude'].should == '41'
        json[0]['description'].should == 'Problem 1'
        json[0]['municipality'].should == 'Butel'
        json[0]['category'].should == 'Abandoned vehicles'
        json[0]['url'].should match('problems/1')
        json[0]['created_at'].should_not be_nil
        json[0]['photo_small'].should match('1/s/rails.png')
        json[0]['photo_medium'].should match('1/m/rails.png')
      end

      it "returns json with ordered problems by distance" do
        create(:problem, :description => "Problem 1", :id => 1,
                       :longitude => 21, :latitude => 41)
        create(:problem, :description => "Problem 2", :id => 2,
                       :longitude => 22, :latitude => 42)

        get :index, :format => 'json',
                    :type => "nearest",
                    :longitude => 21.2,
                    :latitude => 41.2

        json = JSON.parse(response.body)

        json[0]['id'].should == 1
        json[0]['longitude'].should == '21'
        json[0]['latitude'].should == '41'

        json[1]['id'].should == 2
        json[1]['longitude'].should == '22'
        json[1]['latitude'].should == '42'
      end

      it "returns json with ordered problems by distance in reverse" do
        create(:problem, :description => "Problem 1", :id => 1,
                       :longitude => 21, :latitude => 41)
        create(:problem, :description => "Problem 2", :id => 2,
                       :longitude => 22, :latitude => 42)

        get :index, :format => 'json',
                    :type => "nearest",
                    :longitude => 21.7,
                    :latitude => 41.7

        json = JSON.parse(response.body)

        json[0]['id'].should == 2
        json[0]['longitude'].should == '22'
        json[0]['latitude'].should == '42'

        json[1]['id'].should == 1
        json[1]['longitude'].should == '21'
        json[1]['latitude'].should == '41'
      end
    end

    context "my" do
      it "returns empty json when there is no problems" do
        get :index, :format => 'json',
                    :type => "my"
        response.body.should == '[]'
      end

      it "returns all problem details in the json" do
        create(:problem, :description => "Problem 1", :id => 1,
                       :longitude => 21, :latitude => 41, :device_id => 123)

        get :index, :format => 'json',
                    :type => "my",
                    :device_id => 123

        json = JSON.parse(response.body)

        json[0]['id'].should == 1
        json[0]['longitude'].should == '21'
        json[0]['latitude'].should == '41'
        json[0]['description'].should == 'Problem 1'
        json[0]['municipality'].should == 'Butel'
        json[0]['category'].should == 'Abandoned vehicles'
        json[0]['url'].should match('problems/1')
        json[0]['created_at'].should_not be_nil
        json[0]['photo_small'].should match('1/s/rails.png')
        json[0]['photo_medium'].should match('1/m/rails.png')
      end

      it "returns json with ordered problems by distance" do
        create(:problem, :description => "Problem 1", :id => 1,
                       :longitude => 21, :latitude => 41, :device_id => 123)
        create(:problem, :description => "Problem 2", :id => 2,
                       :longitude => 22, :latitude => 42, :device_id => 123)

        get :index, :format => 'json',
                    :type => "my",
                    :device_id => 123

        json = JSON.parse(response.body)

        json[0]['id'].should == 2
        json[0]['longitude'].should == '22'
        json[0]['latitude'].should == '42'

        json[1]['id'].should == 1
        json[1]['longitude'].should == '21'
        json[1]['latitude'].should == '41'
      end
    end

    context "latest" do
      it "returns empty json when there is no problems" do
        get :index, :format => 'json',
                    :type => 'latest'

        response.body.should == '[]'
      end

      it "returns all problem details in the json" do
        create(:problem, :description => "Problem 1", :id => 1,
                       :longitude => 21, :latitude => 41)

        get :index, :format => 'json',
                    :type => 'latest'

        json = JSON.parse(response.body)

        json[0]['id'].should == 1
        json[0]['longitude'].should == '21'
        json[0]['latitude'].should == '41'
        json[0]['description'].should == 'Problem 1'
        json[0]['municipality'].should == 'Butel'
        json[0]['category'].should == 'Abandoned vehicles'
        json[0]['url'].should match('problems/1')
        json[0]['created_at'].should_not be_nil
        json[0]['photo_small'].should match('1/s/rails.png')
        json[0]['photo_medium'].should match('1/m/rails.png')
      end

      it "returns json with ordered problems by distance" do
        create(:problem, :description => "Problem 1", :id => 1,
                       :longitude => 21, :latitude => 41)
        create(:problem, :description => "Problem 2", :id => 2,
                       :longitude => 22, :latitude => 42)

        get :index, :format => 'json',
                    :type => 'latest'

        json = JSON.parse(response.body)

        json[0]['id'].should == 2
        json[0]['longitude'].should == '22'
        json[0]['latitude'].should == '42'

        json[1]['id'].should == 1
        json[1]['longitude'].should == '21'
        json[1]['latitude'].should == '41'
      end
    end
  end

  describe "create" do
    it "creates a problem" do
      municipality = create(:municipality)
      category = create(:category)

      post :create, :format => :json,
                    :problem => {
                      :description => 'problem 123',
                      :device_id => 123,
                      :longitude => 21,
                      :latitude => 42,
                      :email => 'test@example.com',
                      :category_id => category.id,
                      :municipality_id => municipality.id
                    }

      response.should be_success

      json = JSON.parse(response.body)

      json['status'].should == 'ok'
    end

    it "returns error when no municipality" do
      category = create(:category)

      post :create, :format => :json,
                    :problem => {
                      :description => 'problem 123',
                      :device_id => 123,
                      :longitude => 21,
                      :latitude => 42,
                      :email => 'test@example.com',
                      :category_id => category.id
                    }

      response.should be_success

      json = JSON.parse(response.body)

      json['status'].should  == "error"
      json['message'].should == "Municipality can't be blank"
      json['actions'].should == {"municipality"=>"sync"}
    end

    it "returns error when no category" do
      municipality = create(:municipality)

      post :create, :format => :json,
                    :problem => {
                      :description => 'problem 123',
                      :device_id => 123,
                      :longitude => 21,
                      :latitude => 42,
                      :email => 'test@example.com',
                      :municipality_id => municipality.id
                    }

      response.should be_success

      json = JSON.parse(response.body)

      json['status'].should  == "error"
      json['message'].should == "Category can't be blank"
      json['actions'].should == {"category"=>"sync"}
    end

    it "returns error when no category and no municipality" do
      post :create, :format => :json,
                    :problem => {
                      :description => 'problem 123',
                      :device_id => 123,
                      :longitude => 21,
                      :latitude => 42,
                      :email => 'test@example.com'
                    }

      response.should be_success

      json = JSON.parse(response.body)

      json['status'].should  == "error"
      json['message'].should == "Category can't be blank, Municipality can't be blank"
      json['actions'].should == {"category"=>"sync", "municipality"=>"sync"}
    end
  end

  describe "update" do
    it "can update problem by submiting a photo for it" do
      create(:problem, :photo => nil, :device_id => 123, :id => 1)

      put :update, :format => 'json',
                   :id => 1,
                   :device_id => 123,
                   :photo => fixture_file_upload('/rails1.png')


      response.should be_success

      json = JSON.parse(response.body)
      json['status'].should == 'ok'
    end

    it "cannot update problem submiting by other device id" do
      create(:problem, :photo => nil, :device_id => 123, :id => 1)

      put :update, :format => 'json',
                   :id => 1,
                   :device_id => 124,
                   :photo => fixture_file_upload('/rails1.png')


      response.should be_success

      json = JSON.parse(response.body)
      json['status'].should == 'error'
      json['type'].should == 'device_id'
    end
  end
end
