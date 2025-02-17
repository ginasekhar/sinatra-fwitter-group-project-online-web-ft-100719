class UsersController < ApplicationController

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show'
    end

    get '/signup' do
        if !logged_in? 
            erb :'/users/signup'
        else
            redirect '/tweets'
        end
    end 

    post '/signup' do
        #create a new user
        if params[:username] == "" || params[:email] == "" || params[:password] == "" 
           # || params[:password] != params[:password_confirm]
            redirect to "/signup"
        else
            @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
            @user.save
            session[:user_id] = @user.id
            redirect to '/tweets'
        end
    end

    get '/login' do
        if !logged_in? 
            erb :'/users/login'
        else
            redirect '/tweets'
        end
    end

    post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/tweets"
        else
            redirect "/login"
        end
    end

    get '/logout' do
        if logged_in? 
            erb :'/users/logout'
            redirect '/login'
        else
            redirect "/"
        end
    end
    
    post '/logout' do
        session.clear
        redirect "/"
    end
end
