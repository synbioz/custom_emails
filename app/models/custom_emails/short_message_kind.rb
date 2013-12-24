module CustomEmails
  class ShortMessageKind < ActiveRecord::Base
    validates_presence_of :name
    validates_uniqueness_of :name

    has_many :short_messages, foreign_key: :kind_id, inverse_of: :kind, dependent: :destroy
  end
end
