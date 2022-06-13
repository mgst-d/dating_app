require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'associations' do
    it { should have_many_attached(:foto)}
    it { should have_many(:hobby_users)}
    it { should have_many(:hobbies)}
    it { should belong_to(:work)}
    it { should have_many(:liker_likes)}
    it { should have_many(:likees)}
    it { should have_many(:likee_likes)}
    it { should have_many(:likers)}
    it { should have_many(:messages)}  
    it { should have_many(:participants)}  
    it { should have_many(:rooms)}  
  end
  
  context 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  let(:photo_with_valid_params) { ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', content_type: 'image/jpeg', byte_size: 299946)}
  let(:user_with_valid_params) {described_class.new(first_name: 'Alex', last_name: 'Smith', birth: Date.new(1990,01,01), sex: 'Man', 
                                yourself: 'sdsd', latitude: 27.53037290421605, longitude: 53.905427341494146, email: 'Ti@mail.ru', 
                                work_id: 5, password: 'dsdfss') }
  
  context 'Users initialize tests' do
  
    before(:each) do
      user_with_valid_params.foto_blobs << photo_with_valid_params
      user_with_valid_params.save
    end

    subject { user_with_valid_params }

    context 'User first name' do
      it 'returns correct name' do
        expect(subject.first_name).to eq('Alex')
      end
    
      it 'returns object type string' do
        expect(subject.first_name).to be_an_instance_of(String)
      end
    end

    context 'User last name' do
      it 'returns correct name' do
        expect(subject.last_name).to eq('Smith')
      end
    
      it 'returns object type string' do
        expect(subject.last_name).to be_an_instance_of(String)
      end
    end
    
    context 'User work_id' do
      it 'returns correct work_id' do
        expect(subject.work_id).to eq(5)
      end
    
      it 'returns object type Integer' do
        expect(subject.work_id).to be_an_instance_of(Integer)
      end
    end

    context 'User birth' do
      it 'returns correct birth date' do
        expect(subject.birth.to_s).to eq('1990-01-01')
      end
    
      it 'returns object type date' do
        expect(subject.birth).to be_an_instance_of(Date)
      end
    end

    context 'User latitude' do
      it 'returns correct latitude' do
        expect(subject.latitude).to eq(27.53037290421605)
      end
    
      it 'returns object type Float' do
        expect(subject.latitude).to be_an_instance_of(Float)
      end
    end

    context 'User latitude' do
      it 'returns correct longitude' do
        expect(subject.longitude).to eq(53.905427341494146)
      end
    
      it 'returns object type Float' do
        expect(subject.longitude).to be_an_instance_of(Float)
      end
    end

    context 'User sex' do
      it 'returns correct sex' do
        expect(subject.sex).to eq('Man')
      end
    
      it 'returns object type string' do
        expect(subject.sex).to be_an_instance_of(String)
      end
    end

    context 'User yourself' do
      it 'returns yourself text' do
        expect(subject.yourself).to eq('sdsd')
      end
    
      it 'returns object type string' do
        expect(subject.yourself).to be_an_instance_of(String)
      end
    end

    context 'User email' do
      it 'returns correct email' do
        expect(subject.email).to eq('ti@mail.ru')
      end
    
      it 'returns object type string' do
        expect(subject.email).to be_an_instance_of(String)
      end
    end

    context 'User password' do
      it 'returns correct passwords' do
        expect(subject.password).to eq('dsdfss')
      end
    
      it 'returns object type string' do
        expect(subject.password).to be_an_instance_of(String)
      end
    end
  end

  context 'User validations tests' do
   
    after(:each) do
      subject.destroy
    end
    
    context 'When all params OK' do

      before(:each) do
        user_with_valid_params.foto_blobs << photo_with_valid_params
        user_with_valid_params.save
      end
  
      subject { user_with_valid_params }

      it 'should returns valid subject' do
        expect(subject.valid?).to be_truthy
      end
    end

    describe 'first name validations' do
      context 'When first name is not present' do

        subject { described_class.new(last_name: 'Smith', birth: '1990-01-01', sex: 'Man',
                                      yourself: 'sdads', latitude: 27.53037290421605, longitude: 53.905427341494146, 
                                      email: 'Ti@mail.ru', work_id: 5, password: 'dsdfss') }
        
        before(:each) do
          subject.foto_blobs << photo_with_valid_params
          subject.save
        end

        it 'should returns invalid subject' do
          expect(subject.valid?).to be_falsey
        end
      end

      context 'When first name has more than 50 characters' do        
        
        subject { described_class.new(first_name: ('Alexa' * 11), last_name: 'Smith', birth: '1990-01-01', sex: 'Man', 
                                      yourself: 'sdads', latitude: 27.53037290421605, longitude: 53.905427341494146, 
                                      email: 'Ti@mail.ru', work_id: 5, password: 'dsdfss') }
        
        before(:each) do
          subject.foto_blobs << photo_with_valid_params
          subject.save
        end

        it 'should returns invalid subject' do
          expect(subject.valid?).to be_falsey
        end
      end
    end

    describe 'Last name validations' do
      context 'When Last name has more than 50 characters' do
        
        subject { described_class.new(first_name: 'Alex', last_name: ('Smith' * 11), birth: '1990-01-01', sex: 'Man', 
                                      yourself: 'sdads', latitude: 27.53037290421605, longitude: 53.905427341494146, 
                                      email: 'Ti@mail.ru', work_id: 5, password: 'dsdfss') }
        before(:each) do
          subject.foto_blobs << photo_with_valid_params
          subject.save
        end

        it 'should returns invalid subject' do
          expect(subject.valid?).to be_falsey
        end
      end
    end
  
    describe 'Sex validations' do
      context 'When sex is not present' do
        
        subject { described_class.new(first_name: 'Alex', last_name: 'Smith', birth: '1990-01-01', yourself: 'sdads',
                                      latitude: 27.53037290421605, longitude: 53.905427341494146, email: 'Ti@mail.ru', 
                                      work_id: 5, password: 'dsdfss')}
        before(:each) do
          subject.foto_blobs << photo_with_valid_params
          subject.save
        end

        it 'should returns invalid subject' do
          expect(subject.valid?).to be_falsey
        end
      end
    end

    describe 'latitude validations' do
      context 'When latitude is not present' do
        
        subject { described_class.new(first_name: 'Alex', last_name: 'Smith', birth: '1990-01-01', sex: 'Man', 
                                      yourself: 'sdads', longitude: 53.905427341494146, email: 'Ti@mail.ru', 
                                      work_id: 5, password: 'dsdfss') }
        before(:each) do
          subject.foto_blobs << photo_with_valid_params
          subject.save
        end

        it 'should returns invalid subject' do
          expect(subject.valid?).to be_falsey
        end
      end
    end

    describe 'birth validations' do
      context 'When birth is not present' do
        
        subject { described_class.new(first_name: 'Alex', last_name: 'Smith', sex: 'Man', yourself: 'sdads',
                                      latitude: 27.53037290421605, longitude: 53.905427341494146, email: 'Ti@mail.ru', 
                                      work_id: 5, password: 'dsdfss') }
        before(:each) do
          subject.foto_blobs << photo_with_valid_params
          subject.save
        end

        it 'should returns invalid subject' do
          expect(subject.valid?).to be_falsey
        end
      end
  
      context 'When a birth is greater than Time.now' do
        
        subject { described_class.new(first_name: 'Alex', last_name: 'Smith', birth: '2990-01-01', sex: 'Man', 
                                      yourself: 'sdads', latitude: 27.53037290421605, longitude: 53.905427341494146, 
                                      email: 'Ti@mail.ru', work_id: 5, password: 'dsdfss') }
        before(:each) do
          subject.foto_blobs << photo_with_valid_params
          subject.save
        end

        it 'should returns invalid subject' do
          expect(subject.valid?).to be_falsey
        end
      end
  
      context 'When a birth is less than 1900-01-01' do
        
        subject { described_class.new(first_name: 'Alex', last_name: 'Smith', birth: '990-01-01', sex: 'Man', 
                                      yourself: 'sdads', latitude: 27.53037290421605, longitude: 53.905427341494146, 
                                      email: 'Ti@mail.ru', work_id: 5, password: 'dsdfss') }
        before(:each) do
          subject.foto_blobs << photo_with_valid_params
          subject.save
        end

        it 'should returns invalid subject' do
          expect(subject.valid?).to be_falsey
        end
      end
    end

    describe 'yourself validations' do
      context 'When yourself has more than 255 characters' do
        
        subject { described_class.new(first_name: 'Alex', last_name: 'Smith', birth: '1990-01-01', sex: 'Man', 
                                      yourself: ('sdads' * 52), latitude: 27.53037290421605, 
                                      longitude: 53.905427341494146, email: 'Ti@mail.ru', work_id: 5, 
                                      password: 'dsdfss') }
        before(:each) do  
          subject.foto_blobs << photo_with_valid_params
          subject.save
        end

        it 'should returns invalid subject' do
          expect(subject.valid?).to be_falsey
        end
      end
  
      context 'When yourself has forbidden words' do
        
        subject { described_class.new(first_name: 'Alex', last_name: 'Smith', birth: '1990-01-01', sex: 'Man', 
                                      yourself: 'fuck', latitude: 27.53037290421605, longitude: 53.905427341494146, 
                                      email: 'Ti@mail.ru', work_id: 5, password: 'dsdfss') }
        before(:each) do  
          subject.foto_blobs << photo_with_valid_params
          subject.save
        end

        it 'should returns invalid subject' do
          expect(subject.valid?).to be_falsey
        end
      end
    end

    describe 'foto validations' do
      context 'When foto is not present' do
        before(:each) do 
          user_with_valid_params.save
        end

        subject {user_with_valid_params}
        
        it 'should returns invalid subject' do
          expect(subject.valid?).to be_falsey
        end
      end

      context 'When foto is greater than 2Mb' do
        before(:each) do
          user_with_valid_params.foto_blobs << ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', 
                                                                       content_type: 'image/jpeg', byte_size: 3299946)
          user_with_valid_params.save
        end

        subject {user_with_valid_params}

        it 'should returns invalid subject' do
          expect(subject.valid?).to be_falsey
        end
      end

      context 'When foto content type is not image' do
        before(:each) do
          user_with_valid_params.foto_blobs << ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', 
                                                                       content_type: 'video/avi', byte_size: 299946)
          user_with_valid_params.save
        end

        subject {user_with_valid_params}

        it 'should returns invalid subject' do
          expect(subject.valid?).to be_falsey
        end
      end

      context 'When uploading more than 5 photos' do
        before(:each) do
          user_with_valid_params.foto_blobs << ActiveStorage::Blob.new(filename: 'ddff1', checksum: '11', 
                                                                       content_type: 'image/jpeg', byte_size: 299946)
          user_with_valid_params.foto_blobs << ActiveStorage::Blob.new(filename: 'ddff2', checksum: '12', 
                                                                       content_type: 'image/jpeg', byte_size: 299946)
          user_with_valid_params.foto_blobs << ActiveStorage::Blob.new(filename: 'ddff3', checksum: '13', 
                                                                       content_type: 'image/jpeg', byte_size: 299946)
          user_with_valid_params.foto_blobs << ActiveStorage::Blob.new(filename: 'ddff4', checksum: '14', 
                                                                       content_type: 'image/jpeg', byte_size: 299946)
          user_with_valid_params.foto_blobs << ActiveStorage::Blob.new(filename: 'ddff5', checksum: '15', 
                                                                       content_type: 'image/jpeg', byte_size: 299946)
          user_with_valid_params.foto_blobs << ActiveStorage::Blob.new(filename: 'ddff6', checksum: '16', 
                                                                       content_type: 'image/jpeg', byte_size: 299946)
          user_with_valid_params.save
        end

        subject {user_with_valid_params}

        it 'should returns invalid subject' do
          expect(subject.valid?).to be_falsey
        end
      end
    end
  end
end
