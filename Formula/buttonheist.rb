class Buttonheist < Formula
  desc "Give AI agents full programmatic control of iOS apps"
  homepage "https://github.com/RoyalPineapple/TheButtonHeist"
  version "0.2.11"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.11/buttonheist-0.2.11-macos.tar.gz"
  sha256 "54392de507b9a3c4da855701a1c66ad24d1d6e03da8b4494b1cc07ea3a5b49c9"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.11/buttonheist-mcp-0.2.11-macos.tar.gz"
    sha256 "9e99bd4e7b83ab251fcb977a4bc4a0f4c9f262281f050bed6a3eced0f4c29294"
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
