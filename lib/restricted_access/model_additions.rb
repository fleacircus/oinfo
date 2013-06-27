module RestrictedAccess
  module ModelAdditions

    def restricted_model
      belongs_to :user
      belongs_to :mandator

      has_paper_trail
    end

  end
end
