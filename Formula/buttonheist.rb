class Buttonheist < Formula
  desc "Give AI agents full programmatic control of iOS apps"
  homepage "https://github.com/RoyalPineapple/TheButtonHeist"
  version "0.2.15"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.15/buttonheist-0.2.15-macos.tar.gz"
  sha256 "a232975b3ff750108f6744ff7776861d755e645988d1a1dcc2b100edc7cb8ccf"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.15/buttonheist-mcp-0.2.15-macos.tar.gz"
    sha256 "e4748ae4a205a4d571ecacea2dc07b0a0681514fe1ee9d7c8a9a30b8c1bd3640"
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
