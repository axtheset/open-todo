class InsecureUserSerializer < ActiveModel::Serializer
  attributes :id, :email, :password, :full_name

end