# == Schema Information
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  spotify    :string(255)
#  itunes     :string(255)
#  link       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
