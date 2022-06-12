require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {described_class.new(first_name: "Kristy", last_name: "ZZZ", birth: "1990-01-01", sex: "Female", yourself: "fuck", latitude: 27.53037290421605, longitude: 53.905427341494146, email: "11@11", work_id: 17)}

  it 'returns correct name' do
    expect(user.first_name).to eq('Kristy')
  end

  it 'returns type string' do
    expect(user.first_name).to be_an_instance_of(String)
  end

  context 'validations tests' do
    context 'first name validations' do
      context 'When first name is not present' do
        
        before(:each) do
          @user = described_class.new(last_name: 'Smith', birth: '1990-01-01', sex: 'Man', yourself: 'sdads',
            latitude: 27.53037290421605, longitude: 53.905427341494146, email: 'Ti@mail.ru', work_id: 5, 
              password: 'dsdfss') 
          @user.foto_blobs << ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', content_type: 'image/jpeg', byte_size: 299946)
          @user.save
        end

        after(:each) do
          @user.destroy
        end

        it 'should returns false' do
          expect(@user.valid?).to be_falsey
        end
      end

      context 'When first name has more than 50 characters' do        
        before(:each) do
          @user = described_class.new(first_name: 'AlexaAlexaAlexaAlexaAlexaAlexaAlexaAlexaAlexaAlexaAlexa', last_name: 'Smith', birth: '1990-01-01', sex: 'Man', yourself: 'sdads',
            latitude: 27.53037290421605, longitude: 53.905427341494146, email: 'Ti@mail.ru', work_id: 5, 
              password: 'dsdfss') 
          @user.foto_blobs << ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', content_type: 'image/jpeg', byte_size: 299946)
          @user.save
        end

        after(:each) do
          @user.destroy
        end

        it 'should returns false' do
          expect(@user.valid?).to be_falsey
        end
      end

      context 'When first name is present, has less than 50 characters and is a string ' do
        before(:each) do
          @user = described_class.new(first_name: 'Alex', last_name: 'Smith', birth: '1990-01-01', sex: 'Man', yourself: 'sdads',
                                        latitude: 27.53037290421605, longitude: 53.905427341494146, email: 'Ti@mail.ru', work_id: 5, 
                                          password: 'dsdfss') 
          @user.foto_blobs << ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', content_type: 'image/jpeg', byte_size: 299946)
          @user.save
        end

        after(:each) do
          @user.destroy
        end

        it 'should returns true' do
          expect(@user.valid?).to be_truthy
        end
      end
    end

    context 'Last name validations' do
      
      context 'When Last name is not present' do
        before(:each) do
          @user = described_class.new(first_name: 'Alex', birth: '1990-01-01', sex: 'Man', yourself: 'sdads',
                                        latitude: 27.53037290421605, longitude: 53.905427341494146, email: 'Ti@mail.ru', work_id: 5, 
                                          password: 'dsdfss') 
          @user.foto_blobs << ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', content_type: 'image/jpeg', byte_size: 299946)
          @user.save
        end

        after(:each) do
          @user.destroy
        end

        it 'should returns true' do
          expect(@user.valid?).to be_truthy
        end
      end

      context 'When Last name has more than 50 characters' do
        before(:each) do
          @user = described_class.new(first_name: 'Alex', last_name: 'SmithSmithSmithSmithSmithSmithSmithSmithSmithSmithSmith', birth: '1990-01-01', sex: 'Man', yourself: 'sdads',
                                        latitude: 27.53037290421605, longitude: 53.905427341494146, email: 'Ti@mail.ru', work_id: 5, 
                                          password: 'dsdfss') 
          @user.foto_blobs << ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', content_type: 'image/jpeg', byte_size: 299946)
          @user.save
        end

        after(:each) do
          @user.destroy
        end

        it 'should returns false' do
          expect(@user.valid?).to be_falsey
        end
      end

      context 'When Last name is present, has less than 50 characters and is a string ' do
        before(:each) do
          @user = described_class.new(first_name: 'Alex', last_name: 'Smith', birth: '1990-01-01', sex: 'Man', yourself: 'sdads',
                                        latitude: 27.53037290421605, longitude: 53.905427341494146, email: 'Ti@mail.ru', work_id: 5, 
                                          password: 'dsdfss') 
          @user.foto_blobs << ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', content_type: 'image/jpeg', byte_size: 299946)
          @user.save
        end

        after(:each) do
          @user.destroy
        end

        it 'should returns true' do
          expect(@user.valid?).to be_truthy
        end
      end
    end
  

    context 'Sex validations' do
      context 'When sex is not present' do
        before(:each) do
          @user = described_class.new(first_name: 'Alex', last_name: 'Smith', birth: '1990-01-01', yourself: 'sdads',
                                        latitude: 27.53037290421605, longitude: 53.905427341494146, email: 'Ti@mail.ru', work_id: 5, 
                                          password: 'dsdfss') 
          @user.foto_blobs << ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', content_type: 'image/jpeg', byte_size: 299946)
          @user.save
        end

        after(:each) do
          @user.destroy
        end

        it 'should returns false' do
          expect(@user.valid?).to be_falsey
        end
      end
  
      context 'When sex is present' do
        before(:each) do
          @user = described_class.new(first_name: 'Alex', last_name: 'Smith', birth: '1990-01-01', sex: 'Man', yourself: 'sdads',
                                        latitude: 27.53037290421605, longitude: 53.905427341494146, email: 'Ti@mail.ru', work_id: 5, 
                                          password: 'dsdfss') 
          @user.foto_blobs << ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', content_type: 'image/jpeg', byte_size: 299946)
          @user.save
        end

        after(:each) do
          @user.destroy
        end

        it 'should returns true' do
          expect(@user.valid?).to be_truthy
        end
      end
    end

    context 'latitude validations' do
      context 'When latitude is not present' do
        before(:each) do
          @user = described_class.new(first_name: 'Alex', last_name: 'Smith', birth: '1990-01-01', sex: 'Man', yourself: 'sdads',
                                        longitude: 53.905427341494146, email: 'Ti@mail.ru', work_id: 5, 
                                          password: 'dsdfss') 
          @user.foto_blobs << ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', content_type: 'image/jpeg', byte_size: 299946)
          @user.save
        end

        after(:each) do
          @user.destroy
        end

        it 'should returns false' do
          expect(@user.valid?).to be_falsey
        end
      end
  
      context 'When latitude is present and is a float' do
        before(:each) do
          @user = described_class.new(first_name: 'Alex', birth: '1990-01-01', sex: 'Man', yourself: 'sdads',
            latitude: 27.53037290421605, longitude: 53.905427341494146, email: 'Ti@mail.ru', work_id: 5, 
              password: 'dsdfss') 
          @user.foto_blobs << ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', content_type: 'image/jpeg', byte_size: 299946)
          @user.save
        end

        after(:each) do
          @user.destroy
        end

        it 'creates a valid object' do
          expect(@user.valid?).to be_truthy
        end
      end
    end

    context 'birth validations' do
      context 'When birth is not present' do
        before(:each) do
          @user = described_class.new(first_name: 'Alex', last_name: 'Smith', sex: 'Man', yourself: 'sdads',
            latitude: 27.53037290421605, longitude: 53.905427341494146, email: 'Ti@mail.ru', work_id: 5, 
              password: 'dsdfss') 
          @user.foto_blobs << ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', content_type: 'image/jpeg', byte_size: 299946)
          @user.save
        end

        after(:each) do
          @user.destroy
        end

        it 'should returns false' do
          expect(@user.valid?).to be_falsey
        end
      end
  
      context 'When a birth is present but does not have a date type' do
        before(:each) do
          @user = described_class.new(first_name: 'Alex', last_name: 'Smith', birth: 'sdsd', sex: 'Man', yourself: 'sdads',
            latitude: 27.53037290421605, longitude: 53.905427341494146, email: 'Ti@mail.ru', work_id: 5, 
              password: 'dsdfss') 
          @user.foto_blobs << ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', content_type: 'image/jpeg', byte_size: 299946)
          @user.save
        end

        after(:each) do
          @user.destroy
        end

        it 'should returns false' do
          expect(@user.valid?).to be_falsey
        end
      end
  
      context 'When a birth is present and has a date type but greater than Time.now' do
        before(:each) do
          @user = described_class.new(first_name: 'Alex', last_name: 'Smith', birth: '2990-01-01', sex: 'Man', yourself: 'sdads',
            latitude: 27.53037290421605, longitude: 53.905427341494146, email: 'Ti@mail.ru', work_id: 5, 
              password: 'dsdfss') 
          @user.foto_blobs << ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', content_type: 'image/jpeg', byte_size: 299946)
          @user.save
        end

        after(:each) do
          @user.destroy
        end

        it 'should returns false' do
          expect(@user.valid?).to be_falsey
        end
      end
  
      context 'When a birth is present and has a date type but less than 1900-01-01' do
        before(:each) do
          @user = described_class.new(first_name: 'Alex', last_name: 'Smith', birth: '990-01-01', sex: 'Man', yourself: 'sdads',
            latitude: 27.53037290421605, longitude: 53.905427341494146, email: 'Ti@mail.ru', work_id: 5, 
              password: 'dsdfss') 
          @user.foto_blobs << ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', content_type: 'image/jpeg', byte_size: 299946)
          @user.save
        end

        after(:each) do
          @user.destroy
        end

        it 'should returns false' do
          expect(@user.valid?).to be_falsey
        end
      end

      context 'When a birth is present and has a right date' do
        before(:each) do
          @user = described_class.new(first_name: 'Alex', last_name: 'Smith', birth: '1990-01-01', sex: 'Man', yourself: 'sdsd',
            latitude: 27.53037290421605, longitude: 53.905427341494146, email: 'Ti@mail.ru', work_id: 5, 
              password: 'dsdfss') 
          @user.foto_blobs << ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', content_type: 'image/jpeg', byte_size: 299946)
          @user.save
        end

        after(:each) do
          @user.destroy
        end

        it 'should returns true' do
          expect(@user.valid?).to be_truthy
        end
      end
    end

    context 'yourself validations' do
      context 'When yourself is not present' do
        before(:each) do
          @user = described_class.new(first_name: 'Alex', birth: '1990-01-01', sex: 'Man',
            latitude: 27.53037290421605, longitude: 53.905427341494146, email: 'Ti@mail.ru', work_id: 5, 
              password: 'dsdfss') 
          @user.foto_blobs << ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', content_type: 'image/jpeg', byte_size: 299946)
          @user.save
        end

        after(:each) do
          @user.destroy
        end

        it 'should returns true' do
          expect(@user.valid?).to be_truthy
        end
      end
  
      context 'When yourself has more than 255 characters' do
        before(:each) do
          @user = described_class.new(first_name: 'Alex', last_name: 'Smith', birth: '1990-01-01', sex: 'Man', yourself: ('sdads' * 52),
            latitude: 27.53037290421605, longitude: 53.905427341494146, email: 'Ti@mail.ru', work_id: 5, 
              password: 'dsdfss') 
          @user.foto_blobs << ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', content_type: 'image/jpeg', byte_size: 299946)
          @user.save
        end

        after(:each) do
          @user.destroy
        end

        it 'should returns false' do
          expect(@user.valid?).to be_falsey
        end
      end
  
      context 'When yourself is present but has forbidden words ' do
        before(:each) do
          @user = described_class.new(first_name: 'Alex', last_name: 'Smith', birth: '1990-01-01', sex: 'Man', yourself: 'fuck',
            latitude: 27.53037290421605, longitude: 53.905427341494146, email: 'Ti@mail.ru', work_id: 5, 
              password: 'dsdfss') 
          @user.foto_blobs << ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', content_type: 'image/jpeg', byte_size: 299946)
          @user.save
        end
        
        after(:each) do
          @user.destroy
        end

        it 'should returns false' do
          expect(@user.valid?).to be_falsey
        end
      end
  
      context 'When yourself is present, has less than 255 characters and is a string ' do
        before(:each) do
          @user = described_class.new(first_name: 'Alex', last_name: 'Smith', birth: '1990-01-01', sex: 'Man', yourself: 'sdsd',
            latitude: 27.53037290421605, longitude: 53.905427341494146, email: 'Ti@mail.ru', work_id: 5, 
              password: 'dsdfss') 
          @user.foto_blobs << ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', content_type: 'image/jpeg', byte_size: 299946)
          @user.save
        end

        after(:each) do
          @user.destroy
        end

        it 'should returns true' do
          expect(@user.valid?).to be_truthy
        end
      end
    end

    context 'foto validations' do
      
      context 'When foto is not present' do
        before(:each) do
          @user = described_class.new(first_name: 'Alex', last_name: 'Smith', birth: '1990-01-01', sex: 'Man', yourself: 'sdsd',
            latitude: 27.53037290421605, longitude: 53.905427341494146, email: 'Ti@mail.ru', work_id: 5, 
              password: 'dsdfss') 
          @user.save
        end
        
        it 'should returns false' do
          expect(@user.valid?).to be_falsey
        end
      end

      after(:each) do
        @user.destroy
      end

      context 'When foto is greater than 2Mb' do
        before(:each) do
          @user = described_class.new(first_name: 'Alex', last_name: 'Smith', birth: '1990-01-01', sex: 'Man', yourself: 'sdsd',
            latitude: 27.53037290421605, longitude: 53.905427341494146, email: 'Ti@mail.ru', work_id: 5, 
              password: 'dsdfss') 
          @user.foto_blobs << ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', content_type: 'image/jpeg', byte_size: 3299946)
          @user.save
        end

        after(:each) do
          @user.destroy
        end

        it 'should returns false' do
          expect(@user.valid?).to be_falsey
        end
      end

      context 'When foto content type is not image' do
        before(:each) do
          @user = described_class.new(first_name: 'Alex', last_name: 'Smith', birth: '1990-01-01', sex: 'Man', yourself: 'sdsd',
            latitude: 27.53037290421605, longitude: 53.905427341494146, email: 'Ti@mail.ru', work_id: 5, 
              password: 'dsdfss') 
          @user.foto_blobs << ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', content_type: 'video/avi', byte_size: 299946)
          @user.save
        end

        after(:each) do
          @user.destroy
        end

        it 'should returns false' do
          expect(@user.valid?).to be_falsey
        end
      end

      context 'When uploading more than 5 photos' do
        before(:each) do
          @user = described_class.new(first_name: 'Alex', last_name: 'Smith', birth: '1990-01-01', sex: 'Man', yourself: 'sdsd',
            latitude: 27.53037290421605, longitude: 53.905427341494146, email: 'Ti@mail.ru', work_id: 5, 
              password: 'dsdfss') 
          @user.foto_blobs << ActiveStorage::Blob.new(filename: 'ddff1', checksum: '11', content_type: 'image/jpeg', byte_size: 299946)
          @user.foto_blobs << ActiveStorage::Blob.new(filename: 'ddff2', checksum: '12', content_type: 'image/jpeg', byte_size: 299946)
          @user.foto_blobs << ActiveStorage::Blob.new(filename: 'ddff3', checksum: '13', content_type: 'image/jpeg', byte_size: 299946)
          @user.foto_blobs << ActiveStorage::Blob.new(filename: 'ddff4', checksum: '14', content_type: 'image/jpeg', byte_size: 299946)
          @user.foto_blobs << ActiveStorage::Blob.new(filename: 'ddff5', checksum: '15', content_type: 'image/jpeg', byte_size: 299946)
          @user.foto_blobs << ActiveStorage::Blob.new(filename: 'ddff6', checksum: '16', content_type: 'image/jpeg', byte_size: 299946)
          @user.save
        end

        after(:each) do
          @user.destroy
        end

        it 'should returns false' do
          expect(@user.valid?).to be_falsey
        end
      end
  
      context 'When foto has right type and less than 2Mb' do
        before(:each) do
          @user = described_class.new(first_name: 'Alex', last_name: 'Smith', birth: '1990-01-01', sex: 'Man', yourself: 'sdsd',
            latitude: 27.53037290421605, longitude: 53.905427341494146, email: 'Ti@mail.ru', work_id: 5, 
              password: 'dsdfss') 
          @user.foto_blobs << ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', content_type: 'image/jpeg', byte_size: 299946)
          @user.save
        end

        after(:each) do
          @user.destroy
        end

        it 'should returns true' do
          expect(@user.valid?).to be_truthy
        end
      end
    end
  end
end
