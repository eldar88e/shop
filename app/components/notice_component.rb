class NoticeComponent < ViewComponent::Base
  def initialize(notices, key)
    @notices = notices
    @key = key
  end
end
