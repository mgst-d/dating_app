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

  let(:photo_with_valid_params) { ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', content_type: 'image/jpeg', byte_size: 299946)}
  let(:user_with_valid_params) {described_class.new(first_name: 'Alex', last_name: 'Smith', birth: Date.new(1990,01,01), sex: 'Man', 
                                yourself: 'sdsd', latitude: 27.53037290421605, longitude: 53.905427341494146, email: 'Ti@mail.ru', 
                                work_id: 5, password: 'dsdfss') }
  
  describe 'Users initialize tests' do
  
    before(:each) do
      create_user(user_with_valid_params, photo_with_valid_params)
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

  describe 'User validations tests' do
   
    after(:each) do
      subject.destroy
    end
    
    context 'When all params OK' do

      before(:each) do
        create_user(user_with_valid_params, photo_with_valid_params)
      end
  
      subject { user_with_valid_params }

      it 'should returns valid subject' do
        expect(subject).to be_valid
      end
    end

    describe '#first_name' do
      context 'When first name is not present' do

        subject { described_class.new(last_name: 'Smith', birth: '1990-01-01', sex: 'Man',
                                      yourself: 'sdads', latitude: 27.53037290421605, longitude: 53.905427341494146, 
                                      email: 'Ti@mail.ru', work_id: 5, password: 'dsdfss') }
        
        before(:each) do
          create_user(subject, photo_with_valid_params)
        end

        it 'is invalid' do
          expect(subject).not_to be_valid
          expect(subject.errors.count).to eq(1)
          expect(subject.errors.first).to have_attributes(attribute: :first_name)
        end
      end

      context 'When first name has more than 50 characters' do        
        
        subject { described_class.new(first_name: ('Alexa' * 11), last_name: 'Smith', birth: '1990-01-01', sex: 'Man', 
                                      yourself: 'sdads', latitude: 27.53037290421605, longitude: 53.905427341494146, 
                                      email: 'Ti@mail.ru', work_id: 5, password: 'dsdfss') }
        
        before(:each) do
          create_user(subject, photo_with_valid_params)
        end

        it 'is invalid' do
          expect(subject).not_to be_valid
          expect(subject.errors.count).to eq(1)
          expect(subject.errors.first).to have_attributes(type: :too_long)
        end
      end
    end

    describe '#Last_name' do
      context 'When Last name has more than 50 characters' do
        
        subject { described_class.new(first_name: 'Alex', last_name: ('Smith' * 11), birth: '1990-01-01', sex: 'Man', 
                                      yourself: 'sdads', latitude: 27.53037290421605, longitude: 53.905427341494146, 
                                      email: 'Ti@mail.ru', work_id: 5, password: 'dsdfss') }
        before(:each) do
          create_user(subject, photo_with_valid_params)
        end

        it 'is invalid' do
          expect(subject).not_to be_valid
          expect(subject.errors.count).to eq(1)
          expect(subject.errors.first).to have_attributes(type: :too_long)
        end
      end
    end
  
    describe '#Sex' do
      context 'When sex is not present' do
        
        subject { described_class.new(first_name: 'Alex', last_name: 'Smith', birth: '1990-01-01', yourself: 'sdads',
                                      latitude: 27.53037290421605, longitude: 53.905427341494146, email: 'Ti@mail.ru', 
                                      work_id: 5, password: 'dsdfss')}
        before(:each) do
          create_user(subject, photo_with_valid_params)
        end

        it 'is invalid' do
          expect(subject).not_to be_valid
          expect(subject.errors.count).to eq(1)
          expect(subject.errors.first).to have_attributes(attribute: :sex)
        end
      end
    end

    describe '#latitude' do
      context 'When latitude is not present' do
        
        subject { described_class.new(first_name: 'Alex', last_name: 'Smith', birth: '1990-01-01', sex: 'Man', 
                                      yourself: 'sdads', longitude: 53.905427341494146, email: 'Ti@mail.ru', 
                                      work_id: 5, password: 'dsdfss') }
        before(:each) do
          create_user(subject, photo_with_valid_params)
        end

        it 'is invalid' do
          expect(subject).not_to be_valid
          expect(subject.errors.count).to eq(1)
          expect(subject.errors.first).to have_attributes(attribute: :latitude)
        end
      end
    end

    describe '#birth' do
      context 'When birth is not present' do
        
        subject { described_class.new(first_name: 'Alex', last_name: 'Smith', sex: 'Man', yourself: 'sdads',
                                      latitude: 27.53037290421605, longitude: 53.905427341494146, email: 'Ti@mail.ru', 
                                      work_id: 5, password: 'dsdfss') }
        before(:each) do
          create_user(subject, photo_with_valid_params)
        end

        it 'is invalid' do
          expect(subject).not_to be_valid
          expect(subject.errors.count).to eq(2)
          expect(subject.errors.first).to have_attributes(attribute: :birth)
        end
      end
  
      context 'When the birth is earlier than Time.zone.today - 18.years (user under 18)' do
        
        subject { described_class.new(first_name: 'Alex', last_name: 'Smith', birth: Time.zone.today - 18.years + 1, sex: 'Man', 
                                      yourself: 'sdads', latitude: 27.53037290421605, longitude: 53.905427341494146, 
                                      email: 'Ti@mail.ru', work_id: 5, password: 'dsdfss') }
        before(:each) do
          create_user(subject, photo_with_valid_params)
        end

        it 'is invalid' do
          expect(subject).not_to be_valid
          expect(subject.errors.count).to eq(1)
          expect(subject.errors.first).to have_attributes(type: :less_than)
        end
      end
  
      context 'When a birth is less than 1900-01-01' do
        
        subject { described_class.new(first_name: 'Alex', last_name: 'Smith', birth: '990-01-01', sex: 'Man', 
                                      yourself: 'sdads', latitude: 27.53037290421605, longitude: 53.905427341494146, 
                                      email: 'Ti@mail.ru', work_id: 5, password: 'dsdfss') }
        before(:each) do
          create_user(subject, photo_with_valid_params)
        end

        it 'is invalid' do
          expect(subject).not_to be_valid
          expect(subject.errors.count).to eq(1)
          expect(subject.errors.first).to have_attributes(type: :greater_than)
        end
      end
    end

    describe '#yourself' do
      context 'When yourself has more than 255 characters' do
        
        subject { described_class.new(first_name: 'Alex', last_name: 'Smith', birth: '1990-01-01', sex: 'Man', 
                                      yourself: ('sdads' * 52), latitude: 27.53037290421605, 
                                      longitude: 53.905427341494146, email: 'Ti@mail.ru', work_id: 5, 
                                      password: 'dsdfss') }
        before(:each) do  
          create_user(subject, photo_with_valid_params)
        end

        it 'is invalid' do
          expect(subject).not_to be_valid
          expect(subject.errors.count).to eq(1)
          expect(subject.errors.first).to have_attributes(type: :too_long)
        end
      end
  
      context 'When yourself has forbidden words' do
        
        subject { described_class.new(first_name: 'Alex', last_name: 'Smith', birth: '1990-01-01', sex: 'Man', 
                                      yourself: 'fuck', latitude: 27.53037290421605, longitude: 53.905427341494146, 
                                      email: 'Ti@mail.ru', work_id: 5, password: 'dsdfss') }
        before(:each) do  
          create_user(subject, photo_with_valid_params)
        end

        it 'is invalid' do
          expect(subject).not_to be_valid
          expect(subject.errors.count).to eq(1)
          expect(subject.errors.first).to have_attributes(type: "includes forbidden words")
        end
      end
    end

    describe '#foto' do
      context 'When foto is not present' do
        before(:each) do 
          user_with_valid_params.save
        end

        subject {user_with_valid_params}
        
        it 'is invalid' do
          expect(subject).not_to be_valid
          expect(subject.errors.count).to eq(1)
          expect(subject.errors.first).to have_attributes(attribute: :foto)
        end
      end

      context 'When foto is greater than 2Mb' do
        before(:each) do
          user_with_valid_params.foto_blobs << ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', 
                                                                       content_type: 'image/jpeg', byte_size: 3299946)
          user_with_valid_params.save
        end

        subject {user_with_valid_params}

        it 'is invalid' do
          expect(subject).not_to be_valid
          expect(subject.errors.count).to eq(1)
          expect(subject.errors.first).to have_attributes(type: :file_size_out_of_range)
        end
      end

      context 'When foto content type is not image' do
        before(:each) do
          user_with_valid_params.foto_blobs << ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', 
                                                                       content_type: 'video/avi', byte_size: 299946)
          user_with_valid_params.save
        end

        subject {user_with_valid_params}

        it 'is invalid' do
          expect(subject).not_to be_valid
          expect(subject.errors.count).to eq(1)
          expect(subject.errors.first).to have_attributes(type: :content_type_invalid)
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

        it 'is invalid' do
          expect(subject).not_to be_valid
          expect(subject.errors.count).to eq(1)
          expect(subject.errors.first).to have_attributes(type: :limit_out_of_range)
        end
      end
    end
  end
end
