class Buttonheist < Formula
  desc "Give AI agents full programmatic control of iOS apps"
  homepage "https://github.com/RoyalPineapple/TheButtonHeist"
  version "2026.04.06.2"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v2026.04.06.2/buttonheist-2026.04.06.2-macos.tar.gz"
  sha256 "b9e235c68dbd6aa5e1a285880899c1a65e1aa9fba23a457186cc478ea51a3101"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v2026.04.06.2/buttonheist-mcp-2026.04.06.2-macos.tar.gz"
    sha256 "608dcf1f5733dc4f86b4f1b04ff26a3a69b2677d972aa27f4ca9dff9b309895a"
  end

  depends_on :macos
  depends_on macos: :sonoma

  def install
    bin.install "buttonheist"
    bin.install "ButtonHeistFrameworks" if (buildpath/"ButtonHeistFrameworks").exist?
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
