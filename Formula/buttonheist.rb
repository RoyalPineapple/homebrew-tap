class Buttonheist < Formula
  desc "Give AI agents full programmatic control of iOS apps"
  homepage "https://github.com/RoyalPineapple/TheButtonHeist"
  version "0.2.23"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.23/buttonheist-0.2.23-macos.tar.gz"
  sha256 "08bc4bd2fb2262d7cfe99f7325f2fd075962713b45defed8c94f63805ff79af3"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.23/buttonheist-mcp-0.2.23-macos.tar.gz"
    sha256 "07ae690e38dc53d86dead23a5eb35b2efe7b41b52c3eab74f76765a30264500d"
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
