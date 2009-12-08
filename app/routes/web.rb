before do
  headers 'Content-Type' => 'text/html; charset=utf-8'
end

# Stylesheets ============================================================
get '/stylesheets/style.css' do
  headers 'Content-Type' => 'text/css; charset=utf-8'
  sass :style
end

# Routes =================================================================
get '/' do
  @goals = Goal.all
  haml :index
end

get '/goal/create/?' do
  haml :goal
end

get '/goal/:id/edit/?' do
  begin
    @goal = Goal.get!(params[:id])
    haml :goal
  rescue
    raise MyCustomError, "You tried to edit a record that doesn't exist."
  end
end

post '/goal/create/?' do
  attributes_hash = Hash.new
  params.each { |key, value| attributes_hash[key] = value }
  goal = Goal.new( attributes_hash )
  
  if goal.save
    redirect '/'
  else
    throw :halt
  end
end

post '/goal/:id/edit/?' do
  goal = Goal.get(params[:id])
  attributes_hash = Hash.new
  params.each { |key, value| attributes_hash[key] = value }
  
  if goal.update( attributes_hash )
    redirect '/'
  else
    throw :halt
  end
end

post '/goal/:id/destroy/?' do
  goal = Goal.get(params[:id])
  goal.destroy
  
  if goal.destroyed?
    redirect '/'
  else
    throw :halt
  end
end

get '/log/create/?' do
  @goals = Goal.all
  haml :log
end

get '/log/:id/edit/?' do
  begin
    @goals = Goal.all
    @log = Log.get(params[:id])
    haml :log
  rescue
    raise MyCustomError, "You tried to edit a record that doesn't exist."
  end
end

post '/log/create/?' do
  goal = Goal.get(params[:goal_id])
  attributes_hash = Hash.new
  params.each { |key, value| attributes_hash[key] = value }
  log = goal.logs.create( attributes_hash )
  
  if log.save
    redirect '/'
  else
    throw :halt
  end
end

post '/log/:id/edit/?' do
  log = Log.get(params[:id])
  attributes_hash = Hash.new
  params.each { |key, value| attributes_hash[key] = value }
  
  if log.update( attributes_hash )
    redirect '/'
  else
    throw :halt
  end
end

post '/log/:id/destroy/?' do
  Log.destroy
end

get '/report/:month/?' do
  @month = params[:month]
  @logs = Log.all(:month => @month)
  haml :report
end

get '/print/:month/?' do
  @month      = params[:month]
  @logs       = Log.all(:month => @month)
  counter     = 1
  
  if @logs
    @file_name  = @month.to_s + '.pdf'
  
    options     = {
      :title      => page_title,
      :subtitle   => page_subtitle_with_month(@month)
    }
  
    report      = Report.new(options)
  
    @logs.each do |log|      
      tmp = {
        :name         => log.goal.name,
        :progress     => log.progress.to_percentage,
        :obstacles    => log.obstacles,
        :successes    => log.successes,
        :other        => log.other
      }
    
      report.entry(counter, tmp)
      counter += 1
    end
  
    report.save_as(@file_name)
  end
  
  redirect '/'
end