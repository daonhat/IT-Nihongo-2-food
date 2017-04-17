module ApplicationHelper

  def genError (model, field)
    @error = ''

    if model.errors.messages[field].any?
      @error += '<p class="help-block help-block-error">' + model.errors.messages[field].first.capitalize + '</p>'
    end

    return @error.html_safe
  end

  def genError_p err
    @error = ''
    @error += '<p class="help-block help-block-error">' + err + '</p>'

    return @error.html_safe
  end

  def current_user? user
    current_user == user
  end

  # Trim string
  def trim_string(string, length = 50, separator = '...')
    truncate( string, :length => length, :separator => separator)
  end
end
