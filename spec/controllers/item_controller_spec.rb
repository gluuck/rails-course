require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let(:items) { create_list :item , 5 }
  let(:item) { create :item }
  let(:items_params) do
    {item:{
      name: 'car', price: 250 , description: 'ahahah'
    }}
  end
  
  context "GET #index" do

    before {get :index}
    it "returns items" do


      is_expected.to render_template :index
      expect(assigns (:items)).to match_array (items)
    end

  end
  context "POST #create" do
      subject {post :create, params: items_params}
      it 'saves the item' do
        expect{subject}.to change(Item, :count).by 1              
      end
      it "redirect to index" do
        expect(subject).to  redirect_to action: :index
      end
      
    context "with invalid params" do
      let(:items_params) {{item:{price:-20}  }} 
      it "dosnt save" do
        expect {subject}.to_not change(Item, :count) 
        
      end
      it "render to template" do
        is_expected.to render_template :new
      end
      
    end      
    end
    context "Delete #destroy" do
      subject{delete :destroy, params: params}
      let(:params) { {id: item.id} } 
      it "delete from item" do
        item.reload
        expect{subject}.to   change(Item, :count).by(-1)
      end
      it "redirect to index template" do
        is_expected.to redirect_to action: :index
      end
    end
    
end
