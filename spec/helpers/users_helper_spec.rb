require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  
    before(:each) do
      user_with_valid_params.foto_blobs << photo_with_valid_params
      user_with_valid_params.save
    end
  
  describe "#full_name" do
    context 'when user has first_name and last_name' do
      let(:photo_with_valid_params) { ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', 
                                                              content_type: 'image/jpeg', byte_size: 299946)}
      let(:user_with_valid_params) { User.new(first_name: 'Alex', last_name: 'Smith', birth: Date.new(1990,01,01), 
                                              sex: 'Man', yourself: 'sdsd', latitude: 27.53037290421605, 
                                              longitude: 53.905427341494146, email: 'Ti@mail.ru', work_id: 5, 
                                              password: 'dsdfss') }

      it 'concats first_name and last_name with space' do
        expect(helper.full_name(user_with_valid_params)).to eq('Alex Smith')
      end
    end

    context 'when user has only first_name' do
      let(:photo_with_valid_params) { ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', 
                                                              content_type: 'image/jpeg', byte_size: 299946)}
      let(:user_with_valid_params) { User.new(first_name: 'Alex', birth: Date.new(1990,01,01), 
                                              sex: 'Man', yourself: 'sdsd', latitude: 27.53037290421605, longitude: 53.905427341494146, email: 'Ti@mail.ru', work_id: 5, 
                                              password: 'dsdfss') }  
      it 'concats first_name and "" with space' do
        expect(helper.full_name(user_with_valid_params)).to eq('Alex ')
      end
    end
  end

  describe "#age" do
    let(:photo_with_valid_params) { ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', 
                                                            content_type: 'image/jpeg', byte_size: 299946)}
    let(:user_with_valid_params) { User.new(first_name: 'Alex', last_name: 'Smith', birth: Date.new(1990,05,14), 
                                            sex: 'Man', yourself: 'sdsd', latitude: 27.53037290421605, 
                                            longitude: 53.905427341494146, email: 'Ti@mail.ru', work_id: 5, 
                                            password: 'dsdfss') }
    it 'should returns users age' do
      expect(helper.age(user_with_valid_params)).to eq(32)
    end

    it 'should returns object type Integer' do
      expect(helper.age(user_with_valid_params)).to be_an_instance_of(Integer)
    end
  end
end