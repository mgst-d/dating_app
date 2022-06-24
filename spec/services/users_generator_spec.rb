require 'rails_helper'

RSpec.describe UsersGenerator do
	
	let(:photo_with_valid_attributes) { ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', content_type: 'image/jpeg', byte_size: 299946)}
  let(:user_with_valid_attributes) { User.new(first_name: 'Alex', birth: Date.new(1990,01,01), sex: 'Man', 
                                     latitude: 27.53037290421605, longitude: 53.905427341494146, 
                                     email: 'Timm@mail.ru', password: 'dsdfss') }
	let(:user2_with_valid_attributes) { User.new(first_name: 'Alexa', birth: Date.new(1990,01,01), sex: 'Female', 
																			latitude: 27.53037290421605, longitude: 53.905427341494146, 
																			email: 'Tinn@mail.ru', password: 'dsdfss') }
  let(:user3_with_valid_attributes) { User.new(first_name: 'Nata', birth: Date.new(1990,01,01), sex: 'Female', 
																				latitude: 27.53037290421605, longitude: 53.905427341494146, 
																				email: 'Tibb@mail.ru', password: 'dsdfss') }
	let(:session) {{}}
	let(:first_user_from_new_session_users_ids) { User.find(session[:users_id].first) }

  describe '.call' do
	  
		context 'When session[:users_id] is nil' do
			before(:each) do
				session[:users_id] = nil
			end		

	  	it 'returns object type User where sex not eq sex of the current user' do
	  		user2_with_valid_attributes.foto_blobs << photo_with_valid_attributes
	  		user2_with_valid_attributes.save
	  		user3_with_valid_attributes.foto_blobs << photo_with_valid_attributes
	  		user3_with_valid_attributes.save
	  		current_user = user_with_valid_attributes
        current_user.foto_blobs << photo_with_valid_attributes
        current_user.save

	  		expect(UsersGenerator.call(current_user, session)).to (eq(user2_with_valid_attributes)
				                                                  .or eq(user3_with_valid_attributes)).and be_a_kind_of(User)
				expect((UsersGenerator.call(current_user, session)).sex).to eq('Female')
	  	end

			it 'changes session[:count] from nil to 0' do
	  		user2_with_valid_attributes.foto_blobs << photo_with_valid_attributes
	  		user2_with_valid_attributes.save
	  		user3_with_valid_attributes.foto_blobs << photo_with_valid_attributes
	  		user3_with_valid_attributes.save
	  		current_user = user_with_valid_attributes
        current_user.foto_blobs << photo_with_valid_attributes
        current_user.save

	  		expect{ UsersGenerator.call(current_user, session) }.to change { session[:count] }.from(nil).to(0)
	  	end
		end
		
		context 'When session[:users_id] is not nil' do
			context 'When session[:count] is nil' do
				
				before(:each) do
					session[:count] = nil
				end
  
	  	  it 'returns first object type User in session[:users_id] where sex not eq sex of the current user' do
	  	  	user2_with_valid_attributes.foto_blobs << photo_with_valid_attributes
	  	  	user2_with_valid_attributes.save
	  	  	user3_with_valid_attributes.foto_blobs << photo_with_valid_attributes
	  	  	user3_with_valid_attributes.save
	  	  	current_user = user_with_valid_attributes
          current_user.foto_blobs << photo_with_valid_attributes
          current_user.save
					session[:users_id] = [user2_with_valid_attributes.id, user3_with_valid_attributes.id]

	  	  	expect(UsersGenerator.call(current_user, session)).to eq(user2_with_valid_attributes).and be_a_kind_of(User)
					expect((UsersGenerator.call(current_user, session)).sex).to eq('Female')
	  	  end

				it 'changes session[:count] from nil to 0' do
					user2_with_valid_attributes.foto_blobs << photo_with_valid_attributes
					user2_with_valid_attributes.save
					user3_with_valid_attributes.foto_blobs << photo_with_valid_attributes
					user3_with_valid_attributes.save
					current_user = user_with_valid_attributes
					current_user.foto_blobs << photo_with_valid_attributes
					current_user.save
	
					expect{ UsersGenerator.call(current_user, session) }.to change { session[:count] }.from(nil).to(0)
				end
	    end

			context 'When session[:count] < size session[:users_id] - 2' do
				before(:each) do
					session[:count] = -1
				end
  
	  	  it 'returns object User.find(session[:users_id][session[:count] + 1]) type User where sex not eq sex of the current user' do
	  	  	user2_with_valid_attributes.foto_blobs << photo_with_valid_attributes
	  	  	user2_with_valid_attributes.save
	  	  	user3_with_valid_attributes.foto_blobs << photo_with_valid_attributes
	  	  	user3_with_valid_attributes.save
	  	  	current_user = user_with_valid_attributes
          current_user.foto_blobs << photo_with_valid_attributes
          current_user.save
					session[:users_id] = [user2_with_valid_attributes.id, user3_with_valid_attributes.id]
	  	  	
					expect(UsersGenerator.call(current_user, session)).to eq(user2_with_valid_attributes).and be_a_kind_of(User)
					expect((UsersGenerator.call(current_user, session)).sex).to eq('Female')
	  	  end

				it 'changes session[:count] by 1' do
	  	  	user2_with_valid_attributes.foto_blobs << photo_with_valid_attributes
	  	  	user2_with_valid_attributes.save
	  	  	user3_with_valid_attributes.foto_blobs << photo_with_valid_attributes
	  	  	user3_with_valid_attributes.save
	  	  	current_user = user_with_valid_attributes
          current_user.foto_blobs << photo_with_valid_attributes
          current_user.save
					session[:users_id] = [user2_with_valid_attributes.id, user3_with_valid_attributes.id]
	  	  	
					expect{ UsersGenerator.call(current_user, session) }.to change { session[:count] }.by(1)
	  	  end
	    end

			context 'When session[:count] == (size session[:users_id] - 2)' do

	  	  it 'returns last object type User where sex not eq sex of the current user' do
	  	  	user2_with_valid_attributes.foto_blobs << photo_with_valid_attributes
	  	  	user2_with_valid_attributes.save
	  	  	user3_with_valid_attributes.foto_blobs << photo_with_valid_attributes
	  	  	user3_with_valid_attributes.save
	  	  	current_user = user_with_valid_attributes
          current_user.foto_blobs << photo_with_valid_attributes
          current_user.save
					session[:users_id] = [user2_with_valid_attributes.id, user3_with_valid_attributes.id]
					session[:count] = session[:users_id].size - 2

	  	  	expect(UsersGenerator.call(current_user, session)).to eq(user3_with_valid_attributes)
					expect((UsersGenerator.call(current_user, session)).sex).to eq('Female')
					expect(UsersGenerator.call(current_user, session)).to be_a_kind_of(User)
	  	  end

				it 'changes session[:count] by 1' do
	  	  	user2_with_valid_attributes.foto_blobs << photo_with_valid_attributes
	  	  	user2_with_valid_attributes.save
	  	  	user3_with_valid_attributes.foto_blobs << photo_with_valid_attributes
	  	  	user3_with_valid_attributes.save
	  	  	current_user = user_with_valid_attributes
          current_user.foto_blobs << photo_with_valid_attributes
          current_user.save
					session[:users_id] = [user2_with_valid_attributes.id, user3_with_valid_attributes.id]
					session[:count] = session[:users_id].size - 2

	  	  	expect{ UsersGenerator.call(current_user, session) }.to change { session[:count] }.by(1)
	  	  end
	    end
			
			context 'When session[:count] > (size session[:users_id] - 2)' do

	  	  it 'returns first object type User from new session[:users_id] where sex not eq sex of the current user' do
	  	  	user2_with_valid_attributes.foto_blobs << photo_with_valid_attributes
	  	  	user2_with_valid_attributes.save
	  	  	user3_with_valid_attributes.foto_blobs << photo_with_valid_attributes
	  	  	user3_with_valid_attributes.save
	  	  	current_user = user_with_valid_attributes
          current_user.foto_blobs << photo_with_valid_attributes
          current_user.save
					session[:users_id] = [user2_with_valid_attributes.id, user3_with_valid_attributes.id]
					session[:count] = session[:users_id].size
					
	  	  	expect(UsersGenerator.call(current_user, session)).to eq(first_user_from_new_session_users_ids)					
					expect((UsersGenerator.call(current_user, session)).sex).to eq('Female')					
					expect(UsersGenerator.call(current_user, session)).to be_a_kind_of(User)			
	  	  end

				it 'sets session[:count] to 0' do
	  	  	user2_with_valid_attributes.foto_blobs << photo_with_valid_attributes
	  	  	user2_with_valid_attributes.save
	  	  	user3_with_valid_attributes.foto_blobs << photo_with_valid_attributes
	  	  	user3_with_valid_attributes.save
	  	  	current_user = user_with_valid_attributes
          current_user.foto_blobs << photo_with_valid_attributes
          current_user.save
					session[:users_id] = [user2_with_valid_attributes.id, user3_with_valid_attributes.id]
					session[:count] = session[:users_id].size

	  	  	expect{ UsersGenerator.call(current_user, session) }.to change { session[:count] }.from(2).to(0)
	  	  end
	    end
		end
		context 'when current_user is nil' do
	    it 'returns nil' do
	    	user2_with_valid_attributes.foto_blobs << photo_with_valid_attributes
	    	user2_with_valid_attributes.save
	    	user3_with_valid_attributes.foto_blobs << photo_with_valid_attributes
	    	user3_with_valid_attributes.save
	    	current_user = nil
		    session[:users_id] = [user2_with_valid_attributes.id, user3_with_valid_attributes.id]
				session[:count] = session[:users_id].size
				
	    	expect(UsersGenerator.call(current_user, session)).to be_nil						
	    end
	  end
  end
end