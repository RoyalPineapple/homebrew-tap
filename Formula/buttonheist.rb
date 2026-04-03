class Buttonheist < Formula
  desc "Give AI agents full programmatic control of iOS apps"
  homepage "https://github.com/RoyalPineapple/TheButtonHeist"
  version "2026.04.03.2"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v2026.04.03.2/buttonheist-2026.04.03.2-macos.tar.gz"
  sha256 "ed3616e4d725ff7dcb3fb26223ae0f8e4617a9403721c890bb77eb9212b9bcf6"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v2026.04.03.2/buttonheist-mcp-2026.04.03.2-macos.tar.gz"
    sha256 "e4b7a8a9b1d5b73adfc9106033d2cee7de909654a2bd958e745c70cfbc3aa67c"
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
