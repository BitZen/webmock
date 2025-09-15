# frozen_string_literal: true

module WebMock
  class NetConnectNotAllowedError < Exception
    def initialize(request_signature)
      request_signature_snippet = RequestSignatureSnippet.new(request_signature)

      lines = []
      lines << "Real HTTP connections are disabled. Unregistered request: #{request_signature}"

      if ENV['WEBMOCK_VERBOSE'].to_bool
        lines << request_signature_snippet.stubbing_instructions
        lines << request_signature_snippet.request_stubs
      end

      lines << '=' * 60

      super(lines.compact.join("\n\n"))
    end
  end
end
