class Buttonheist < Formula
  desc "Give AI agents full programmatic control of iOS apps"
  homepage "https://github.com/RoyalPineapple/TheButtonHeist"
  version "2026.04.06"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v2026.04.06/buttonheist-2026.04.06-macos.tar.gz"
  sha256 "6d7d614bda8c7c4c32e9c4100534ce6c2a59acc18d30ab7cfe183b53ccabebd0"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v2026.04.06/buttonheist-mcp-2026.04.06-macos.tar.gz"
    sha256 "2aaaecd7be4b7ed69a1c8bf4def4341a74bb7ec5e02ca3d68227dc1592ef17fd"
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
