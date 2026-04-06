class Buttonheist < Formula
  desc "Give AI agents full programmatic control of iOS apps"
  homepage "https://github.com/RoyalPineapple/TheButtonHeist"
  version "2026.04.06.1"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v2026.04.06.1/buttonheist-2026.04.06.1-macos.tar.gz"
  sha256 "53fd9ff06ea39043c779b1617fa29362b8c9fb788ab986a689d38a8d447f7092"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v2026.04.06.1/buttonheist-mcp-2026.04.06.1-macos.tar.gz"
    sha256 "4845bccafaefee0e7802f03ce7a43d1cdd3692a3f810dfa2c91dc03bfb675235"
  end

  depends_on :macos
  depends_on macos: :sonoma

  def install
    bin.install "buttonheist"
    resource("mcp").stage { bin.install "buttonheist-mcp" }
  end

  def caveats
    <<~EOS
      To integrate Button Heist into your iOS app:

        cd /path/to/your-ios-project
        buttonheist integrate

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
