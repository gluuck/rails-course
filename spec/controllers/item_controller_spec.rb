require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  
  describe "GET #show" do
    let(:items) { create_list :item , 5 } 
    before {get :index}
    it "returns items" do
      
      binding.pry
      
      expect(assigns :items).to match_array items
    end
    
  end
  describe "DELETE #destroy" do
    
  end
  
end