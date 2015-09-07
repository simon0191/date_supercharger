require "date_supercharger/version"
require "date_supercharger/matcher"
require "date_supercharger/method_definer"
require "active_record"

module DateSupercharger
  extend ActiveSupport::Concern

  included do
    def self.method_missing(method_sym, *arguments, &block)
      return super unless descends_from_active_record?
      matcher = Matcher.new(self,method_sym)

      if matcher.match?
        method_definer = MethodDefiner.new(self)
        method_definer.define(attribute: matcher.attribute, suffix: matcher.suffix)
        send(method_sym, *arguments)
      else
        super
      end
    end

    def self.respond_to?(method_sym, include_private = false)
      return super unless descends_from_active_record?
      if Matcher.new(self,method_sym).match?
        true
      else
        super
      end
    end
  end
end
ActiveRecord::Base.send :include, DateSupercharger
