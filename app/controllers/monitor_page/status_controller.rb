require_dependency "monitor_page/application_controller"

module MonitorPage
  class StatusController < ApplicationController
    layout 'monitor_page/application'

    def index
      unless MonitorPage.ip_whitelisted?(request.remote_ip)
        rails_specific_render 'Forbidden' and return
      end

      check_results = MonitorPage.checks.map{|c| c.call }

      overall_pass = check_results.inject(true) { |res, check| res && check[:result] }

      results = check_results.map do |r|
        if r[:result]
          "#{r[:label]}: Passed"
        else
          "#{r[:label]}: Failed - #{r[:message]}"
        end
      end

      results << "-----------"
      results << "Overall: #{overall_pass ? 'Passed' : 'Failed'}"

      rails_specific_render results.join("<br/>").html_safe
    end

    private

    def rails_specific_render(str)
      if Rails::VERSION::STRING[0] == '3'
        render inline: str
      else
        render html: str
      end
    end
  end
end
