require_dependency "monitor_page/application_controller"

module MonitorPage
  class StatusController < ApplicationController
    layout 'monitor_page/application'

    def index
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

      render html: results.join("<br/>").html_safe
    end
  end
end
