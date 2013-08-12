module UsersHelper
  
  def gravatar_for(user)
    # Returns the gravatar for a given user
    # gravatar_url are based in the MD5 algorithm
    # In Ruby MD5 hashing algoritm is based on the
    # hexdigest method from the Digest library
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, atl: user.name, class: "gravatar")
  end
end
