class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :avatar_url

  def avatar_url
    object.avatar.thumb('50x50#').url if object.avatar_stored?
  end
end
