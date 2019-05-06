module Hdh
end

require 'hdh/version'
require 'hdh/helpers'

module Hdh
  extend ::Hdh::Helpers

  class Base
    include ::Hdh::Helpers
  end
end
