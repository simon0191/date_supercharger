require "date_supercharger/version"
require "date_supercharger/matcher"
require "active_record"

module DateSupercharger
  extend ActiveSupport::Concern

  included do
    def self.method_missing(method_sym, *arguments, &block)
      return super unless descends_from_active_record?
      matcher = Matcher.new(self,method_sym)

      if matcher.match?
        new_method = "#{matcher.attribute}_#{matcher.suffix}"
        case matcher.suffix
        when :after,:before,:before_or_at,:after_or_at
          operators = { after: ">", before: "<", before_or_at: "<=", after_or_at: ">=" }
          singleton_class.class_eval do
            define_method(new_method) do |date|
              where("#{matcher.attribute} #{operators[matcher.suffix]} ?", date)
            end
          end
        when :between,:between_inclusive
          methods = {between: ["after_or_at","before"],between_inclusive:["after_or_at","before_or_at"]}
          singleton_class.class_eval do
            define_method(new_method) do |from,to|
              from_method = methods[matcher.suffix].first
              to_method = methods[matcher.suffix].second
              send("#{matcher.attribute}_#{from_method}",from).send("#{matcher.attribute}_#{to_method}",to)
            end
          end
        end
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
