class TeamsController < ApplicationController
    get '/teams' do
        if logged_in?
            @teams = Team.all
            erb :'/teams/teams'
        else
            redirect to '/login'
        end
    end

    get '/teams/new' do
        if logged_in?
            erb :'/teams/create_team'
        else
           redirect to '/login' 
        end
    end
end
