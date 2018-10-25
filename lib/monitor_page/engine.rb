module MonitorPage

  class Engine < ::Rails::Engine
    isolate_namespace MonitorPage

  end


  class << self
    attr_accessor :checks

    def checks
      @checks || []
    end

    def configure &block
      instance_eval(&block)
    end

    def check(label, &block)
      self.checks += [Proc.new { StatusCheck.create_check(label, &block) }]
    end
  end

  class StatusCheck
    attr_accessor :label

    def initialize(label)
      @label = label
    end

    def self.create_check(label, &block)
      new(label).create_check(&block)
    end

    def create_check(&block)
      instance_eval(&block)
    end

    def pass
      return { label: label, result: true }
    end

    def error(message)
      return { label: label, result: false, message: message }
    end
  end
end
