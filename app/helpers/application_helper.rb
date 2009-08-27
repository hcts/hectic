# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def format_account_limit(value)
    value.zero? ? 'Unlimited' : "#{value} KB"
  end
end
