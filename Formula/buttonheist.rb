class Buttonheist < Formula
  desc "Give AI agents full programmatic control of iOS apps"
  homepage "https://github.com/RoyalPineapple/TheButtonHeist"
  version "0.2.30"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.30/buttonheist-0.2.30-macos.tar.gz"
  sha256 "b9960d5413c5459225b0b604aac39a7b035860974141eb927e81821fd3ebb219"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.30/buttonheist-mcp-0.2.30-macos.tar.gz"
    sha256 "f6a892d426200c725ef80f3aee3b99b6f5950177c6b760128c4348df3fd342ad"
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
