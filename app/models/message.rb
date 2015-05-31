class Message
  include ActiveModel::Model
  attr_accessor :payload

  def self.wrap(payload)
    if payload.is_a? Message
      payload
    else
      Message.new(payload: payload)
    end
  end

  def new_child(payload)
    Message.new(payload: payload)
  end
end
