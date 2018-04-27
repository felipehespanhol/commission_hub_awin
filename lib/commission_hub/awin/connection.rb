module CommissionHub
  module Awin
    class Connection < CommissionHub::Connection

      def_endpoint :advertisers, "programmes", class: :Base

      def initialize(settings)
        @settings = settings
      end

    end
  end
end
