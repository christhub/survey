require('sinatra/activerecord')
require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/question')
require('./lib/answer.rb')
require('./lib/survey.rb')

get('/') do
  erb(:index)
end

get('/surveys/') do
  @surveys = Survey.all
  erb(:surveys)
end

post('/surveys/') do
  survey_name = params.fetch('survey_name')
  Survey.create({title: survey_name})
  erb(:surveys)
end
