module ApplicationHelper
  def preferred_unit(*opt)
    if opt.present? 
      @preferred_unit = session[:preferred_unit] = opt.first
    else
      @preferred_unti ||= session[:preferred_unit] || 'Mandrake'
    end
  end
end
