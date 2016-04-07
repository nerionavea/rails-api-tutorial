require 'spec_helper'

describe Api::V1::TypeOfServicesController do
  describe "GET #show" do
    before(:each) do
      @type_of_service = FactoryGirl.create :type_of_service
      get :show, id: @type_of_service.id
    end

    it "returns the information about a reporter on a hash" do
      type_of_service_response = json_response[:type_of_service]
      expect(type_of_service_response[:description]).to eql @type_of_service.description
    end

    it { should respond_with 200}
  end

  describe "GET #index" do
    before(:each) do
      4.times {FactoryGirl.create :type_of_service}
      get :index
    end

    it "returns 4 records from the database" do
      type_of_service_response = json_response
      expect(type_of_service_response[:type_of_services]).to have(4).items
    end

    it {should respond_with 200}
  end

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        @type_of_service_attributes = FactoryGirl.attributes_for :type_of_service
        api_authorization_header user.auth_token
        post :create, {user_id: user.id, type_of_service: @type_of_service_attributes}
      end

      it "renders the json representation for the type of service reccord just created" do
        type_of_service_response = json_response
        expect(type_of_service_response[:title]).to eql @type_of_service_attributes[:title]
      end
    end
    context "when is not created" do
      before(:each) do
        user = FactoryGirl.create :user
        @type_of_service_attributes = {description: "change oil", standart_days: "das", standart_kms: 5000, sms_model: "hello it's me"}
        api_authorization_header user.auth_token
        post :create, {user_id: user.id, type_of_service: @type_of_service_attributes}
      end

      it "renders an errors json" do
        type_of_service_response = json_response
        expect(type_of_service_response).to have_key(:errors)
      end

      it "renders the json errors on whye could not be created" do
        type_of_service_response = json_response
        expect(type_of_service_response[:errors][:standart_days]).to include "is not a number"
      end

      it { should respond_with 422 }
    end
  end
  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      @type_of_service = FactoryGirl.create :type_of_service, user: @user
      api_authorization_header @user.auth_token
    end
    context "when is successfully updated" do
      before(:each) do
        patch :update, {user_id: @user.id, id: @type_of_service.id, type_of_service: {description: 'Change gearbox'}}
      end

      it "renders the json representation foor the updated user" do
        type_of_service_response = json_response[:type_of_service]
        expect(type_of_service_response[:description]).to eql "Change gearbox"
      end

      it { should respond_with 200 }
    end

    describe "when is not updated" do
      before(:each) do
        patch :update, {user_id: @user.id, id: @type_of_service.id, type_of_service: {standart_kms: 'five'}}
      end

      it "renders an errors json" do
        type_of_service_response = json_response
        expect(type_of_service_response).to have_key(:errors)
      end

      it "renders the json errors on whye could not be created" do
        type_of_service_response = json_response
        expect(type_of_service_response[:errors][:standart_kms]).to include "is not a number"
      end

      it { should respond_with 422}
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      @type_of_service = FactoryGirl.create :type_of_service, user: @user
      api_authorization_header @user.auth_token
      delete :destroy, {user_id: @user.id, id: @type_of_service.id}
    end

    it { should respond_with 204}
  end
end
