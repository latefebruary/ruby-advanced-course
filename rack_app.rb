class RackApp
  def call(env)
    path = env['PATH_INFO']

    if path == '/'
      [200, {}, ['Hello world']]
    else
      [404, {}, []]
    end
  end
end
