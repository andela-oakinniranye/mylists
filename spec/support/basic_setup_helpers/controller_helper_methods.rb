module ControllerHelperMethods
  def send_request(method, action, request_params=nil)
    params = {format: :json}
    params.merge!(request_params) unless request_params.blank?
    self.send(method, action, params)
  end
end
