class Buttonheist < Formula
  desc "Give AI agents full programmatic control of iOS apps"
  homepage "https://github.com/RoyalPineapple/TheButtonHeist"
  version "2026.04.06.3"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v2026.04.06.3/buttonheist-2026.04.06.3-macos.tar.gz"
  sha256 "3c221b061d5d54aab2c28d90ead828242858d61ad0421de65d708ca07e9747ba"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v2026.04.06.3/buttonheist-mcp-2026.04.06.3-macos.tar.gz"
    sha256 "871c520c7eaf4360ce9a673260136eb92db7b79e7bb05d632f7b50ce0fedf329"
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
