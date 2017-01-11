module Le
  module Host

    def self.new(token, local, debug, ssl, datahub_endpoint, host_id, custom_host, udp_port, use_data_endpoint)

      Le::Host::HTTP.new(token, local, debug, ssl, datahub_endpoint, host_id, custom_host, udp_port, use_data_endpoint)
    end

    module InstanceMethods
      def formatter
        proc do |severity, datetime, _, msg|
          format_message(msg, severity, datetime)
        end
      end

      def format_message(message_in, severity, datetime)
        if message_in.is_a?(String)
          "#{datetime} #{message_in.lstrip}"
        elsif message_in.is_a?(Hash)
          message_in.merge({date_time: datetime, severity: severity}).to_json
        else
          "#{datetime} #{message_in.inspect}"
        end
      end
    end

  end
end

require File.join(File.dirname(__FILE__), 'host', 'http')
