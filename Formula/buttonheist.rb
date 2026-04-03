class Buttonheist < Formula
  desc "Give AI agents full programmatic control of iOS apps"
  homepage "https://github.com/RoyalPineapple/TheButtonHeist"
  version "2026.04.03.1"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v2026.04.03.1/buttonheist-2026.04.03.1-macos.tar.gz"
  sha256 "2cca7d51bf6b31e8038b5adc03394bf6019c267baaaed5bd1f103fc057e5411a"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v2026.04.03.1/buttonheist-mcp-2026.04.03.1-macos.tar.gz"
    sha256 "1a8d74d1fe0e98f63cdee2333977384d01a8277c2a77849f6e30dd276185999b"
  end

  depends_on :macos
  depends_on macos: :sonoma

  def install
    bin.install "buttonheist"
    resource("mcp").stage { bin.install "buttonheist-mcp" }
  end

  def caveats
    <<~EOS
      MCP server is installed at:
        #{opt_bin}/buttonheist-mcp

      Add to your project's .mcp.json:
        {
"mcpServers": {
  "buttonheist": {
    "command": "#{opt_bin}/buttonheist-mcp",
    "args": []
  }
}
        }
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/buttonheist --version")
  end
end
