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

    post '/teams' do
        if logged_in?
            if params[:team_name] == ""
                redirect to "/teams/new"
            else
                @team = Team.new(team_name: params[:team_name])
                @team.user_id = current_user.id
                if @team.save
                    session[:team_id] = @team.id
                    redirect to "/teams/#{@team.id}"
                else
                    redirect to "/team/new"
                end
            end
        else
            redirect to '/login'
        end
    end

    get '/teams/:id' do
        if logged_in?
            @team = Team.find_by_id(params[:id])
            erb :'/teams/show_team'
        else
            redirect to '/login'
        end
    end

    delete '/teams/:id/delete' do
        if logged_in?
          @team = Team.find_by_id(params[:id])
          if @team.user.id == current_user.id
            @team.delete
            redirect to '/teams/new'
          end
        else
            redirect to '/login'
        end
    end
end
