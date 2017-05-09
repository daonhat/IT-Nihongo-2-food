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

  def list_likers food
    user_names = []
    food.likes.each do |like|
      user_names.push(link_to like.user.name.present? ? like.user.name : like.user.email, user_path(like.user))
      # user_names += trim_string(like.user.email, 15)+', '
    end
    if food.likes.count <= 2
      user_names.to_sentence.html_safe
    else
      food.likes.count
    end
  end
end
