class Buttonheist < Formula
  desc "Give AI agents full programmatic control of iOS apps"
  homepage "https://github.com/RoyalPineapple/TheButtonHeist"
  version "2026.04.04"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v2026.04.04/buttonheist-2026.04.04-macos.tar.gz"
  sha256 "1c499ca4cc152ec39c9d0cbe58fe41a52c7ef91f576002b0c3efb6c518535a87"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v2026.04.04/buttonheist-mcp-2026.04.04-macos.tar.gz"
    sha256 "c9d18acdad1d13215c32eaa65090f09cc509b7f46d4bb337949718957aa71e3c"
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
