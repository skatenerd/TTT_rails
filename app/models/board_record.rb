class BoardRecord < ActiveRecord::Base
    after_initialize :init

    def init
      self.board ||= "          "
    end

end
