require 'rails_helper'

RSpec.describe UsersGenerator, type: :service do
	
	let(:photo_with_valid_attributes) { ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', content_type: 'image/jpeg', byte_size: 299946)}
  let(:current_user) { User.new(first_name: 'Alex', birth: Date.new(1990,01,01), sex: 'Man', 
                                     latitude: 27.53037290421605, longitude: 53.905427341494146, 
                                     email: 'Timm@mail.ru', password: 'dsdfss') }
	let(:user2_with_valid_attributes) { User.new(first_name: 'Alexa', birth: Date.new(1990,01,01), sex: 'Female', 
																			latitude: 27.53037290421605, longitude: 53.905427341494146, 
																			email: 'Tinn@mail.ru', password: 'dsdfss') }
  let(:user3_with_valid_attributes) { User.new(first_name: 'Nata', birth: Date.new(1990,01,01), sex: 'Female', 
																				latitude: 27.53037290421605, longitude: 53.905427341494146, 
																				email: 'Tibb@mail.ru', password: 'dsdfss') }
	let(:session) {{}}
	let(:first_user_from_new_users_ids_session) { User.find(session[:users_id].first) }
	
	subject { UsersGenerator.call(current_user, session) }

  describe '.call' do
	  
		context 'When session[:users_id] is nil' do
			before(:each) do
				session[:users_id] = nil
				create_3_users(current_user, user2_with_valid_attributes, user3_with_valid_attributes, photo_with_valid_attributes)
			end		

	  	it 'returns object type User where sex not eq sex of the current user' do
	  		expect(subject).to (eq(user2_with_valid_attributes).or eq(user3_with_valid_attributes)).and be_instance_of(User)
				expect(subject.sex).to eq('Female')
	  	end

			it 'changes session[:count] from nil to 0' do
	  		expect{ subject }.to change { session[:count] }.from(nil).to(0)
	  	end
		end
		
		context 'When session[:users_id] is not nil' do
			context 'When session[:count] is nil' do
				
				before(:each) do
					session[:count] = nil
					create_3_users(current_user, user2_with_valid_attributes, user3_with_valid_attributes, photo_with_valid_attributes)
					session[:users_id] = [user2_with_valid_attributes.id, user3_with_valid_attributes.id]
				end
  
	  	  it 'returns first object type User in session[:users_id] where sex not eq sex of the current user' do
	  	  	expect(subject).to eq(user2_with_valid_attributes).and be_instance_of(User)
					expect(subject.sex).to eq('Female')
	  	  end

				it 'changes session[:count] from nil to 0' do	
					expect{ subject }.to change { session[:count] }.from(nil).to(0)
				end
	    end

			context 'When session[:count] < size session[:users_id] - 2' do
				before(:each) do
					session[:count] = -1
					create_3_users(current_user, user2_with_valid_attributes, user3_with_valid_attributes, photo_with_valid_attributes)
					session[:users_id] = [user2_with_valid_attributes.id, user3_with_valid_attributes.id]
				end
  
	  	  it 'returns object User.find(session[:users_id][session[:count] + 1]) type User where sex not eq sex of the current user' do
					expect(subject).to eq(user2_with_valid_attributes).and be_instance_of(User)
					expect(subject.sex).to eq('Female')
	  	  end

				it 'changes session[:count] by 1' do
					expect{ subject }.to change { session[:count] }.by(1)
	  	  end
	    end

			context 'When session[:count] == (size session[:users_id] - 2)' do
				before(:each) do
					create_3_users(current_user, user2_with_valid_attributes, user3_with_valid_attributes, photo_with_valid_attributes)
					session[:users_id] = [user2_with_valid_attributes.id, user3_with_valid_attributes.id]
					session[:count] = session[:users_id].size - 2
				end

	  	  it 'returns last object type User where sex not eq sex of the current user' do
	  	  	expect(subject).to eq(user3_with_valid_attributes).and be_instance_of(User)
					expect(subject.sex).to eq('Female')
	  	  end

				it 'changes session[:count] by 1' do
	  	  	expect{ subject }.to change { session[:count] }.by(1)
	  	  end
	    end
			
			context 'When session[:count] > (size session[:users_id] - 2)' do
				before(:each) do
					create_3_users(current_user, user2_with_valid_attributes, user3_with_valid_attributes, photo_with_valid_attributes)
					session[:users_id] = [user2_with_valid_attributes.id, user3_with_valid_attributes.id]
					session[:count] = session[:users_id].size
				end

	  	  it 'returns first object type User from new session[:users_id] where sex not eq sex of the current user' do
	  	  	expect(subject).to eq(first_user_from_new_users_ids_session).and be_instance_of(User)					
					expect(subject.sex).to eq('Female')							
	  	  end

				it 'sets session[:count] to 0' do
	  	  	expect{ subject }.to change { session[:count] }.from(2).to(0)
	  	  end
	    end
		end
  end
end