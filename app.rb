require('sinatra/activerecord')
require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/question')
require('./lib/answer.rb')
require('./lib/survey.rb')
require 'pry'

after do
  ActiveRecord::Base.clear_active_connections!
end

before do
  cache_control :public, :no_cache
  cache_control :views, :no_cache
end

get('/') do
  erb(:index, :layout => :layout)
end

get('/surveys/') do
  @surveys = Survey.all
  erb(:surveys)
end

post('/surveys/') do
  survey_name = params.fetch('survey_name')
  Survey.create({title: survey_name})
  redirect('/surveys/')
end

delete('/surveys/delete/:id/') do
  survey = Survey.find(params.fetch('id').to_i)
  survey.delete

  redirect('/surveys/')
end

get('/surveys/:id/') do
  @survey = Survey.find(params.fetch('id').to_i)
  @questions = @survey.questions

  erb(:survey)
end

get('/surveys/update/:id/') do
  @survey = Survey.find(params.fetch('id').to_i)
  erb(:edit_survey)
end
