module DateSupercharger
  class MethodDefiner

    attr_reader :klass

    def initialize(klass)
      @klass = klass
    end

    def define(opts)
      attribute = opts[:attribute]
      suffix = opts[:suffix]

      new_method = "#{attribute}_#{suffix}"
      case suffix
      when :after,:before,:before_or_at,:after_or_at
        operators = { after: ">", before: "<", before_or_at: "<=", after_or_at: ">=" }
        klass.singleton_class.class_eval do
          define_method(new_method) do |date|
            where("#{attribute} #{operators[suffix]} ?", date)
          end
        end
      when :between,:between_inclusive
        methods = {between: ["after_or_at","before"],between_inclusive:["after_or_at","before_or_at"]}
        klass.singleton_class.class_eval do
          define_method(new_method) do |from,to|
            from_method = methods[suffix].first
            to_method = methods[suffix].second
            send("#{attribute}_#{from_method}",from).send("#{attribute}_#{to_method}",to)
          end
        end
      end
    end

  end
end
