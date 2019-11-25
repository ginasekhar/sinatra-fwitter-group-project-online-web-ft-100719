class TweetsController < ApplicationController

    get "/tweets" do
        if logged_in?
            @tweets = Tweet.all
            erb :'/tweets/index'
        else
            redirect to '/'
        end
    end

    get '/tweets/new' do 
        if logged_in?
            erb :'/tweets/new'
        else
            redirect to '/'
        end
    end
    
    post '/tweets' do 
        #binding.pry
        if logged_in?
            if params[:content] != "" && @tweet = current_user.tweets.build(content: params[:content])
                @tweet.save
                redirect to "/tweets/#{@tweet.id}"
            else
                redirect "/tweets"
            end
        else
            redirect to '/'
        end
    end
    
    get '/tweets/:id/edit' do 
        if logged_in? 
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet && @tweet.user == current_user 
                erb :'/tweets/edit'
            else
                # Can't update a tweet that is not yours
                redirect '/tweets'
            end
        else
            redirect to '/'
        end
    end

    get '/tweets/:id' do 
        if logged_in? 
            @tweet = Tweet.find_by_id(params[:id])
            erb :'/tweets/show'
        else
            redirect to '/'
        end
    end

    patch '/tweets/:id' do 
        if logged_in? 
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet && @tweet.user == current_user 
                @tweet.update(content: params[:content])
                redirect to "tweets/#{@tweet.id}"
            else
                erb :'/tweets/index'
            end
        else
            redirect to '/'
        end
    end

    delete '/tweets/:id/delete' do
        if logged_in? 
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet && @tweet.user == current_user 
                @tweet.delete
            end
                erb :'/tweets/index'
        else
            redirect to '/'
        end      
    end
end
