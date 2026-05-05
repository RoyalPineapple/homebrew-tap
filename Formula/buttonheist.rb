class Buttonheist < Formula
  desc "Give AI agents full programmatic control of iOS apps"
  homepage "https://github.com/RoyalPineapple/TheButtonHeist"
  version "0.2.20"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.20/buttonheist-0.2.20-macos.tar.gz"
  sha256 "385307542a467ad7547e820d98511aa13ac58e204e139380fbafca33f99b592f"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.20/buttonheist-mcp-0.2.20-macos.tar.gz"
    sha256 "395bf26969fdd15e368cdcb24f180181bc406b81b479ded9c1c275a4e1a4bc32"
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
