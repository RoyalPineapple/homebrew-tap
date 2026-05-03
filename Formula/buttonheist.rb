class Buttonheist < Formula
  desc "Give AI agents full programmatic control of iOS apps"
  homepage "https://github.com/RoyalPineapple/TheButtonHeist"
  version "0.2.19"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.19/buttonheist-0.2.19-macos.tar.gz"
  sha256 "36992458620d8ce224051ceb70811511e0d9f54fcf9385957b3b49127cb8b1da"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.19/buttonheist-mcp-0.2.19-macos.tar.gz"
    sha256 "b41a616d9cbb6a1deda55ce8852f38f14c2d285f63c6fea54cbb87bf9a79bc04"
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
