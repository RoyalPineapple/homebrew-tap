class Buttonheist < Formula
  desc "Give AI agents full programmatic control of iOS apps"
  homepage "https://github.com/RoyalPineapple/TheButtonHeist"
  version "0.2.29"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.29/buttonheist-0.2.29-macos.tar.gz"
  sha256 "266cbd1d435d15914c33a1a6ca90ab367bf4342ab3a07424ae8845c3e4cd2864"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.29/buttonheist-mcp-0.2.29-macos.tar.gz"
    sha256 "1758de2aff749b08ce0b6d270538e4939511f3043437ed28a9e064420e95accc"
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
