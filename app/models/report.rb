class Report < Prawn::Document

  TITLE_FONT_SIZE = 24
  SUBTITLE_FONT_SIZE = 16

  def initialize(options={})
    @title              = options[:title]
    @subtitle           = options[:subtitle]
    @entries            = []
    
    super   :page_layout => :landscape,
            :type => 'application/pdf'
  end
  
  def entry(counter, options={})
    entry_options = Hash.new
    options.each do |k, v|
      entry_options[k] =  if k.eql?(:name)
"""Goal #{counter.to_s}: 
#{v}"""
                          else
                            v
                          end
    end
    @entries << entry_options
  end
  
  def draw_report
    font "Helvetica"

    # Titles
    text @title, :size => TITLE_FONT_SIZE
    text @subtitle, :size => SUBTITLE_FONT_SIZE
    
    # Table
    pad_top(30) do
      draw_table
    end
  end
  
  def draw_table
    @entries.each do |entry|
      @data ||= []
      @data << entry.values
    end
        
    table @data,
          :width              => 700,
          :column_widths      => {0 => 100, 1 => 60, 2 => 200, 3 => 200, 4 => 140},
          :position           => :left,
          :border_style       => :grid,
          :text_size          => 10,
          :headers            => @entries.first.keys.map(&:capitalize),
          :header_color       => '104E8B',
          :header_text_color  => 'FFFFFF',
          :vertical_padding   => 5,
          :horizontal_padding => 3
  end
  
  def save_as(file)
    draw_report
    self.render_file(file)
  end

end