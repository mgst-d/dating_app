require  'rails_helper'

# RSpec.describe UsersController, type:  :controller  do
#   # группа тестов, которая отвечает за тестирование экшена  index
#   describe "GET #index" do
#     # тест проверяет что возвращается корретный запрос
#     it "returns a success response" do
#       get :index
#       expect(response).to have_http_status(:ok)
#     end

#     # ниже должны быть тесты которые проверяют на рендеринг определенных
#     # представлений и создание (assigns) определенных экземпляров
#     it "renders index template"  do
#     end
#     it "assigns tasks" do
#     end
#   end
# end

# RSpec.describe UsersController, type: :controller do

#   let(:user) { build(:user) }
#   before { login_user user }
#   #for user log in
  
#   let(:case_file) { create(:case_file) }
#   let(:link) { create(:link, case_file: case_file) }
  
#   describe "DELETE destroy" do
#     it "deletes a link" do
#       expect { delete :destroy, id: link.id , case_id: case_file }.
#       to change(Link, :count).by(-1) 
#       expect(response).to redirect_to(case_path(case_file))
#     end
#   end
# end

# RSpec.describe UsersController do
#   describe "GET 'index'" do
#     context "when not logged in" do
#       # you want to be sure that before_filter is executed
#       it "requires authentication" do
#         controller.expects :logged_in?
#         get 'index'
#       end
#       # you don't want to spec that it will redirect you to login_path
#       # because that spec belongs to #logged_in? method specs
#     end
#     context "when authenticated" do
#       before(:each) { controller.stubs :logged_in? }
#       it "renders :index template" do
#         get 'index'
#         should render_template(:index)
#       end
#       it "spec other things your action does when user is logged in"
#     end
#   end
# end

#   RSpec.describe UsersController do
#     describe '#index' do
#       subject { get :index }
  
#       it { should redirect_to new_user_session_path }
  
#       context 'for signed in user' do
#         sign_in { create(:user) } # хэлпер, чтобы залогинить пользователя
#         it { should be_forbidden }
  
#         context 'with permissions' do
#           add_permissions(:manager) # хэлпер для добавления прав залогиненному пользователю
#           it { should be_ok }
#         end
#       end
#     end
  
#     # Тут и ниже опустим авторизацию для экономии места
#     describe '#create' do
#       subject { post :create, project: resource_params }
#       let(:resource_params) { {name: 'new_project'} }
  
#       it 'creates resource and redirects to its page' do
#         expect { subject }.to change(Project, :count).by(1)
#         resource = Project.last
#         expect(project.name).to eq 'new_name'
#         expect(subject).to redirect_to project_path(resource)
#       end
  
#       context 'when params are invalid' do
#         let(:resource_params) { super().merge!(name: '') }
  
#         it { should render_template :new }
#         it 'doesnt create resource' do
#           expect { subject }.to_not change(Project, :count)
#         end
#       end
#     end
#   end