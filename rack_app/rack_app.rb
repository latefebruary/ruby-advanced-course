class RackApp
  def call(_env)
    [200, {}, ['Hello world']]
  end
end
