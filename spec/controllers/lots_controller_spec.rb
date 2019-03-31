require 'rails_helper'

RSpec.describe LotsController, type: :controller do
  describe 'POST lots#create' do
    context 'When params is invalid' do
      it 'increase count of lots by 0 and should be error' do
        expect {
            post(:create, params: { lot: { 
              name: "",
              start_price: 10,
              autopurchase_price: 200,
              lot_end_date: Time.new('2000'),
              description: "description"
            }})
          }.to change(Lot, :count).by(0)
      end
    end
  end

  describe 'POST lots#create' do
    context 'When params is correct' do
      it 'increase count of lots by 1' do
        expect{
          post(:create, params: { lot: { 
            name: "qwe123",
            start_price: 10,
            autopurchase_price: 200,
            lot_end_date: "01/01/2020".to_time,
            description: "description"
          }})
        }.to change(Lot, :count).by(1)  
      end
    end
  end

  describe 'GET lots#show' do
    before do
      @lot = FactoryBot.create(:lot)
    end
    it 'renders show if lot is exist' do
      get :show, params: { id: @lot.id }
      expect(response).to render_template('show')
    end

    it 'renders 404 or exception ActiveRecord::RecordNotFound if lot is not exist' do
      expect { 
        get :show, params: { id: 0 }
      }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end

  describe 'DELETE lots#destroy' do
    context 'When params is correct' do
      it 'should redirect to index' do
        sign_in FactoryBot.create(:user)
        FactoryBot.create(:lot)
        delete :destroy, params: { id: Lot.last.id }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'When params is not correct' do
      it 'should throw exception ActiveRecord::RecordNotFound ' do
        expect{
          delete :destroy, params: { id: 0 }
        }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'EDIT lots#edit' do
    context 'When user sign in' do
      it 'should redirect to index' do
        user = FactoryBot.create(:user)
        user.lots << Lot.last
        sign_in user
        get :edit, params: { id: user.lots.last }
        expect(response).to render_template('edit')
      end
    end

    context 'When user is not sign in' do
      it 'should error in render' do
        get :edit, params: { id: Lot.last.id }
        expect(response).to_not render_template('edit')
      end
    end
  end
end

