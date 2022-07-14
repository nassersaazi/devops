module Stageable
  extend ActiveSupport::Concern

  included do
    extend Enumerize
    enumerize :stage, in: {test: 0, productive: 1}, default: 1
  end

end