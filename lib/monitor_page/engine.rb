require "ipaddr"

module MonitorPage
  class Engine < ::Rails::Engine
    isolate_namespace MonitorPage
  end

  class << self
    attr_accessor :checks, :whitelisted_ips

    def checks
      @checks || []
    end

    def configure &block
      instance_eval(&block)
    end

    def check(label, &block)
      self.checks += [Proc.new { StatusCheck.create_check(label, &block) }]
    end

    def permit(ips)
      ip_ranges = ips.is_a?(String) ? ips.split(/,\s?/) : ips

      self.whitelisted_ips = ip_ranges.map{|ip| IPAddr.new(ip) }
    end

    def ip_whitelisted?(request_ip)
      @whitelisted_ips.inject(false){|res,ip| ip.include?(IPAddr.new(request_ip)) or res }
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
