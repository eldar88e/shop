class NoticeComponent < ViewComponent::Base
  def initialize(notices, key = nil)
    @notices = notices
    @key = key
  end
end
