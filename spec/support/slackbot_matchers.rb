require 'rspec/expectations'

RSpec::Matchers.define :not_respond do
  match do |actual|
    channel, user, message = parse(actual)
    allow(Giphy).to receive(:random)
    client = app.send(:client)
    expect(client).to_not receive(:message)
    app.send(:message, client, Hashie::Mash.new(text: message, channel: channel, user: user))
    true
  end

  private

  def parse(actual)
    actual = { message: actual } unless actual.is_a?(Hash)
    [actual[:channel] || 'channel', actual[:user] || 'user', actual[:message]]
  end
end
