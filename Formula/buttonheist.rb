class Buttonheist < Formula
  desc "Give AI agents full programmatic control of iOS apps"
  homepage "https://github.com/RoyalPineapple/TheButtonHeist"
  version "2026.04.05"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v2026.04.05/buttonheist-2026.04.05-macos.tar.gz"
  sha256 "8d03a996f3e0fab866b686fa18481bffc17e6a7be00412ceb79c7d7a357cd04b"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v2026.04.05/buttonheist-mcp-2026.04.05-macos.tar.gz"
    sha256 "4b77e3ca06a6f3f131efbc524e1368c59a78bf4cef10dd9e9a789c70bf52c661"
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
