module OpenProject
  module Companies
    module Patches
      module UserPatch
        def self.included(base) # :nodoc:
          base.class_eval do
            has_and_belongs_to_many :companies

            scope :like, lambda { |q|
              s = "%#{q.to_s.strip.downcase}%"

              where(
                "LOWER(login) LIKE :s OR LOWER(firstname) LIKE :s OR LOWER(lastname) LIKE :s OR LOWER(mail) LIKE :s",
                { s: s }
              )
            }

            scope :sorted_alphabetically, -> { order("login, lastname, firstname, mail") }
          end
        end
      end
    end
  end
end
