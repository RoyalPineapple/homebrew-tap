class Buttonheist < Formula
  desc "Give AI agents full programmatic control of iOS apps"
  homepage "https://github.com/RoyalPineapple/TheButtonHeist"
  version "2026.04.03"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v2026.04.03/buttonheist-2026.04.03-macos.tar.gz"
  sha256 "3f0ae72ed6f29faf892dbc66a3aa0769d102f11c072fa0a966027ddaf4a9a773"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v2026.04.03/buttonheist-mcp-2026.04.03-macos.tar.gz"
    sha256 "e7f87fcfd7404bd26c02f9f80d55c0904b9959683734c5207b188afdf5a27dd4"
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
