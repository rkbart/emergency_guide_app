module ArticlesHelper
  def theme_badge_color(theme)
    case theme.to_sym
    when :health then "bg-blue-100 text-blue-800"
    when :food then "bg-green-100 text-green-800"
    when :disaster then "bg-red-100 text-red-800"
    when :security then "bg-purple-100 text-purple-800"
    when :education then "bg-yellow-100 text-yellow-800"
    when :migration then "bg-indigo-100 text-indigo-800"
    when :environment then "bg-teal-100 text-teal-800"
    else "bg-gray-100 text-gray-800"
    end
  end
end
