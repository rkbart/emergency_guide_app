module ApplicationHelper
  def flash_class(type)
    case type.to_sym
    when :notice then "bg-green-100 text-green-800"
    when :alert, :error then "bg-red-100 text-red-800"
    else "bg-blue-100 text-blue-800"
    end
  end
end
