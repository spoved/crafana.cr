module PanelList
  property panels : Array(Crafana::Panel) = Array(Crafana::Panel).new

  def add_single_stat(**args, &block : Crafana::SingleStat ->)
    panel = Crafana::SingleStat.new(**args)
    self.panels << panel
    yield panel
    self.panels
  end

  def add_graph(**args, &block : Crafana::Graph ->)
    panel = Crafana::Graph.new(**args)
    self.panels << panel
    yield panel
    self.panels
  end

  def add_text(**args, &block : Crafana::Text ->)
    panel = Crafana::Text.new(**args)
    self.panels << panel
    yield panel
    self.panels
  end

  def add_table(**args, &block : Crafana::Table ->)
    panel = Crafana::Table.new(**args)
    self.panels << panel
    yield panel
    self.panels
  end

  def panels : Array(Crafana::Panel)
    if dashboard.nil?
      @panels
    else
      dashboard.as(Crafana::Dashboard).panels
    end
  end

  def update_grid_pos
    curr_y = 0
    curr_w = 0
    panels.each do |panel|
      if panel.grid_pos.w == 24 || (curr_w + panel.grid_pos.w) >= 24
        curr_y = curr_y + 1
        curr_w = 0
      else
        curr_w = curr_w + panel.grid_pos.w
      end
      panel.grid_pos.y = curr_y
    end
  end
end
