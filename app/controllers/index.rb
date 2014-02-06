get '/' do
  # render home page
  @users = User.all

  erb :index
end

#----------- SESSIONS -----------

get '/sessions/new' do
  # render sign-in page
  @email = nil
  erb :sign_in
end

post '/sessions' do
  # sign-in
  @email = params[:email]
  user = User.authenticate(@email, params[:password])
  if user
    # successfully authenticated; set up session and redirect
    session[:user_id] = user.id
    redirect '/'
  else
    # an error occurred, re-render the sign-in form, displaying an error
    @error = "Invalid email or password."
    erb :sign_in
  end
end

delete '/sessions/:id' do
  # sign-out -- invoked via AJAX
  return 401 unless params[:id].to_i == session[:user_id].to_i
  session.clear
  200
end


#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  @user = User.new
  erb :sign_up
end

post '/users' do
  # sign-up
  @user = User.new params[:user]
  if @user.save
    # successfully created new account; set up the session and redirect
    session[:user_id] = @user.id
    redirect '/'
  else
    # an error occurred, re-render the sign-up form, displaying errors
    erb :sign_up
  end
end

#-------- PROFILE ------- #

get '/skills/edit' do
  @errors = true if params[:errors]
  params.inspect
  user_id = session[:user_id]
  @skills = Skill.all
  redirect '/sessions/new' if user_id.nil?
  @user = User.find(user_id)
  erb :edit_skills
end

post '/skills/edit' do
  user = User.find(session[:user_id])
  user.user_skills.each { |uskill| uskill.destroy }

  skill_names = params[:checked].keys

  @models = skill_names.collect do |name|
    skill = Skill.find_by(name: name)
    years = params[name]["years"]
    formal = params[name]["formal"]
    user.add_skill(skill: skill, years_exp: years, formal: formal)
  end

  if @models.any? { |model| model.invalid? }
    redirect to '/skills/edit?errors=true'
      
  else
    redirect to '/'
  end
end
