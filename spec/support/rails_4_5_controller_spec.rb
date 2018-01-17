# The syntax for controller specs changed between Rails 4.x and Rails 5.x such
# that specs written for one are not compatible with the other. This helper
# allows us to DRY up the detection and accomodation for the different call
# signatures.
module Rails45Controller

  def request_with_params(verb, action, params, format)
    if Rails::VERSION::MAJOR < 5
      send(verb.to_sym, action, params.merge(format: format.to_sym))
    else
      send(verb.to_sym, action, params: params, format: format.to_sym)
    end
  end

end
