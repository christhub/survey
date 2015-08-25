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

post('/surveys/:id/questions/') do
  text = params.fetch('text')
  id = params.fetch('id')
  survey_id = params.fetch('survey_id').to_i
  Question.create(text: text, survey_id: survey_id)
  @survey = Survey.find(params.fetch('id').to_i)
  @questions = @survey.questions
  redirect("/surveys/#{survey_id}")
end

# post('/surveys/:id/answers/') do
#   survey_id = params.fetch('id').to_i
#   survey = Survey.find(survey_id)
#
#   survey.questions.each do |question|
#     question_id = question.id
#     answer = params.fetch("answer_to_#{question_id}")
#     Answer.create({survey_id: survey_id, question_id: question_id, text: answer})
#   end
# 
#   redirect('/surveys/')
# end

delete('/surveys/:id/question/:id/delete/') do
  question = Question.find(params.fetch('id').to_i)
  id = params.fetch('id')
  question.delete
  erb(:survey)
end

get('/survey/:id/question/:id/update/') do
   @survey = Survey.find(params.fetch('id').to_i)
   @question = @survey.questions
end

patch('/survey/:id/question/:id/update/') do
  question = Question.find(params.fetch('id').to_i)
  id = params.fetch('id')
  survey_id = params.fetch('survey_id')
  text = params.fetch('text')
  Question.create(text: text, survey_id: survey_id)
  redirect("/surveys/#{id}/questions")
end
