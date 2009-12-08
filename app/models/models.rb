class Goal
  include DataMapper::Resource
  property :id,           Serial
  property :name,         String
  property :created_at,   DateTime, :default => DateTime.now
  property :updated_at,   DateTime, :default => DateTime.now
  
  has n, :logs

  before :save, :prepare
  before :destroy, :delete_associations
  
  def delete_associations
    self.logs.destroy
  end
  
  private
    def prepare
      self.updated_at = DateTime.now
    end
end

class Log
  include DataMapper::Resource
  property :id,           Serial
  property :month,        String
  property :progress,     Float, :default => 0.0
  property :obstacles,    Text,  :default => "N/A"
  property :successes,    Text,  :default => "N/A"
  property :other,        Text,  :default => "N/A"
  property :created_at,   DateTime, :default => DateTime.now
  property :updated_at,   DateTime, :default => DateTime.now
  
  belongs_to :goal
  before :update, :prepare
  before :save, :prepare
  
  def self.distinct_months(goal_id)
    return repository(:default).adapter.query("SELECT distinct month FROM logs WHERE goal_id = ? ORDER BY id ASC", goal_id)
  end
  
  private  
    def prepare
      if (self.progress.is_a?(String))
        self.progress = self.progress.to_f.to_decimal
      end
      self.updated_at = DateTime.now
    end
end