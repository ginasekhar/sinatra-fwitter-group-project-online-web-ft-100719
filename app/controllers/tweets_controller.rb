class TweetsController < ApplicationController

    get "/tweets" do
        if logged_in?
            @tweets = Tweet.all
            erb :'/tweets/index'
        else
            redirect to '/login'
        end
    end

    get '/tweets/new' do 
        if logged_in?
            erb :'/tweets/new'
        else
            redirect to '/login'
        end
    end
    
    post '/tweets' do 
        #binding.pry
        if logged_in?
            if params[:content] != "" 
                if @tweet = current_user.tweets.build(content: params[:content])
                    @tweet.save
                    redirect to "/tweets/#{@tweet.id}"
                else
                    redirect to "/tweets/new"
                end
            else
                redirect to "/tweets/new"
            end
        else
            redirect to '/login'
        end
    end
    
    get '/tweets/:id' do 
        if logged_in? 
            @tweet = Tweet.find_by_id(params[:id])
            #binding.pry
            erb :'/tweets/show'
        else
            redirect to '/login'
        end
    end

    get '/tweets/:id/edit' do 
        if logged_in? 
            @tweet = Tweet.find_by_id(params[:id])
            #binding.pry
            if @tweet && @tweet.user == current_user 
                erb :'/tweets/edit'
            else
                # Can't update a tweet that is not yours
                redirect to '/tweets/#{@tweet.id}'
            end
        else
            redirect to  '/login'
        end
    end

    patch '/tweets/:id' do 
        if logged_in? 
            
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet && @tweet.user == current_user && params[:content] != "" 
                @tweet.update(content: params[:content])
                redirect to "/tweets/#{@tweet.id}"
            else
                redirect to "/tweets/#{@tweet.id}/edit"
            end
        else
            redirect to '/login'
        end
    end

    delete '/tweets/:id/delete' do
        if logged_in? 
            @tweet = Tweet.find_by_id(params[:id])
            #binding.pry
            if @tweet && @tweet.user == current_user
                @tweet.delete
            else
                redirect to "/tweets/#{@tweet.id}"
            end    
        else
            redirect to '/login'
        end      
    end
end
