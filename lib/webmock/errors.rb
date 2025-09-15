# frozen_string_literal: true

module WebMock
  class NetConnectNotAllowedError < Exception
    def initialize(request_signature)
      request_signature_snippet = RequestSignatureSnippet.new(request_signature)

      lines = []
      lines << "Real HTTP connections are disabled. Unregistered request: #{request_signature}"
      lines << request_signature_snippet.stubbing_instructions if Config.instance.show_stubbing_instructions?
      lines << request_signature_snippet.request_stubs if Config.instance.show_request_stubs?
      lines << '=' * 60

      super(lines.compact.join("\n\n"))
    end
  end
end
