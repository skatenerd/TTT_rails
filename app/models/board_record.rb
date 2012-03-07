class BoardRecord < ActiveRecord::Base
    after_initialize :init

    def init
      self.board ||= "          " #let's you set a default association
    end

end
