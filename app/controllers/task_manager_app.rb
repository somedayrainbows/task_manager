require_relative '../models/task.rb'
# allows access to task.rb and methods in there that are referenced below like task.save

class TaskManagerApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)
  set :method_override, true
  # explain, need a new line for each "set"? looks like attr_reader but different setup...

  get '/' do
    erb :dashboard
  end

  get '/tasks' do
    @tasks = Task.all
    erb :index
  end

  get '/tasks/new' do
    erb :new
  end

  post '/tasks' do
    task = Task.new(params[:task])
    task.save
    redirect '/tasks'
  end

  get '/tasks/:id' do
    @task = Task.find(params[:id])
    erb :show
  end

  get '/tasks/:id/edit' do
    @task = Task.find(params[:id])
    erb :edit
  end

  put '/tasks/:id' do |id|
   Task.update(id.to_i, params[:task])
   redirect "/tasks/#{id}"
 end

  delete '/tasks/:id' do |id|
    Task.destroy(id.to_i)
    redirect '/tasks'
  end

end

# CRUD homework ## see also questions in the task.rb file...
#
# 1. Define CRUD.
#     1. Create, Read, Update, Delete 
# 2. Why do we use set method_override: true?
#     1. To allow use of _method in the form (the hidden “PUT” function that allows us access to the route that will accomplish the replace activity)… 
# 3. Explain the difference between value and name in this line: <input type='text' name='task[title]' value="<%= @task.title %>"/>.
#     1. ? — can we go over this please? 
# 4. What are params? Where do they come from?
#     1. Params are a hash of key value pairs, come from data in url or inputted by users 
# 5. Check out your routes. Why do we need two routes each for creating a new Task and editing an existing Task?
#     1. You need get and put (to reset it) routes. One does the showing of the data and the second does the replacing of the data. 
